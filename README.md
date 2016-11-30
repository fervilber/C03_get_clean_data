# C03_get_clean_data
In this repo I put some keys for the course getting and cleaning data.

This are some notes with the code of the classes and tricks i found.


# WEEK 1
# WEEK 2

# WEEK 3
## Subsetting and Sorting
en esta Clase se explican las funciones incluidas en el pqeute base para hacer subdivisiones y subcnjuntos, tambien como ordenar variables dentro de un data frame.

```{r}
#########################################
##  SUBDIVIDISION DE  VARIABLES
##  CREACION DE SUBCONJUNTOS
#########################################

#Creamos un data frame
set.seed(13435)
x<- data.frame("var1"= sample(1:5),"var2"= sample(6:10),"var3"= sample(11:15))
x<-x[sample(1:5),];x$var2[c(1,3)]=NA
x

# Seleccionar una columna por numero
x[,1]
# Seleccionar columna por name
x[,"var1"]

# Seleccionar parte de una fila y columna a la vez
x[1:2,"var2"]

# Seleccionar con operadores lógicos
# selecciono los valores que cumplen esta condición en todas las columnas
x[(x$var1<=3 & x$var3 >11),] # AND 

x[(x$var1<=3 | x$var3>15),] # OR


# Seleccionar con which
x[which(x$var2>8),] # no considera los NA
x[(x$var2>8),]  # ver diferencia respecto a NA, esto si

# subconjunto de una columna que ademas contenga ciertos valores
x2<-x[x$var3 %in% c(4,56,23)] # crea nueva tabla con la columna var3
                              # pero solo las filas que valen 4, 56 y 23

#########################################
##  ORDENAR VARIABLES
#########################################

# Ordenar una columna ascendiente por defecto
sort(x$var1)

# ordenar por orden decreciente
sort(x$var1, decreasion=TRUE)

# ordenar y poner los NA al final
sort(x$var1, na.last=TRUE)

# Ordenar toda el data frame según una columna
x[order(x$var1),] # ordeno por la columna var1


#Ordenar por varias variables
x[order(x$var1,x$var3),] # ordeno por la columna var1

#####################################
# Añadir una columna nueva al data frame directamente
x$var4<- rnorm(5)

#Añadir columnas nuevas
y<- cbind(x,rnorm(5)) # la añade en la ultima columna
y<- cbind(rnorm(5),x) # añade una columna en la primera columna

# Añade una fila nueva 
y<-rbind(c(1,2,3,4,5,6),x)

```
## Uso del paquete plyr
Hace uso del paquete plyr para realizar la seleccion y clasificacion de un data frame
El comando tbl_df, se usa para transformar un data frame en data table, lo que es mejor para imprimir y ver las tablas.

```{r}
library(plyr)
# transformar un data frame en data table
data <- tbl_df(rawData)

#Ordenar según una de las variables columnas
arrage(x,var1)                     # = x[order(x$var1),]
arrage(x,desc(var1))  # orden decreciente
```
### Select
Selecciona columnas o lo que es lo mismo variables dentro de una tabla.
select(dataFrameTable, var1, var2, var3)# = returns a table

Para quitar una columna o varias de la tabla

data1< select(dataFrameTable,-(var8:size)# = elimina desde la col8 hasta el final  size

### filter
Función para filtrar una tabla según los valores de las filas, retorna todas las filas que son verdad
filter(dataFrameTable, var1 == "cosas")
filter(dataFrameTable, is.na(var1)) #filtra los NA

### Arrange
Ordena la tabla según una de las variables o columnas
arrange(x,var1) # esto equivale a  = x[order(x$var1),]
arrange(x,desc(var1))  # orden decreciente

### rename()
Para renombrar las variables de una tabla
rename(dataFrameTable, newColName = colName)

### mutate()
Crear una nueva variable=col calculada o cambiar una ya existente

mutate(dataFrameTable, newColumn = size / 2^20)

### summarize()
Da valores resumen por columnas de la tabla.
Es muy util si se usa junto con la funcion group_by

summarize(dataFrameTable, avg = mean(colnameA)) # = returns the mean from the column in a single variable with the specified name

### group_by()
Agrupa los valores de la tabla en subconjuntos según el valor de una variable.

by_package <- group_by(cran, package) #= creates a grouped data frame table by specified variabl
summarize(by_package, mean(size)) # = returns the mean size of each group (instead of 1 value from the summarize()
  Note: n() = counts number of observation in the current group
  Note: n_distinct() = efficiently count the number of unique values in a vector
  Note: quantile(variable, probs = 0.99) = returns the 99% percentile from the data
  Note: by default, dplyr prints the first 10 rows of data if there are more than 100 rows; if there are not, it will print everything

## Summarizng Data
Repasa las formas de visualizar de forma general un data frame.
De echar un vistazo a la tabla con los comandos básicos:
```{r}
  head(df,6)
  tail(df,4)
  summary(df)
  str(df)
  quantile(df, probs = seq(0, 1, 0.2), na.rm = TRUE)
  
  table(dataframe$var2, useNA="no valido")
    #Crea una tabla de relaciones entre variables
    table(dataframe$var2,dataframe$var4)
  
  colSum(is.na(dataframe))
  all(colSum(is.na(dataframe)) # nos dice si hay algun NA en la tabla
```
### Missing Values
```{r}
sum(is.na(dataframe$var3) # cuantos NA hay en la var3
 any(is.na(dataframe$var3)) # nos devuelve si hay algun NA en el resultado 
 all(condicion) # devuelve true o false si se cumple la condición en todos los valores  
 all(dt$col1 >0)
```
### Busqueda de texto
Para saber cuantos cumple y no cumplen la condicion:
```{r}
table(dataframe$var1 %in% c("hola"))
table(dataframe$var1 %in% c("hola", "adios")) # OR
```
Podemos usar el resultado anterior para seleccionar en la table
dataframe( dataframe$var1 %in% c("hola", "adios") # esto nos selecciona la tabla de los que contienen hola y adios 

### Tablas cruzadas
para sacar este caracter usar "~ tecla 4 + flecha"

Para saber la frecuencia de la columna Gender comparado con la col Admit
```{r}
xt <- xtabs( Freq ~ Gender + Admit, data=DF)
```
Un comando muy interesante que unido con ftabl(dt) puede dar juego, pero hay que entenderlo
sirve para hacer tablas cruzadas de relaciones
```{r}
xt <- xtabs(Freq ~ Gender + Admit, data = data.frame) 
```
#= cross-tabulate variable 1 with all other variables, creates multiple two dimensional tables
xt2 <- xtabs(var1 ~ ., data = data.frame) 
ftable(xt2) = compacts the different tables and prints out a more compacted version
```
### Ver el tamaño de una tabla en memoria
```{r}
object.size(fakeData)
print(object.size(fakeData), units="Mb")
```
# WEEK 4

