#### R_code_exam.R

### 1. R code First

######################

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

# vari madi per fare lo zoom

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
