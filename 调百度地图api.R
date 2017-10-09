######将城市转为经纬度######
#输入自己申请的百度地图的AK密钥
AK <- 'c7oFYmcmd2CVFcSLRtZqOEH16498GAl2'

# 载入需要的文件或地址
add_id <- c("北京天安门",  '东方明珠')

#载入需要的包
library(rjson)
library(RCurl)

#设定空向量
baidu_lat <- c()
baidu_lng <- c()
baidu_address <-c()
baidu_geo <- c()

#列表循环-begin#
for (location in add_id) {
  #建立地址转换网址
  url <- paste("http://api.map.baidu.com/geocoder/v2/?ak=",AK,"&output=json&address=",location, sep = "")
  url_string <- URLencode(url)
  
  # 捕获连接对象
  connect <- url(url_string)      # 要close  或者用getURL代替， tryCatch 避免网络不好时报错中断
  
  # 处理json对象
  temp_geo <- fromJSON(paste(readLines(connect,warn = F), collapse = ""))
  temp_lat<-temp_geo$result$location$lat
  temp_lng<-temp_geo$result$location$lng
  
  # 关闭连接
  close(connect)
  
  #存储数据
  baidu_geo  <-c(baidu_geo,temp_geo)
  baidu_lat <- c(baidu_lat,temp_lat)
  baidu_lng <- c(baidu_lng,temp_lng)
  baidu_address <- c(baidu_address,location)
}
#列表循环-end#
content <- data.frame(baidu_address,baidu_lat,baidu_lng, stringsAsFactors = F)

#查看数据导出数据
content;  
write.csv(content,file="baidu_geocoding.csv")
