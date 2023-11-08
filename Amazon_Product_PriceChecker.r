library(csv)
library(rvest)      
link="https://www.amazon.in/Lenovo-Desktop-ColdFront-Lighting-Transparent/dp/B09NPPQZQY/ref=sr_1_6?crid=256E2U17PT29B&keywords=gaming%2Bpc&qid=1693551251&sprefix=gaming%2Bpc%2Caps%2C281&sr=8-6&th=1"
library(readxl)

getPrice=function(link){
  page=read_html(link)
  price<- page %>% html_elements(".a-price-whole")
  price=price[1]
  price=as(price,"character")
  len <- nchar(price)
  price=substr(price,29,len-45)
  price=strsplit(price,",")
  priceint=""
  for(i in price[[1]]){
    priceint=paste0(priceint,i)
  }
  price=as.integer(priceint)
  print(price)
  return(price)
}

bookEx <- read_excel("C:/Users/Thej Venkat/Desktop/Thej/sem4/r programming/Products.xlsx", col_names = FALSE)
ReadPrices<-function(){
  for (i in 1:nrow(bookEx)) {
    name=as.character(bookEx[i,1])
    print(paste("Name:", name))
    link=bookEx[i,2]
    link=as.character(link)
    pr<-getPrice(link)
    writeFile(name,pr)
  }
}

writeFile=function(file_name,price){
  file_name=paste0("C:/Users/Thej Venkat/Desktop/Thej/sem4/r programming/",file_name,".csv")
  tryCatch({
    new_row <- data.frame(price=price)
    write.table(new_row, file = file_name, sep = ",", append = TRUE,
                quote = FALSE, col.names = FALSE, row.names = TRUE)
  },
  error=function(e){
    print(e)
    price=c(price)
    price.data <- data.frame(price)
    write.csv(file_name,price.data)
  })
}

while(TRUE){
  Sys.sleep(5)
  n=readline("Read prices (0=NO):")
  if(n=='0'){
    break
  }else{
    ReadPrices()
  }
}