library(stringr)

# function to remove certain characters from a character representation of a number of a column
# this also sets missing values to NA which we can then set to 0
numCleaner <- function(df, colname, string) {
  df[[colname]] <- df[[colname]] %>%
    str_replace_all(string, "") %>%
    as.numeric()
  return(df)
}

# function to generate a basic linear model for predicting number of deaths based on number of cases
# (assumes the dataframe has 'TotalDeaths' and 'TotalCases' variables)
lm.deaths <- function(df) {
  model <- lm(TotalDeaths ~ TotalCases, data = df)
  return(model)
}

# function to generate a basic linear model for predicting number of cases based on number of tests
# (assumes the dataframe has 'TotalCases' and 'TotalTests' variables)
lm.cases <- function(df) {
  model <- lm(TotalCases ~ TotalTests, data = df)
  return(model)
}