timeSeries=function(){
  name=(readline("Enter the product name:"))
  start=c()
  start[1]=as.integer(readline("starting year:"))
  start[2]=as.integer(readline("starting month:"))
  file_name=paste0("C:/Users/Thej Venkat/Desktop/Thej/sem4/r programming/",name,".csv")
  if (file.exists(file_name)) {
    book=read.csv(file_name,header=FALSE)
    n=nrow(book)
    print(paste("Readings available for first",n,"Months."))
    end=c()
    end[1]=as.integer(readline("ending year:"))
    end[2]=as.integer(readline("ending month:"))
    ts <- ts(book, start = start, end = end, frequency = 12)
    plot(ts, type = "o", col = "blue", main = "Time Series Plot", xlab = "Time", ylab = "Price")

  } else {
    print("Product file does not exist")
  }
}
timeSeries()