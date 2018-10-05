# Linear Regression on Lung Capacity data 
# LungCapData is attached in this repository

lungs_data <- read.csv("C:\Users\Ankur\Documents\Data Science\Courses\DS 510\LungCapData.csv")
View(lungs_data)
# view the dataset and the results

summary(lungs_data)
# variables: LungCapData, Age, Height, Smoke, Gender, Caesarean 
# LungCap mean = 7.863
# Age mean = 12.33

str(lungs_data)
# dataframe of 725 observations of 6 variables

plot(lungs_data$Age, lungs_data$LungCap, main = "Scatterplot") 
# scatterplot of relationship between Lung Capacity and Age
cor(lungs_data$Age, lungs_data$LungCap)
# their correlation is fairly positive

help(lm)
# get information about lm function for regression
# can also use following: ?lm

model <- lm(lungs_data$LungCap ~ lungs_data$Age, data = lungs_data) 
# linear regression on Lungcap as dependent and Age as independent variable

summary(model)
# p-value extremely low so significant
# r-squared is the percentage of variation

attributes(model)
# all attributes stored in the model

model$coefficients
# coefficients of the linear model equation
B0 <- model$coefficients[1]
B1 <- model$coefficients[2]

plot(lungs_data$Age, lungs_data$LungCap, main = "Scatterplot")
# scatterplot of Age as x and LungCap as y
abline(model, col = "red", lwd = 3) 
# regression line added in the plot with color and line width 

confint(model)
# confidence interval for the cofficients
confint(model, level=0.99)
# changed to 99%, standard is 95% 

## check validity of the regression
# dataset divided into 80-20 ratio for training-test
training <- lungs_data[1:580,] 
View(training)
test <- lungs_data[581:725,] 
View(test)

rownames(test) <- seq(length=nrow(test))
# reset the sequence 

model1 <-lm(training$LungCap ~ training$Age) 
summary(model1) 
# linear regression on training dataset

pred <- coef(model1)[1] + coef(model1)[2]*test$Age 
View(pred) 
# predict values against test dataset

test_lungs <- test[,1] 
View(test_lungs) 
# Lung Capacity values from the test dataset
# all rows and 1st column of Lung Capacity values

error1 <- test_lungs - pred 
View(error1)
# error difference between predicted and actual values

plot(error1, xlab = 'Error', ylab = 'Residual')
abline(0,0) 
# plot error and line with 0 slope, 0 intercept
summary(error1)

hist(error1, prob = T, breaks = 10, xlab = 'Error Residual', ylab = 'Density') 
lines(density(error1), col='red') 
# histogram of errors
# plot of errors

## normalize the curve
mu_e <- mean(error1) 
# mean
v_e <- var(error1) 
# variance
sd_e <- sqrt(v_e)
# standard deviation
x_e <- seq(-4,4, length=20)
# 20 randomly generated numbers between -4 and +4
y_e <- dnorm(x_e, mu_e, sd_e)
# distribute the values using Normal Distribution using function dnorm 
lines(x_e, y_e, col = 'blue') 
# plot the curve representing ideal normally distributed values
# blue curve to compare with the output red curve to analyze the distribution

