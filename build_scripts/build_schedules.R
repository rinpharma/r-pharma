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

# Get data -------------------------------------------------------------------

sheet_url <- "https://docs.google.com/spreadsheets/d/1NaDnMRh2nOBCzBUxbIyJBVWd_InaEMLTW0rEJtD2ywE/edit#gid=0"

d_raw_proceedings <- read_sheet(
  sheet_url,
  sheet = "all_conferences",
  col_types = "ccccDcccccc"
  )

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
    StartTime = anytime::anytime(paste(Date, Start)),
    EndTime = anytime::anytime(paste(Date, End)),
    StartTime = strftime(StartTime, format="%l:%M %p"),
    EndTime = strftime(EndTime, format="%l:%M %p"),

    EndTime = ifelse(EndTime == "12:00 am",NA,EndTime)
  ) %>%
  select(
    ID,Event,Abstract,Type, Year,Date, Speaker, Affiliation, Title, Slides, Video,
    StartTime,EndTime,Start,End
  )

## build website schedule yml files

meta <- list(
  schedule2018 = list(
    year = 2018,
    data = d_all %>%
      filter(Event == "2018 Conference"),
    #days = c(1,2),
    url = "rinpharma2018"
    #titles = c("Day 1", "Day 2"),
    #subtitles = c("15 Aug [9:15am - 5:25pm ET]", "16 Aug [9:15am - 5:25pm ET]")
  ),
  schedule2019 = list(
    year = 2019,
    data = d_all %>%
      filter(Event == "2019 Conference"),
    #days = c(1,2,3),
    url = "rinpharma2018"
    #titles = c("Day 1 - Workshops", "Day 2", "Day 3")
    #subtitles = c("20 Aug [8:00am - 5:20pm ET]", "21 Aug [8:15am - 5:35pm ET]", "22 Aug [8:15am - 5:45pm ET]")
  ),
  schedule2020 = list(
    year = 2020,
    data = d_all %>%
      filter(Event == "2020 Conference"),
    #days = c(1,2,3,4),
    url = "rinpharma2018"
    #titles = c("Workshops", "Day 1", "Day 2", "Day 3"),
    #subtitles = c("5 Oct - 9 Oct", "13 Oct [10:00am - 2:10 pm ET]", "14 Oct [10:00am - 2:20 pm ET]", "15 Oct [10:00am - 2:10 pm ET]")
  ),
  schedule2021 = list(
    year = 2021,
    data = d_all %>%
      filter(Event == "2021 Conference"),
    #days = c(1,2,3,4),
    url = "rinpharma2018"
    #titles = c("Workshops", "Day 1", "Day 2", "Day 3"),
    #subtitles = c("5 Oct - 9 Oct", "13 Oct [10:00am - 2:10 pm ET]", "14 Oct [10:00am - 2:20 pm ET]", "15 Oct [10:00am - 2:10 pm ET]")
  ),
    schedule2022 = list(
    year = 2022,
    data = d_all %>%
      filter(Event == "2022 Conference"),
    #days = c(1,2,3,4),
    url = "rinpharma2018"
    #titles = c("Workshops", "Day 1", "Day 2", "Day 3"),
    #subtitles = c("5 Oct - 9 Oct", "13 Oct [10:00am - 2:10 pm ET]", "14 Oct [10:00am - 2:20 pm ET]", "15 Oct [10:00am - 2:10 pm ET]")
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
  content : "All times below in US ET."
  scheduleTab:', .trim = FALSE, .na = ""
  ))

  for (day_val in unique(df$Date)) {
    df_day <- df %>% dplyr::filter(Date == day_val)

    df_day_range <- glue(
      "{min_start} to {min_end}",
      min_start = df_day %>%
        arrange(Start) %>%
        slice(1) %>% pull(StartTime),
      min_end = max(
        c(
          {
            df_day %>%
              arrange(desc(Start)) %>%
              slice(1) %>% pull(StartTime)
          },
          {
            df_day %>%
              arrange(desc(End)) %>%
              slice(1) %>% pull(EndTime)
          }
        ), na.rm = TRUE
      )
    )

    cat(glue(
      '
    ################################# tab itam loop
    - title : "{strftime(as.Date(day_val, origin = "1970-01-01"), format="%d %b")}"
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
      
      if (data$Type == "Schedule only") {
        cat(glue(
          '
        # tab content list
        - time : "{data$StartTime}"
          image : "media/schedule/{data$Type}.jpg"
          icons: {icons}
          slides: "{data$Slides}"
          youtube: "{data$Video}"
          content: "

          **{data$Title}** 
          "
          ', .trim = FALSE, .na = "")
        )
        
      } else if (data$Type == "Coffee session") {
        
        cat(glue(
          '
        # tab content list
        - time : "{data$StartTime}"
          image : "media/schedule/{data$Type}.jpg"
          content: "

          **{data$Title}** (Coffee session)
          "
          ', .trim = FALSE, .na = "")
        )
        
      } else {
        cat(glue(
          '
        # tab content list
        - time : "{data$StartTime}"
          image : "media/schedule/{data$Type}.jpg"
          icons: {icons}
          slides: "{data$Slides}"
          youtube: "{data$Video}"
          content: "

          [**{data$Title}**](/publication/{data$ID}/)
          

          {data$Speaker}, _{data$Affiliation}_
          "
          ', .trim = FALSE, .na = "")
          )
      }


    }
  }

  sink()

}
