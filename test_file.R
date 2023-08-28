setwd("../../repos")
library(data.table)
library(ggplot2)
library(dplyr)
library(tidytext)
library(tidyr)
library(stringr)
library(magrittr)
library(readr)
library(ggridges)
library(ggjoy)

# Install textdata library for afinn library
install.packages("textdata")
library(textdata)

# Open dep csv
dep = read_csv("../../mnt/dep.csv", show_col_types = FALSE)
dep

# Drop unneeded columns 
dep.1 = subset(dep, select = c("post", "gender", "covid period"))
dep.1

# Rename columns
dep.1 = dep.1 %>%
  rename(period = "covid period", text = "post")
dep.1

# Convert into tibble 
dep.1_df = tibble(line = 1:852, text = dep.1$text, gender = dep.1$gender, period = dep.1$period)
dep.1_df

# Analyze bigrams 
bigrams = dep.1_df %>%
  unnest_tokens(bigram, text, token = "ngrams", n = 2)
bigrams

# AFINN library 
AFINN = get_sentiments("afinn")
AFINN

# Get bigrams that begin with the word "depression" for pre-pandemic posts
pre_bigrams_separated <- bigrams %>%
  filter(period == "pre") %>%
  separate(bigram, c("word1", "word2"), sep = " ") %>%
  filter(word1 == "depression") %>%
  count(word1, word2, sort = TRUE)
pre_bigrams_separated

#get family words for pre-pandemic
pre_dep_words = pre_bigrams_separated %>%
  filter(word1 == "depression") %>%
  inner_join(AFINN, by = c(word2 = "word")) %>%
  count(word2, value, sort = TRUE)
pre_dep_words

#graph positive v negative sentiments pre-pandemic 
pre_dep_words %>%
  mutate(contribution = n * value) %>%
  arrange(desc(abs(contribution))) %>%
  head(20) %>%
  mutate(word2 = reorder(word2, contribution)) %>%
  ggplot(aes(word2, n * value, fill = n * value > 0)) +
  geom_col(show.legend = FALSE) +
  ggtitle("Words preceded by \"Depression\" in pre-pandemic subreddit posts") +
  xlab("Word after Depression") +
  ylab("Sentiment value * number of occurrences") +
  coord_flip()


#get bigrams that begin with the word "depression" for post-pandemic posts
post_bigrams_separated = bigrams %>%
  filter(period == "post") %>%
  separate(bigram, c("word1", "word2"), sep = " ") %>%
  filter(word1 == "depression") %>%
  count(word1, word2, sort = TRUE)
post_bigrams_separated

# Get family words related to "depression"
post_dep_words <- post_bigrams_separated %>%
  filter(word1 == "depression") %>%
  inner_join(AFINN, by = c(word2 = "word")) %>%
  count(word2, value, sort = TRUE)
post_dep_words

post_dep_words %>%
  mutate(contribution = n * value) %>%
  arrange(desc(abs(contribution))) %>%
  head(20) %>%
  mutate(word2 = reorder(word2, contribution)) %>%
  ggplot(aes(word2, n * value, fill = n * value > 0)) +
  geom_col(show.legend = FALSE) +
  ggtitle("Words preceded by \"Depression\" in pre-pandemic subreddit posts") +
  xlab("Word after Depression") +
  ylab("Sentiment value * number of occurrences") +
  coord_flip()


#Emotional analysis 

# get the words in my text
cleaned_text <- dep.1_df %>%
  unnest_tokens(word,text) 

# import nrc library
# this library has emotional categories
nrc <- get_sentiments("nrc")

# join the words with library
nrc_words <- cleaned_text %>%
  inner_join(get_sentiments("nrc"), by = "word", relationship = "many-to-many")


#Without normalization 
  # Subset data for pre and post COVID periods
  female_covid <- nrc_words[nrc_words$gender == "female", ]
  male_covid <- nrc_words[nrc_words$gender == "male", ]
  
# Create a custom color palette
  custom_palette <- c("#1f77b4", "#ff7f0e")
  
 # Create a bar graph for pre covid 
  ggplot(data = pre_covid, aes(x = sentiment, fill = gender)) +
    geom_bar(position = "dodge") +
    scale_fill_manual(values = custom_palette) +  # Apply custom color palette
    theme_minimal() +
    xlab("Sentiment") + ylab("Total Count") +
    ggtitle("Total Sentiment Score for Men and Women Before and After COVID") +
    scale_fill_discrete(name = "Gender") +
    facet_grid(. ~ period, labeller = label_parsed)
  
  # Create a bar graph for post covid 
  ggplot(data = post_covid, aes(x = sentiment, fill = gender)) +
    geom_histogram(aes( y= after_stat(density) )) +
    scale_fill_manual(values = custom_palette) +  # Apply custom color palette
    theme_minimal() +
    xlab("Sentiment") + ylab("Total Count") +
    ggtitle("Total Sentiment Score for Men and Women Before and After COVID") +
    scale_fill_discrete(name = "Gender") +
    facet_grid(. ~ period, labeller = label_parsed)
  
  
  
  
#With normalization 
  # Calculate normalized counts for pre_covid dataframe
  female_covid_norm <- female_covid %>%
    group_by(period, sentiment) %>%
    summarise(total_count = n(), .groups = "drop") %>%
    group_by(period) %>%
    mutate(normalized_count = total_count / sum(total_count) , .groups = "drop")
  
  # Calculate normalized counts for post_covid dataframe
  male_covid_norm <- male_covid %>%
    group_by(period, sentiment) %>%
    summarize(total_count = n(), .groups = "drop") %>%
    group_by(period) %>%
    mutate(normalized_count = total_count / sum(total_count), .groups = "drop")
  
  # Combine normalized dataframes
  normalized_data <- bind_rows(
    mutate(female_covid_norm, gender = "female"),
    mutate(male_covid_norm, gender = "male")
  )
  
  # Define custom color palette
  custom_palette <- c("#E69F00", "#56B4E9")
  
  # Create the bar graph with normalized data
  ggplot(data = normalized_data, aes(x = sentiment, y = normalized_count, fill = gender)) +
    geom_bar(position = "dodge", stat = "identity") +
    scale_fill_manual(values = custom_palette) +
    theme_minimal() +
    xlab("Sentiment") + ylab("Normalized Count") +
    ggtitle("Normalized Sentiment Distribution for Men and Women Before and After COVID") +
    scale_fill_discrete(name = "Gender") +
    facet_grid(. ~ period, labeller = label_parsed)
  
  