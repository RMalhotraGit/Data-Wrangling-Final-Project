library(rvest)
source("functions.R")

# scraping nj data
nj_url <- "https://www.worldometers.info/coronavirus/usa/new-jersey/"
nj <- nj_url %>%
  read_html() %>%
  html_table(fill = TRUE) %>%
  .[[1]]

# getting rid of column for total tests in NJ and source column
nj <- nj[, !names(nj) %in% c("TotalTests", "Source")]

# getting rid of rows that are not counties
nj <- nj[(nj$County != "New Jersey Total") &
           (nj$County != "Unassigned") &
           (nj$County != "Total:"),]

# get the column names for columns with numeric values and clean them
numCols.nj <- colnames(nj)[colnames(nj) != "County"]
for (i in 1:length(numCols.nj)) {
  nj <- numCleaner(nj, numCols.nj[i], ",")
  nj <- numCleaner(nj, numCols.nj[i], "\\+")
}

# change NA values to 0
nj[is.na(nj)] <- 0

# reassinging id values to account for removed rows
rownames(nj) <- seq(1, dim(nj)[1])

# CHOROPLETHR VERSION OF DATA
#nj.choro <- nj

# change to lower case
#nj.choro$County <- tolower(nj.choro$County)