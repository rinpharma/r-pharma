####
#
# make the schedule

  library(tidyverse)

#### Get data ----------

  # abstracts
  abstracts <- readr::read_csv("import/rpharma2018_abstracts.csv")

  # schedule
  schedule <- readr::read_csv("import/rpharma2018_schedule.csv")

#### Add order
  abstracts <- abstracts %>%
    left_join(
      schedule %>%
        filter(!is.na(speaker_id)) %>%
        mutate(order = row_number()) %>%
        select(speaker_id,order, date,time),
      by = "speaker_id"
    )

#### Create time ----

  abstracts <- abstracts %>%
    mutate(
      day = case_when(
        date == "2018/8/15" ~ "Wednesday, 15th August",
        date == "2018/8/16" ~ "Thursday, 16th August",
        TRUE ~ date
      ),
      when = paste0(
        day," from ",time
      )
    )

#### Split data ----

  abstracts_talks <- abstracts %>%
    filter(
      !is.na(email) & speaker_id %in% schedule$speaker_id
    )

  abstracts_keynotes <- abstracts %>% filter(is.na(email))

#### Arrange data

  abstracts_talks <- abstracts_talks %>% arrange(speakerName)

#### Check assumptions -------

  # emails unique in abstracts
  if (
    dplyr::n_distinct(abstracts_talks$email) != nrow(abstracts_talks)
  ) stop("EMAIL NOT UNIQUE")

#### Function to read in templates -------

  jb_readtemplate <- function(x){
    content <- readLines(paste0("templates/",x))
    content <- paste(content,collapse = "\n")
    content
  }

