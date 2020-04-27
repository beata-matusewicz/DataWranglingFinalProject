library(tidyverse)
library(rvest)

url <- "https://en.wikipedia.org/wiki/List_of_colleges_and_universities_in_Connecticut"

# very difficult to find full list of colleges that is not in javascript
# decided to go with just state universities
# had to read html for each state in wikipedia

wiki_function <- function (x) {

url <- x

state <- url %>%
  read_html () %>%
  html_nodes (xpath = '//*[@id="firstHeading"]') %>%
  html_text () %>% 
  str_replace ("List of colleges and universities in ", "")

wiki <- url %>%
  read_html () %>% 
  html_nodes (xpath = '//*[@id="mw-content-text"]/div/table[1]') %>%
  html_table (fill = TRUE) %>%
  .[[1]] %>%
  as_tibble () %>% 
  mutate (state = state) %>%
  print()

}

# figure out how to get links out of here...
"https://en.wikipedia.org/wiki/Lists_of_American_institutions_of_higher_education" %>%
  read_html () %>%
  html_nodes ("a") %>%
  sapply(function(x) x[[2]])
  

  unlist () %>%
  str_extract_all ("(/wiki/List_of_colleges_and_universities_in_)+.*") %>%
  View ()





wiki_function ("https://en.wikipedia.org/wiki/List_of_colleges_and_universities_in_Connecticut")

