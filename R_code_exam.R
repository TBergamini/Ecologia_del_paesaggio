#### R_code_exam.R

### 1. R code First

# Primo codice R

#TB. installazione pacchetti
install.packages("sp")

library(sp)

data(meuse)

meuse

head(meuse)

#TB. plottaggio

plot(meuse$cadmium,meuse$lead)

attach(meuse)

plot(cadmium,lead)

#TB. grafico abbellito: simbolo, colore impostato a rosso
plot(cadmium,lead,pch=19,cex=2,col="red")


pairs(meuse[,3:6])


#################################################################
#################################################################
#################################################################
######################

### 2. R code spatial

#TB. R spaziale: funzioni spaziali in Ecologia del paesaggio

install.packages("sp")

#TB. con library() richiamiamo il pacchetto
library(sp)

#TB. dati
data(meuse)

meuse

head(meuse)

#TB. plot cadmium e lead

#TB. alleghiamo il dataframe
attach(meuse)

#TB. plottaggio del dataframe

plot(cadmium,lead,col="red",pch=19,cex=2)

# exercise: plot di copper e zinc con simbolo trinagolo (17) e colore verde
plot(copper,zinc,col="green",pch=17,cex=2)

#TB. cambiare le etichette
plot(copper,zinc,col="green",pch=17,cex=2,xlab="rame",ylab="zinco")

#TB. multiframe o multipanel
par(mfrow=c(1,2))
plot(cadmium,lead,col="red",pch=19,cex=2)
plot(copper,zinc,col="green",pch=17,cex=2)

#TB. invertiamo i grafici riga/colonna in colonna/riga
par(mfrow=c(2,1))
plot(cadmium,lead,col="red",pch=19,cex=2)
plot(copper,zinc,col="green",pch=17,cex=2)

#TB. multigrame automatico
install.packages("GGally")
library(GGally)
ggpairs(meuse[,3:6])

#TB. Spatial!!
head(meuse)

coordinates(meuse)=~x+y
plot(meuse)

#TB. funzione spplot per plottare i dati spazialmente
spplot(meuse,"zinc")


#################################################################
#################################################################
#################################################################

### 3. R code spatial 2

######  R spatial

#TB. libreria sp
library(sp)

#TB. dataset da usare
data(meuse)
head(meuse)

#TB. usare cordinate del dataset
coordinates(meuse)=~x+y

#TB. spplot dati sullo zinco 
spplot(meuse,"zinc")


#TB. esercizio: spplot dei dati di rame (per vedere i nomi delle colonne si usa head() o names()
spplot(meuse,"copper")

#TB. utilizzo funzione bubble
bubble(meuse,"zinc")

#TB. esercizio bubble su rame, ma colorato di rosso
bubble(meuse,"copper",col="red")

#TB. foraminiferi, carbon capture
#TB. array
foram <- c(10, 20, 35, 55, 67, 80)
carbon <- c(5, 15, 30, 70, 85, 99)
#TB. facciamo un plot dei due dati inventati
plot(foram, carbon, col="green", cex=2, pch=18)

#TB. dati esterni su Covid-19
#TB. cartella creata su C:/lab (windows)
setwd("C:/lab") # windows

#TB. leggere la tabella dal file e nominarla covid-19
covid <- read.table("covid_agg.csv",head=TRUE)


#################################################################
#################################################################
#################################################################

### 4. R code point pattern

# Codice per l'analisi di strutture relazionate ai punti nello spazio (point patterns)

#TB. installo e richiamo le librerie

install.packages("ggplot2")
library(ggplot2) #per richiamare il pacchetto
install.packages("spatstat")
library(spatstat)

#TB. settaggio della directory per utenti windows
setwd("C:/lab")

#TB. lettura della tabella su covid e delle variabili
covid <- read.table("covid_agg.csv", head=T)

#TB. funzione per visualizzarla (prime righe)
head(covid)

#TB. facciamo un plot dei dati
plot(covid$country,covid$cases) # il $ serve a collegare i dati 
#TB. si può fare anche facendo attach(covid) e poi plot(country,cases)

#TB. per vsualizzare la scelta di configurazione 
plot(covid$country,covid$cases,las=0) #las=0 le label sono parallele all'asse
plot(covid$country,covid$cases,las=1) #le etichette diventano orizzontali
plot(covid$country,covid$cases,las=2) # las=2 perpendicolari all'asse
plot(covid$country,covid$cases,las=3) # las=3 sono tutti verticali

