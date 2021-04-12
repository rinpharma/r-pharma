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
# Display name
title: {title}

# Is this the primary user of the site?
superuser: {site_superuser} # true or false

# Role/position
role: {role}

social:
- icon: linkedin
  icon_pack: fab
  link: https://www.linkedin.com/in/{linkedin}
{github}
{custom_link}


# Enter email to display Gravatar (if Gravatar enabled in Config)
email: '{email}'

# Highlight the author in author lists? (true/false)
highlight_name: false

# Organizational groups that you belong to (for People widget)
#   Set this to `[]` or comment out if you are not using People widget.
user_groups:
- Organising Committee
---
"

# Get data -------------------------------------------------------------------

  sheet_url <- "https://docs.google.com/spreadsheets/d/1NaDnMRh2nOBCzBUxbIyJBVWd_InaEMLTW0rEJtD2ywE/edit#gid=0"
  # check the value of the option, if you like
  #options(gargle_oauth_email = "james.black.jb2@roche.com")
  #gs4_auth(email = "james.black.jb2@roche.com", cache = ".secrets")
  d_raw_team <- read_sheet(sheet_url, sheet = "team")
  
# Clean data -------------------------------------------------------------------
  
  d_team <- d_raw_team %>%
    filter(!is.na(linkedin)) 
  
  d_team[is.na(d_team)] <- ""
  
# Fill template ----------------------------------------------------------------
for (i in d_team$linkedin) {
  
  i_team <- d_team %>%
    filter(linkedin == i) 
  
  if(i_team$custom_link != ""){
    custom_link <- glue(
      "- icon: link
        icon_pack: fas
        link: {i_team$custom_link}
      "
    )
  } else {
    custom_link <- ""
  }
  
  if(i_team$github != ""){
    github <- glue(
      "- icon: github
        icon_pack: fab
        link: https://github.com/{i_team$github}
      "
    )
  } else {
    github <- ""
  }

  team_output <-
    glue(
      template,
      title = i_team$name,
      site_superuser = i_team$site_superuser,
      role = i_team$role,
      linkedin = i_team$linkedin,
      custom_link = custom_link,
      github = github,
      email = i_team$email
    )
  
  i_folder <- glue("content/authors/",i_team$linkedin)
  dir.create(i_folder, showWarnings = FALSE)
  sink(paste0(i_folder,"/index.md"))
  cat(team_output)
  sink()
}
  
#### Pins -------------------------------------------------------------------
board_register_github(
  repo = "rinpharma/rinpharma-data", branch = "master",
  token = Sys.getenv("REPO_PIN_PAT")
  )

# remove email
organising_team <- d_team %>%
  select(
    name,role,custom_link,linkedin,organising_comm,exec_comm,program_comm
  )


pin(organising_team, 
    description = "Full proceedings data", 
    board = "github",
    branch = "master"
)  
  