# Logistic Regression on Grades data
# Grades is attached in this repository

# FYI: position cursor over function to see its syntax details

grade <- read.csv("C:\Users\Ankur\Documents\Data Science\Courses\DS 510\Grades.csv")
# if URL not reading, can use function below to browse and select file
grades <- read.csv(file.choose())
View(grade)

summary(grade)
str(grade)
# 400 observations of 4 variables (admit, gre, gpa, rank)

grade$admit <- as.factor(grade$admit) 
grade$rank <- as.factor(grade$rank)
# convert variables from integer to factor

xtabs(~admit + rank, data = grade) 
# two-way table for factor variable
# recommended only with factor variable

temp <- sample(2, nrow(grade), replace = T, prob = c(0.8,0.2)) 
# temp variable to store ramdomly generated values (1 & 2) with ratio 80-20

train <- grade[temp==1,] 
test <- grade[temp==2,]
# move all observations assigned 1 to train object
# move all observations assigned 2 to test object

View(train)
View(test)
# view the datasets

## Apply Logistic Regression
model <-  glm(admit ~ gre + gpa + rank, data = train, family = 'binomial') 
summary(model)
# check significance codes of variables
# Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

### difference between glm and lm is described in glm_lm repository file in Extracurricular->Beginner

model2 <- glm(admit ~ gpa + rank, data = train, family = 'binomial') 
summary(model2) 
# run model again after removing gre as it is insignificant 

pred1 <- predict(model2, train, type = 'response') 
# predict the probability against each observation in training dataset

head(pred1) 
# first 6 probabilities automatically
head(pred1, 10)
# first 10 observations in train dataset

coef(model2)
# coefficients of variables and intercept in model2

coef_B0 <- coef(model2)[1] 
coef_gpa <- coef(model2)[2]  
coef_r2 <- coef(model2)[3] 
coef_r3 <- coef(model2)[4] 
coef_r4 <- coef(model2)[5] 
# define variables to coefficients 

y = coef_B0 + coef_gpa*3.61 + coef_r3*1 
y
# manually computing probability for input: gpa=3.61 & rank=3
p <- exp(y)/(1+exp(y))
p
# calculate probability

y2 = coef_B0 + coef_gpa*4 
y2 
# gpa=4 & rank=1
# rank 1 selected by default if a coef_rank is not selected
p2 <- exp(y2)/(1+exp(y2)) 
p2 
# lower rank means more negative coefficients so high rejection

prediction_1 <- ifelse(pred1>0.5, 1, 0)
# prediction parameter 
# if prediction more than 0.5 then selected and if lower than 0.5 then rejected  
tab1 <- table(Predicted = prediction_1, Actual = train$admit) 
tab1 
# confusion matrix of the predicted vs actual results in tabular form
sum(diag(tab1))/sum(tab1)*10
# accuracy measured to be 72.619

pred_2 <- predict(model2, test, type = 'response') 
prediction_2 <- ifelse(pred_2 > 0.5,1,0) 
tab2 <- table(Predicted = prediction_2, Actual = test$admit) 
tab2 
sum(diag(tab2))/sum(tab2)*100 
# similar validation on test dataset
# accuracy of 70.3125

