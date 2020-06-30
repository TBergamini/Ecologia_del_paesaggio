#### R_code_exam.R

### 1. R code First
# Primo codice R

# installazione pacchetti
install.packages("sp")

library(sp)

data(meuse)

meuse

head(meuse)


plot(meuse$cadmium,meuse$lead)

attach(meuse)

plot(cadmium,lead)

# grafico abbellito: simbolo, colore impostato a rosso
plot(cadmium,lead,pch=19,cex=2,col="red")


pairs(meuse[,3:6])


#################################################################
#################################################################
#################################################################
######################

### 2. R code spatial

# R spaziale: funzioni spaziali in Ecologia del paesaggio

install.packages("sp")

# con library() richiamiamo il pacchetto
library(sp)

# dati
data(meuse)

meuse

head(meuse)

# plot cadmium e lead

# alleghiamo il dataframe
attach(meuse)

plot(cadmium,lead,col="red",pch=19,cex=2)

# exercise: plot di copper e zinc con simbolo trinagolo (17) e colore verde
plot(copper,zinc,col="green",pch=17,cex=2)

# cambiare le etichette
plot(copper,zinc,col="green",pch=17,cex=2,xlab="rame",ylab="zinco")

# multiframe o multipanel
par(mfrow=c(1,2))
plot(cadmium,lead,col="red",pch=19,cex=2)
plot(copper,zinc,col="green",pch=17,cex=2)

# invertiamo i grafici riga/colonna in colonna/riga
par(mfrow=c(2,1))
plot(cadmium,lead,col="red",pch=19,cex=2)
plot(copper,zinc,col="green",pch=17,cex=2)

# multigrame automatico
install.packages("GGally")
library(GGally)
ggpairs(meuse[,3:6])

# Spatial!!
head(meuse)

coordinates(meuse)=~x+y
plot(meuse)

# funzione spplot per plottare i dati spazialmente
spplot(meuse,"zinc")


#################################################################
#################################################################
#################################################################

### 3. R code spatial 2

######  R spatial

# libreria sp
library(sp)

# dataset da usare
data(meuse)
head(meuse)

# usare cordinate del dataset
coordinates(meuse)=~x+y

#spplot dati sullo zinco 
spplot(meuse,"zinc")


#esercizio: spplot dei dati di rame (per vedere i nomi delle colonne si usa head() o names()
spplot(meuse,"copper")

# utilizzo funzione bubble
bubble(meuse,"zinc")

# esercizio bubble su rame, ma colorato di rosso
bubble(meuse,"copper",col="red")

# foraminiferi, carbon capture
#array
foram <- c(10, 20, 35, 55, 67, 80)
carbon <- c(5, 15, 30, 70, 85, 99)
# facciamo un plot dei due dati inventati
plot(foram, carbon, col="green", cex=2, pch=18)

#dati esterni su Covid-19
# cartella creata su C:/lab (windows)
setwd("C:/lab") # windows

# leggere la tabella dal file e nominarla covid-19
covid <- read.table("covid_agg.csv",head=TRUE)


#################################################################
#################################################################
#################################################################

### 4. R code point pattern

# Codice per l'analisi di strutture relazionate ai punti nello spazio (point patterns)

install.packages("ggplot2")
library(ggplot2) #per richiamare il pacchetto
install.packages("spatstat")
library(spatstat)

#settaggio della directory per utenti windows
setwd("C:/lab")

#lettura della tabella su covid e delle variabili
covid <- read.table("covid_agg.csv", head=T)

#funzione per visualizzarla (prime righe)
head(covid)

#facciamo un plot dei dati
plot(covid$country,covid$cases) # il $ serve a collegare i dati 
#si può fare anche facendo attach(covid) e poi plot(country,cases)

# per vsualizzare la scelta di configurazione 
plot(covid$country,covid$cases,las=0) #las=0 le label sono parallele all'asse
plot(covid$country,covid$cases,las=1) #le etichette diventano orizzontali
plot(covid$country,covid$cases,las=2) # las=2 perpendicolari all'asse
plot(covid$country,covid$cases,las=3) # las=3 sono tutti verticali

plot(covid$country,covid$cases,las=3,cex.axis=0.5) # cex.axis modifica la grandezza degli assi

# ggplot2
data(mpg)
head(mpg)

