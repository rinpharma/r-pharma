---
title: 'Exploratory Graphics (xGx): Promoting the purposeful exploration of PKPD data'
authors:
- Alison Margolskee
date: '2019-08-21T00:00:00Z'

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

abstract: Introduction As pharmacometricians, we sometimes jump into complex modeling before thoroughly exploring our data. This can happen due to tight timelines, lack of ready-to-use graphic tools or enthusiasm for complex models. Exploratory plots can help to uncover useful insights in the data and identify aspects to be explored further through modeling or in future studies. Exploratory plots can even quickly answer questions without the need of a complex model, improving our efficiency and providing timely impact on project strategy. The Exploratory Graphics (xGx) tool is an open-source R-based tool, freely available on GitHub [1]. Intuitively organized by datatype and driven by analysis questions, the tool aims to encourage a question-based approach to data exploration focusing on the key questions relevant to dose-exposure-response analyses. Objectives - Facilitate the purposeful exploration of PKPD data - Encourage a question-based approach to data exploration, focusing on dose-exposure-response relationships - Provide a teaching tool for people new to PKPD analysis Methods PK (single and multiple ascending dose), and PD (continuous, time-to-event, categorical, count, and ordinal) data were simulated and formatted according to a typical PKPD modeling dataset format. Lists of key questions relevant to dose-exposure-response exploration were compiled, and exploratory plots were generated to answer each question. The graphs were created following good graphics principles to ensure quality and consistency in our graphical communications [2]. Results Examples of the key analysis questions include - Provide an overview of the data - What type of data is it (e.g. continuous, binary, categorical)? - How many doses? - What is the range of doses explored? - For PK data, how many potential compartments are observed? - Is the exposure dose-proportional? - Is there evidence of nonlinearity in clearance? - Assess the variability - How large is the between subject variability compared to between dose separation? - Can any of the between subject variability be attributed to any covariates? - Are there any patterns in the within subject variability (e.g. circadian rhythms, seasonal effects, food effects, underlying disease progression)? - Assess the dose/exposure-response relationship - Is there evidence of a correlation between dose/exposure and response? - Is the relationship positive or negative? - Is there a plateau or maximal effect in the observed dose/exposure range? - Is there evidence of a delay between exposure and response? For each datatype in the simulated dataset, plots were generated to answer these key questions. The plots along with the codes to produce them were compiled into a user friendly interface. The tool is intuitively organized by datatype and driven by the analysis questions. Since the graphs were generated based on a typical modeling dataset format and hosted online, they can be easily accessed and applied to new projects. Conclusion Exploratory plots were generated, built around typical key questions particularly relevant to dose-exposure-response exploration and compiled into a user friendly interface. The Exploratory Graphics (xGx) tool can help underscore the role of purposeful data exploration for quantitative scientists. Through a question-based approach, xGx helps uncover useful insights that can be revealed without complex modeling and identify aspects of the data that may be explored further. References [1] Margolskee, A., Khanshan, F., Stein, A., Ho, Y., and Looby, M. (2019) Exploratory Graphics (xGx). Pharmacometrics, Novartis Institutes for Biomedical Research, Cambridge. (Available from https//opensource.nibr.com/xgx/) [2] Margolskee, A., Baillie, M., Magnusson, B., Jones, J. and Vandemeulebroecke, M. (2018) Graphics principles cheat sheet. Biostatistical Sciences and Pharmacometrics, Novartis Institutes for Biomedical Research, Cambridge. (Available from https//graphicsprinciples.github.io/)

tags:
- Rstudio
featured: false

links:
url_slides: ''
url_video: ''

---