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