#data (dataset)
#aes (estetica variabili)
#tipo di geometria
ggplot(mpg,aes(x=displ,y=hwy)) + geom_point() # geometria a punti
ggplot(mpg,aes(x=displ,y=hwy)) + geom_line()  # geometria a linea
ggplot(mpg,aes(x=displ,y=hwy)) + geom_polygon() # geom a poligoni

# ora ggplot ma di covid
names(covid)
ggplot(covid,aes(x=lon,y=lat,size=cases)) + geom_point()

#creare un dataset per spatstat
attach(covid)
covids <- ppp(lon, lat, c(-180,180), c(-90,90))

d <- density(covids)
plot(d)
points(covids, pch=19)

#salviamo il lavoro del progetto per mancanza di tempo, così da riavere tutto 


#carichiamo i dati di ieri
setwd("C:/lab")
load("Lavoro 31 marzo.RData")
ls() #per vedere i dati precedenti
library(spatstat) #richiama la libreria di spatstat (se no non ti legge plot d)
install.packages("rgdal") #installare libreria per leggere dati vettoriali
library(rgdal) #richiamo la libreria
plot(d)
cl <- colorRampPalette(c('yellow','orange','red'))(100) # cambiare colore alla mappa: palette
plot(d,col=cl)
#esercizio: plot della mappa della densità dal verde al blu
cl <- colorRampPalette(c('yellow','green','blue'))(100)

points(covids,pch=19,cex=0.5)

#mettere i bordi alle nazioni, utilizzando un database internazionale

coastlines <- readOGR("ne_10m_coastline.shp")
plot(coastlines, col="blue", add=T) #aggiungere le coastlines al plot precedente

# esercizio: plot della mappa di densità con una nuova colorazione e aggiunta delle coastlines
cl <- colorRampPalette(c('yellow','green','blue'))(100)
plot(d,col=cl)
plot(coastlines, col="black", add=T)
points(covids,pch=19,cex=0.5)


#21/4/20

library(spatstat)
library(ggplot2)
library(sp)
library(rgdal) 

coastlines <- readOGR("ne_10m_coastline.shp")
plot(d)
points(covids,col="yellow")
plot(coastlines, col="yellow", add=T)

cl5 <- colorRampPalette(c('cyan', 'purple', 'red')) (200)
plot(d, col=cl5, main="density")
points(covids)
coastlines <- readOGR("ne_10m_coastline.shp")
plot(coastlines, add=T)

# interpolation
head(covid)
marks(covids) <- covid$cases
s <- Smooth(covids)
plot(s)

#esercizio: inseirire a s anche i punti e i bordi delle coste
cl5 <- colorRampPalette(c('cyan', 'purple', 'red')) (200) 
plot(s, col=cl5, main="estimate of cases")
points(covids)
coastlines <- readOGR("ne_10m_coastline.shp")
plot(coastlines, add=T)

#### mappa finale
par(mfrow=c(2,1))

#densità
cl5 <- colorRampPalette(c('cyan', 'purple', 'red')) (200)
plot(d, col=cl5, main="density")
points(covids)
coastlines <- readOGR("ne_10m_coastline.shp")
plot(coastlines, add=T)

#interpolazione
cl5 <- colorRampPalette(c('cyan', 'purple', 'red')) (200)
plot(s, col=cl5, main="estimate of cases")
points(covids)
coastlines <- readOGR("ne_10m_coastline.shp")
plot(coastlines, add=T)



#San marino
library(spatstat)
setwd("C:/lab")
load("Tesi.RData")
ls()
head(Tesi)

attach(Tesi)

summary(Tesi)
#point pattern: x,y,c(xmin,xmax),C(ymin,ymax)
Tesippp <- ppp(Longitude, Latitude, c(12.41, 12.47), c(43.90, 43.95))

dT <- density(Tesippp)
plot(dT)
points(Tesippp, col="black")

# lezione del 28/04/20

setwd("C:/lab/")
load("sanmarino.RData")

ls()

# dT = density map; Tesi = tabella dei dati originali; Tesippp = point pattern di Tesi

library(spatstat)
plot(dT)
points(Tesippp, col="green")
head(Tesi)

# interpolation
# marks(Tesippp) <- Tesi[8] # numero della colonna con i casi
marks(Tesippp) <- Tesi$Species_richness 
interpol <- Smooth(Tesippp) #crea mappa raster a partire da valori discreti
plot(interpol)
points(Tesippp, col="black")

