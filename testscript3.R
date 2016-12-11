# Reading Data
library(rpart)
library(rattle)
library(rpart.plot)
library(RColorBrewer)
train = read.csv("C:/Users/AGGARWAL'S/Desktop/Titanic/train.csv" ,stringsAsFactors=FALSE)
test = read.csv("C:/Users/AGGARWAL'S/Desktop/Titanic/test.csv" ,stringsAsFactors=FALSE)
str(train)

fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked,
             data = train,method = "class")
fancyRpartPlot(fit)

Prediction <- predict(fit, test, type = "class")
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "myfirstdtree.csv", row.names = FALSE)
