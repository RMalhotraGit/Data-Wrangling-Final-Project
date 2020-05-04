library(rvest)
library(tidyr)
library(dplyr)

# scraping bergen county data
bergen_url <- "https://www.insidernj.com/bergen-county-town-covid-19-list-15982-cases-total-friday/"
bergen <- bergen_url %>%
  read_html() %>%
  html_nodes("p") %>%
  html_text()

# to find starting index, we look for Allendale, since list is in alphabetical order
startIndex <- 0
for (i in 1:length(bergen)) {
  if(grepl("*Allendale", bergen[i])) {
    startIndex <- i
  }
}
# add on 69 since there are a total of 70 cities/towns in Bergen county
endIndex <- startIndex + 69

# save just the cities/towns and cases from html text
bergen <- bergen[startIndex:endIndex]

# separate city/town and the number of cases
bergen <- separate(as.data.frame(bergen), bergen, c("City/Town", "TotalCases"), sep = ":")

# remove * that appears in some of the city/town names
bergen$`City/Town` <- bergen$`City/Town` %>%
  str_replace_all("\\*", "")

# convert cases from character type to numeric
bergen$TotalCases <- bergen$TotalCases %>% as.numeric()