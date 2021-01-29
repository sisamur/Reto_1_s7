install.packages("DBI")
install.packages("RMySQL")
install.packages("dplyr")
install.packages("ggplot2")

library(DBI)
library(RMySQL)
library(dplyr)
library(ggplot2)

#Crea un repositorio en Github llamado Reto_Sesion_7
#
#Crea un Project llamado Reto_Sesion_07 dentro de RStudio utilizando tu cuenta de RStudio, que esté ligado al repositorio recien creado
#
#Ahora en RStudio crea un script llamado queries.Ren donde se conecte a la BDD shinydemo
#
#Una vez hecha la conexión a la BDD, generar una busqueda con dplyr que devuelva el porcentaje de personas que hablan español en todos los países

MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

dbListTables(MyDataBase)

DataDB <- dbGetQuery(MyDataBase, "select * from CountryLanguage")
str(DataDB)
filtro.sp<-filter(DataDB, Language == "Spanish")

#Realizar una gráfica con ggplot que represente este porcentaje de tal modo que en el eje de las Y aparezca el país y en X el porcentaje, y que diferencie entre aquellos que es su lengua oficial y los que no de diferente color (puedes utilizar la geom_bin2d() y _ coord_flip()_)

ggplot(filtro.sp, aes( x = CountryCode, y=Percentage, fill = IsOfficial )) + 
  geom_bin2d() +
  coord_flip()+
  ggtitle("Porcentaje de personas que hablen español") +
  ylab("Porcentaje") +
  xlab("País")+
  labs(fill = "Es oficial")


#Una vez hecho esto hacer el commit y push para mandar tu archivo al repositorio de Github Reto_Sesion_7

