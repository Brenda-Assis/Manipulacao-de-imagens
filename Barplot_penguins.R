
#instalando pacote dos penguins
install.packages("palmerpenguins")
library(tidyverse)
library(palmerpenguins)

# Barplot 
penguins %>%
  count(species) %>%
  ggplot() + geom_col(aes(x = species, y = n, fill = species)) +
  geom_label(aes(x = species, y = n, label = n)) +
  scale_fill_manual(values = c("darkorange","purple","cyan4")) +
  theme_minimal() +
  labs(title = 'Penguins Species & Count')

