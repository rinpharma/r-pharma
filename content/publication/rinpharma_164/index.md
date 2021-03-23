---
title: 'PREP - Packages fRom tEmPlates - An R Package to Streamline Development of Shiny Apps and R Packages'
authors:
- J. Kyle Wathen
date: '2020-10-14T00:00:00Z'

# Schedule page publish date (NOT proceeding's date).
publishDate: '20001-01-01T00:00:00Z'

# proceeding type.
# Legend: 0 = Uncategorized; 1 = Talk, 2 = Keynote, 3 = Workshop
# To add more update publications_types.toml and en.yaml
publication_types: ['1']
publication_type_description: Talk

# proceeding name and optional abbreviated proceeding name.
publication: Presented at 2020 Conference
publication_short: Presented at 2020 Conference

abstract: In the recent years, R Shiny apps have gained considerable momentum and have been utilized to develop many useful dashboards and user interfaces (UI) that allow non-programmers access to innovative tools. Due to the ease of development of Shiny apps and lack of complex examples, R developers often create a new shiny app in a single app.r file that contains both the ui and server code/ As a project grows, and capabilities expand in the app, a common practice is to separate the code into two files, one for the server object and one for the ui object. While these approaches may suffice for simple applications, they can lead a developer or team of developers down a path to an application with many lines of code (e.g. 15,000+) in a single file that can be extremely difficult to debug, test, maintain or expand. This approach can also lead to a file with a mixture of UI/server related code in the same files as complex computational code. In this talk, I will present the {PREP} (Packages fRom tEmPlates) package that was created to help teams streamline development of R Shiny apps and R packages using an approach that follows software development best practices. The PREP package adds new project types to R Studio to help streamline new project creation and development. There are three PREP project type options 1) a Shiny app as a package, 2) a Shiny app or 3) R package that is setup with the unit testing framework included utilizing {testthat} and is intended to contain all the complex computational functionality. Both Shiny app options are organized using modules with a consistent default theme, ability to switch between color theme options and example code for commonly implemented tasks. By developing the complex computations in the R packages and the Shiny app as separate projects, teams can utilize each person's skill set better and simplify the testing thus making a more robust final product. By developing the Shiny app with modules, teams can avoid extremely long single files and allow for sharing customized controls within different pages, make it much easier of using source control technology like GitHub. In addition, the PREP package includes functions to add new tabs and modules to the Shiny app and create new functions with testing setup in the computational package to avoid multiple steps of creating files for new functions and testing. PREP is designed to be used by new package/Shiny developers and is highly customizable for expert users without adding a dependency to your final product.

tags:
- Rstudio
featured: false

links:
url_slides: 'https://github.com/rinpharma/2020_presentations/tree/master/talks_folder/2020-Wathen-PREP.pptx'
url_video: 'https://youtu.be/_Hfq8ymQWIY'

---