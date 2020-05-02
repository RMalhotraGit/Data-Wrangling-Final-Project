library(rvest)

# scraping united states data
url_us <- "https://www.worldometers.info/coronavirus/country/us/"

# 1st table on website is desired table
us <- url_us %>%
  read_html() %>%
  html_table(fill = TRUE) %>%
  .[[1]]

# saving only 50 states and DC
us <- us[(us$USAState != "USA Total") &
           (us$USAState != "Northern Mariana Islands") &
           (us$USAState != "Guam	") &
           (us$USAState != "Puerto Rico") &
           (us$USAState != "United States Virgin Islands") &
           (us$USAState != "Veteran Affairs") &
           (us$USAState != "US Military") &
           (us$USAState != "Federal Prisons") &
           (us$USAState != "Navajo Nation") &
           (us$USAState != "Grand Princess Ship") &
           (us$USAState != "Wuhan Repatriated") &
           (us$USAState != "Diamond Princess Ship") &
           (us$USAState != "Guam") &
           (us$USAState != "Total:"),]