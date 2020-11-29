## build schedules

## build website schedule yml files from csv data

library(dplyr)
library(glue)

meta <- list(
  schedule2018 = list(
    year = 2018,
    file = "./build_schedules/RPharma_schedule_2018.csv",
    days = c(1,2),
    titles = c("15 Aug [9:15am - 5:25pm ET]", "16 Aug [9:15am - 5:25pm ET]")
  ),
  schedule2019 = list(
    year = 2019,
    file = "./build_schedules/RPharma_schedule_2019.csv",
    days = c(1,2),
    titles = c("21 Aug [8:15am - 5:35pm ET]", "22 Aug [8:15am - 5:45pm ET]")
  ),
  schedule2018 = list(
    year = 2020,
    file = "./build_schedules/RPharma_schedule_2020.csv",
    days = c(1,2,3),
    titles = c("13 Oct [10:00am - 2:10 pm ET]", "14 Oct [10:00am - 2:20 pm ET]", "15 Oct [10:00am - 2:10 pm ET]")
  )
)

for (yr in seq_along(meta)) {
  
  ## Read in file
  df <- read.csv(meta[[yr]]$file, stringsAsFactors = FALSE)

  ## open file for writing
  sink(paste0("./build_schedules/rpharma_", meta[[yr]]$year, ".yml"))
  
  cat(glue(
    'schedule:
  enable : true
  titleOutline : "schedule"
  title : "R/Pharma {meta[[yr]]$year}"
  content : "All times below in US ET"
  scheduleTab:', .trim = FALSE, .na = ""
  ))
    
  for (day_val in meta[[yr]]$days) {
    df_day <- df %>% dplyr::filter(day == day_val)
    
    cat(glue(
      '
    ################################# tab itam loop
    - title : "Day {day_val}"
      subtitle : "{meta[[yr]]$titles[[day_val]]}"
      tabContentList:', .trim = FALSE, .na = ""
    ))
    
    for (i in 1:nrow(df_day)) {
      data <- df_day[i, ]
      
      if (data$type %in% c("coffee", "lunch")) {
        icons <- "false"
      } else {
        icons <- "true"
      }
      
      v_author <- unique(unlist(strsplit(data$author, " // ")))
      if (length(v_author) == 0) {
        v_author <- ""
      }
      else if (length(v_author) > 1) {
        v_author <- paste0(paste0(v_author[-length(v_author) - 1], collapse = ", "), v_author[length(v_author)], collapse = " and ")
      }
      
      v_affiliation <- unique(unlist(strsplit(data$affiliation, " // ")))
      if (length(v_affiliation) == 0) {
        v_affiliation <- ""
      }
      else if (length(v_affiliation) > 1) {
        v_affiliation <- paste0(paste0(v_affiliation[-length(v_affiliation) - 1], collapse = ", "), v_affiliation[length(v_affiliation)], collapse = " and ")
      }
      
      cat(glue(
      '
        # tab content list
        - time : "{data$time}"
          image : "images/schedule/{data$type}.jpg"
          icons: {icons}
          slides: "{data$slides}"
          youtube: "{data$youtube}"
          content: "
        
          ### {data$title}
               
          ###### {v_author}
               
          {v_affiliation}
          "
          ', .trim = FALSE, .na = ""))
    }
  }

  sink()
  
}



