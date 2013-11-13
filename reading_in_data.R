###########
#flat files
###########

#csv
titanic <- read.csv(file='titanic.csv',
                    header=TRUE, #does the file have a header?
                    as.is=TRUE)  #tells R to not guess what the data type should be

#equivalent to above
titanic <- read.table(file='titanic.csv',
                      header=TRUE,
                      as.is=TRUE,
                      sep=',')

#writing 
write.table(titanic, #dataframe you want to write
            file='titanic.txt', #name of your file
            sep='\t',
            row.names=FALSE) #usually don't want to keep row names in your file


#tab delimited file
titanic1 <- read.table(file='titanic.txt',
                      header=TRUE,
                      as.is=TRUE,
                      sep='\t')


rm(dataname) # it will temperarily removed 
gc() # tell you the memory usage

####################
#database connection
####################

library(RODBC)
?odbcConnect
?sqlQuery

ch <- odbcConnect('ph') #this is your dsn
sample <- sqlQuery(ch, "SELECT top 100 * from [xx.xx.xx.xx].[XxxxXxx].[dbo].[DataWorks] dw")

