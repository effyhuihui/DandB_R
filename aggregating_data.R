#################
#Aggregating data
#################
titanic <- read.csv(file='titanic.csv', as.is=T, header=T)

##table
?table
table(titanic$sex)

table(titanic$sex, titanic$survived)

prop.table(table(titanic$sex, titanic$survived))

table(titanic$sex, titanic$survived)/nrow(titanic)


fem <- subset(titanic, titanic$sex == 'female')

table(fem$pclass, fem$survived)

##tapply
tapply(fem$fare, fem$survived, mean)

       
tapply(titanic$age,titanic$sex,mean) 

tapply(titanic$age,titanic$pclass,mean,na.rm=T) #tells R to exclude missing values


##aggregate
aggregate(age~pclass+sex,FUN=mean,data=titanic) 

##ddply
library(plyr)
?ddply
ddply(titanic, .(sex,pclass),summarize,
      mean = mean(age),
      sd = sd(age),
      max = max(age),
      iqr = IQR(age))

ddply(titanic, .(sex,pclass),summarize,
      mean = mean(age, na.rm = TRUE),
      sd = sd(age, na.rm = TRUE),
      max = max(age, na.rm=TRUE),
      iqr = IQR(age,na.rm=TRUE))

#user defined functions:
check.NA <- function(x){
  sum(is.na(x))
}


##apply
?apply
apply(titanic,1,check.NA) #rows
apply(titanic,2,check.NA) #columns

#lapply
## a very useful example about "what's the difference between apply and lapply"
http://stackoverflow.com/questions/2392216/why-is-as-factor-returns-a-character-when-used-inside-apply
?lapply
str(titanic)
titanic[c(1,4,6:7,11)] <- lapply(titanic[c(1,4,6:7,11)], as.factor)
titanic[c("survived", "sex", "sibsp", "parch", "embarked")] <- lapply(titanic[c("survived", "sex", "sibsp", "parch", "embarked")],as.factor)

packages <- c("plyr", "lubridate")
lapply(packages, require, character.only=T)
