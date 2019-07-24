library(tidyverse)

schedule <- read_lines(
  "https://rinpharma.github.io/timevis_schedule/output_table.html"
  )

schedule <- c(
  '<h2 class="section-title">Schedule</h2>',
  schedule
)

write_lines(
  schedule,
  "themes/hugo-conference/layouts/partials/schedule.html"
)
