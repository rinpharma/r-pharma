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
  col_types = "ccDccnccc"
  )

d_workshops <- d_workshops %>%
  mutate(
    year = format(date, format = "%Y"),
    month_date = format(date, format = "%b %d")
  )

# Build content file ---------------------------------------------------------
for (i in unique(d_workshops$event)) {
  
  i_sanitised <- gsub("[[:punct:]]", "", i)
  i_sanitised <- gsub(" ", "", i_sanitised)
  i_url <- paste0("./content/workshop/",i_sanitised)
  
  i_workshop <- d_workshops %>%
    filter(
      event == i
    )
  
  ## create workshops folder
  dir.create(i_url,showWarnings = FALSE, recursive = TRUE)
  
  ## open file for writing
  sink(paste0(i_url,"/index.md"))
  
  ## use sprintf in place of glue due to challenges in yaml indentation
  
  top_txt <- paste(
    '---',
    paste('title:', i),
    paste('date:', min(as.character(i_workshop$date-90))),
    'featured: true',
    'workshopDetails:',
    '  # workshop details loop\n',
    sep = "\n"
  )
  
  
  workshops <- paste(
    apply(i_workshop, 1, function(x) {
      paste(
        sprintf('  - title: "%s"', x['title']),
        sprintf('    date: "%s"', x['month_date']),
        sprintf('    time: "%s"', x['time']),
        sprintf('    presenter: "%s"', x['presenter']),
        sprintf('    max_attendees: %s', x['max_attendees']),
        sprintf('    ticketurl: "%s"', x['ticket_url']),
        sprintf('    status: %s', tolower(x['status'])),
        sprintf('    note: %s', tolower(x['note'])),
        sep = "\n"
      )
    }),
    collapse = "\n"
  )
  
  
  bottom_txt <- paste(
    '\n\n---\n',
    'R/Pharma is excited to present a total of 20 workshops this year, hosted by members of our community.  Please register for those you are interested in (space is limited so we ask you not to register for all of them).  Zoom links will be sent to workshop attendees a couple of days before the workshop.\n',
    'If you have not registered for the R/Pharma conference we ask that you do so before selecting a workshop.  You can join at https://hopin.com/events/r-pharma-2022/registration.\n',
    'R/Pharma is an amazing community and all of these workshops are put on by volunteers at no cost.  If you would like to contribute to a future workshop please reach out to us through the [contact page](https://rinpharma.com/contact/).\n',
    sep = '\n'
  )
  
  cat(top_txt)
  cat(workshops)
  cat(bottom_txt)
  
  sink() 
}



