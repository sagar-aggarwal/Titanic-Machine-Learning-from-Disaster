# Reading Data

train = read.csv("C:/Users/AGGARWAL'S/Desktop/Titanic/train.csv" ,stringsAsFactors=FALSE)
test = read.csv("C:/Users/AGGARWAL'S/Desktop/Titanic/test.csv" ,stringsAsFactors=FALSE)
str(train)

test$Survived <- rep(0,418)

submit <- data.frame(PassengerId = test$PassengerId,Survived = test$Survived)
write.csv(submit,file = "allperish.csv",row.names =  FALSE)
