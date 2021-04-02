library(glue)
library(dplyr)
library(googlesheets4)

library(openssl)
library(jpeg)

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

  d_raw_team <- read_sheet(sheet_url, sheet = "team")

# Clean data -----------------------------------------------------------------

  d_team <- d_raw_team %>%
    filter(!is.na(linkedin)) %>%
    select(email,linkedin) %>%
    mutate(
      hashed = md5(email)
    )

  d_team[is.na(d_team)] <- ""

# Get images
  # default
  default_pic <- readJPEG("static/media/default-avatar.jpg")

  # loop
  for (i in 1:nrow(d_team)){
    i_data <- d_team[i,]

    i_hash <- i_data$hashed
    i_linkedin <- i_data$linkedin

    url <- paste0("https://cdn.libravatar.org/gravatarproxy/",i_hash,"?s=200&default=None")
    destination <- paste0("content/authors/",i_linkedin,"/avatar.jpg")

    #Creating temporary place to save
    temp <- tempfile()
    #Downloding the file
    download.file(url,temp,mode="wb")
    #Reading the file from the temp object
    no_image <- FALSE
    tryCatch({
      pic <- readJPEG(temp)
    }, error=function(e){no_image <<- TRUE})

    if (no_image) {writeJPEG(default_pic,destination)}

    #Saving to your location
    if (!no_image) {writeJPEG(pic,destination)}
    # cleanup
    file.remove(temp)
  }
