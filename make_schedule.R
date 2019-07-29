library(tidyverse)

schedule <- read_lines(
  "https://rinpharma.github.io/timevis_schedule/output_table.html"
  )

schedule <- c(
  '<h2 class="section-title">Schedule</h2>',
  '<h4 class="section-title">DRAFT schedule - speakers, order and rooms are subject to change.</h4>',
  schedule
)

write_lines(
  schedule,
  "themes/hugo-conference/layouts/partials/schedule.html"
)
