library(glue)
library(dplyr)
library(googlesheets4)

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

# Get data -------------------------------------------------------------------

sheet_url <- "https://docs.google.com/spreadsheets/d/1NaDnMRh2nOBCzBUxbIyJBVWd_InaEMLTW0rEJtD2ywE/edit#gid=0"

d_workshops <- read_sheet(
  sheet_url,
  sheet = "workshops",
  col_types = "ccccncl"
  )

# Build content file ---------------------------------------------------------

## create workshops folder
dir.create("./content/workshops2021", showWarnings = FALSE)

## open file for writing
sink("./content/workshops2021/_index.md")

cat(glue(
    '---
title: workshops
workshopDetails:
  # workshop details loop
  
    '))

workshops <- d_workshops %>%
  glue_data('
    - title: "{title}"
        date: "{date}"
        time: "{time}"
        presenter: "{presenter}"
        max_attendees: {max_attendees}
        ticketurl: "{ticket_url}"
        available: {if_else(available, "true", "false")}
     
  ', trim = FALSE)

cat(workshops)

content_txt <- glue('---

R/Pharma is excited to present a total of 14 workshops this year, hosted by members of our community.  Please register for one or two of your choice (space is limited so we ask you not to register for all of them).  Zoom links will be sent to workshop attendees a couple of days before the workshop.

If you have not registered for the R/Pharma conference we ask that you do so before selecting a workshop.  You can join at https://hopin.com/events/r-pharma-2021/registration.

R/Pharma is an amazing community and all of these workshops are put on by volunteers at no cost.  If you would like to contribute to a future workshop please reach out to us through the [contact page](https://rinpharma.com/contact/).

')

cat(content_txt)

sink()

