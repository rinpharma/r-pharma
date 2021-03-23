---
title: 'Reproducible shiny apps with shinymeta'
authors:
- Carson Sievert
date: '2019-08-22T00:00:00Z'

# Schedule page publish date (NOT proceeding's date).
publishDate: '20001-01-01T00:00:00Z'

# proceeding type.
# Legend: 0 = Uncategorized; 1 = Talk, 2 = Keynote, 3 = Workshop
# To add more update publications_types.toml and en.yaml
publication_types: ['1']
publication_type_description: Talk

# proceeding name and optional abbreviated proceeding name.
publication: Presented at 2019 Conference
publication_short: Presented at 2019 Conference

abstract: Shiny makes it easy to take domain logic from an existing R script and wrap some reactive logic around it to produce an interactive webpage where others can quickly explore different variables, parameter values, models/algorithms, etc. Although the interactivity is great for many reasons, once an interesting result is found, it's more difficult to prove the correctness of the result since (1) the result can only be (easily) reproduced via the Shiny app and (2) the relevant domain logic which produced the result is obscured by Shiny's reactive logic. The R package shinymeta provides tools for capturing and exporting domain logic for execution outside of a Shiny runtime (so that others can reproduce Shiny-based result(s) from a new R session).

tags:
- Rstudio
featured: false

links:
url_slides: 'https://talks.cpsievert.me/20190823/'
url_video: ''

---