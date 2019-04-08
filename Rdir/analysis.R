table <- read.csv("NG2icefronts.csv")
means <- c()
for (i in c(0:45)) {
  icefront <- table[table$newID == i, ]
  means <- rbind(means, mean(icefront$flowid))
}
colnames(means) <- "means"
month <- c(6,7,8,9,10,11,12,1,2,3,4,5,6,7,8,9,10,11,12,1,2,3,4,5,6,7,8,9,10,11,12,1,2,3,4,5,6,7,8,9,10,11,12,1,2,3)

myplot <- cbind(month, means)
plot(myplot[,1],myplot[,2], type = "p")
plot(means,type = "l")
