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
         sn_accounts_other) |> 
  # Rename long columns
  rename(mastodon_motivation_new_social_network = mastodon_motivation_i_wanted_to_try_a_new_social_network, 
         mastodon_motivation_friends = mastodon_motivation_most_of_my_friends_and_people_i_follow_are_already_using_mastodon,
         mastodon_motivation_500_characters = mastodon_motivation_ability_to_write_up_to_500_characters_in_a_toot,
         mastodon_motivation_elon_musk = mastodon_motivation_i_m_concerned_about_elon_musk_acquiring_twitter,
         mastodon_motivation_twitter_events = mastodon_motivation_i_m_concerned_by_latest_events_in_twitter,
         mastodon_motivation_twitter_dissappear = mastodon_motivation_i_m_concerned_that_twitter_may_dissappear,
         mastodon_motivation_twitter_dissatisfaction = mastodon_motivation_i_m_dissatisfied_with_twitter_and_mastodon_seemed_like_an_alternative,
         mastodon_motivation_truth_social_dissatisfaction = mastodon_motivation_i_wasn_t_happy_with_truth_social_and_mastodon_seemed_like_an_alternative,
         instance_criteria_managers = instance_criteria_instance_s_manager_s,
         instance_criteria_n_users = instance_criteria_number_of_users,
         instance_criteria_free = instance_criteria_free_account_no_subscription_costs,
         instance_criteria_signup_approval = instance_criteria_signup_requires_admin_to_approve_verify_the_account,
         mastodon_experience_harassment = mastodon_experience_harassment_towards_certain_users,
         mastodon_experience_hate_speech = mastodon_experience_hate_speech_towards_certain_demographics,
         mastodon_experience_alt_text = mastodon_experience_image_descriptions_text_descriptions_for_visually_impaired,
         mastodon_experience_quality_conversations = mastodon_experience_respectful_constructive_conversations,
         mastodon_rating_ease_of_use = mastodon_rating_mastodon_is_easy_to_use,
         mastodon_rating_safe_space = mastodon_rating_mastodon_is_a_safe_space_for_social_interactions,
         mastodon_rating_welcoming = mastodon_rating_mastodon_is_welcoming_to_new_users,
         mastodon_rating_content = mastodon_rating_i_can_find_interesting_and_relevant_content_in_mastodon,
         mastodon_rating_people = mastodon_rating_i_can_find_interesting_and_relevant_people_in_mastodon,
         mastodon_rating_server_admin = mastodon_rating_i_trust_my_mastodon_s_server_instance_admin,
         mastodon_rating_social_conventions = mastodon_rating_mastodon_s_social_conventions_contribute_to_make_mastodon_a_better_place,
         twitter_experience_harassment = twitter_experience_harassment_towards_certain_users,
         twitter_experience_hate_speech = twitter_experience_hate_speech_towards_certain_demographics,
         twitter_experience_alt_text = twitter_experience_image_descriptions_text_descriptions_for_visually_impaired,
         twitter_experience_quality_conversations = twitter_experience_respectful_constructive_conversations)

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
