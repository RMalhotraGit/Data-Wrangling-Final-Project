library(rvest)
source("functions.R")

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

# get the column names for columns with numeric values
numCols.world <- colnames(world)[colnames(world) != "Country,Other" & colnames(world) != "Continent"]
for (i in 1:length(numCols.world)) {
  world <- numCleaner(world, numCols.world[i], ",")
  world <- numCleaner(world, numCols.world[i], "\\+")
}

# change NA values to 0
world[is.na(world)] <- 0

# reassinging id values to account for removed rows
rownames(world) <- seq(1, dim(world)[1])

# create a death rate variable
world$DeathRate <- world$TotalDeaths/world$TotalCases