# some background
# http://statistics.gov.scot/data/deaths-involving-coronavirus-covid-19
# https://medium.swirrl.com/using-r-to-analyse-linked-data-7225eefe2eb8
#
# training resources
# https://guides.statistics.gov.scot/article/22-querying-data-with-sparql
# https://guides.statistics.gov.scot/article/34-understanding-the-data-structure


# going to use the package "SPARQL" to source the data
library(SPARQL)
library(dplyr)
library(tidyr)
library(stringr)
library(lubridate)
library(here)

source(here("SPARQL_queries", "SG_SparQL_Queries.R"))

pd <- get_SG_Population_SparQL()
pop_full <- pd$results
pop_boards <- pop_full %>% 
  filter(sex == "All", age == "All") 
  

# get the data
qd <- get_SG_Covid_SparQL()
Covid_full <- qd$results
summary(Covid_full)

# add a date field to use instead of the week commencing field
# get the area code from the URI
# convert Cause into a factor
Covid_full <- Covid_full %>% 
  mutate(
    week_beginning = ymd(
      str_extract(string = periodname, pattern = "\\d{4}[-]\\d{2}[-]\\d{2}")
    )
  ) %>% 
  mutate(areauri = str_extract(areauri, "\\S\\d\\d")) %>% 
  mutate(cause = as.factor(cause)) %>% 
  mutate(areauri = as.factor(areauri)) %>% 
  mutate(periodname = as.factor(periodname))

summary(Covid_full)

# add the Scotland Population Projection for 2020
Covid_full <- Covid_full %>% 
  left_join(pop_boards %>% select(area, nPeople)) %>% 
  mutate(deaths_per_thousand = nDeaths / (nPeople/1000)) 

#split the data into three tables:
#  - Scotland_YearToDate
#  - Scotland_by_Week
#  - BoardsCause_YearToDate
#  - BoardsCause_by_Week
#  - Demographics_YearToDate
#  - Demographics_by_Week

Scotland_Location_YearToDate <- Covid_full %>% 
  dplyr::filter(periodname == 2020 & area == "Scotland" & sex == "All" & age == "All") %>% 
  select(-week_beginning, -sex, -age)

Scotland_Location_by_Week <- Covid_full %>%
  dplyr::filter(area == "Scotland" & periodname != 2020 & sex == "All" & age == "All") %>% 
  select( -age, -sex)  

Scotland_Age_YearToDate <- Covid_full %>% 
  dplyr::filter(periodname == 2020 & area == "Scotland" & sex == "All" & location == "All") %>% 
  select(-week_beginning, -sex, -location)

Scotland_Age_by_Week <- Covid_full %>%
  dplyr::filter(area == "Scotland" & periodname != 2020 & sex == "All" & location == "All") %>% 
  select( -location, -sex) 

BoardsCause_YearToDate<- Covid_full %>% 
  dplyr::filter(periodname == 2020 & areauri == "S08") %>% 
  select(-week_beginning, -sex, -age)

BoardsCause_by_Week<- Covid_full %>% 
  dplyr::filter(periodname != 2020 & areauri == "S08") %>% 
  select(-age, -sex, -areauri, -location)

CouncilsCause_YearToDate<- Covid_full %>% 
  dplyr::filter(periodname == 2020 & areauri == "S12") %>% 
  select(-week_beginning, -sex, -age)

CouncilsCause_by_Week<- Covid_full %>% 
  dplyr::filter(periodname != 2020 & areauri == "S12") %>% 
  select(-age, -sex, -location)

Demographics_YearToDate<- Covid_full %>% 
  dplyr::filter(periodname == 2020 & sex != "All") %>% 
  select(-week_beginning, -area, -areauri, -location)

Demographics_by_Week<- Covid_full %>% 
  dplyr::filter(periodname != 2020 & sex != "All" & age !="All") %>% 
  select(-area, -areauri, -location)


External_events <- tribble(
  ~ date, ~ event,
  "2020-01-30", "Global health\nemergency declared",
  "2020-03-11", "Pandemic\ndeclared",
  "2020-02-13", "China reporting\nchange",
  "2020-03-23", "UK lockdown\nstarted"
) %>%
  mutate(date = as.Date(date))