#R code analisi multitemporale di variazione di land cover

setwd("C:/lab/")
library(raster)

defor1 <- brick("defor1_.jpg")
defor2 <- brick("defor2_.jpg")
 plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
 
#esercizio 
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")
 
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

#classificazione non supervisionata
library(RStoolbox)
plot(d1c$map)
cl <- colorRampPalette(c('black','green'))(100) # 
plot(d1c$map, col=cl)

cl <- colorRampPalette(c('green','black'))(100) # invertireb i colori
plot(d1c$map, col=cl)

#classificazione del defor2
#esercizio: classificare con due classi l'immagine satellitare
d2c <- unsuperClass(defor2, nClasses=2)
plot(d2c$map, col=cl)

dev.off() #chiudiamo i grafici

#plot delle mappe ottenute
par(mfrow=c(2,1))
plot(d1c$map, col=cl)
plot(d2c$map, col=cl)

par(mfrow=c(1,2))
plot(d1c$map, col=cl)
plot(d2c$map, col=cl)

freq(d1c$map)
# aree aperte = 34519 celle
# foresta = 306773 celle

# calcolare proporzione
totd1 <- 34519 + 306773
percent1 <- freq(d1c$map) * 100 / totd1

#percentuali
#foreste = 89.89
# aree aperte = 10.11

freq(d2c$map)
# aree aperte = 178140
#foreste = 164586
totd2 <- 178140 + 164586
percent2 <- freq(d2c$map) * 100 / totd2
# areeaperte  48.1
#foreste 51.9

#################

cover <- c("Agriculture", "Forest")
before <- c(10.11,89.89)
after <- c(48.1,51.9)

output <- data.frame(cover,before,after)
View(output)

library(ggplot2)

setwd("C:/lab/")
load("defor.RData")
ls() #vediamo la lista dei file

library(raster)

par(mfrow=c(1,2))
cl <- colorRampPalette(c('black','green'))(100) # 
plot(d1c$map, col=cl)
plot(d2c$map, col=cl)

library(ggplot2)
# istogramma sulla % di copertura del suolo
ggplot(output, aes(x=cover, y=before, color=cover)) +
geom_bar(stat="identity", fill="white")

#esercizio: plot dell'istogramma della deforestazione dopo
ggplot(output, aes(x=cover, y=after, color=cover)) +
geom_bar(stat="identity", fill="white")

install.packages("gridExtra")
library(gridExtra) #oppure require(Extra)

gr1<-ggplot(output, aes(x=cover, y=before, color=cover)) +
geom_bar(stat="identity", fill="white")
gr2<-ggplot(output, aes(x=cover, y=after, color=cover)) +
geom_bar(stat="identity", fill="white")
grid.arrange(gr1, gr2, nrow = 1) # this needs griExtra, mette entrambi i grafici in una finestra

