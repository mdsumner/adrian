library(dplyr)
library(DBI)
mapfile <- "C:\\data\\Radian\\odbc\\sst.map"
dstring <- sprintf("Driver={Manifold 9.0 Project Driver (Experimental) (*.map)};DBQ=%s; ReadOnly=true", mapfile)
con <- dbConnect(odbc::odbc(), .connection_string  = dstring)
dbListTables(con)
x <- dbFetch(dbSendQuery(con, "SELECT * FROM [sst (1,1)] WHERE X = 0 AND Y = 0"))

x <- dbFetch(dbSendQuery(con, "SELECT * FROM [sst (1,1)] "))
x$data <- lapply(x$Tile, function(a) tibble(sst = readBin(a, what = "numeric", size = 8, n = 128 * 128)))
x$Tile <- NULL
library(tidyr)
x1 <- as_tibble(x) %>% unnest() %>% filter(sst > -1.9) %>% group_by(X, Y) %>% summarize(sst = mean(sst)) %>% ungroup()
x2 <- as_tibble(x) %>% unnest() 
library(raster)
r <- rasterFromXYZ(x2)
rm(x2)
plot(r)
