list.files("diet_data")

andy <- read.csv("diet_data/Andy.csv")
head(andy)

length(andy$Day)
dim(andy)
summary(andy)

andy[1, "Weight"]
andy[30, "Weight"]

andy[which(andy$Day == 30), "Weight"]
andy[which(andy[,"Day"] == 30), "Weight"]

subset(andy$Weight, andy$Day == 30)


andy_start <- andy[1, "Weight"]
andy_end <- andy[30, "Weight"]
andy_loss <- andy_start - andy_end
andy_loss

files <- list.files("diet_data")
files
files[3:5]

files_full <- list.files("diet_data", full.names = TRUE)
files_full
head(read.csv(files_full[3]))

andy_david <- rbind(andy, read.csv(files_full[2]))
andy_david