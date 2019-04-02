## Load in data
troops <- read.table("https://raw.githubusercontent.com/nsmackler/PSYCH-531/master/napoleon/troops.txt", header=T)
cities <- read.table("https://raw.githubusercontent.com/nsmackler/PSYCH-531/master/napoleon/cities.txt", header=T)

## load in tidyverse
library(dplyr)

troops %>% head() %>% pandoc.table()

## plot with just paths
ggplot(troops, aes(x = long, y = lat, group = group)) +
  geom_path()

## colored by direction and width as number of troops
ggplot(troops, aes(x = long, y = lat, group = group, 
                   color = direction, size = survivors)) +
  geom_path()


#rounded paths to make it fit better
ggplot(troops, aes(x = long, y = lat, group = group, 
                   color = direction, size = survivors)) +
  geom_path(lineend = "round")

#increase the width range
ggplot(troops, aes(x = long, y = lat, group = group, 
                   color = direction, size = survivors)) +
  geom_path(lineend = "round")+
  scale_size(range = c(0.5, 15))

#remove labels and adjust colors!
ggplot(troops, aes(x = long, y = lat, group = group, 
                   color = direction, size = survivors)) +
  geom_path(lineend = "round") +
  scale_size(range = c(0.5, 15)) + 
  scale_colour_manual(values = c("#DFC17E", "#252523")) +
  labs(x = NULL, y = NULL) + 
  guides(color = FALSE, size = FALSE)


## add in the city labels
ggplot() +
  geom_path(data = troops, aes(x = long, y = lat, group = group, 
                               color = direction, size = survivors),
            lineend = "round") +
  geom_point(data = cities, aes(x = long, y = lat)) +
  geom_text(data = cities, aes(x = long, y = lat, label = city),col="red", vjust = 1.5) +
  scale_size(range = c(0.5, 15)) + 
  scale_colour_manual(values = c("#DFC17E", "#252523")) +
  labs(x = NULL, y = NULL) + 
  guides(color = FALSE, size = FALSE)


## what about adding temperature?
temps <- read.table("temps.txt", header=T)
temps$date <- as.Date(strptime(temps$date,"%d%b%Y"))
