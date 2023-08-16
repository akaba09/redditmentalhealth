library(data.table)
library(ggplot2)
library(dplyr)
library(tidytext)
library(tidyr)
library(stringr)
library(magrittr)
library(readr)
library(ggridges)

# Install textdata library for afinn library
install.packages("textdata")
library(textdata)

# Open dep csv
dep = read_csv("julia-1.5.3/dep.csv", show_col_types = FALSE)
dep

# Drop unneeded columns 
dep.1 = subset(dep, select = c("post", "gender", "covid period"))
dep.1

# Rename columns
dep.1 = dep.1 %>%
  rename(period = "covid period", text = "post")
dep.1


# Convert into tibble 
dep.1_df = tibble(line = 1:852, text = dep.1$text, gender = dep.1$gender)
dep.1_df

# Analyze bigrams 
bigrams = dep.1_df %>%
  unnest_tokens(bigram, text, token = "ngrams", n = 2)
bigrams

# AFINN library 
AFINN = get_sentiments("afinn")
AFINN

# Get bigrams that begin with the word "mental" in pre 
lan_bigrams_separated <- bigrams %>%
  filter(period == "pre") %>%
  separate(bigram, c("word1", "word2"), sep = " ") %>%
  filter(word1 == "depression") %>%
  count(word1, word2, sort = TRUE)
lan_bigrams_separated
