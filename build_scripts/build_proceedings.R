library(glue)
library(dplyr)
library(googlesheets4)

library(pins)

options(gargle_quiet = FALSE)

file_name <- "rinpharma-4ac2ad6eba3b.json"
secret_name <- "googlesheets4"
path <- paste0("inst/secret/", file_name)
raw <- readBin(path, "raw", file.size(path))
json <- sodium::data_decrypt(
  bin = raw, key = gargle:::secret_pw_get(secret_name),
  nonce = gargle:::secret_nonce()
)
pass <- rawToChar(json)

gs4_auth(
  scopes = 'https://www.googleapis.com/auth/spreadsheets',
  path = pass
  )

## Template -------------------------------------------------------------------
template <- "
---
title: '{title}'
authors:
{authors}
date: '{date}T00:00:00Z'

# Schedule page publish date (NOT proceeding's date).
publishDate: '1999-01-01T00:00:00Z'

# proceeding type.
# Legend: 0 = Uncategorized; 1 = Talk, 2 = Keynote, 3 = Workshop
# To add more update publications_types.toml and en.yaml
publication_types: ['{type}']
publication_type_description: {type_text}

# proceeding name and optional abbreviated proceeding name.
publication: Presented at {event}
publication_short: Presented at {event}

abstract: {abstract}

tags:
{affaliations}
featured: false

links:
url_slides: '{slides}'
url_video: '{video}'

---

{missing_comment}
"

# Get data -------------------------------------------------------------------

  sheet_url <- "https://docs.google.com/spreadsheets/d/1NaDnMRh2nOBCzBUxbIyJBVWd_InaEMLTW0rEJtD2ywE/edit#gid=0"

  d_raw_proceedings <- read_sheet(sheet_url, sheet = "all_conferences")

# Clean data -----------------------------------------------------------------

  d_all <- d_raw_proceedings %>%
    arrange(Date,Start) %>%
    mutate(
      # Modify col
      Title = gsub("'","",Title),
      # Add col
      Year = format(Date, format="%Y"),
      ID = paste0("rinpharma_",row_number())
    ) %>%
    select(
      ID,Event,Abstract,Type, Year,Date, Speaker, Affiliation, Title, Slides, Video
    )

  d_proceedings <- d_all %>%
    filter(
      Type %in% c("Workshop","Keynote","Talk")
    )

# Remove NA
  d_proceedings[is.na(d_proceedings)] <- ""

# Sanitise
  d_proceedings <- d_proceedings %>%
    mutate(
      type = case_when(
        Type == "Talk" ~ 1,
        Type == "Keynote" ~ 2,
        Type == "Workshop" ~ 3
      ),

      # sanitize abstract
      abstract = gsub(":","",Abstract),
      abstract = gsub("[\r\n]"," ",abstract),
      abstract = trimws(abstract), 
      abstract = gsub("[{}]"," ",abstract),
      

      # split speaker and author
      author = paste("-",Speaker),
      author = gsub(" and ","\n- ",author),
      author = gsub(", ","\n- ",author),

      affaliations = paste("-",Affiliation),
      affaliations = gsub(" \\| ","\n- ",affaliations),
      
      missing_content = case_when(
        abstract == "" & Slides == "" & Video == "" ~ "Unfortunately we do not currently have an abstract, copy of the slides or link to the video to this presentation",
        TRUE ~ ""
      )
    )
  
#  d_proceedings <- d_proceedings %>% filter(Year < 2022)

# Fill template --------------------------------------------------------------
for (i in d_proceedings$ID) {

  i_proceeding <- d_proceedings %>%
    filter(ID == i) # i <- "rinpharma_70" i <- "rinpharma_127"

  proceeding_output <-
    glue(
      template,
      date = i_proceeding$Date,
      type_text = i_proceeding$Type,
      title = i_proceeding$Title,
      authors = i_proceeding$author,
      type = i_proceeding$type,
      event = i_proceeding$Event,
      abstract = i_proceeding$abstract,
      affaliations = i_proceeding$affaliations,
      slides = i_proceeding$Slides,
      video = i_proceeding$Video,
      missing_comment = i_proceeding$missing_content
    )

  i_folder <- glue("content/publication/",i_proceeding$ID)
  dir.create(i_folder, showWarnings = FALSE)
  sink(paste0(i_folder,"/index.md"))
  cat(proceeding_output)
  sink()
}

#### Pins -------------------------------------------------------------------
  # board_register_github(
  # repo = "rinpharma/rinpharma-data",
  # branch = "master",
  # token = Sys.getenv("REPO_PIN_PAT")
  # )
  # 
  # # old_proceedings <- gh_file_get(
  # #   repo = "rinpharma-data",
  # #   org = "rinpharma",
  # #   file = "d-proceedings/data.csv"
  # # ) %>%
  # # read_csv(quoted_na = FALSE)
  # 
  # # Proceedings
  # proceedings <- d_proceedings %>%
  #   select(
  #     ID,Event,Type,Year,Date,Speaker,
  #     Affiliation,Title,Slides,Video,Abstract = abstract
  #   )
  # 
  # 
  # pin(proceedings,
  #     description = "Full proceedings data",
  #     board = "github",
  #     branch = "master"
  # )