library(rgdal)
sanmarino <- readOGR("San_Marino.shp")
plot(sanmarino)
plot(interpol, add=T)
points(Tesippp, col="black")
plot(sanmarino, add=T) #riaggiungiamo sopra la mappa di sanmarino

#esercizio: fare un plot multiframe di densità e interpolazione
par(mfrow=c(2,1)) #creiamo un multiframe a 2 righe e 1 colonna
plot(dT, main="Densità")
points(Tesippp, col="black")
plot(interpol, main="Stima della ricchezza di specie")
points(Tesippp, col="black")
View(Tesi) #per vedere la tabella dei dati relativi a Tesi

#esercizio: cambiamo colonne e righe del multiframe
par(mfrow=c(1,2))
plot(dT, main="Density of points")
points(Tesippp,col="black")
plot(interpol, main="Estimate of species richness")
points(Tesippp,col="black")
 
#################################################################
#################################################################
#################################################################

### 5. R code teleril

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

#ricarico il progetto

setwd("C:/lab")
load("satellitare.RData")
ls() #per vedere cosa abbiamo salvato

library(raster) #ricarichiamo la libreria raster

plot(p224r63_2011)

cl <- colorRampPalette(c('black','grey','light grey'))(100) # impostiamo le colorazioni
plot(p224r63_2011, col=cl)
 
cllow <- colorRampPalette(c('black','grey','light grey'))(5) # impostiamo le colorazioni guardando come cambiano le sfumature cambiandone il numero di classi
plot(p224r63_2011, col=cllow)

#impostiamo il colore sulla banda del blu
names(p224r63_2011) # visualizziamo i nomi dell'immagine scelta
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100)
#attch(dataframe) non funziona con il pacchetto raster
#simbolo che lega la colonna (la banda) al database (immagine satellitare): $
plot(p224r63_2011$B1_sre, col=clb)

#esercizio: plottare la banda dell'infrarosso vicino con
# colorRampPalette che varia dal rosso all'arancione al giallo
clr <- colorRampPalette(c('red','orange','yellow'))(100)
plot(p224r63_2011$B4_sre, col=clr)

#multiframe delle 4 bande
par(mfrow=c(2,2)) # dividiamo in 2 righe e 2 colonne
# blu
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100)
plot(p224r63_2011$B1_sre, col=clb)

#verde
clg <- colorRampPalette(c('dark green','green','light green'))(100)
plot(p224r63_2011$B2_sre, col=clg)

#Rosso
clred <- colorRampPalette(c('dark red','red','yellow'))(100)
plot(p224r63_2011$B3_sre, col=clred)

# infrarosso vicino
clr <- colorRampPalette(c('red','orange','yellow'))(100)
plot(p224r63_2011$B4_sre, col=clr)

dev.off() #chiude la finestra grafica
# montiamo l'immagine come le vedrebbe l'occhio umano (natural colours)
# 3 componenti all'interno della grafica del pc: R G B
# 3 bande: R= bande del red, G= bande del green, B= bande del blue
# B1: blue
# B2: green
# B3: red
# B4: near infrared (nir)
# B5: medium infrared
# B6: thermal infrared
# B7: medium infrared

plotRGB(p224r63_2011, r=3, g=2, b=1) # no plotrgb (capisce il maiuscolo)
# "stiriamo" i colori
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")

# usiamo anche l'infrarosso vicino per vedere meglio la vegetazione
# false colours
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

#salvare un grafico 
pdf("primografico.pdf") # png("primografico.png")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
dev.off()

