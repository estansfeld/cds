# method from https://rpubs.com/pbaumgartner/wayback
# the Wayback site: https://web.archive.org/

# setting up
knitr::opts_chunk$set(
  message = F,
  error = F,
  warning = F,
  comment = NA,
  highlight = T,
  prompt = T
)
### Set the global option options(stringsAsFactors = FALSE) 
### inside a parent function and restore the option after the parent function exits
if (!require("xfun"))
{install.packages("xfun", repos = 'http://cran.wu.ac.at/')
  library(xfun)}

xfun::stringsAsStrings()


### install and load some important packages
### https://github.com/tidyverse/tidyverse
if (!require("tidyverse"))
{install.packages("tidyverse", repos = 'http://cran.wu.ac.at/')
  library(tidyverse)}

### above command installed and loaded the core tidyverse packages:
# ggplot2:    data visualisation
# tibble:     a modern take on data frames
# tidyr:      data tidying
# readr:      data import (csv, tsv, fwf)
# purrr:      functional R programming
# dplyr:      data (frame) manipulation
# stringr:    string manipulation
# forcats:    working with categorial varialbes
# tidyselect: backend for the selecting functions of the 'tidyverse'. (?, new?)


### My reminder for other essential packages:
### Working with times:
# hms, for times.

# lubridate, for date/times.
if (!require("lubridate"))
{install.packages("lubridate", repos = 'http://cran.wu.ac.at/')
  library(lubridate)}

### Importing other types of data:
# feather, for sharing with Python and other languages.
# haven, for SPSS, SAS, and Stata files.
# httr, for web APIs.
# jsonlite for JSON.
# readxl, for .xls and .xlsx files.


# rvest, for web scraping.
if (!require("rvest"))
{install.packages("rvest", repos = 'http://cran.wu.ac.at/')
  library(rvest)}

# xml2, for XML.
if (!require("xml2"))
{install.packages("xml2", repos = 'http://cran.wu.ac.at/')
  library(xml2)}

### Modelling
# modelr, for modeling within a pipeline
# broom, for turning models into tidy data


### Special packages for this article
if (!require("wayback"))
{remotes::install_github("jsta/wayback", build_vignettes = TRUE)
  library(wayback)}



#######
# check if the site of interest is archived on wayback:
staticgen_avail <- archive_available("https://www.staticgen.com/")
saveRDS(staticgen_avail, file = "data/staticgen_avail.rds")
staticgen_avail
staticgen_avail <- archive_available("https://www.staticgen.com/")
saveRDS(staticgen_avail, file = "data/staticgen_avail.rds")
staticgen_avail
