# Project: Exploring Men's Mental Health in Humanitarian Crises Through NLP
This project takes inspiration from the pioneering work of Low, D. M., Rumker, L., Torous, J., Cecchi, G., Ghosh, S. S., & Talkar, T., as presented in their study titled ["Natural Language Processing Reveals Vulnerable Mental Health Support Groups and Heightened Health Anxiety on Reddit During COVID-19: Observational Study"](https://www.jmir.org/2020/10/e22635/) published in the Journal of Medical Internet Research (JMIR), volume 22, issue 10. Their study provided valuable insights into using natural language processing to analyze the impact of disruptive events, like the Covid-19 pandemic, on mental health. The datasets used in their study can be accessed [here](https://zenodo.org/record/3941387#.ZJRTV-zMJoY).

### Executive Summary
In the context of humanitarian crises, conflicts, and violence, there is a lack of research surrounding men's mental health and victimhood. While substantial attention has been directed towards addressing the well-being of women and children, the discourse centered on men's mental health struggles and experiences is slow to follow. This research project leverages Natural Language Processing (NLP) techniques to delve into Reddit discussions related to depression. By doing so, I aspire to contribute to a more inclusive and comprehensive approach to addressing mental well-being.

![image](https://github.com/akaba09/redditmentalhealth/blob/main/img/reddit.png)

I used sentiment analysis, zero-shot classifier, and topic modeling to explore posts in the r/depression subreddit before and after the pandemic. 

### Problem Statement
There is an alarming lack of research and discourse centered on the mental health struggles and experiences of men. This gap raises significant concerns about the holistic well-being of all individuals affected by humanitarian insecurities.

Reddit is a popular platform for sharing personal experiences. With a predominately male user base, Reddit is a valuable resource for examining the distinctions between how men and women express their vulnerabilities and experiences in times of instability.

### Data
I used the depression datasets provided in the study. I focused on two distnict datasets, namely [pre](https://zenodo.org/record/3941387/files/depression_pre_features_tfidf_256.csv?download=1) and [post](https://zenodo.org/record/3941387/files/depression_post_features_tfidf_256.csv?download=1) pandemic. 

* Pre-Pandemic Dataset: This dataset covers the period from December 2018 to December 2019, offering insights into discussions on depression before the outbreak of the COVID-19 pandemic.

* Post-Pandemic Dataset: The post-pandemic dataset encompasses the time frame from January 1 to April 2020, a period marked by the initial impact and response to the pandemic. Given, that there were far more posts for pre-pandemic, I used [push shift reddit API](https://pushshift.io/signup) to pull 1000 more posts. Access to the code for the pull is [here](https://github.com/akaba09/redditmentalhealth/blob/main/code/API_data/Pulled_data%20.ipynb) and the cleaned dataset is [here](https://github.com/akaba09/redditmentalhealth/blob/main/files/dep.csv). 


#### Description of Data
|Variables|Usage|
|:---|:---|
|Subreddit|type of subreddit depression|
|Covid period|time period of the pandemic in which the post were made|
|Gender|male or female identifying user|
|Covid period|pre or post|

For gender, I noticed that a common convention is for users to identify their gender by saying something like, "as a 18F, I..." I used regex to string match for the pattern of two digits followed by a M/F to estimate gender for the users.


### Data Cleaning
The data cleaning was done in Python, which can be accessed [here](https://github.com/akaba09/redditmentalhealth/blob/main/code/EDA/01_Clean_data.ipynb). I used regular expressions to eliminate special characters, numeric characters, html, and URLs. I also used it to filter out specific expressions that were gender identifying in order to categorize each post by gender. 

### Exploring the Data
While conducting exploratory data analysis, I explored common bigrams and trigrams used by both genders in discussions before and after the pandemic. The code for exploring the frequency of common words between genders can be accessed [here](AMI - ADD LINK HERE!)

![here](https://github.com/akaba09/redditmentalhealth/blob/main/img/trigram_pre.png)

The trigram analysis revealed a disparity in the use of "long story short" between male and female subreddit users, which seems aligned with the prevalent stigma associated with men being less inclined to openly discuss their emotional and mental well-being. Notably, male users tended to utilize indirect adjectives more frequently, whereas female users favored direct adjectives when discussing their well-being.

### Models 

#### BERTopic 
I first started off by conducting [BERTopic modeling](https://github.com/akaba09/redditmentalhealth/blob/main/code/Topic_modeling.ipynb) to categorize the various types of issues discussed in the subreddits.

Here are the top topics explored:
|topic number|topic ngram 1|topic ngram 2|topic ngram 3|
|:---|:---|:---|:---|
|0|ton work|motivated work|work semester|constant reminder|
|1|weight gain|bring doctor|mg wellbutrin|
|2|help help|help depression|think burden|
|3|medical student|tell parents|parents depression|
|4|personal level|age look|make friendship|
|5|person thoughts|tell people kill|lot suicidal|
|6|open track|owmfjtupls lgphmhscwymepbbdz|cilqvodbwctphoukbs zll|

For the full tabular output of the various ngram topics they can be viewed [here](https://github.com/akaba09/redditmentalhealth/blob/main/files/BERTopic_model.csv)

Something interesting that I found from the model was that "open track" was a prevalent topic, followed by the subtopics of a bunch of links to playlists recommended by other Reddit users. Could music be an outlet of expression or therapy for many of the subreddit users? Does it help them express what they can't say? Here's the [link](https://open.spotify.com/user/9jif2jecb7qpfw25qyz20c9ed/playlist/2Ka8i0P9BGogjccGz0FiE5?si=-p9yt61-QLqQhbqS2uED1w) to a glimpse of one of the playlists recommended by a subreddit user. 

#### Sentiment Analysis 
I decided to use a zero-shot classfication model from [HuggingFace](https://huggingface.co/MoritzLaurer/DeBERTa-v3-base-mnli-fever-anli) for sentiment analysis. 

* [Zero-Shot Classification](https://github.com/akaba09/redditmentalhealth/blob/main/code/zero_shot_classification.ipynb) is a task in NLP where a model is able to classify new text from previously unseen classes.

I assigned a bunch of labels to the model, such as "anticipation", "anger", "disgust", "fear", "joy", and "trust," to understand how the overall nuances surrounding depression had changed between both genders given the COVID period in which the posts were made.

![temp image](https://github.com/akaba09/redditmentalhealth/blob/main/img/sentiment_post.png)

Looking at the plot, we can see that the overall posts were categorized as either having positive or negative sentiments. Given the minimal nuances, I decided to exclude those labels and use Zero-Shot Classification to get a more comprehensive result of how sentiments around depression has chagned for both genders, pre/post covid. 

Here's a brief snippet of the model's output:
|index|subreddit|date|text|covid period|gender|labels|themesScores|
|:---|:---|:---|:---|:---|:---|:---|:---|
|0|depression|8/28/19|The sun hasn't even come up, and I'm f ready to go to bed again. So, I've got this weird thing where I'm depressed and anxious for a few days each month. Some months I'm fine, but it is usually the same time each month. My guess is it is hormone-related. Anyhow, I am so very grateful for everything I have in life, but I just can't help the way I feel. I know it's only temporary, but my boyfriend has left to work, and I'm laying here, just overwhelmed with emotions and crying.|pre|female|[anticipation, trust, fear]|[0.85821, 0.12961, 0.01218]|
|440|depression|7/25/23|on lexapro for months now and at the same time i started omprezalone for gerd last monday a day or two before these thoughts started my med lady switched me to protonix stomach meds and kept the lexapro the same she also had me taking almost mg of magnesium every day and iu of vitamin d my question is has anyone experienced this before and how did you overcome this my therapist believes it is depression getting the better of me and that the new stomach meds i am on are causing a bad reaction please give me hope i want to marry this girl|post|male|[fear, anticipation, joy]|[0.76342,0.2158, 0.02078]|

From this output, we can see how the model is more refined and highlights nuanced emotional dynamics, capturing complexities beyond standard positive or negative sentiments in the provided text. It emphasizes the model's capacity to discern and interpret subtle variations in emotional expression, offering a richer understanding of mental and emotional experiences between both genders.

Access to the full output is [here](https://github.com/akaba09/redditmentalhealth/blob/main/files/Zero_sentiment.csv) 

## Conclusion
In conclusion, by leveraging Natural Language Processing techniques to address the significant gap in research on men's mental health during humanitarian crises and through analysis of Reddit discussions on depression before and after the COVID-19 pandemic, various key findings emerged. Expoloring language patterns revealed distinct differences in expression between male and female users. BERTopic modeling uncovered prevalent topics, notably highlighting the role of music as a potential outlet for emotional expression. Sentiment analysis using a zero-shot classifier provided nuanced insights into the evolving and distinct emotional dynamics between males and females, emphasizing the need for a comprehensive understanding of mental health experiences. Overall, from the project we gain valuable insights to the discourse on men's mental health, leading to a further need in advocating for a more inclusive approach in addressing mental well-being during times of instability.