#multiframe
par(mfrow=c(1,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

dev.off()

#nir nella componente red
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
#esercizio: nir nella componente green
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
#esercizio: nir nella componente blue
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")


# 15/04 ripresa della lezione

library(raster)

setwd("C:/lab")

load("satellitare.RData")

#lista contenuti salvati
ls()

# richiamo immagine del 1988
p224r63_1988 <- brick("p224r63_1988_masked.grd")

plot(p224r63_1988)

#multiframe
par(mfrow=c(2,2))

# blu
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100)
plot(p224r63_1988$B1_sre, col=clb)

#verde
clg <- colorRampPalette(c('dark green','green','light green'))(100)
plot(p224r63_1988$B2_sre, col=clg)

#Rosso
clred <- colorRampPalette(c('dark red','red','yellow'))(100)
plot(p224r63_1988$B3_sre, col=clred)

# infrarosso vicino
clr <- colorRampPalette(c('red','orange','yellow'))(100)
plot(p224r63_1988$B4_sre, col=clr)

#chiudo il vecchio plot
dev.off()

# B1: blue
# B2: green
# B3: red
# B4: near infrared (nir)

plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")

#esercizio: plot dell'immagine con nir su "R"
#nir nella componente red
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")

#plot delle due immagini 1988 e 2011
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

#aggiungere il titolo
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin", main="1988")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin", main="2011")
dev.off()

#spectral indices
#dvi1988 = nir1988-red1988

dvi1988 <- p224r63_1988$B4_sre - p224r63_1988$B3_sre
plot(dvi1988)

# esercizio: calcolare dvi per 2011
dvi2011 <- p224r63_2011$B4_sre - p224r63_2011$B3_sre
plot(dvi2011)

cldvi <- colorRampPalette(c('light blue','light green','green'))(100) # 
plot(dvi2011, col=cldvi)

# analisi multiframe
difdvi <- dvi2011 - dvi1988
plot(difdvi)
cldifdvi <- colorRampPalette(c('red','white','blue'))(100) # 
plot(difdvi, col=cldifdvi)

# visualizzare un output
# multiframe 1988rgb, 2011rgb, difdvi
par(mfrow=c(3,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plot(difdvi, col=cldifdvi)

dev.off()

#cambiare la risoluzione
p224r63_2011lr <- aggregate(p224r63_2011, fact=10)

par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011lr, r=4, g=3, b=2, stretch="Lin")

#bassa risoluzione
p224r63_2011lr50 <- aggregate(p224r63_2011, fact=50)
p224r63_2011lr50
# original 30m -> resampled 1500m

par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011lr, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011lr50, r=4, g=3, b=2, stretch="Lin")

dvi2011lr50 <- p224r63_2011lr50$B4_sre - p224r63_2011lr50$B3_sre
plot(dvi2011lr50)

#dvi1988 low resolution
p224r63_1988r50 <- aggregate(p224r63_1988, fact=50)
dvi1988lr50 <- p224r63_1988lr50$B4_sre - p224r63_1988lr50$B3_sre
 
# difdvi low resolution
difdvilr50 <- dvi2011lr50 - dvi1988lr50
 plot(difdvilr50,col=cldifdvi)

par(mfrow=c(2,1))
plot(difdvi, col=cldifdvi)
plot(difdvilr50, col=cldifdvi)

#################################################################
#################################################################
#################################################################

### 7. R code multitemp

#R code analisi multitemporale di variazione di land cover

setwd("C:/lab/")
library(raster)

defor1 <- brick("defor1_.jpg")
defor2 <- brick("defor2_.jpg")
 plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
 
#esercizio: plot della seconda data
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")
 
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

#classificazione non supervisionata
library(RStoolbox)
d1c <- unsuperClass(defor1, nClasses=2)
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

#################################################################
#################################################################
#################################################################

### 8. R code multitemp NO2

# R code per l'analisi dati NO2

setwd("C:/lab/")
library(raster)

EN01 <- raster("EN_0001.png")
plot(EN01)

#esercizio: importare ogni immagine
EN01 <- raster("EN_0001.png")
EN02 <- raster("EN_0002.png")
EN03 <- raster("EN_0003.png")
EN04 <- raster("EN_0004.png")
EN05 <- raster("EN_0005.png")
EN06 <- raster("EN_0006.png")
EN07 <- raster("EN_0007.png")
EN08 <- raster("EN_0008.png")
EN09 <- raster("EN_0009.png")
EN10 <- raster("EN_0010.png")
EN11 <- raster("EN_0011.png")
EN12 <- raster("EN_0012.png")
EN13 <- raster("EN_0013.png")

cl <- colorRampPalette(c('red','orange','yellow'))(100)
par(mfrow=c(1,2))
plot(EN01, col=cl)
plot(EN13, col=cl)

dev.off()
difno2 <- EN13-EN01 #differenza
cldif <- colorRampPalette(c('blue','black','yellow'))(100) # 
plot(difno2, col=cldif)

