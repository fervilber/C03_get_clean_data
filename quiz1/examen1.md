
# Pregunta 1
The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: <https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv>
and load the data into R. The code book, describing the variable names is here: <https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf>

How many housing units in this survey were worth more than $1,000,000?

```{r}
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

# Otra opcion
count(p1$VAL == 24)
# o lo mismo de otra forma
length(p1$VAL[!is.na(p1$VAL) & p1$VAL==24])
```

# Pregunta 2

```{r}
tmp<-p1$FES
```

# Pregunta 3. EXCEL
Download the Excel spreadsheet on Natural Gas Aquisition Program here: <https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx>
Read rows 18-23 and columns 7-15 into R and assign the result to a variable called: dat 
What is the value of: sum(dat$Zip*dat$Ext,na.rm=T) 

```{r}
install.packages("xlsx")
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
# Otra opcion que he visto es con la librería library(XLConnect)
# datos_excel <- readWorksheetFromFile(excel.file, sheet = 1, header = TRUE, startCol = 7, startRow = 18, endCol = 15, endRow = 23)

#piden evaluar esto;
sum(datos_excel$Zip*datos_excel$Ext,na.rm=T)
#el resultado de la suma es la respuesta a la pregunta
```

# Pregunta 4. XML
Read the XML data on Baltimore restaurants from here: <https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml>
 
How many restaurants have zipcode 21231?
```{r}
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
# Así pues nos asignamos como rootNode el nodo de 2ª clase, bajamos un escalón...
rootNode<-rootNode[[1]]
#aquí vemos junto cada una los nodos hijos de cada row
xmlSApply(rootNode,xmlValue)

# como estamos ya en el segundo paso podemos pregntar 
zip<-xpathSApply(rootNode,"//zipcode",xmlValue)
# La respuesta a la pregunta es :
length(zip[zip==21231]) 
# o 
count(zipcode == 21231)


## otra forma q no funcion pues no hay elementos <li  class="xxxx"> en el xml
doc<-xmlTreeParse("./data/restbal1.xml", useInternal=TRUE)
xpathSApply(doc,"li[@class='zipcode']",xmlValue)
```

# Ejercicio 5
The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: <https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv>
Using the fread() command load the data into an R object DT 
Which of the following is the fastest way to calculate the average value of the variable pwgtp15 broken down by sex using the data.table package?

  - rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
  - mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
  - sapply(split(DT$pwgtp15,DT$SEX),mean)
  - mean(DT$pwgtp15,by=DT$SEX)
  - DT[,mean(pwgtp15),by=SEX]
  - tapply(DT$pwgtp15,DT$SEX,mean)

--
## Solucion
```{r}
bajar encuesta de IDAHO sobre casas de la sguiente dirección
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile="./data/e5.csv")
destfile="./data/e5.csv"
# piden guardar en R usando el comando fread() y almacenar el resutado en DT
# lo primer que pasa es que me dice que no existe este comando
# si pasa eso ejecutar esto:
require(data.table)
# o library(data.table)

DT<-fread(destfile)
# la alternativa es con write.table
DT<-write.table(big_df, file=file, row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE)
system.time(fread(file))

library(data.table)
DT <- fread(input="./data/e5.csv", sep=",")
file.info("./data/e5.csv")$size

# o como 
sapply(split(DT$pwgtp15,DT$SEX), mean)

# formulas para calcular lo mismo
system.time(DT[,mean(pwgtp15),by=SEX])

# En mi caso los tiempos del PC son 0 en todos los casos
# Alguno por internet lo hace así, pero no le he didicado mucho a esto:
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
