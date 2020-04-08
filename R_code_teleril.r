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