plot(covid$country,covid$cases,las=3,cex.axis=0.5) # cex.axis modifica la grandezza degli assi

#TB. ggplot2
data(mpg)
head(mpg)

#TB. data (dataset)
#TB. aes (estetica variabili)
#TB. tipo di geometria
ggplot(mpg,aes(x=displ,y=hwy)) + geom_point() # geometria a punti
ggplot(mpg,aes(x=displ,y=hwy)) + geom_line()  # geometria a linea
ggplot(mpg,aes(x=displ,y=hwy)) + geom_polygon() # geom a poligoni

#TB. ora ggplot ma di covid
names(covid)
ggplot(covid,aes(x=lon,y=lat,size=cases)) + geom_point()

#TB. creare un dataset per spatstat
attach(covid)
covids <- ppp(lon, lat, c(-180,180), c(-90,90))

#TB. imposto d come densità dei dati covid
d <- density(covids)
plot(d)
points(covids, pch=19)

#TB. salviamo il lavoro del progetto per mancanza di tempo, così da riavere tutto 


#TB. carichiamo i dati di ieri
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

#TB. mettere i bordi alle nazioni, utilizzando un database internazionale

coastlines <- readOGR("ne_10m_coastline.shp")
plot(coastlines, col="blue", add=T) #aggiungere le coastlines al plot precedente

# esercizio: plot della mappa di densità con una nuova colorazione e aggiunta delle coastlines
cl <- colorRampPalette(c('yellow','green','blue'))(100)
plot(d,col=cl)
plot(coastlines, col="black", add=T)
points(covids,pch=19,cex=0.5)


#21/4/20

#TB. ricarico le librerie 
library(spatstat)
library(ggplot2)
library(sp)
library(rgdal) 

#TB. imposto le coastline e faccio un plot della densitàe dei punti
coastlines <- readOGR("ne_10m_coastline.shp")
plot(d)
points(covids,col="yellow")
plot(coastlines, col="yellow", add=T)

#TB. lo rifaccio cambiando colore
cl5 <- colorRampPalette(c('cyan', 'purple', 'red')) (200)
plot(d, col=cl5, main="density")
points(covids)
coastlines <- readOGR("ne_10m_coastline.shp")
plot(coastlines, add=T)

#TB. interpolation
head(covid)
marks(covids) <- covid$cases
s <- Smooth(covids)
plot(s)

#TB. esercizio: inseirire a s anche i punti e i bordi delle coste
cl5 <- colorRampPalette(c('cyan', 'purple', 'red')) (200) 
plot(s, col=cl5, main="estimate of cases")
points(covids)
coastlines <- readOGR("ne_10m_coastline.shp")
plot(coastlines, add=T)

#TB. mappa finale
par(mfrow=c(2,1))

#TB. densità
cl5 <- colorRampPalette(c('cyan', 'purple', 'red')) (200)
plot(d, col=cl5, main="density")
points(covids)
coastlines <- readOGR("ne_10m_coastline.shp")
plot(coastlines, add=T)

#TB. interpolazione
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

#TB. point pattern: x,y,c(xmin,xmax),C(ymin,ymax)
Tesippp <- ppp(Longitude, Latitude, c(12.41, 12.47), c(43.90, 43.95))

#TB. densità della tesi con anche i punti
dT <- density(Tesippp)
plot(dT)
points(Tesippp, col="black")

# lezione del 28/04/20

#TB. ricarico
setwd("C:/lab/")
load("sanmarino.RData")

ls()

#TB. dT = density map; Tesi = tabella dei dati originali; Tesippp = point pattern di Tesi

library(spatstat)
plot(dT)
points(Tesippp, col="green")
head(Tesi)

#TB. interpolation
#TB. marks(Tesippp) <- Tesi[8] # numero della colonna con i casi
marks(Tesippp) <- Tesi$Species_richness 
interpol <- Smooth(Tesippp) #crea mappa raster a partire da valori discreti
plot(interpol)
points(Tesippp, col="black")

#TB. carico i dati di san marino e della tesi
library(rgdal)
sanmarino <- readOGR("San_Marino.shp")
plot(sanmarino)
plot(interpol, add=T)
points(Tesippp, col="black")
plot(sanmarino, add=T) #riaggiungiamo sopra la mappa di sanmarino

