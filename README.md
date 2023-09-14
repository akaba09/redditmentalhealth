# Project: Exploring Men's Mental Health in Humanitarian Crises Through NLP
This project takes inspiration from the pioneering work of Low, D. M., Rumker, L., Torous, J., Cecchi, G., Ghosh, S. S., & Talkar, T., as presented in their study titled ["Natural Language Processing Reveals Vulnerable Mental Health Support Groups and Heightened Health Anxiety on Reddit During COVID-19: Observational Study"](https://www.jmir.org/2020/10/e22635/) published in the Journal of Medical Internet Research (JMIR), volume 22, issue 10. Their study provided valuable insights into using natural language processing to analyze distinct and critical gaps in the discourse regarding men's mental health during times of humanitarian insecurities. The datasets used in their study can be accessed [here](https://zenodo.org/record/3941387#.ZJRTV-zMJoY).

## Executive Summary
In response to the striking knowledge gaps surrounding men's mental health and victimhood during humanitarian crises and conflicts, this research project leverages Natural Language Processing (NLP) techniques to delve into Reddit discussions related to depression. Our aim is to illuminate the often-overlooked narratives and expressions of men who have experienced these challenging circumstances. By doing so, I aspire to contribute to a more inclusive and comprehensive approach to using mental well-being during times of humanitarian insecurity to exemplify the lack of discourse.

*ADD VISUAL FROM CANVA ![here]()

I did an in-depth examination of Reddit postings dealing with depression in the context of humanitarian inseurities. I used sentiment analysis techniques and Natural Language Processing (NLP) methodologies, particularly zero-shot classifier. In order to identify and categorize topics and themes the most prevalent in this dataset in order to capture the distinct emotional essence and subtle nuances embedded in these posts between male and female. -> edit tmm

## Problem Statement
In the context of humanitarian crises, conflicts, and violence, there exists a noticeable lack of discourse surrounding men's mental health and victimhood. While substantial attention has been directed towards addressing the mental well-being of women and children in such challenging circumstances, there is an alarming lack of research and discourse centered on the mental health struggles and experiences of men. This gap in understanding and acknowledgment raises significant concerns about the holistic well-being of all individuals affected by humanitarian insecurities.

To bridge this knowledge gap and gain insights into the nuanced experiences of men as victims in times of crisis, conflict, or violence, it's important to leverage digital platforms such as Reddit, specifically focusing on subreddit discussions related to depression. Reddit is a popular platform for sharing personal experiences, with the majority of their users being male, including struggles with mental health, making it a valuable resource for examining how men express their vulnerabilities and experiences in times of humanitarian instability like the pandemic (Covid-19).

## Data
For the data I primarily utilized the depression datasets provided in the study. I focused on two distnict datasets, namely [pre](https://zenodo.org/record/3941387/files/depression_pre_features_tfidf_256.csv?download=1) and [post](https://zenodo.org/record/3941387/files/depression_post_features_tfidf_256.csv?download=1) pandemic. 

* Pre-Pandemic Dataset: This dataset covers the period from December 2018 to December 2019, offering insights into discussions on depression before the outbreak of the COVID-19 pandemic.

* Post-Pandemic Dataset: The post-pandemic dataset encompasses the time frame from January 1 to April 2020, a period marked by the initial impact and response to the pandemic.

### Description of Data
|Variables|Usage|
|:---|:---|
|Subreddit|type of subreddit depression|
|Covid period|time period of the pandemic in which the post were made|
|gender|male or female subreddit user|
|covid period|pre or post|

Given, that there were far more psot for pre pandemic using [push shift][] I was able to pull 1000 more reddit posts from 2023 to make the datasets a bit more identical in length/amount. Access to the code for the pull is [here](https://github.com/akaba09/redditmentalhealth/blob/main/code/API_data/Pulled_data%20.ipynb) and the cleaned dataset is [here](https://github.com/akaba09/redditmentalhealth/blob/main/files/dep.csv). 

## Data Cleaning
The data cleaning was done in Python, which can be accessed [here](https://github.com/akaba09/redditmentalhealth/blob/main/code/EDA/01_Clean_data.ipynb). I used regular expressions to eliminate special characters, numeric characters, html, and URLs. I also used it to filter out specific expressions that were gender identifying in order to categorize each post by gender. 

## Exploring the Data
The expl
## Models 

## Conclusion

## Next Steps

