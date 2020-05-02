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

# get the column names for columns with numeric values
numCols.nj <- colnames(nj)[colnames(nj) != "County"]
for (i in 1:length(numCols.nj)) {
  nj <- numCleaner(nj, numCols.nj[i], ",")
  nj <- numCleaner(nj, numCols.nj[i], "\\+")
}