#TB. esercizio: fare un plot multiframe di densità e interpolazione
par(mfrow=c(2,1)) # TB.creiamo un multiframe a 2 righe e 1 colonna
plot(dT, main="Densità")
points(Tesippp, col="black")
plot(interpol, main="Stima della ricchezza di specie")
points(Tesippp, col="black")
View(Tesi) #TB. per vedere la tabella dei dati relativi a Tesi

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

#TB. pacchetti che ci serviranno
install.packages("raster") 
install.packages("rgdal") 
install.packages("ggplot2")
install.packages("RStoolbox")

library(raster)
library(rgdal)
library(ggplot2)
library(RStoolbox)

#TB. nomino il file .rgd
p224r63_2011 <- brick("p224r63_2011_masked.grd")
 
plot(p224r63_2011)

#TB. ricarico il progetto

setwd("C:/lab")
load("satellitare.RData")
ls() #TB. per vedere cosa abbiamo salvato

library(raster) #TB. ricarichiamo la libreria raster

plot(p224r63_2011)

cl <- colorRampPalette(c('black','grey','light grey'))(100) # impostiamo le colorazioni
plot(p224r63_2011, col=cl)
 
cllow <- colorRampPalette(c('black','grey','light grey'))(5) # impostiamo le colorazioni guardando come cambiano le sfumature cambiandone il numero di classi
plot(p224r63_2011, col=cllow)

#TB. impostiamo il colore sulla banda del blu
names(p224r63_2011) #TB. visualizziamo i nomi dell'immagine scelta
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100)
#TB. attch(dataframe) non funziona con il pacchetto raster
#TB. simbolo che lega la colonna (la banda) al database (immagine satellitare): $
plot(p224r63_2011$B1_sre, col=clb)

#TB. esercizio: plottare la banda dell'infrarosso vicino con ColorRampPalette che varia dal rosso all'arancione al giallo
clr <- colorRampPalette(c('red','orange','yellow'))(100)
plot(p224r63_2011$B4_sre, col=clr)

#TB. multiframe delle 4 bande
par(mfrow=c(2,2)) #TB. dividiamo in 2 righe e 2 colonne
#TB. blu
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100)
plot(p224r63_2011$B1_sre, col=clb)

#TB. verde
clg <- colorRampPalette(c('dark green','green','light green'))(100)
plot(p224r63_2011$B2_sre, col=clg)

#TB. Rosso
clred <- colorRampPalette(c('dark red','red','yellow'))(100)
plot(p224r63_2011$B3_sre, col=clred)

#TB. infrarosso vicino
clr <- colorRampPalette(c('red','orange','yellow'))(100)
plot(p224r63_2011$B4_sre, col=clr)

dev.off() #TB. chiude la finestra grafica
#TB. montiamo l'immagine come le vedrebbe l'occhio umano (natural colours)
#TB. 3 componenti all'interno della grafica del pc: R G B
#TB. 3 bande: R= bande del red, G= bande del green, B= bande del blue
#TB. B1: blue
#TB. B2: green
#TB. B3: red
#TB. B4: near infrared (nir)
#TB. B5: medium infrared
#TB. B6: thermal infrared
#TB. B7: medium infrared

plotRGB(p224r63_2011, r=3, g=2, b=1) #TB. no plotrgb (capisce il maiuscolo)
#TB. "stiriamo" i colori
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")

#TB. usiamo anche l'infrarosso vicino per vedere meglio la vegetazione
#TB. false colours
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

#TB. salvare un grafico 
pdf("primografico.pdf") # png("primografico.png")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
dev.off()

