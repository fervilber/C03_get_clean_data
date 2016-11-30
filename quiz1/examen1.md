
```{r}
###############################################
## codigo para resolver el ejercicio 1  #######
## week 1 getting and cleaning data     #######
###############################################


# Descargar de la web el fichero siguiente csv
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
# lo guardamos en la carpeta local como p1.csv
download.file(fileUrl, destfile="p1.csv")

# leemos su contenido
p1 <- read.table("p1.csv", sep="," , header= TRUE)
# Leemos la variable VAL que continene el valor de las casas
tmp<-p1$VAL
tmp<-tmp[!is.na(tmp)] # seleccionamos los validos quitamos NA

# leemos enel code book que un valor de 24 significa que el
# valor  de la casa es de 1 millon o más.
tmp<-tmp[tmp>=24]
# La respuesta de cuantos hay de mas de un millon es:
pregunata1<- length(tmp)

# pregunta 2

tmp<-p1$FES
# la columna contiene datos de dos variables mezcladas

#Code book says VAL with 24 represents any house more than $1000000. 
#Following piece of code is trying to get count on house price >$1000000 whose value is not NA
length(idaho_housing$VAL[!is.na(idaho_housing$VAL) & idaho_housing$VAL==24])


#####################################################
# Pregunta 3.EXCEL
install.packages("xlsx")
#require(xlsx)
library(xlsx)
# Bajamos una hoja excel de natural gas resources

if(!file.exists("data")){dir.create("data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"

#Ojo en ficheros binarios es necesario decirle a R que lo es
# no funciona si no es oniendo ./data/gas.xlsx  mode="wb"
download.file(fileUrl, destfile="./data/gas.xlsx", mode="wb")
dateDownload<-date()

# Establecemoslas columnas y filas que queremos leer
colIndex<-7:15
rowIndex<-18:23
datos_excel <- read.xlsx("./data/gas.xlsx", sheetIndex=1,
                         header=TRUE,colIndex=colIndex, rowIndex=rowIndex) 
#piden evaluar esto;
sum(datos_excel$Zip*datos_excel$Ext,na.rm=T)
#el resultado de la suma es la respuesta a la pregunta


####################################################
# Pregunta 4.XML
#XML baltimore RESTAURANTS 
# haow many restaurants have zipcode 21231?
####################################################
#install.packages("XML")
library(XML)

fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(fileUrl, destfile="./data/restbal1.xml")

doc<-xmlTreeParse("./data/restbal1.xml", useInternal=TRUE)
#nodo raiz o principal
rootNode<-xmlRoot(doc)
#nombre del nodo raiz
xmlName(rootNode)
#los nombres de los nodos hijos del raiz
names(rootNode)
#                   1         2        3      4
#la estructura es response--> row --> row --> (name, zipcode, neighbourhood..)
#por lo tanto nos interesa el 3 paso que continene como hijos las variables
rootNode<-rootNode[[1]]
#aquí vemos junto cada una los nodos hijos de cada row
xmlSApply(rootNode,xmlValue)

# como estamos ya en el segundo paso podemos pregntar 
zip<-xpathSApply(rootNode,"//zipcode",xmlValue)
# La respuesta a la pregunta es :
length(zip[zip==21231]) 

## otra forma q no funcion pues no hay elementos <li  class="xxxx"> en el xml
doc<-xmlTreeParse("./data/restbal1.xml", useInternal=TRUE)
xpathSApply(doc,"li[@class='zipcode']",xmlValue)


#######################################################
##Ejercicio 5
# bajar encuesta de IDAHO sobre casas de la sguiente dirección
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile="./data/e5.csv")
destfile="./data/e5.csv"
# piden guardar en R usando el comando fread() y almacenar el resutado en DT
# lo primer que pasa es que me dice que no existe este comando
# si pasa eso ejecutar esto:
require(data.table)

DT<-fread(destfile)
# la alternativa es con write.table
DT<-write.table(big_df, file=file, row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE)
system.time(fread(file))

library(data.table)
DT <- fread(input="./data/e5.csv", sep=",")
file.info("./data/e5.csv")$size

system.time(DT[,mean(pwgtp15),by=SEX])
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(mean(DT[DT$SEX==1,]$pwgtp15))  
system.time(mean(DT[DT$SEX==2,]$pwgtp15))
system.time(rowMeans(DT)[DT$SEX==1],rowMeans(DT)[DT$SEX==2])

#borra todas las variables del espacio de trabajo
rm(list=ls())

# nos piden como calcular la media de  la variable pwgtp15 distinguiendo por sexo
# de las respuestas decir cual es la más rápida:
# podemos usar system.time() para ello

# lo primero que se me ocurre es usar split
subset1<-split(DT$pwgtp15,DT$SEX)
#esto lo divide en dos, y podemos sacar la media de cada uno
summary(subset1[[1]])
summary(subset1[[2]])
# o como 
sapply(split(DT$pwgtp15,DT$SEX), mean)


# formulas para calcular lo mismo
system.time(DT[,mean(pwgtp15),by=SEX])
Fer# la más rapida es esta, aunque los tiempos del PC son 0 en todos los casos
DT[,mean(pwgtp15),by=SEX]

mean(DT$pwgtp15,by=DT$SEX)
Frodo = sapply(1:100, system.time(DT[,mean(pwgtp15),by=SEX]))
system.time(apply(DT, 1, DT[,mean(pwgtp15),by=SEX]))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
################
#contar casos usamos la funcion .N
DT[,.N, by=SEX]  

###Question 5
if (!file.exists("data")) {
    dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "./data/06pid.csv", method = "curl")
dateDownloaded <- date()

DT <- fread("./data/06pid.csv")
# We can change the value of "race" according to our needs
race <- 1000

# This method use the features of data.table.
# replicate(race, function for measuring time(function being tested)[bit of 
# function for measuring time result which exploring with str suggests the 
# specific user time is in])
horse1 <- replicate(race, unname(system.time(DT[, mean(pwgtp15), by = SEX]))[1])
horse1_av <- cumsum(horse1) / seq_along(horse1)
topY <- max(horse1_av, horse2_av, horse3_av)
lowY <- min(horse1_av, horse2_av, horse3_av)
```
