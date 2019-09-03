library(sf,quietly = T)
setwd("E:/Documents/CICLO/Apresentacoes/Unidirecionalidade/")

# read
geo <- read_sf("shp/geo_cwb.shp")
geo <- st_transform(geo,31982)
ac <- read_sf("shp/area.shp")
#st_crs(ac) <- 31982
ac$geometry <- st_transform(ac$geometry,31982)
# operations
ac_buf <- st_buffer(ac,dist = 1500)
geo_buf1 <- st_crop(geo,ac_buf)
# clean
geo_buf <- geo_buf1[-which(geo_buf1$fclass%in%c("pedestrian","footway","steps")),]
cicleway <- geo_buf1[which(geo_buf1$fclass%in%"cycleway"),]
geo_b <- geo_buf[which(geo_buf$oneway%in%"B"),]
geo_bs <- geo_b[which(geo_b$fclass%in%"service"),]
# save
write_sf(geo_buf,"shp/geo_buf.shp")
write_sf(cicleway,"shp/cycleway.shp")
write_sf(geo_b,"shp/twoway.shp")
write_sf(ac,"shp/area.shp")
write_sf(geo_bs,"shp/geo_bs.shp")
# view
#
#
#
#
plot(ac_buf$geometry)
plot(geo$geometry,add=TRUE)
plot(ac$geometry,col="blue",add=T)
plot(geo_buf,col="green",add=T)
geo_cwb <- st_crop(cwb,geo)
st_crs(geo)
