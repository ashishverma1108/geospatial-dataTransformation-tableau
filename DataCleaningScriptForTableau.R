
##
#Author: Ashish verma
#Date: 12/11/2014
##
#Reading the file containing Geocodes of airports
geocodes <- read.table("C:/Users/Ashish Verma/Desktop/R Work/code.csv", header=TRUE, sep=",",as.is = TRUE) #reading geocodes to assign to airports

#Reading the flight data to be formatted
airline_sched <- read.table("C:/Users/Ashish Verma/Desktop/R Work/Sep5DataV2/Sep5DataGMTV2.csv", header=TRUE, sep=",", fill=TRUE,as.is=TRUE) #reading airline data to be formatted

#Removing blank rows
airline_sched <- airline_sched[!apply(is.na(airline_sched) | airline_sched == "",1,all),]



#Defining dataframes to be used later to clean and store data in new format
final_data <- as.data.frame(matrix(ncol=16,nrow=0), stringAsFactors= F)
colnames(final_data) <- c("Airport","Dep Time","Arr Time", "Dep Delay","Arr Delay","Flight Num", "PathID", "Path Order", "Latitude", "Longitude", "TailNum","Late Aircraft Delay","Carrier Delay","Weather Delay","NAS Delay","Security Delay")

temp1 <- as.data.frame(matrix(ncol=16,nrow=0), stringAsFactors= F)
colnames(temp1) <- c("Airport","Dep Time","Arr Time", "Dep Delay","Arr Delay","Flight Num", "PathID", "Path Order", "Latitude", "Longitude", "TailNum","Late Aircraft Delay","Carrier Delay","Weather Delay","NAS Delay","Security Delay")

temp2 <- as.data.frame(matrix(ncol=16,nrow=0), stringAsFactors= F)
colnames(temp2) <- c("Airport","Dep Time","Arr Time", "Dep Delay","Arr Delay","Flight Num", "PathID", "Path Order", "Latitude", "Longitude", "TailNum","Late Aircraft Delay","Carrier Delay","Weather Delay","NAS Delay","Security Delay")

#Formatting and storing data in final_data
for(i in 1:dim(airline_sched)[1]){
  temp1 <- cbind(as.character(airline_sched$Origin[i]),as.character(airline_sched$DepTime[i]),"",as.character(airline_sched$DepDelay[i]),"",as.character(airline_sched$FlightNum[i]),paste(as.character(airline_sched$Origin[i]),as.character(airline_sched$Dest[i]),sep="-"),1,geocodes$Latitude[geocodes$locationID == as.character(airline_sched$Origin[i])],geocodes$Longitude[geocodes$locationID == as.character(airline_sched$Origin[i])],as.character(airline_sched$TailNum[i]),as.character(airline_sched$LateAircraftDelay[i]),as.character(airline_sched$CarrierDelay[i]),as.character(airline_sched$WeatherDelay[i]),as.character(airline_sched$NASDelay[i]),as.character(airline_sched$SecurityDelay[i]))
  temp2 <- cbind(as.character(airline_sched$Dest[i]),"",as.character(airline_sched$ArrTime[i]),"",as.character(airline_sched$ArrDelay[i]),as.character(airline_sched$FlightNum[i]),paste(as.character(airline_sched$Origin[i]),as.character(airline_sched$Dest[i]),sep="-"),2,geocodes$Latitude[geocodes$locationID == as.character(airline_sched$Dest[i])],geocodes$Longitude[geocodes$locationID == as.character(airline_sched$Dest[i])],as.character(airline_sched$TailNum[i]),as.character(airline_sched$LateAircraftDelay[i]),as.character(airline_sched$CarrierDelay[i]),as.character(airline_sched$WeatherDelay[i]),as.character(airline_sched$NASDelay[i]),as.character(airline_sched$SecurityDelay[i]))
  tempr <- as.data.frame(rbind(temp1,temp2), stringAsFactors = F, names=colnames(final_data))
  final_data <- as.data.frame(rbind(final_data,tempr), stringAsFactors = F)
}

#Writing data to a csv to be used with tableau. 
write.table(final_data, file="C:/Users/Ashish Verma/Desktop/R Work/processedSep5GMTV3.csv")
