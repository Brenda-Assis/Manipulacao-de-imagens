#pdi

setwd("C:/Users/erald/OneDrive/Área de Trabalho/eraldo-bkp/== U N B - E S T A T/-=2022.1=-/CE2 - R/=SEMINÁRIO/QUICKBIRD - BRASILIA")

install.packages("raster")
library(raster)
library(rgdal)

########## ABRIR IMAGEM DE SATÉLITE - SELEÇÃO DE BANDAS MULTIESPECTRAIS ########

r = raster("qb_05jun.tif",band = 3) # Vermelho
g = raster("qb_05jun.tif",band = 2) # Verde
b = raster("qb_05jun.tif",band = 1) # azul
ir= raster("qb_05jun.tif",band = 4) # infravermelho

rgb=brick(b,g,r)
plotRGB(rgb, r=3, g=2, b=1 , stretch='lin')

#composição falsa cor ( banda do Infravermelho no canal Verde - para ressaltar elementos da vegetação)
rgb_fc=brick(b,ir,r)
plotRGB(rgb_fc, r=3, ir=2, b=1 , stretch='lin')



########### N D V I ##########

NDVI = (ir - r)/(ir + r)
plot(NDVI)

print(r)
print(NDVI)


################# 3D RELEVO ####################
install.packages("rgdal")
library(rgdal)
library(dplyr)
install.packages("devtools")
devtools::install_github("tylermorganwall/rayshacarta_cyan")
library("rayshacarta_cyan")
library(png)

loadzip = tempfile()
download.file("https://tylermw.com/data/dem_01.tif.zip",loadzip)
localtif=unzip(loadzip, 'dem_01.tif') %>% raster()
unlink(loadzip)

rast.mat = raster_to_matrix(localtif)

rast.mat %>%
  sphere_shade(texture = 'desert') %>%
  plot_map()

#visualização 3d
rast.mat %>%
  sphere_shade(texture = 'desert') %>%
  add_water(detect_water(rast.mat), color='desert')%>%
  plot_3d(rast.mat, zscale = 10, fov=0, theta = 135,
          zoom = 0.75, phi = 45, windowsize = c(1000,800))
rencarta_cyan_snapshot()




############## anaglifo #####

setwd("C:/Users/erald/OneDrive/Área de Trabalho/eraldo-bkp/== U N B - E S T A T/-=2022.1=-/CE2 - R/=SEMINÁRIO/=ANAGLIFOS")

install.packages("raster")
library(raster)
library(rgdal)


r1 = raster("carta_red.jpg",band = 1)
g2 = raster("carta_cyan.jpg",band = 2)
b2 = raster("carta_cyan.jpg",band = 3)


rgb=brick(r1,g2,b2)
plotRGB(rgb, r1=1, g2=2, b2=3 , stretch='lin')


