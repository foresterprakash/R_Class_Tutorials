## Reading the files

## Major file type to store in R are:

# 1. Excel File(.xlsx)
# 2. Text file(.txt)
# 3. csv file(.csv)

# 1. csv file

# Available CSV FILES IN THE DATA FOLDER
list.files("Data",pattern = ".csv")

# Now read csv files

dat <- read.csv(file = "Data/heart.data.csv",
                header = TRUE,
                col.names = c("s.n","Bikings","Smoking","Heart.Diseases"))



## Read text file

# Available text FILES IN THE DATA FOLDER
list.files("Data",pattern = ".txt")

# now read text files

txt1 <- read.table(file = "Data/data1.txt",header = TRUE,sep = "-")

txt2 <- read.table(file = "Data/data2.txt", header = TRUE, sep = ":")

txt3 <- read.table(file = "Data/data3.txt", header = TRUE, sep = "/")

txt4 <- read.table(file = "Data/tips_text.txt", header = TRUE, sep = "\t")

## Reading Excel File 
# Available excel FILES IN THE DATA FOLDER
list.files("Data",pattern = ".xlsx")

#install.packages("readxl")
library(readxl)

xl_dat <- read_excel("Data/SampleData.xlsx",sheet = 2, range = "A1:G44",col_names = TRUE)

xl_dat1 <- read_excel("Data/SampleData.xlsx",sheet = 3, range = "A1:G44",col_names = FALSE)

colnames(xl_dat1) <- colnames(xl_dat)



## Read file from google drive

file_id <- "12z0Ru-xR0z2AqDGIMGV_irAojWv-jAbu"

library(googledrive)

drive_download(as_id(file_id), path = "clients.csv",overwrite = TRUE)

# Writing files

# Write text files

write.table(x = xl_dat, file = "Data/written_data/first_dat.txt", sep = "-")

write.table(x = txt1, file = "Data/written_data/text1.txt", sep= "\t")


## writing file in csv

write.csv(txt1, file = "Data/written_data/dat1.csv")

## Excel writing
library(openxlsx)

wb <- createWorkbook() # It creats a blank workbook

## now add blank sheet inside

addWorksheet(wb, "data1")

## Now put your data in that created sheet
writeData(wb, "data1", txt1)

## create another sheet in wb

addWorksheet(wb, "data2")

# write next data in 2nd sheet

writeData(wb, "data2", txt2)

## create another sheet
addWorksheet(wb, "data3")
writeData(wb, "data3",xl_dat)

saveWorkbook(wb, file = "Data/written_data/my_excel.xlsx", overwrite = TRUE)

#openXL("Data/written_data/my_excel.xlsx")




















