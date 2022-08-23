
# Instalando o pacote EBImage
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("EBImage")

# Demais pacotes
require("magick")
require("imager")
require("EBImage")


## Leitura no pacote magick
library(magick)
im <- image_read("C:/Users/User/OneDrive - unb.br/Documentos/Manipula????o de imagens/images/vinho.jpg")
print(im)

# Leitura no pacote imager
library(imager)
im1 <- load.image("C:/Users/User/OneDrive - unb.br/Documentos/Manipula????o de imagens/images/vinho.jpg")
plot(im1)

# Leitura no pacote EBImage
library(EBImage)
im2 <- readImage("C:/Users/User/OneDrive - unb.br/Documentos/Manipula????o de imagens/images/vinho.jpg")
display (im2)

# Mudando a resolu????o de uma imagem
im2_1 <-resize(x=im2, w=1200)
im2_2 <- resize(x=im2,w=500,h=500)

