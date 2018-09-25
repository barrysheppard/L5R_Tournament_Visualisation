# EU

city <- c("Birmingham","Düsseldorf","Paris","Cork", "Warsaw", "Bologna","Madrid")
lat <- c(52.4862, 51.2277, 48.8566, 51.8969, 52.2297, 44.4949, 40.4168)
lon <- c(-1.8904, 6.7735, 2.3522, -8.4863, 21.0122, 11.3426, -3.7038)
players <- c(332, 130, 378, 198, 99, 71, 456)
eukotei <- data.frame(city, lat, lon, players)


library(ggmap)
map <- get_map(location = 'Europe', zoom = 4)

eumap <- ggmap(map) 
eumap + geom_point(data = eukotei, aes(x = lon, y = lat, size = players, alpha = .5, col="red"))


    
## US
                      
city <- c("Philidelphia","San Antonio","Atlanta","San Francisco", "Ohio", "Seattle", "Houston")
lat <- c(39.9526, 29.4241,33.7490, 37.7749, 39.9612, 47.6062, 29.7604)
lon <- c(-75.1652, -98.4936, -84.3880, -122.4194, -82.9988, -122.3321, -95.3698)
players <- c(219, 61, 60, 51, 43, 65, 65)
uskotei <- data.frame(city, lat, lon, players)


library(ggmap)
map <- get_map(location = 'US', zoom = 4)

usmap <- ggmap(map) 
usmap + geom_point(data = uskotei, aes(x = lon, y = lat, size = players, alpha = .5, col="red"))



## AU

city <- c("Melbourne")
lat <- c(-37.8136)
lon <- c(144.963)
players <- c(60)
aukotei <- data.frame(city, lat, lon, players)


library(ggmap)
map <- get_map(location = 'Australia', zoom = 4)

aumap <- ggmap(map) 
aumap + geom_point(data = aukotei, aes(x = lon, y = lat, size = players, alpha = .5, col="red"))


