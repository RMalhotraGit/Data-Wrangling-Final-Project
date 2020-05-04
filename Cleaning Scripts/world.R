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

### CHOROPLETHR VERSION OF DATA
# creating a copy of the dataset to use for choroplethr
world.choro <- world

# change to lower case
world.choro$`Country,Other` <- tolower(world.choro$`Country,Other`)

# change country names to match those in choroplethr
world.choro$`Country,Other`[world.choro$`Country,Other` == "usa"] <- "united states of america"
world.choro$`Country,Other`[world.choro$`Country,Other` == "uk"] <- "united kingdom"
world.choro$`Country,Other`[world.choro$`Country,Other` == "s. koera"] <- "south korea"
world.choro$`Country,Other`[world.choro$`Country,Other` == "czechia"] <- "czech republic"
world.choro$`Country,Other`[world.choro$`Country,Other` == "serbia"] <- "republic of serbia"
world.choro$`Country,Other`[world.choro$`Country,Other` == "uae"] <- "united arab emirates"
world.choro$`Country,Other`[world.choro$`Country,Other` == "north macedonia"] <- "macedonia"
world.choro$`Country,Other`[world.choro$`Country,Other` == "timor-leste"] <- "east timor"
world.choro$`Country,Other`[world.choro$`Country,Other` == "tanzania"] <- "united republic of tanzania"
world.choro$`Country,Other`[world.choro$`Country,Other` == "bahamas"] <- "the bahamas"
world.choro$`Country,Other`[world.choro$`Country,Other` == "drc"] <- "democratic republic of the congo"
world.choro$`Country,Other`[world.choro$`Country,Other` == "congo"] <- "republic of congo"
world.choro$`Country,Other`[world.choro$`Country,Other` == "guinea-bissau"] <- "guinea bissau"
