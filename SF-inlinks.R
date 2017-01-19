###SF-inlinks.R
###version 1.0
###Description : SF-inlinks provides a fast way to identify 301, 302, 404 and 500 links on your website from a Screaming Frog
#"all_inlinks" export. SF-inlinks creates 2 actionnable files for each status code. The first file "inlinks" file shows you 
#the number of inlinks for each bad link and allows you to identify big spots quickly (e.g. menu, sub-menu). The second file
#"from_to" gives you the detail for all the bad links spots to correct the remaining wrong links.
###How to use this script : First install the 3 needed libraries and follow the 3 steps in comments.


library("readxl")
library("WriteXLS")
library("dplyr")

#1. Give your project a name :
project_id <- "myproject"    
dir.create(project_id)

#2. Replace "all_inlinks.xlsx" by your file name :
All_inlinks <- read_excel("all_inlinks.xlsx", sheet = 1, col_names = TRUE, col_types = NULL, skip = 1)

#3. Click Run, and get ready to improve the Internet!


#All_inlinks file improvement
cnames <- c("type", "source", "dest", "size", "alt","anc", "code", "status", "follow") #new colnames
colnames(All_inlinks) <- cnames #replace colnames by new colnames
All_inlinks <- All_inlinks[,c("type","source","dest","code")] #Delete all unecesary columns

#Dataframe creation
url301 <- subset(All_inlinks, code == 301)  #Create the from_to dataframe
if (!is.null(url301)) {   #if the subset is not null, then make the folowing steps
total301 <- group_by(url301, dest)  #Group URL by destionation URL
total301 <- summarize(total301, total = n())  #Counts URL
total301 <- arrange(total301, desc(total))  #Sort URL
total301["Links position"] <- ifelse(total301$total>=1000,"menu","submenu or content")  #Add a new column with big spots
WriteXLS(url301, ExcelFileName = paste(project_id, "301_from_to.xls", sep = "/"))   #Save the from_to.xls file
WriteXLS(total301, ExcelFileName = paste(project_id, "301_inlinks.xls", sep = "/"))   #Save the inlinks.xls file
}

url302 <- subset(All_inlinks, code == 302)
if (!is.null(url302)) {
total302 <- group_by(url302, dest)
total302 <- summarize(total302, total = n())
total302 <- arrange(total302, desc(total))
total302["Links position"] <- ifelse(total302$total>=1000,"menu","submenu or content")
WriteXLS(url302, ExcelFileName = paste(project_id, "302_from_to.xls", sep = "/"))
WriteXLS(total302, ExcelFileName = paste(project_id, "302_inlinks.xls", sep = "/"))
}

url404 <- subset(All_inlinks, code == 404)
if (!is.null(url404)) {
total404 <- group_by(url404, dest)
total404 <- summarize(total404, total = n())
total404 <- arrange(total404, desc(total))
total404["Links position"] <- ifelse(total404$total>=1000,"menu","submenu or content")
WriteXLS(url404, ExcelFileName = paste(project_id, "404_from_to.xls", sep = "/"))
WriteXLS(total404, ExcelFileName = paste(project_id, "404_inlinks.xls", sep = "/"))
}

url500 <- subset(All_inlinks, code == 500)
if (!is.null(url500)) {
total500 <- group_by(url500, dest)
total500 <- summarize(total500, total = n())
total500 <- arrange(total505, desc(total))
total500["Links position"] <- ifelse(total500$total>=1000,"menu","submenu or content")
WriteXLS(url500, ExcelFileName = paste(project_id, "500_from_to.xls", sep = "/"))
WriteXLS(total500, ExcelFileName = paste(project_id, "500_inlinks.xls", sep = "/"))
}