#TB. multiframe
par(mfrow=c(1,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

#TB. pulisco la finestra grafici
dev.off()

#TB. nir nella componente red
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
#esercizio: nir nella componente green
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
#esercizio: nir nella componente blue
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")


# 15/04 ripresa della lezione

#TB. ricarico la lezione
library(raster)

setwd("C:/lab")

load("satellitare.RData")

#TB. lista contenuti salvati
ls()

#TB. richiamo immagine del 1988
p224r63_1988 <- brick("p224r63_1988_masked.grd")

plot(p224r63_1988)

#TB. multiframe
par(mfrow=c(2,2))

#TB. blu
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100)
plot(p224r63_1988$B1_sre, col=clb)

#TB. verde
clg <- colorRampPalette(c('dark green','green','light green'))(100)
plot(p224r63_1988$B2_sre, col=clg)

#TB. Rosso
clred <- colorRampPalette(c('dark red','red','yellow'))(100)
plot(p224r63_1988$B3_sre, col=clred)

#TB. infrarosso vicino
clr <- colorRampPalette(c('red','orange','yellow'))(100)
plot(p224r63_1988$B4_sre, col=clr)

#TB. chiudo il vecchio plot
dev.off()

# B1: blue
# B2: green
# B3: red
# B4: near infrared (nir)

plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")

#esercizio: plot dell'immagine con nir su "R"
#TB. nir nella componente red
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")

#TB. plot delle due immagini 1988 e 2011
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

#TB. aggiungere il titolo
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin", main="1988")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin", main="2011")
dev.off()

#TB. spectral indices
#TB. dvi1988 = nir1988-red1988

dvi1988 <- p224r63_1988$B4_sre - p224r63_1988$B3_sre
plot(dvi1988)

#TB. esercizio: calcolare dvi per 2011
dvi2011 <- p224r63_2011$B4_sre - p224r63_2011$B3_sre
plot(dvi2011)

cldvi <- colorRampPalette(c('light blue','light green','green'))(100) # 
plot(dvi2011, col=cldvi)

#TB. analisi multiframe
difdvi <- dvi2011 - dvi1988
plot(difdvi)
cldifdvi <- colorRampPalette(c('red','white','blue'))(100) # 
plot(difdvi, col=cldifdvi)

#TB. visualizzare un output
#TB. multiframe 1988rgb, 2011rgb, difdvi
par(mfrow=c(3,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plot(difdvi, col=cldifdvi)

dev.off()

#TB. cambiare la risoluzione
p224r63_2011lr <- aggregate(p224r63_2011, fact=10)

par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011lr, r=4, g=3, b=2, stretch="Lin")

#TB. bassa risoluzione
p224r63_2011lr50 <- aggregate(p224r63_2011, fact=50)
p224r63_2011lr50
#TB. original 30m -> resampled 1500m
#TB. multiframe 3 righe 1 colonna
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011lr, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011lr50, r=4, g=3, b=2, stretch="Lin")

dvi2011lr50 <- p224r63_2011lr50$B4_sre - p224r63_2011lr50$B3_sre
plot(dvi2011lr50)

#TB. dvi1988 low resolution
p224r63_1988r50 <- aggregate(p224r63_1988, fact=50)
dvi1988lr50 <- p224r63_1988lr50$B4_sre - p224r63_1988lr50$B3_sre
 
#TB. difdvi low resolution
difdvilr50 <- dvi2011lr50 - dvi1988lr50
plot(difdvilr50,col=cldifdvi)

#TB. multiframe
par(mfrow=c(2,1))
plot(difdvi, col=cldifdvi)
plot(difdvilr50, col=cldifdvi)

#################################################################
#################################################################
#################################################################

### 7. R code multitemp

#R code analisi multitemporale di variazione di land cover

#TB. set della wd
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

#TB. classificazione non supervisionata
library(RStoolbox)
d1c <- unsuperClass(defor1, nClasses=2)
plot(d1c$map)
cl <- colorRampPalette(c('black','green'))(100) # 
plot(d1c$map, col=cl)

cl <- colorRampPalette(c('green','black'))(100) # invertireb i colori
plot(d1c$map, col=cl)

#TB. classificazione del defor2
#TB. esercizio: classificare con due classi l'immagine satellitare
d2c <- unsuperClass(defor2, nClasses=2)
plot(d2c$map, col=cl)

dev.off() #TB. chiudiamo i grafici

#TB. plot delle mappe ottenute
par(mfrow=c(2,1))
plot(d1c$map, col=cl)
plot(d2c$map, col=cl)

#TB. inverto righe e colonne
par(mfrow=c(1,2))
plot(d1c$map, col=cl)
plot(d2c$map, col=cl)

freq(d1c$map)
#TB. aree aperte = 34519 celle
#TB. foresta = 306773 celle

#TB. calcolare proporzione
totd1 <- 34519 + 306773
percent1 <- freq(d1c$map) * 100 / totd1

# percentuali
# foreste = 89.89
# aree aperte = 10.11

