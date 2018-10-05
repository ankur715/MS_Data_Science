## Support Vector Machines
## iris dataset

install.packages('e1071')
library(e1071)

data()
# pre fed datasets in R

head(iris)
# first 6 entries of iris dataset

data(iris)
# activate iris dataset
summary(iris)
str(iris)
# 150 observations of 5 variables
# 50 observations for each of 3 species

plot(iris$Petal.Length, iris$Petal.Width, col=iris$Species)
# scatterplot of petal width as dependent of petal length is linear
plot(iris$Sepal.Length, iris$Sepal.Width, col=iris$Species)
# scatterplot of sepal width as dependent of sepal length is not much correlation

s <- sample(1:150, 100)
# sample sequence of 100 numbers from range 1 to 150

iris_train <- iris[s,3:5] 
iris_test <- iris[-s,3:5] 
# training and test datasets study petal width and length 
# 100 random samples from iris in train and remaining 50 in test

model <- svm(Species ~., data = iris_train, kernel = "linear") 
summary(model) 
plot(model, iris_train)
# svm performs classification and regression

pred <- predict(model, iris_test, type = "class") 
plot(model, iris_test)
plot(pred)
# predicts test dataset according to model calculations

tab <- table(Predicted = pred, Actual = iris_test[,3]) 
tab
# compare predicted test values with actual test values 

sum(diag(tab))/sum(tab)*100 
# accuracy of 96%