#### Make overview -------

  schedule_withtalks <- schedule %>%
    left_join(
      abstracts %>%
        select(speaker_id,title,speakerName),
      by = "speaker_id"
    ) %>%
    mutate(
      info  = case_when(
        type == "Tutorial" ~ paste(talk_desc,"(Workshop)"),
        type %in% c("Keynote","Talk","Lightning Talk") ~ title,
        TRUE ~ type
      )
    )




  sink("01_overview.Rmd")
  cat(
    "# (PART) Overview {-}

# Schedule

")

  schedule %>%
    left_join(
      abstracts %>%
        select(speaker_id,title,speakerName),
      by = "speaker_id"
    ) %>%
    mutate(
      type = ifelse(
        type == "Tutorial","Workshop",type
      ),
      info = case_when(
        type == "Workshop" ~ talk_desc,
        type %in% c("Keynote","Talk","Lightning Talk") ~
          paste0(title," **(",speaker,")**"),
        type == "Opening Remarks" ~ speaker,
        TRUE ~ " "
      )
    ) %>%
    select(When = time,What = type, Who = info) %>%
    knitr::kable("html") %>%
    kableExtra::kable_styling(bootstrap_options = c("striped")) %>%
    kableExtra::group_rows(
      "Tuesday", 1, 1,label_row_css = "background-color: #666; color: #fff;"
      ) %>%
    kableExtra::group_rows(
      "Wednesday", 2, 32, label_row_css = "background-color: #666; color: #fff;"
      ) %>%
    kableExtra::group_rows(
      "Thursday", 33, 63, label_row_css = "background-color: #666; color: #fff;"
      ) %>%
    cat(sep = "\n")

cat("\n")

cat("## Wednesday

This is the shortened schedule, please go to [the Full Schedule](http://rinpharma.com/program/schedule.html) for more detailed information.

")
  # day 1
  temp <- schedule_withtalks %>%
    filter(date == "2018/8/15")

  cat(paste0("| When | What | \n"))
  cat(paste0("|----|----| \n"))
  cat(
    paste0(
      "* **",temp$time,"** _",temp$info,"_ \n"
    ),
    sep = ""
  )

  cat("

## Thursday

This is the shortened schedule, please go to [the Full Schedule](http://rinpharma.com/program/schedule.html) for more detailed information.

")

  # day 2
  temp <- schedule_withtalks %>%
    filter(date == "2018/8/16")
  cat(
    paste0(
      "* **",temp$time,"** _",temp$info,"_ \n"
    ),
    sep = ""
  )
  sink()

  #### Make keynotes -------

  sink("02_keynotes.Rmd")
  cat("# (PART) Talks {-}")
  cat("\n\n")
  cat("# Keynotes")
  cat("\n\n")
  cat("To start viewing abstracts, either 1) press right on your keyboard, 2) click the arrow or 3) select a talk from the menu.")
  cat("\n")
  # loop through talks
  talks_atalk <- jb_readtemplate("talks_atalk")
  for (i in 1:nrow(abstracts_keynotes)) {
    # get data on one talk
    i_talk <- abstracts_keynotes[i,]

    cat(sprintf(
      talks_atalk
      ,i_talk$title # title
      ,i_talk$speakerName # name
      ,i_talk$affiliation # affiliation
      ,i_talk$when
      ,i_talk$abstract # abstract
    ))
  }
  sink()

#### Make talks by name -------

  sink("03_talks.Rmd")
  cat("# Talks - by author")
  cat("\n\n")
  cat("To start viewing abstracts, either 1) press right on your keyboard, 2) click the arrow or 3) select a talk from the menu.")
  cat("\n")
  # loop through talks
  talks_atalk <- jb_readtemplate("talks_atalk")
  # by name
  for (i in 1:nrow(abstracts_talks)) {
    # get data on one talk
    i_talk <- abstracts_talks[i,]

    cat(sprintf(
      talks_atalk
      ,i_talk$title # title
      ,i_talk$speakerName # name
      ,i_talk$affiliation # affiliation
      ,i_talk$when
      ,i_talk$abstract # abstract
    ))
  }
  sink()

#### Summary -------




  library(googlesheets)
  table <- "RinPharmaRegistered"
  sheet <- gs_title(table)
  # Read the data
  registered <-  gs_read_csv(sheet) %>%
    filter(Name != "test")

  library(treemap)
  registered %>%
    group_by(Company) %>%
    summarise(
      n = n()
    ) %>% DT::datatable()

  png(filename="tree.png",width=800, height=800)
  treemap(
    registered %>%
      mutate(
        Company = case_when(
          Company == "amgen" ~ "Amgen",
          Company == "Boehringer Ingelheim" ~ "Boehringer-Ingelheim",
          Company == "Genentech" ~ "Roche / Genentech",
          Company == "Genetech" ~ "Roche / Genentech",
          Company == "Roche" ~ "Roche / Genentech",
          Company == "Lilly" ~ "Eli Lily",
          Company == "Rstudio" ~ "RStudio",
          Company == "Glaxosmithkline" ~ "GSK",
          Company == "Johnson & Johnson" ~ "J&J",
          TRUE ~ Company
        ),
        Industry = case_when(
          Company %in% c(
            "Roche / Genentech","Biogen",
            "J&J","Pfizer","Merck","Sanofi",
            "Amgen","BMS","Novartis","Abbott",
            "Abbvie","BMS","Boehringer-Ingelheim",
            "EDM Serono","GSK","Eisai","Eli Lily"
          ) ~ "Pharma",
          Company %in% c(
            "PPDI","Metrum","Genesis","Covance","Generable",
            "Sievert Consulting LLC","TCB Analytics"
          ) ~ "CRO",
          Company %in% c(
            "Harvard","Broad Institute","Mayo Clinic","Iowa State University",
            "Oregon Health & Science University","IQSS Harvard",
            "Northeastern University","Technical University of Denmark",
            "University of Illinois at Chicago"
          ) ~ "Academic",
          Company %in% c("FDA","RStudio","rOpenSci") ~ "Other"
        )
      ) %>%
      group_by(Industry,Company) %>%
      summarise(
        `People attending (boxes sized by n)` = n()
      ) %>% as.data.frame(),
    index = c("Company"),
    vSize = "People attending (boxes sized by n)",
    vColor = "Industry",
    type = "categorical",
    fontsize.labels = 9,
    position.legend = "none",
    fontsize.legend = 6)
  dev.off()

  library(tm)

  vdocs <- VCorpus(VectorSource(abstracts$abstract))
  vdocs <- tm_map(vdocs, content_transformer(tolower))      # to lowercase
  vdocs <- tm_map(vdocs, removeWords, stopwords("english")) # remove stopwords

  # our custom vector of stop words

  my_custom_stopwords <- c("approach",
                           "case",
                           "low",
                           "new",
                           "north",
                           "real",
                           "use",
                           "using",
                           "can",
                           "will",
                           "due",
                           "analyses,",
                           "areas",
                           "available",
                           "back",
                           "become",
                           "type",
                           "entirely",
                           "used",
                           "well",
                           "also"
  )

  vdocs <- tm_map(vdocs, removeWords, my_custom_stopwords)
  tdm <- TermDocumentMatrix(vdocs)

  m <- as.matrix(tdm)
  v <- sort(rowSums(m),decreasing=TRUE)
  d <- data.frame(word = names(v),freq=v)

  set.seed(1234)
  library(wordcloud)
  png(filename="wc_abstracts.png",width=600, height=600)
  wordcloud(words = d$word, freq = d$freq, min.freq = 7,
            scale = c(6,1),
            max.words=200, random.order=FALSE, rot.per=0.35,
            colors=brewer.pal(8, "Dark2"))
  dev.off()

  vdocs <- VCorpus(VectorSource(abstracts$title))
  vdocs <- tm_map(vdocs, content_transformer(tolower))      # to lowercase
  vdocs <- tm_map(vdocs, removeWords, stopwords("english")) # remove stopwords

  # our custom vector of stop words

  my_custom_stopwords <- c("approach",
                           "case",
                           "low",
                           "new",
                           "north",
                           "real",
                           "use",
                           "using",
                           "can",
                           "will",
                           "due",
                           "analyses,",
                           "areas",
                           "available",
                           "back",
                           "become",
                           "type",
                           "entirely",
                           "used",
                           "well",
                           "also",
                           "analysis.",
                           "data,",
                           "however,"
  )

  vdocs <- tm_map(vdocs, removeWords, my_custom_stopwords)
  tdm <- TermDocumentMatrix(vdocs)

  m <- as.matrix(tdm)
  v <- sort(rowSums(m),decreasing=TRUE)
  d <- data.frame(word = names(v),freq=v)

  set.seed(1234)
  library(wordcloud)
  png(filename="wc_titles.png",width=600, height=600)
  wordcloud(words = d$word, freq = d$freq, min.freq = 2,
            scale=c(6,2),
            max.words=200, random.order=FALSE, rot.per=0.35,
            colors=brewer.pal(8, "Dark2"))
  dev.off()


  sink("04_summary.Rmd")
  cat("# Summary plots")
  cat("\n\n")
  cat("Following section provides summary information about the conference.")
  cat("\n\n")
  cat("## Attendees\n")
  cat("\n\n")
  cat("![](tree.png)\n")
  cat("\n\n")
  cat("## Wordclouds\n")
  cat("\n\n")
  cat("A wordcloud based on speaker abstracts")
  cat("\n\n")
  cat("![](wc_abstracts.png)")
  cat("\n\n")
  cat("A wordcloud based on speaker presentation titles")
  cat("\n\n")
  cat("![](wc_titles.png)")

  sink()
