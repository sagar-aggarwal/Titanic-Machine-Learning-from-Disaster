# Reading Data

train = read.csv("C:/Users/AGGARWAL'S/Desktop/Titanic/train.csv" ,stringsAsFactors=FALSE)
test = read.csv("C:/Users/AGGARWAL'S/Desktop/Titanic/test.csv" ,stringsAsFactors=FALSE)
str(train)

prop.table(table(train$Sex,train$Survived),1)

train$Child <- 0
train$Child[train$Age < 18] <- 1

train$Farenew <- '30+'
train$Farenew[train$Fare < 30 & train$Fare >= 20] <- '20-30'
train$Farenew[train$Fare < 20 & train$Fare >= 10] <- '10-20'
train$Farenew[train$Fare < 10] <- '<10'

aggregate(Survived~Farenew + Pclass + Child + Sex,data = train,FUN = function(x){sum(x)/length(x)})

test$Survived <- rep(0,418)
test$Survived[test$Sex == "female"] <- 1
test$Survived[test$Sex == 'female' & test$Pclass == 3 & test$Fare >= 20] <- 0

submit <- data.frame(PassengerId = test$PassengerId,Survived = test$Survived)
write.csv(submit,file = "allfemalesurvive.csv",row.names =  FALSE)
