# R spaziale: funzioni spaziali in ecologia del paesaggio (si comincia)

install.packages("sp")

# con library() viene richiamato il pacchetto dalla libreria
library(sp)

#dati richiamati
data(meuse)

meuse

head(meuse)

# plot di cadmio e lead

#alleghiamo il database (o dataframe in R)

attach(meuse)

plot(cadmium,lead,col="green",pch=19,cex=2)

# esercizio: plot di rame (copper) e zinco con simbolo triangolo (17) e colore verde
plot(copper,zinc,col="green",pch=17,cex=2)

# come cambiare le etichette xlab e ylab
plot(copper,zinc,col="green",pch=17,cex=2,xlab="Rame",ylab="Zinco")

#multiframe o multipanel
par(mfrow=c(1,2))
plot(cadmium,lead,col="green",pch=19,cex=2)
plot(copper,zinc,col="green",pch=17,cex=2)

# invertiamo i grafici righe e colonne
par(mfrow=c(2,1))
plot(cadmium,lead,col="green",pch=19,cex=2)
plot(copper,zinc,col="green",pch=17,cex=2)

#multigrame automatico 
install.packages("GGally")

library(GGally)
ggpairs(meuse[,3:6])


# Spatial!!
head(meuse)

coordinates(meuse)=~x+y
plot(meuse)

# funzione spplot per plottare i dati spazialmente
spplot(meuse,"zinc")
