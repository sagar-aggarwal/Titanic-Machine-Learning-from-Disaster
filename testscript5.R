# Reading Data
library(rpart)
library(rattle)
library(rpart.plot)
library(RColorBrewer)
train = read.csv("C:/Users/AGGARWAL'S/Desktop/Titanic/train.csv" ,stringsAsFactors=FALSE)
test = read.csv("C:/Users/AGGARWAL'S/Desktop/Titanic/test.csv" ,stringsAsFactors=FALSE)
str(train)

test$Survived <- NA
alldata <- rbind(train, test)
alldata$Title <- sapply(alldata$Name, FUN=function(x) {strsplit(x, split='[,.]')[[1]][2]})
alldata$Title <- sub(' ', '', alldata$Title)
alldata$Title[alldata$Title %in% c('Mme', 'Mlle')] <- 'Mlle'
alldata$Title[alldata$Title %in% c('Capt', 'Don', 'Major', 'Sir')] <- 'Sir'
alldata$Title[alldata$Title %in% c('Dona', 'Lady', 'the Countess', 'Jonkheer')] <- 'Lady'
alldata$Title <- factor(alldata$Title)
alldata$Family <- alldata$SibSp + alldata$Parch + 1
alldata$Surname <- sapply(alldata$Name, FUN=function(x) {strsplit(x, split='[,.]')[[1]][1]})
alldata$FamilyID <- paste(as.character(alldata$Family), alldata$Surname, sep="")
alldata$FamilyID[alldata$Family <= 2] <- 'Small'
famIDs <- data.frame(table(alldata$FamilyID))
famIDs <- famIDs[famIDs$Freq <= 2,]

alldata$FamilyID[alldata$FamilyID %in% famIDs$Var1] <- 'Small'
alldata$FamilyID <- factor(alldata$FamilyID)
train <- alldata[1:891,]
test <- alldata[892:1309,]

fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + Title + Family + FamilyID,
               data=train, 
               method="class")

fancyRpartPlot(fit)

Prediction <- predict(fit, test, type = "class")
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "featureengineering.csv", row.names = FALSE)