freq(d2c$map)
#TB. aree aperte = 178140
#TB. foreste = 164586
totd2 <- 178140 + 164586
percent2 <- freq(d2c$map) * 100 / totd2
#TB. areeaperte  48.1
#TB. foreste 51.9

#################

#TB. copertura prima e dopo
cover <- c("Agriculture", "Forest")
before <- c(10.11,89.89)
after <- c(48.1,51.9)

output <- data.frame(cover,before,after)
View(output)

library(ggplot2)

#TB. set della wd e load dei dati
setwd("C:/lab/")
load("defor.RData")
ls() #TB. vediamo la lista dei file

library(raster)

#TB. plottaggio una riga due colonne
par(mfrow=c(1,2))
cl <- colorRampPalette(c('black','green'))(100) # 
plot(d1c$map, col=cl)
plot(d2c$map, col=cl)

library(ggplot2)
#TB. istogramma sulla % di copertura del suolo
ggplot(output, aes(x=cover, y=before, color=cover)) +
geom_bar(stat="identity", fill="white")

#esercizio: plot dell'istogramma della deforestazione dopo
ggplot(output, aes(x=cover, y=after, color=cover)) +
geom_bar(stat="identity", fill="white")

install.packages("gridExtra")
library(gridExtra) #oppure require(Extra)

#TB. visualizziamo entrambi i grafici in una finestra con la funzione grid.arrange
gr1<-ggplot(output, aes(x=cover, y=before, color=cover)) +
geom_bar(stat="identity", fill="white")
gr2<-ggplot(output, aes(x=cover, y=after, color=cover)) +
geom_bar(stat="identity", fill="white")
grid.arrange(gr1, gr2, nrow = 1) 

#################################################################
#################################################################
#################################################################

### 8. R code multitemp NO2

# R code per l'analisi dati NO2

#TB. set della wd e delle librerie
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

#TB. imposto la colorazione e faccio un plot multiframe
cl <- colorRampPalette(c('red','orange','yellow'))(100)
par(mfrow=c(1,2))
plot(EN01, col=cl)
plot(EN13, col=cl)

#TB. chiudo le visualizzazioni precedenti, e faccio un plot della differenza
dev.off()
difno2 <- EN13-EN01 #TB. differenza
cldif <- colorRampPalette(c('blue','black','yellow'))(100) # 
plot(difno2, col=cldif)

#TB. plot delle immagini
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

#TB. imposto le librerie e ricarico i dati
library(raster)

setwd("C:/lab/esa_no2")

#TB. faccio una lista dei .png con la funzione lapply
rlist <- list.files(pattern=".png")
listafinale <- lapply(rlist, raster)
EN <- stack(listafinale)

difEN <- EN$EN_0013 - EN$EN_0001 #TB. differenza tra EN13 e EN01

cld <- colorRampPalette(c('blue','white','red'))(100) # 
plot(difEN, col=cld)

cl <- colorRampPalette(c('red','orange','yellow'))(100) #
plot(EN, col=cl)

#TB. boxplot
boxplot(EN, horizontal=T,outline=F,axes=T)

#################################################################
#################################################################
#################################################################

### 9. R code snow

setwd("C:/lab/")

#TB. installiamo/richiamiamo i pacchetti
install.packages("ncdf4")
library(ncdf4)
library(raster)

#TB. nomino il raster
snowmay <- raster("c_gls_SCE500_202005180000_CEURO_MODIS_V1.0.1.nc")
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 

# esercizio: plottare la neve con le colorazioni 
plot(snowmay,col=cl)

##TB. importare i dati sulla neve

setwd("C:/lab/snow") 

snow2000r <- raster("snow2000r.tif")

# esempio di utilizzo di lapply() con i dati di NO2
# rlist=list.files(pattern=".png", full.names=T)

## salvataggio di raster in una lista con l'utilizzo di lapply
# list_rast=lapply(rlist, raster)
# EN <- stack(list_rast)
# plot(EN)

rlist <- list.files(pattern=".tif") #creiamo una lista con le immagini sulla neve
rlist 

#TB. salvare i raster in una lista usando lapply
list_rast <- lapply(rlist, raster)
snow.multitemp <- stack(list_rast)
plot(snow.multitemp,col=cl)

par(mfrow=c(1,2))
plot(snow.multitemp$snow2000r, col=cl)
plot(snow.multitemp$snow2020r, col=cl)

