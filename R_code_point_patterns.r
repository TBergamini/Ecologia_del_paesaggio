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
