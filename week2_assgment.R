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

files[1]
files[3:5]


files_full <- list.files("diet_data", full.names = TRUE)
files_full

head(read.csv(files_full[3]))

andy_david <- rbind(andy, read.csv(files_full[3]))
head(andy_david)
tail(andy_david)

day_25 <- andy_david[which(andy_david$Day == 25),]
day_25

for (i in 1:5) {print(i)}

dat <-data.frame()
for (i in 1:5){
  dat <- rbind(dat, read.csv(files_full[i]))
}

str(dat)

median(dat$Weight, na.rm=TRUE)


dat_30 <- dat[which(dat$Day==30),]
dat_30
median(dat_30$Weight)

weightmedian <- function(directory, day){
  files_list <- list.files(directory, full.names=TRUE)
  dat <- data.frame()
  for (i in 1:5) {
    dat <- rbind(dat, read.csv(files_list[i]))
  }
  dat_subset <- dat[which(dat[, "Day"]==day),]
  median(dat_subset[,'Weight'], na.rm=TRUE)
}

weightmedian(directory = 'diet_data', day=20)
weightmedian('diet_data', 4)

summary(files_full)
tmp <- vector(mode='list', length = length(files_full))
summary(tmp)

for (i in seq_along(files_full)){
  tmp[i] <- read.csv(files_full[i])
}

str(tmp)
output <- do.call(rbind, tmp)
str(output)

specfiles <- list.files("specdata")
specfiles

specfiles_full <- list.files("specdata", full.names = TRUE)
specfiles_full

head(specfiles_full[1])
first <- read.csv(specfiles_full[1])
head(first)

sub_first <- first[, "sulfate"]
sub_first

mean(sub_first, na.rm=TRUE)


# part 1------------------------------------------
pollutantmean <- function(directory, pollutant, id = 1:332){
  files_list <- list.files(directory, full.names=TRUE)
  dat <- data.frame()
  for (i in id){
    dat <- rbind(dat, read.csv(files_list[i]))
  }
  sub_dat <- dat[, pollutant]
  mean(sub_dat, na.rm=TRUE)
}
#testing
pollutantmean("specdata", "sulfate", 1:10)
pollutantmean("specdata", "nitrate", 70:72)
pollutantmean("specdata", "nitrate", 23)

#-----------------------------------------------------------------------------


# part2 ------------------------------------------------------------------- 
complete <- function(directory, id = 1:332){
  files_list <- list.files(directory, full.names=TRUE)
  nobs <- c()
  for (i in id){
    dt <- read.csv(specfiles_full[i])
    nobs <- c(nobs, length(dt$Date[complete.cases(dt$sulfate, dt$nitrate)]))
  }
  data.frame("id" = id, "nobs" = nobs)
}
# testing
complete("specdata", 1)
complete("specdata", c(2, 4, 8, 10, 12))
complete("specdata", 30:25)
complete("specdata", 3)\

#---------------------------------------------------------------------


#part3 ----------------------------------------------------
corr <- function(directory, threshold = 0){
  nobs_df = complete(directory)
  nobs_df_ok = nobs_dt[nobs_dt$nobs > threshold,]
  res = c()
  for (i in nobs_df_ok$id){
    df = read.csv(specfiles_full[i])
    res <- c(res, cor(df$sulfate, df$nitrate, use = "complete.obs"))
  }
  res
}

#testing
cr <- corr("specdata", 150)
head(cr)
summary(cr)


cr <- corr("specdata", 400)
head(cr)
summary(cr)

cr <- corr("specdata", 5000)
summary(cr)

cr <- corr("specdata")
summary(cr)
length(cr)