par(mfrow=c(1,2)) #TB. confronto tra le immagini, 1 riga 2 colonne
plot(snow.multitemp$snow2000r, col=cl, zlim=c(0,250))
plot(snow.multitemp$snow2020r, col=cl, zlim=c(0,250))

difsnow = snow.multitemp$snow2020r - snow.multitemp$snow2000r     #TB. differenza copertura
cldiff <- colorRampPalette(c('blue','white','red'))(100) #TB. colorazione della visualizzazione della copertura
plot(difsnow, col=cldiff)

# prediction
#TB. scaricare prediction.r 
# plot(predicted.snow.2025.norm, col=cl)
# se no scaricare la versione .tif
predicted.snow.2025.norm <- raster("predicted.2025.norm.tif")
plot(predicted.snow.2025.norm, col=cl)

#################################################################
#################################################################
#################################################################

### 10. R code patches

# R_code_patches.r
# install.packages("igraph")

#TB. richiamo librerie
library(raster)
library(igraph) #TB. per le pacthes
library(ggplot2) #TB. per il plot finale

setwd("C:/lab/") #TB. settaggio della directory per windows

#TB. nomino i raster
d1c <- raster("d1c.tif")
d2c <- raster("d2c.tif")

par(mfrow=c(1,2))
cl <- colorRampPalette(c('black','green'))(100) # impostiamo la colorazione
plot(d1c,col=cl)
plot(d2c,col=cl)

#TB. agricoltura: classe 1  foresta: classe 2
d1c.for <- reclassify(d1c, cbind(1,NA))
d2c.for <- reclassify(d2c, cbind(1,NA))

par(mfrow=c(1,2))
cl <- colorRampPalette(c('black','green'))(100) 
plot(d1c,col=cl)
plot(d1c.for, col=cl)

par(mfrow=c(1,2))
plot(d1c)
plot(d2c)

#TB. creare patches
library(igraph) # da usare per le patches
d1c.for.patches <- clump(d1c.for)
d2c.for.patches <- clump(d2c.for)

# writeRaster(d1c.for.patches, "d1c.for.patches.tif")
# writeRaster(d2c.for.patches, "d2c.for.patches.tif")
# d1c.for.patches <- raster("d1c.for.patches.tif")
# d2c.for.pacthes <- raster("d2c.for.patches.tif")

# Esercizio: plottare entrambe le mappe una accanto all'altra
clp <- colorRampPalette(c('dark blue','blue','green','orange','yellow','red'))(100) # 
par(mfrow=c(1,2))
plot(d1c.for.patches, col=clp)
plot(d2c.for.patches, col=clp)

#TB. max patches d1 = 301
#TB. max patches d2 = 1212

#TB. plot dei risultati:
time <- c("Period 1","Period 2")
npatches <- c(301,1212)

output <- data.frame(time,npatches)
attach(output)

#TB. facciamo il ggplot
ggplot(output, aes(x=time, y=npatches)) + geom_bar(stat="identity", fill="white")


#################################################################
#################################################################
#################################################################


#### 11. R_code crop  exam 
library(raster)
setwd("C:/lab/snow/")

#esercizio: caricare tutte le immagini snow

rlist <- list.files(pattern="snow") #TB. faccio la lista
rlist

list_rast <- lapply(rlist, raster) #TB. salvare l'immagine in una lista (lapply)
snow.multitemp <- stack(list_rast)
 
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100)  
plot(snow.multitemp,col=clb)

#TB. vari modi per fare lo zoom

snow.multitemp

plot(snow.multitemp$snow2010r, col=clb)

extension <- c(6, 20, 40, 50)
zoom(snow.multitemp$snow2010r, ext=extension)

#TB. zoom attraverso disegno
plot(snow.multitemp$snow2010r, col=clb)
zoom(snow.multitemp$snow2010r, ext=drawExtent())

#TB. comando crop (taglia e non ingrandisce soltanto)
extension <- c(6, 20, 35, 50)
snow2010r.italy <- crop(snow.multitemp$snow2010r, extension)
plot(snow2010r.italy, col=clb)

#esercizio: fare il crop di tutto lo stack
tot.italy <- crop(snow.multitemp, extension)
plot(tot.italy, col=clb)
plot(tot.italy, col=clb, zlim=c(20,200)) # con variazione impostata da 20 a 200 per tutti uguale

#TB. boxplot
boxplot(tot.italy, horizontal=T,outline=F)

#################################################################
#################################################################
#################################################################

