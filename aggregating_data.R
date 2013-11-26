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


## two very useful resources to differentiate apply family:
## http://stackoverflow.com/questions/3505701/r-grouping-functions-sapply-vs-lapply-vs-apply-vs-tapply-vs-by-vs-aggrega
##http://stackoverflow.com/questions/2392216/why-is-as-factor-returns-a-character-when-used-inside-apply

##tapply
tapply(fem$fare, fem$survived, mean)

       
tapply(titanic$age,titanic$sex,mean) 

tapply(titanic$age,titanic$pclass,mean,na.rm=T) #tells R to exclude missing values


##aggregate
## Formulas, one ~ one, one ~ many, many ~ one, and many ~ many:

> aggregate(Age~Pclass+Sex, FUN=mean,data=titanic)
  Pclass    Sex      Age
1      1 female 34.61176
2      2 female 28.72297
3      3 female 21.75000
4      1   male 41.28139
5      2   male 30.74071
6      3   male 26.50759



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
?lapply
str(titanic)
titanic[c(1,4,6:7,11)] <- lapply(titanic[c(1,4,6:7,11)], as.factor)
titanic[c("survived", "sex", "sibsp", "parch", "embarked")] <- lapply(titanic[c("survived", "sex", "sibsp", "parch", "embarked")],as.factor)

packages <- c("plyr", "lubridate")
lapply(packages, require, character.only=T)
