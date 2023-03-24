# Functions for data manipulation.

#' Prepares dataframe with survey responses.
#' @description Reads a csv file containing qualtrics' export and cleans data.
#' @param file String pointing to the csv file.
#' @return Clean and tidy dataset with anonymised responses, ready to analise.
data_preparations <- function(file) {
  df <- readr::read_csv(here::here(file),
                        skip = 1, na = c("", " "),
                        col_type = list(.default = col_character())
                        ) |> 
    # Qualtrics adds comments to row one. They need to be removed.
    dplyr::filter(row_number() != 1) |> 
    # Cleaning up messy names (whitespaces, capitalisation...).
    janitor::clean_names() |> 
    # Anonymise
    select(-starts_with("recipient_"))
  
  return(df)
    
}

df<- data_preparations("data/Mastodon+survey_March+17,+2023_09.01.csv")
