table <- read.csv("NG2net.CSV")

image <- table[table$newID == 0, ]
line <- image[image$pid == 0, ]
line <- line[order(line$flowid), ]
for (k in c(1:200)) {
  if (line[k,'HH'] >= -18.5) {
    line[k,'HHbinary'] <- 1;
  } else {
    line[k,'HHbinary'] <- -1;
  }
}
print(line$HH)
line$cumHH = 0
line[1,'cumHH'] = line[1,'HHbinary']

for (k in c(2:200)) {
  line[k,'cumHH'] = line[k,'HHbinary'] + line[k-1,'cumHH']
}
line <- line[order(line$cumHH, decreasing=TRUE), ]
icefront <- c()
icefront <- rbind(icefront, line[1, ])

icefronts <- c()
for (i in c(0:45)) {
  image <- table[table$newID == i, ]
  icefront <- c()
  for (j in c(0:198)) {
    line <- image[image$pid == j, ]
    line <- line[order(line$flowid), ]
    for (k in c(1:200)) {
      if (line[k,'HH'] >= -18.5) {
        line[k,'HHbinary'] <- 1;
      } else {
        line[k,'HHbinary'] <- -1;
      }
    }
    line$cumHH = 0
    line[1,'cumHH'] = line[1,'HHbinary']
    for (k in c(2:200)) {
      line[k,'cumHH'] = line[k,'HHbinary'] + line[k-1,'cumHH']
    }
    line <- line[order(line$cumHH, decreasing=TRUE), ]
    icefront <- rbind(icefront, line[1, ])
  }
  icefronts <- rbind(icefronts, icefront)
}
write.csv(icefronts, "NG2icefronts.csv")
