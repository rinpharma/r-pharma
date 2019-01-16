library(tidyverse)
library(glue)
library(stringr)
library(forcats)

library(magrittr)

git_info <- function(
  clone_dir = ".",
  max_branches = 1000,
  repo_name = basename(getwd())
){
}

# details
branch_name <- system("git rev-parse --abbrev-ref HEAD", intern = TRUE)
hash <- RWDShelpers::gitStatus(return = "hash")


log_format_options <- c(
  datetime = "cd", commit = "h", parents = "p", author = "an", subject = "s"
  )
option_delim <- "\t"
log_format   <- glue::glue("%{log_format_options}") %>% glue::collapse(option_delim)
log_options  <- glue::glue('--pretty=format:"{log_format}" --date=format:"%Y-%m-%d %H:%M:%S"')
log_cmd      <- glue::glue('git -C {clone_dir} log {log_options}')
log_cmd

history_logs <- system(log_cmd, intern = TRUE) %>%
  stringr::str_split_fixed(option_delim, length(log_format_options)) %>%
  tibble::as_tibble() %>%
  setNames(names(log_format_options)) %>%
  dplyr::mutate(parents = stringr::str_split(parents, " "))

# Make branch numbers
# Start with NA
history_logs$branch <- NA

# Create a boolean vector to represent free columns (1000 should be plenty!)
free_col <- rep(TRUE, max_branches)

for (i in seq_len(nrow(history_logs) - 1)) { # - 1 to ignore root
  # Check current branch col and assign open col if NA
  branch <- history_logs$branch[i]

  if (is.na(branch)) {
    branch <- which.max(free_col)
    free_col[branch] <- FALSE
    history_logs$branch[i] <- branch
  }

  # Go through parents
  parents <- history_logs$parents[[i]]

  for (p in parents) {
    parent_col <- history_logs$branch[history_logs$commit == p]

    # If col is missing, assign it to same branch (if first parent) or new
    # branch (if other)
    if (is.na(parent_col)) {
      parent_col <- dplyr::if_else(p == parents[1], branch, which.max(free_col))

      # If NOT missing this means a split has occurred. Assign parent the lowest
      # and re-open both cols (parent closed at the end)
    } else {
      free_col[c(branch, parent_col)] <- TRUE
      parent_col <- min(branch, parent_col)

    }

    # Close parent col and assign
    free_col[parent_col] <- FALSE
    history_logs$branch[history_logs$commit == p] <- parent_col
  }
}

history_logs <- history_logs %>%
  dplyr::mutate(
    author = sub(" \\{Mdbr~South San Francisco\\}","",author),
    author = sub(" \\{Mdbr~Basel\\}","",author),
    author = sub(" \\{Mdpa~Basel\\}","",author),
    author = dplyr::case_when(
      author %in% c(
        "epijim","Black, James","James","Black, James {Mdpa~Basel}"
        ) ~ "James Black",
      author %in% c(
        "Lambert, Peter {Mdbr~South San Francisco}"
      ) ~ "Peter Lambert",
      TRUE ~ stringr::str_to_title(author))
    )

history_logs %>%
  dplyr::group_by(author) %>%
  dplyr::summarise(
    Commits = n()
  ) %>%
  dplyr::arrange(-Commits)

history_logs %>%
  dplyr::group_by(author) %>%
  dplyr::summarise(
    Commits = n()
  ) %>%
  dplyr::arrange(-Commits) %>%
  dplyr::mutate(author = forcats::fct_reorder(author, Commits)) %>%
  ggplot2::ggplot(ggplot2::aes(author, Commits)) +
  ggplot2::geom_col(ggplot2::aes(fill = Commits), show.legend = FALSE) +
  ggplot2::coord_flip() +
  ggplot2::ggtitle(paste(repo_name,"authors with most commits")) +
  ggplot2::labs(x = NULL, y = "Number of commits", caption = "Blah blah")

library(tidygraph)
library(ggraph)
library(tidytext)

# Convert commit to a factor (for ordering nodes)
history_logs <- history_logs %>%
  dplyr::mutate(commit = factor(commit))

# Nodes are the commits (keeping relevant info)
nodes <- history_logs %>%
  dplyr::select(-parents) %>%
  dplyr::arrange(commit)

# Edges are connections between commits and their parents
edges <- history_logs %>%
  dplyr::select(commit, parents) %>%
  tidyr::unnest(parents) %>%
  dplyr::mutate(parents = factor(parents, levels = levels(commit))) %>%
  dplyr::transmute(from = as.integer(parents), to = as.integer(commit)) %>%
  tidyr::drop_na()

# Create tidy directed graph object
git_graph <- tidygraph::tbl_graph(nodes = nodes, edges = edges, directed = TRUE)

# snake
git_graph %>%
  ggraph::ggraph(layout = "partition") +
  ggraph::geom_edge_link(alpha = .1) +
  ggraph::geom_node_point(ggplot2::aes(color = factor(branch)), alpha = .3) +
  ggraph::theme_graph() +
  ggplot2::theme(legend.position = "none")

git_graph %>%
  ggraph::ggraph() +
  ggraph::geom_edge_link(alpha = .1) +
  ggraph::geom_node_point(ggplot2::aes(color = factor(branch)), alpha = .3) +
  ggraph::theme_graph() +
  ggplot2::theme(legend.position = "none")

# linear

ggraph_git <- . %>%
  # Set node x,y coordinates
  tidygraph::activate(nodes) %>%
  dplyr::mutate(x = datetime, y = branch) %>%
  # Plot with correct layout
  ggraph::create_layout(
    layout = "manual",
    node.positions = tibble::as_tibble(tidygraph::activate(., nodes))) %>%
    {ggraph::ggraph(., layout = "manual") + ggraph::theme_graph() +
      ggplot2::labs(
        caption = paste("Plot generated",Sys.Date(),"from",getwd())
        )
      }

# 10 most-common authors
top_authors <- git_graph %>%
  tidygraph::activate(nodes) %>%
  tibble::as_tibble() %>%
  dplyr::count(author, sort = TRUE) %>%
  dplyr::top_n(3, n) %>%
  dplyr::pull(author)

# Plot
git_graph %>%
  tidygraph::activate(nodes) %>%
  dplyr::mutate(
    author = factor(author, levels = top_authors),
    Author = forcats::fct_explicit_na(author, na_level = "Other")
    ) %>%
  ggraph_git() +
  ggraph::geom_edge_link(alpha = .1) +
  ggraph::geom_node_point(ggplot2::aes(color = Author), alpha = .7) +
  ggplot2::theme(legend.position = "bottom") +
  ggplot2::ggtitle(
    paste(repo_name,"commits by author"),
    subtitle = paste("from commit",hash,"on",branch_name,"branch")
    )
