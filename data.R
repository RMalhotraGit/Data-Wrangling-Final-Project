library(rvest)

# scraping world data
url_world <- "https://www.worldometers.info/coronavirus/"
world <- url_world %>%
  read_html() %>%
  html_table(fill = TRUE) %>%
  .[[1]]

# saving only countries
world <- world[(world$`Country,Other` != "Asia") &
    (world$`Country,Other` != "Europe") &
    (world$`Country,Other` != "") &
    (world$`Country,Other` != "North America") &
    (world$`Country,Other` != "South America") &
    (world$`Country,Other` != "Oceania") &
    (world$`Country,Other` != "Africa") &
    (world$`Country,Other` != "World") &
    (world$`Country,Other` != "Diamond Princess") &
    (world$`Country,Other` != "Total:"),]
