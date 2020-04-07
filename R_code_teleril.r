##-- Codice R per analisi dati di rilevamento satellitare

setwd("C:/lab")

#pacchetti che ci serviranno
install.packages("raster") 
install.packages("rgdal") 
install.packages("ggplot2")
install.packages("RStoolbox")

library(raster)
library(rgdal)
library(ggplot2)
library(RStoolbox)


p224r63_2011 <- brick("p224r63_2011_masked.grd")
 
plot(p224r63_2011)
