#Task 1
#Load "mtcars" data and create a new dataset having “mpg”, “cyl”,“disp”,“hp”, “wt”, and “am”
mtcars
newdataset <- mtcars[,c("mpg","cyl","disp","hp","wt","am")]
View(newdataset)
str(mtcars)
#see what how the dataset looks and its dataframe

#Task 2
#New categorical variable "mpg_group" according to conditions
attach(newdataset)
newdataset$mpg_group[mpg < 12] <- "low"
newdataset$mpg_group[mpg >= 12 &  mpg < 20] <- "medium"
newdataset$mpg_group[mpg >= 20] <- "high"
detach(newdataset)
View(newdataset)
#see what how the dataset looks

#Task 3
#For each mpg_group, attach mpg, disp, wt
attach(newdataset)
newdataset_1 <- newdataset[,c("mpg","disp","wt","mpg_group")]
agg_data <- aggregate(newdataset_1, by=list(mpg_group),FUN = mean, na.rm=TRUE)

#Task 4
#totalnewdataset <- rbind(newdataset, lmpg_group, mmpg_group, hmph_group, by=c(mpg_group))
merge_data <- merge(agg_data,newdataset,by.x=c("Group.1"),by.y=c("mpg_group"),ALL=TRUE)

#Task 5
subset_data <- subset(merge_data, cyl < 8 & am == 1)
subset_data[,-5]
