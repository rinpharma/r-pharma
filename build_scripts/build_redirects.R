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

## Template -------------------------------------------------------------------
template <- '
<html>
  <head>
    <meta http-equiv="refresh" content="0; url={new_location}" />
  </head>

  <body>
    <p><a href="{new_location}">Redirect</a></p>
  </body>
</html>
'

# Get data -------------------------------------------------------------------

  sheet_url <- "https://docs.google.com/spreadsheets/d/1NaDnMRh2nOBCzBUxbIyJBVWd_InaEMLTW0rEJtD2ywE/edit#gid=0"
  # check the value of the option, if you like
  #options(gargle_oauth_email = "james.black.jb2@roche.com")
  #gs4_auth(email = "james.black.jb2@roche.com", cache = ".secrets")
  data <- read_sheet(sheet_url, sheet = "redirects")
  
  
# Fill template ----------------------------------------------------------------
for (i in data$`old page`) {
  
  i_data <- data %>%
    filter(`old page` == i) 
  
  output <-
    glue(
      template,
      new_location = i_data$`new page`
    )
  
  dir.create(paste0("static",i_data$`old page`), showWarnings = FALSE)
  sink(paste0("static",i_data$`old page`,"index.html"))
  cat(output)
  sink()
}
  
