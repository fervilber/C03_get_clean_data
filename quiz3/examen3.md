Este código es personal, Si estás realizando el curso, no lo mires, intenta hacerlo por tu cuenta.

# Pregunta 1
The American Community Survey distributes downloadable data about United States communities.
Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:

<https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv>

and load the data into R. The code book, describing the variable names is here:

<https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf>

Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products.
Assign that logical vector to the variable agricultureLogical.
Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE.

## Solucion
busco en el codebook las variables que tienen relacion con la superficie en Acres y el valor de producto agricola.
Encuentro que son las columnas  ACR y AGS, y busco a qué valores corresponden mayor que 10 acres y mayor que 10,000 $.
La col WORKSTAT corresponde a los propietarios.
Por lo tanto la solucion sería. 1 bajar el archivo, 2 crear el vector lo

```{r}
#Bajamos el fichero csv de la web
  fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
#codebook https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
# lo guardamos en la carpeta local como surv_2006.csv
  download.file(fileUrl, destfile="surv_2006.csv")
# leemos su contenido
  surv_2006 <- read.table("surv_2006.csv", sep="," , header= TRUE)
# vemos los datos
  View(surv_2006)
# hacemos la consulta lógica
  agricultureLogical<- surv_2006$ACR==3 & surv_2006$AGS==6
# Obtenemos el resultado seleccionando las 3 primeras 
head(select(surv_2006[which(agricultureLogical),],WORKSTAT ),3)

```

# Pregunta 2
Using the jpeg package read in the following picture of your instructor into R
<https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg>
Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data? 
(some Linux systems may produce an answer 638 different for the 30th quantile)

## Solucion
Bajamos el fichero de la web, ojo pues según el SO del ordenador debemos usar uno u otro method de download para que no de errores.
En Mac curl, en windows wininet
Una vez tengamos el fichero lo leemos con la funcion readJPEG y calculamos los cuantiles pedidos

```{r}
library(jpeg)

fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
destfile="Fjeff.jpg"

#Un problema solucionado cambiando el method a wininet que es de windows y binario
download.file(fileUrl, destfile=destfile, method = "wininet", mode= "wb")
imgjpg<-readJPEG(destfile, native = TRUE)
#calculo los cuantiles pedidos
quantile(imgjpg, probs = c(0.3,0.8))

```


# Pregunta 3
Load the Gross Domestic Product data for the 190 ranked countries in this data set:
<https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv>
Load the educational data from this data set:
<https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv>
Match the data based on the country shortcode. How many of the IDs match? 
Sort the data frame in descending order by GDP rank (so United States is last). 
What is the 13th country in the resulting data frame?
Original data sources:
<http://data.worldbank.org/data-catalog/GDP-ranking-table>
<http://data.worldbank.org/data-catalog/ed-stats>

## Solucion
Bajar los ficheros, revisarlos con un editor de texto tipo surface o UltraEdit, y vemos que no hay encabezados y el final es confuso.
Limpiamos el fichero con estos editores, o lo podemos hacer desde código diciendo que lea solo 
```{r}
#cargamos las librerías necesarias
library(data.table)
library(plyr)
library(dplyr)

#Leemos los ficheros de la web
file1<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(file1, destfile="GDP.csv", method = "wininet")
# en este caso he limpiado con UltraEdit el fichero, me parece más rápido que con código
# el fichero limpio lo cuardo como GDP1.csv

file2<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(file2, destfile="Country.csv", method = "wininet")

# cargo como data table en una variable
# he cambiado con el editor de texto los nombres aunque lopodía haber hecho con codigo
# setnames(df, c("var1", "var2"), c("CountryCode", "Ranking"))

dt1<-read.csv("GDP1.csv", header=TRUE) 
dt1 <- dt1[!= ""] # quito los vacios
dt1<-tbl_df(dt1) # transformo df en data table

dt2<-read.csv("Country.csv", header=TRUE) 
dt2<-tbl_df(dt2) # transformo df en data table

# Realizo el macth que pide el problema
dt3<-match_df(dt1,dt2)
# se puede hacer un join o merge tambien 
# dt3 <- merge(dt1, dt2, all = TRUE, by = c("CountryCode"))

#filtramos para seleccionar las filas que tienen valor en Ranking, y las que no tienen son las que no han obtenido match

dim(filter(dt3,!is.na(Ranking)))# es el num de coincidencias en match
                                # ya que los paises que no tienen ranking es que no estaban en la tabla
# Otra forma sería así
sum(!is.na(unique(dt3$Ranking)))

#Ordenamos la tabla según indican
dt4<- arrange(dt3,desc(Ranking))
dt4[13,] # es el pais num 13 que piden

```

# Pregunta 4
What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group? 

## Solucion
Juntamos las dos tablas anteriores con join o merge
```{r}
dt5<-join(dt1, dt2, by = "CountryCode", type = "left", match = "all")
names(dt5)

result <- dt5 %>% 
            select(Ranking,Income.Group) %>%
            filter(!is.na(Ranking)) %>%
#            group_by(Income.Group) %>%
#            summarize(mean(Ranking))

 dt6<-dt5 %>% select(Ranking,Income.Group) %>% filter(!is.na(Ranking))#%>% group_by(Income.Group)
 # no sé porqué he tenido problemas con el group_by, y lo he tenido que sacar a mano
 # el summarize

summarize(filter(dt6,Income.Group=="High income: OECD"),mean(Ranking))
summarize(filter(dt6,Income.Group=="High income: nonOECD"),mean(Ranking))
```


# Pregunta 5
Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. 
How many countries are Lower middle income but among the 38 nations with highest GDP?

## Solución
```{r}
filter(dt6,Income.Group=="Lower middle income",Ranking<=38)
```
