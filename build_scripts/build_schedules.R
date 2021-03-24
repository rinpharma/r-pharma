library(glue)
library(tidyverse)
library(googlesheets4)
library(pins)

# Get data -------------------------------------------------------------------

sheet_url <- "https://docs.google.com/spreadsheets/d/1NaDnMRh2nOBCzBUxbIyJBVWd_InaEMLTW0rEJtD2ywE/edit#gid=0"
# check the value of the option, if you like
options(gargle_oauth_email = "james.black.jb2@roche.com")
gs4_auth(email = "james.black.jb2@roche.com", cache = ".secrets")
d_raw_proceedings <- read_sheet(sheet_url, sheet = "all_conferences")

# Clean data -------------------------------------------------------------------

d_all <- d_raw_proceedings %>%
  arrange(Date,Start) %>%
  mutate(
    # Modify col
    Title = gsub("'","",Title),
    # Add col
    Year = format(Date, format="%Y"),
    ID = paste0("rinpharma_",row_number())
  ) %>%
  mutate(
    StartTime = strftime(Start, format="%H:%M:%S"),
    EndTime = strftime(End, format="%H:%M:%S")
  ) %>%
  select(
    ID,Event,Abstract,Type, Year,Date, Speaker, Affiliation, Title, Slides, Video,
    StartTime,EndTime
  )

## build website schedule yml files 

meta <- list(
  schedule2018 = list(
    year = 2018,
    data = d_all %>%
      filter(Event == "2018 Conference"),
    #days = c(1,2),
    url = "rinpharma2018",
    #titles = c("Day 1", "Day 2"),
    subtitles = c("15 Aug [9:15am - 5:25pm ET]", "16 Aug [9:15am - 5:25pm ET]")
  ),
  schedule2019 = list(
    year = 2019,
    data = d_all %>%
      filter(Event == "2019 Conference"),
    #days = c(1,2,3),
    url = "rinpharma2018",
    #titles = c("Day 1 - Workshops", "Day 2", "Day 3"),
    subtitles = c("20 Aug [8:00am - 5:20pm ET]", "21 Aug [8:15am - 5:35pm ET]", "22 Aug [8:15am - 5:45pm ET]")
  ),
  schedule2020 = list(
    year = 2020,
    data = d_all %>%
      filter(Event == "2020 Conference"),
    #days = c(1,2,3,4),
    url = "rinpharma2018",
    #titles = c("Workshops", "Day 1", "Day 2", "Day 3"),
    subtitles = c("5 Oct - 9 Oct", "13 Oct [10:00am - 2:10 pm ET]", "14 Oct [10:00am - 2:20 pm ET]", "15 Oct [10:00am - 2:10 pm ET]")
  )
)

for (yr in seq_along(meta)) {

  ## Read in file
  df <-  meta[[yr]]$data

  ## open file for writing
  sink(paste0("./data/rinpharma", meta[[yr]]$year, ".yml"))

  cat(glue(
    'schedule:
  enable : true
  titleOutline : "schedule"
  title : "R/Pharma {meta[[yr]]$year}"
  content : "All times below in US ET. See proceedings for final abstracts."
  scheduleTab:', .trim = FALSE, .na = ""
  ))

  for (day_val in unique(df$Date)) {
    df_day <- df %>% dplyr::filter(Date == day_val)
    
    df_day_range <- glue(
      "{min_start} to {min_end}",
      min_start = min(df_day$StartTime, na.rm = TRUE),
      min_end = max(
        c(
          max(df_day$EndTime, na.rm = TRUE),
          max(df_day$StartTime, na.rm = TRUE)
        ), na.rm = TRUE
      )
    )

    cat(glue(
      '
    ################################# tab itam loop
    - title : "{as.character(day_val)}"
      subtitle : "{df_day_range}"
      tabContentList:', .trim = FALSE, .na = ""
    ))

    for (i in 1:nrow(df_day)) {
      data <- df_day[i, ]

      if (data$Type %in% c("Schedule only", "Coffee session")) {
        icons <- "false"
      } else {
        icons <- "true"
      }

      v_author <- data$Speaker

      v_affiliation <- data$Affiliation

      cat(glue(
      '
        # tab content list
        - time : "{data$StartTime}"
          image : "media/schedule/{data$Type}.jpg"
          icons: {icons}
          slides: "{data$Slides}"
          youtube: "{data$Video}"
          content: "

          ### {data$Title}

          ###### {v_author}

          {v_affiliation}
          "
          ', .trim = FALSE, .na = ""))
    }
  }

  sink()

}
