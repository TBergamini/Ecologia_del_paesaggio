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
