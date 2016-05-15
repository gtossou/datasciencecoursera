#Définir le workspace

#Telecharger le fichier grace  à download.file 
URL <- "https://d37djvu3ytnwxt.cloudfront.net/asset-v1:MITx+15.071x_2a+2T2015+type@asset+block/AnonymityPoll.csv"
download.file(URL, destfile = "poll.csv", method="curl")

#Affectation à un data frame  
poll<-read.csv("poll.csv",header = TRUE)

#Synthèse des données du data frame
summary(poll)

#Details sur les variables (nom des colonnes) du data frame
str(poll)

#Combien de répondants à l'enquete ont un accès à Internet?

table(poll$Internet.Use)

#How many interviewees reported not having used the Internet and not having used a smartphone?
table(poll$Internet.Use, poll$Smartphone)

#Use the subset function to obtain a data frame called "limited",
#which is limited to interviewees who reported Internet use or who reported smartphone use
#The "select" part is just to select only a set of variables(its mandatory for the question)

limited<-subset(poll, poll$Internet.Use==1 | poll$Smartphone==1, select = c(Internet.Use,Smartphone))

#To count the number for the above question we can use dim or nrow
nrow(limited)
dim(limited)

#Which variables have missing values in the limited data frame? (summary)

#How many interviewees reported a value of 0 for Info.On.Internet?
table(limited$Info.On.Internet)

#What proportion of interviewees who answered the Worry.About.Info 
#question worry about how much information is available about them on the Internet?

#Often, we are interested in whether certain characteristics of interviewees (e.g. their age or political opinions)
#affect their opinions on the topic of the poll (in this case, opinions on privacy). 
#In this section, we will investigate the relationship between the characteristics Age and Smartphone and 
#outcome variables Info.On.Internet and Tried.Masking.Identity, again using the limited data frame
#we built in an earlier section of this problem.

#Build a histogram of the age of interviewees. What is the best represented age group in the population?
hist(limited$Age)

#What is the largest number of interviewees that have exactly the same value in their Age variable AND the same value in their Info.On.Internet variable? In other words, what is the largest number of overlapping 
#points in the plot plot(limited$Age, limited$Info.On.Internet)
max(table(limited$Age, limited$Info.On.Internet))
table(limited$Age, limited$Info.On.Internet)

#To avoid points covering each other up, we can use the jitter() function on the values we pass to the plot function. 
#Experimenting with the command jitter(c(1, 2, 3))

#jitter adds or subtracts a small amount of random noise to the values passed to it, 
#and two runs will yield different results

#For younger people aged 18-30, the average value of Info.On.Internet appears to be roughly 5, while most peopled aged 60 and older have a value less than 5. Therefore, older age appears to be associated 
#with a smaller value of Info.On.Internet, but from the spread of dots on the image, 
#it's clear the association is not particularly strong.
jitter(c(1, 2, 3))
plot(jitter(limited$Age), jitter(limited$Info.On.Internet))

#exemple d'utilisation de la fonction tapply 
# On souhaite connaître l'âge moyen selon le genre
Age <- c(12,15,23,29)
Genre <- c("homme", "homme", "femme", "femme")
data <- data.frame(Age, Genre)
tapply(data$Age, data$Genre, mean)

#What proportion of smartphone users who answered the Tried.Masking.
#Identity question have tried masking their identity when using the Internet? 0.1925

#What proportion of non-smartphone users who answered the Tried.Masking.
#Identity question have tried masking their identity when using the Internet? 0.1174

#We can get the breakdown for smartphone and non-smartphone users with:
  
tapply(limited$Tried.Masking.Identity, limited$Smartphone, table)

#Among smartphone users, 93 tried masking their identity and 390 did not, resulting in proportion 93/(93+390)=0.1925. Among non-smartphone users, 33 tried masking their identity and 248 did not, resulting in proportion 33/(33+248)=0.1174.

#This could have also been read from tapply(limited$Tried.Masking.Identity, limited$Smartphone, summary).