### 12. Species Distribution Modelling

#questa volta non impostiamo la directory
# install.packages("sdm")
# install.packages("rgdal")
library(sdm)
library(raster)
library(rgdal)

#TB. Specie
file <- system.file("external/species.shp", package="sdm") #carichiamo un file di sistema
species <- shapefile(file) # carichiamo la parte grafica, e punti 
species

species$Occurrence   #TB. per vedere i dati di occurence
plot(species)

plot(species[species$Occurrence == 1,],col='blue',pch=16)

points(species[species$Occurrence == 0,],col='red',pch=16)

#TB. variabili ambientali

path <- system.file("external", package="sdm") #TB. importiamo il percorso per la cartella dei dati ambientali

lst <- list.files(path=path,pattern='asc$',full.names = T) #TB. nominiamo la lista
lst

preds <- stack(lst) #TB. facciamo uno stack delle variabili (predittori)

cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)

plot(preds$elevation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$temperature, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$precipitation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$vegetation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

#TB. modelizzazione

d <- sdmData(train=species, predictors=preds)
d

m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=d, methods='glm') 
p1 <- predict(m1, newdata=preds)

plot(p1, col=cl)
points(species[species$Occurrence == 1,], pch=16)


#################################################################
#################################################################
#################################################################

# EXAM PROJECT

# Analisi multitemporale della copertura vegetale mediante indicatore FAPAR, nel periodo che va dal 2000 al 2020. Con un focus sul Sud America.
# Sito Copernicus per i dati: https://land.copernicus.vgt.vito.be/PDF/portal/Application.html#Home

                   
#  Installo e richiamo le librerie necessarie    

install.packages("sp")
library(sp)
       
install.packages("raster")       
library(raster)
       
install.packages("ncdf4")
library(ncdf4)
       
install.packages("rgdal")
library(rgdal)

install.packages("ggplot2")
library(ggplot2)

install.packages("spatstat")
library(spatstat)

install.packages("gridExtra")
library(gridExtra)

# creo una sottocartella dentro lab
# Si fa un settaggio della working directory
                     
setwd("C:/lab/esame")                     

# Importo e nomino i file con formato .nc degli anni 2000 - 2010 - 2020 attraverso la funzione raster
                     
FAPAR2020 <- raster("c_gls_FAPAR-RT6_202003100000_GLOBE_PROBAV_V2.0.1.nc")      

FAPAR2010 <- raster("c_gls_FAPAR_201003100000_GLOBE_VGT_V2.0.1.nc")
                    
FAPAR2000 <- raster("c_gls_FAPAR_200001240000_GLOBE_VGT_V1.4.1.nc")

# Oppure attraverso la funzione list.files imposto una lista con i file .nc                                                    
                                                        
list <- list.files(pattern=".nc")                                                
list

# Con la funzione lapply carico tutti i file .nc
                                                        
list_rast <- lapply(list, raster)
                                                        
# Con la funzione stack uniamo i dati in un oggetto unico 

FAPAR.multitemp <- stack(list_rast)         
                     
# Si definiscono i colori della Palette
                     
cl <- colorRampPalette(c('yellow','green','darkgreen'))(100)

# Si esegue un plottaggio delle immagini attraverso un par

par(mfrow=c(3,1))                                                       
                                                        
plot(FAPAR2000, main="FAPAR ANNO 2000", col=cl)
                                                        
plot(FAPAR2010, main="FAPAR ANNO 2010", col=cl)                                                       
  
plot(FAPAR2020, main="FAPAR ANNO 2020", col=cl)              
                
# Si esegue una differenza tra FAPAR2020 E FAPAR2000.
                                                        
diffapar= FAPAR2020 - FAPAR2000
     
# Imposto un altra colorazione.
                                                        
cl <- colorRampPalette(c('red','yellow','green'))(100)                                                        
                                                      
# Si fa un plot della differenza aggiungendo la coastline

plot(diffapar, main="2020 - 2000", col=cl)
setwd("C:/lab/esame")
coastlines <- readOGR ("ne_10m_coastline.shp")

# Si controlla che la differenza e la coastline abbiano la stessa estensione

coastlines
diffapar

#Cambio estensione a diffapar

extension <- c(-180, 180, -85.22194, 83.6341)
diffapar <- crop(diffapar, extension)

#Faccio un plot di fapar e coastline insieme

