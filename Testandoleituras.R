```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = FALSE)

# Instalando o pacote EBImage
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("EBImage")

# Demais pacotes
installed.packages("magick")
installed.packages("imager")
installed.packages("seriation")
require("BiocManager") 
require("EBImage")
require("magick")
require("imager")
require("EBImage")
require("seriation")
```

setwd("C:/Users/User/OneDrive - unb.br/Documentos/Manipulação de imagens")

im <- image_read("ben.jpg")
print(im)

im1 <- load.image("ben.jpg")
plot(im1)

im2 <- readImage("ben.jpg")
display(im2)

library("magick")
Leitura <- image_read("C:/Users/User/OneDrive - unb.br/Documentos/Manipulação de imagens/Leitura.png")
print(leitura)
image_write(Leitura, path = "Leitura.jpg", format = "jpeg", quality = 75)
Leituraconv <- image_convert(leitura, format ="jpeg" )
image_info(Leituraconv)

print(Leituraconv)

resize(Leituraconv,)