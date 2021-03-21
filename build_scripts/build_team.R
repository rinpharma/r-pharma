library(glue)
library(tidyverse)
library(googlesheets4)

## Template
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
#- icon: github
#  icon_pack: fab
#  link: https://github.com/epijim
#- icon: link
#  icon_pack: fab
#  link: https://github.com/epijim

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

# Get data

  sheet_url <- "https://docs.google.com/spreadsheets/d/1NaDnMRh2nOBCzBUxbIyJBVWd_InaEMLTW0rEJtD2ywE/edit#gid=0"
  # check the value of the option, if you like
  options(gargle_oauth_email = "james.black.jb2@roche.com")
  gs4_auth(email = "james.black.jb2@roche.com", cache = ".secrets")
  d_raw_team <- read_sheet(sheet_url, sheet = "team")
  
# Clean data
  
  d_team <- d_raw_team %>%
    filter(!is.na(linkedin)) 
  
# Fill template
for (i in d_team$linkedin) {
  
  i_team <- d_team %>%
    filter(linkedin == i) 

  team_output <-
    glue(
      template,
      title = i_team$name,
      site_superuser = i_team$site_superuser,
      role = i_team$role,
      linkedin = i_team$linkedin,
      email = i_team$email
    )
  
  i_folder <- glue("content/authors/",i_team$linkedin)
  dir.create(i_folder, showWarnings = FALSE)
  sink(paste0(i_folder,"/index.md"))
  cat(team_output)
  sink()
}
  