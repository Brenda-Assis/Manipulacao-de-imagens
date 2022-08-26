
###################
setwd("C:/Users/erald/OneDrive/Área de Trabalho/eraldo-bkp/== U N B - E S T A T/-=2022.1=-/CE2 - R/=SEMINÁRIO")
install.packages("BiocManager") 
BiocManager::install("EBImage")
devtools::install_github("rstudio/tensorflow")
devtools::install_github("rstudio/keras")
tensorflow::install_tensorflow()
tensorflow::tf_config()
library(EBImage)
library(keras) 
library(caret)
library (pbapply)
library(tensorflow)

car_dir <- "carros/"
planes_dir <- "avioes/"
verifica_dir <- "verifica/"


width <- 30
height <- 30

extrair_caracteristicas <- function (dir_path, width, height){
  
  img.size <- width * height
  image_name <- list.files(dir_path)
  print(paste("Iniciando Processo", length(image_name), "imagens"))
  
  lista_parametros <- pblapply(image_name, function(imgname){
    img <- readImage(file.path(dir_path, imgname))
    img_resized <- resize(img, w = width, h = height)
    img_matrix <- as.matrix(img_resized@.Data)
    img_vector <- as.vector(t(img_matrix))
    
    return(img_vector)
  })
  
  feature_matrix <- do.call(rbind, lista_parametros)
  feature_matrix <- as.data.frame(feature_matrix)
  
  names(feature_matrix) <- paste0("pixel", c(1:img.size))
  return(feature_matrix)
}

car_data <- extrair_caracteristicas(dir_path = car_dir, width = width, height = height)

planes_data <- extrair_caracteristicas(dir_path = planes_dir, width = width, height = height)

car_data$label <- 0
planes_data$label <- 1

allData <-rbind(car_data,planes_data)   # juntar os dados

#inicio da criação da Rede Neural para prever reconhecer carros ou aviões
indices <- createDataPartition(allData$label, p=0.9 , list = FALSE)  #caret# criação dos indices para treinamento dos dados - 90%
train <- allData[indices,] # treino
test <- allData[-indices,] # teste

trainLabels <- to_categorical(train$label)
testLabels <- to_categorical(test$label)

testLabels

xtrain <- data.matrix(train[,-ncol(train)])
ytrain <- data.matrix(train[,ncol(train)])

xtest <- data.matrix(test[,-ncol(test)])
ytest <- data.matrix(test[,ncol(test)])


#####TREINAR MODELO (KERAS)
model <- keras_model_sequential()
model %>%
  layer_dense(units = 256, activation = 'relu', input_shape = c(2700)) %>%  ##1A layer
  layer_dense(units = 128, activation = 'relu')%>%
  layer_dense(units = 64, activation = 'relu')%>%
  layer_dense(units = 32, activation = 'relu')%>%
  layer_dense(units = 2, activation = 'softmax')

summary(model)

model%>%
  compile(loss='binary_crossentropy',
          optimizer = optimizer_adam(),
          metrics = c('accuracy')
          )

history <- model %>%
  fit(xtrain,
      trainLabels,
      epochs = 10,
      batch_size = 32,
      validation_split = 0.2)

plot(history)

model %>% evaluate(xtest, testLabels, verbose = 1)

pred <- model %>% predict(xtest)  %>% k_argmax()
table(Predicted = as.numeric(pred), Reais = ytest)


verifica<-extrair_caracteristicas(verifica_dir, width = width, height = height)
pred_test <- model %>% predict(as.matrix(verifica)) %>% k_argmax()
pred_test






