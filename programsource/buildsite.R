####
#
# make the schedule

  library(tidyverse)

#### Get data ----------

  # abstracts
  abstracts <- readr::read_csv("import/rpharma2018_abstracts.csv")

  # schedule
  schedule <- readr::read_csv("import/rpharma2018_schedule.csv")

#### Add order
  abstracts <- abstracts %>%
    left_join(
      schedule %>%
        filter(!is.na(speaker_id)) %>%
        mutate(order = row_number()) %>%
        select(speaker_id,order, date,time),
      by = "speaker_id"
    )

#### Create time ----

  abstracts <- abstracts %>%
    mutate(
      day = case_when(
        date == "2018/8/15" ~ "Wednesday, 15th August",
        date == "2018/8/16" ~ "Thursday, 16th August",
        TRUE ~ date
      ),
      when = paste0(
        day," from ",time
      )
    )

#### Split data ----

  abstracts_talks <- abstracts %>%
    filter(
      !is.na(email) & speaker_id %in% schedule$speaker_id
    )

  abstracts_keynotes <- abstracts %>% filter(is.na(email))

#### Arrange data

  abstracts_talks <- abstracts_talks %>% arrange(speakerName)

#### Check assumptions -------

  # emails unique in abstracts
  if (
    dplyr::n_distinct(abstracts_talks$email) != nrow(abstracts_talks)
  ) stop("EMAIL NOT UNIQUE")

#### Function to read in templates -------

  jb_readtemplate <- function(x){
    content <- readLines(paste0("templates/",x))
    content <- paste(content,collapse = "\n")
    content
  }

#### Make overview -------

  schedule_withtalks <- schedule %>%
    left_join(
      abstracts %>%
        select(speaker_id,title,speakerName),
      by = "speaker_id"
    ) %>%
    mutate(
      info  = case_when(
        type == "Tutorial" ~ paste(talk_desc,"(Workshop)"),
        type %in% c("Keynote","Talk","Lightning Talk") ~ title,
        TRUE ~ type
      )
    )


  sink("01_overview.Rmd")
  cat(
    "# (PART) Overview {-}

# Schedule

## Wednesday

")
  # day 1
  temp <- schedule_withtalks %>%
    filter(date == "2018/8/15")

  cat(paste0("| When | What | \n"))
  cat(paste0("|----|----| \n"))
  cat(
    paste0(
      "| **",temp$time,"** | _",temp$info,"_ |\n"
    ),
    sep = ""
  )

  cat("

## Thursday

")

  # day 2
  temp <- schedule_withtalks %>%
    filter(date == "2018/8/16")
  cat(
    paste0(
      "* **",temp$time,"** _",temp$info,"_ \n"
    ),
    sep = ""
  )
  sink()

  #### Make keynotes -------

  sink("02_keynotes.Rmd")
  cat("# (PART) Talks {-}")
  cat("\n\n")
  cat("# Keynotes")
  cat("\n")
  # loop through talks
  talks_atalk <- jb_readtemplate("talks_atalk")
  for (i in 1:nrow(abstracts_keynotes)) {
    # get data on one talk
    i_talk <- abstracts_keynotes[i,]

    cat(sprintf(
      talks_atalk
      ,i_talk$title # title
      ,i_talk$speakerName # name
      ,i_talk$affiliation # affiliation
      ,i_talk$when
      ,i_talk$abstract # abstract
    ))
  }
  sink()

#### Make talks by name -------

  sink("03_talks.Rmd")
  cat("# Talks - by author\n")
  # loop through talks
  talks_atalk <- jb_readtemplate("talks_atalk")
  # by name
  for (i in 1:nrow(abstracts_talks)) {
    # get data on one talk
    i_talk <- abstracts_talks[i,]

    cat(sprintf(
      talks_atalk
      ,i_talk$title # title
      ,i_talk$speakerName # name
      ,i_talk$affiliation # affiliation
      ,i_talk$when
      ,i_talk$abstract # abstract
    ))
  }
  sink()

#### Make talks by order -------

  sink("04_talks-order.Rmd")
  cat("# Talks - chronological\n")
  # loop through talks
  # by order
  abstracts_talks <- abstracts_talks %>%
    arrange(order)
  for (i in 1:nrow(abstracts_talks)) {
    # get data on one talk
    i_talk <- abstracts_talks[i,]

    cat(sprintf(
      talks_atalk
      ,i_talk$title # title
      ,i_talk$speakerName # name
      ,i_talk$affiliation # affiliation
      ,i_talk$when
      ,i_talk$abstract # abstract
    ))
  }
  sink()