#plot delle immagini
par(mfrow=c(4,4))
plot(EN01, col=cl)
plot(EN02, col=cl)
plot(EN03, col=cl)
plot(EN04, col=cl)
plot(EN05, col=cl)
plot(EN06, col=cl)
plot(EN07, col=cl)
plot(EN08, col=cl)
plot(EN09, col=cl)
plot(EN10, col=cl)
plot(EN11, col=cl)
plot(EN12, col=cl)
plot(EN13, col=cl)



####### lezione del 12/5

library(raster)

setwd("C:/lab/esa_no2")

rlist <- list.files(pattern=".png")

listafinale <- lapply(rlist, raster)

EN <- stack(listafinale)

difEN <- EN$EN_0013 - EN$EN_0001

cld <- colorRampPalette(c('blue','white','red'))(100) # 
plot(difEN, col=cld)

cl <- colorRampPalette(c('red','orange','yellow'))(100) #
plot(EN, col=cl)

boxplot(EN, horizontal=T,outline=F,axes=T)

#################################################################
#################################################################
#################################################################

### 9. R code snow

setwd("C:/lab/")

install.packages("ncdf4")
library(ncdf4)
library(raster)

snowmay <- raster("c_gls_SCE500_202005180000_CEURO_MODIS_V1.0.1.nc")
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 

# esercizio: plottare la neve con le colorazioni 
plot(snowmay,col=cl)

##### importare i dati sulla neve

setwd("~/lab/snow")
# setwd("/Users/utente/lab/snow") #mac
# setwd("C:/lab/snow") # windows

# snow2000r <- raster("snow2000r.tif")

# lapply() example with NO2 data

# rlist=list.files(pattern=".png", full.names=T)

##save raster into list
##con lappy
# list_rast=lapply(rlist, raster)
# EN <- stack(list_rast)
# plot(EN)

rlist <- list.files(pattern=".tif")
rlist 

#save raster into list
#con lappy
list_rast <- lapply(rlist, raster)
snow.multitemp <- stack(list_rast)
plot(snow.multitemp,col=cl)

par(mfrow=c(1,2))
plot(snow.multitemp$snow2000r, col=cl)
plot(snow.multitemp$snow2020r, col=cl)

par(mfrow=c(1,2))
plot(snow.multitemp$snow2000r, col=cl, zlim=c(0,250))
plot(snow.multitemp$snow2020r, col=cl, zlim=c(0,250))

difsnow = snow.multitemp$snow2020r - snow.multitemp$snow2000r
cldiff <- colorRampPalette(c('blue','white','red'))(100) 
plot(difsnow, col=cldiff)

# prediction
# go to IOL and downloand prediction.r into the folder snow
# source("prediction.r")
# plot(predicted.snow.2025.norm, col=cl)
# since the code needs time, you can ddownload predicted.snow.2025.norm.tif from iol in the Data

predicted.snow.2025.norm <- raster("predicted.snow.2025.norm.tif")
plot(predicted.snow.2025.norm, col=cl)










#### 11. R_code crop  exam 
 library(raster)
setwd("C:/lab/snow/")

#esercizio: caricare tutte le immagini snow

rlist <- list.files(pattern="snow")
rlist

list_rast <- lapply(rlist, raster)
snow.multitemp <- stack(list_rast)
 
 clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) # 
plot(snow.multitemp,col=clb)

# vari modi per fare lo zoom

snow.multitemp

plot(snow.multitemp$snow2010r, col=clb)

extension <- c(6, 20, 40, 50)
zoom(snow.multitemp$snow2010r, ext=extension)

# zoom attraverso disegno
plot(snow.multitemp$snow2010r, col=clb)
zoom(snow.multitemp$snow2010r, ext=drawExtent())

# comando crop (taglia e non ingrandisce soltanto)
extension <- c(6, 20, 35, 50)
snow2010r.italy <- crop(snow.multitemp$snow2010r, extension)
plot(snow2010r.italy, col=clb)

#esercizio: fare il crop di tutto lo stack
tot.italy <- crop(snow.multitemp, extension)
plot(tot.italy, col=clb)
plot(tot.italy, col=clb, zlim=c(20,200)) # con variazione impostata da 20 a 200 per tutti uguale

# boxplot
boxplot(snow.multitemp.italy, horizontal=T,outline=F)
