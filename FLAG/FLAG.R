## Task 1

load("/Users/apatel8/Downloads/FLAG.Rdata")
# loading FLAG dataset
summary(FLAG)
# summarize the basic statistics of FLAG
str(FLAG)
# structure of FLAG to find out how many observations and variables
library(psych)
# install psych package for describe function
describe(FLAG)
# decscribe the statistics of STATUS to get statistics of each variable
freqSTATUS <- table(FLAG$STATUS)
freqSTATUS
# 185 of 0 STATUS and 50 of 1 STATUS
hist(FLAG$COST, col="red")
# histogram of COST, color of red


## Task 2

hist(FLAG$STATUS)
densitySTATUS <- density(FLAG$STATUS)
densitySTATUS
plot(densitySTATUS)
# much better view of distribution using density instead of histogram
# density of 0 STATUS is higher than 1 STATUS
library(sm)
attach(FLAG)
sm.density.compare(COST,STATUS)
# cost and status are very similar, both right-skewed

## Task 3

boxplot(DOTEST~STATUS, data=FLAG, main="FLAG",
        xlab="DOTEST", ylab="STATUS")
# boxplot of DOTEST by STATES 
boxplot(STATUS~DOTEST, data=FLAG, main="FLAG",
        xlab="DOTEST", ylab="STATUS")
# no boxplot, just to test what it looks like when switched axis