par(mfrow=c(1,1))
plot(diffapar,col= cl, zlim=c(0,1))
plot(coastlines,lwd=0.2,add=T)
 
#Faccio le frequenze per il 2020 - 2010 - 2000

freq(FAPAR2020)
          value     count
[1,]     0 144993782
[2,]     1  40144246
[3,]    NA 447079572
fr2020 <- freq(FAPAR2020)
       
freq(FAPAR2010)
        value     count
[1,]     0 156696516
[2,]     1  33645168
[3,]    NA 441875916
fr2010 <- freq(FAPAR2010)
       
freq(FAPAR2000)
     value     count
[1,]     0  67278978
[2,]     1  23775822
[3,]    NA 541162800
fr2000 <- freq(FAPAR2000)  

# Creo un plot multiframe con i grafici delle frequenze

FAPAR <- c(2020,2010,2000)
pixels <- c(14009212,13442848,8713505)
FAPAR1.multitemp <- data.frame(FAPAR, pixels)
ggplot(FAPAR1.multitemp, aes(x=FAPAR,y=pixels)) + geom_bar(stat="identity",fill="dark green")
 
# Calcolare proporzione

totd1 <- 144993782 + 40144246
percent1 <- fr2020 * 100 / totd1
totd3 <- 67278978 + 23775822
percent3 <- fr2000 * 100 / totd3

# Si imposta la tabella delle % di foreste e aree aperte

cover <- c("Aree Aperte", "Foresta")
Anno2020 <- c(78.31659,21.68341)
Anno2000 <- c(73.88845,26.11155)
output <- data.frame(cover,Anno2000,Anno2020)
View(output)

# Con ggplot eseguiamo il grafico delle % di copertura, e con grid.arrange uniamo i grafici in una finestra

gr1<-ggplot(output, aes(x=cover, y=Anno2000, color=cover)) + geom_bar(stat="identity", fill="white") + coord_cartesian(ylim = c(0, 100))
gr2<-ggplot(output, aes(x=cover, y=Anno2020, color=cover)) + geom_bar(stat="identity", fill="white") + coord_cartesian(ylim = c(0, 100))
grid.arrange(gr1, gr2, nrow = 1)
 
# Usiamo la funzione crop per eseguire un taglio 
# dell'immagine sul Sud America impostando l'estensione

extension <- c(-110, -20, -70, 10)                  
SA2020 <- crop(FAPAR2020, extension)
SA2010 <- crop(FAPAR2010, extension)
SA2000 <- crop(FAPAR2000, extension)    

# Facciamo un par con le immagini ottenute

par(mfrow=c(3,1))
plot(SA2020,main = "Anno 2020")
plot(SA2010,main ="Anno 2010")
plot(SA2000,main = "Anno 2000")

# Faccio le frequenze anche per il Sud America

freq(SA2020)
           value    count
[1,]     0  5259647
[2,]     1 14009212
[3,]    NA 59758341
FRSA20 <- freq(SA2020)
       
freq(SA2010)
        value    count
[1,]     0  5825737
[2,]     1 13442848
[3,]    NA 59758615
FRSA10 <- freq(SA2010)
       
freq(SA2000)
     value    count
[1,]     0  4905018
[2,]     1  8713505
[3,]    NA 65408677
FRSA00 <- freq(SA2000)  

# calcolare proporzione
tot1 <- 5259647 + 14009212
prc1 <- FRSA20 * 100 / tot1
tot3 <- 4905018 + 8713505
prc3 <- FRSA00 * 100 / tot3

# Imposto la tabella delle % 

copertura <- c("Aree Aperte", "Foresta")
Anno_2020 <- c(27.2961,72.7039)
Anno_2000 <- c(36.01725,63.98275)
fine <- data.frame(copertura,Anno_2000,Anno_2020)
View(fine)

# Con ggplot visualizziamo il grafico delle % e con grid.arrange visualizzo i due grafici in una finestra

GR1<-ggplot(fine, aes(x=copertura, y=Anno_2000, color=copertura)) + geom_bar(stat="identity", fill="white") + coord_cartesian(ylim = c(0, 100))
GR2<-ggplot(fine, aes(x=copertura, y=Anno_2020, color=copertura)) + geom_bar(stat="identity", fill="white") + coord_cartesian(ylim = c(0, 100))
grid.arrange(GR1, GR2, nrow = 1)
