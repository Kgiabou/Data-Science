 ###  App Github ###


#Question 1:
        
        
library(httr)
require(XML)
require(jsonlite)
library(data.table)
oauth_endpoints("github")

myapp <- oauth_app("github",
                   key = "5491d4adb3ac90174306",
                   secret = "d8ea421dba17da69575b62dc2b7d813441d69742"
)

github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

req <- GET("https://api.github.com/users/jtleek/repos", config(token = github_token))
stop_for_status(req)

### returns a list with the contents of the API ###
lista <- content(req) 

### To find a string in a list use sapply and this simple function##
### To return the position in the list we use which ###

lista2 <- which(sapply(lista, function(X) "datasharing" %in% X));

###Question 2:
library(sqldf)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "acs.csv",  method = "curl") ### store the file as "acs" defined in the quiz

### USing sqldf we can write queries  straight in R for data frames ##

sqldf("select pwgtp from acs where AGEP <50")

### Question 3 analogous to 2:

### Question 4

con <-url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(con)

close(con)
htmlCode

char <- numeric()
line <- c(10,20,30,100) 
for (i in seq_along(line))
{
        ch <- nchar(htmlCode[line][i])
        char <- c(char, ch)
}
char


### Question 5 :

library(readr)


fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
### this function is used to determine column widths ##
fwf_empty(fileurl, skip = 4, skip_empty_rows = FALSE, n = 100L)

dat <- read.fwf(fileurl, widths=c(12, 7, 4, 9, 4, 9, 4, 9, 4), skip = 4) ##its impossible to find the widths
