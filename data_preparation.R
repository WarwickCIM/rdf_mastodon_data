# Prepares an anonymised and clean dataset to be used for the analysis.

library(dplyr)
library(janitor)

filename <- "Mastodon+survey_March+24,+2023_09.44.csv"


# Question texts ----------------------------------------------------------

df_question_text <- read.csv(paste0("data/raw/", filename))


# Responses ---------------------------------------------------------------

df_responses <- read.csv(paste0("data/raw/", filename), skip = 1, 
               na.strings = c("", " ")) |> 
  as_tibble() |> 
  # Qualtrics adds comments to row one. They need to be removed.
  filter(row_number() != 1) |> 
  # Cleaning up messy names (whitespaces, capitalisation...).
  janitor::clean_names() |> 
  # Combine columns
  mutate(source = case_when(q_chl == "email" ~ "email",
                            .default = source)) |> 
  # Remove unnecessary fields
  select(-finished, -external_data_reference, 
         -response_type,
         -distribution_channel,
         -q_total_duration,
         -q_dl,
         -q_chl) |> 
  # Remove columns with only NA values
  select_if(function(x){!all(is.na(x))}) |> 
  # At the beginning there wasn't any option not to specify that
  # people didn't have an account on any of the social media platforms from the
  # list. This should fix that
  mutate(sn_accounts = case_when(grepl("non|^no", tolower(sn_accounts_other))
                                 ~"None of the above",
                                 .default = sn_accounts),
         sn_accounts_other)

write.csv(df_responses, file = "data/responses_clean.csv", 
          row.names = FALSE)

df_responses_anonymised <- df_responses |> 
  # Anonymisation
  select(-starts_with("recipient_"),
         -ip_address,
         -starts_with("location_"), # Technically, the location is not accurate: https://www.qualtrics.com/support/survey-platform/data-and-analysis-module/data/download-data/understanding-your-dataset/
         -mastodon_account,
         -open_comments)

write.csv(df_responses_anonymised, file = "data/responses_anonymised.csv", 
          row.names = FALSE)


# Comments ----------------------------------------------------------------

# Comments may contain sensitive information, so not including them in the
# anonymised version, while keeping an untracked file.

df_comments <- read.csv(paste0("data/raw/", filename), skip = 1, 
                        na.strings = c("", " ")) |> 
  select(open_comments) |> 
  filter(!is.na(open_comments))

write.csv(df_comments, "data/survey_comments.csv", 
          row.names = FALSE)
