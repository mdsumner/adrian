library(dplyr)
library(DBI)
mapfile <- "C:\\data\\Radian\\odbc\\ice_tiles.map"
dstring <- sprintf("Driver={Manifold 9.0 Project Driver (Experimental) (*.map)};DBQ=%s;", mapfile)
con <- dbConnect(odbc::odbc(), .connection_string  = dstring)

dbListTables(con)
dbSendQuery(con, "SELECT * FROM mdf_meta")

tbl(con, "mfd_meta")
DBI::dbWriteTable(con, "mtcars", mtcars)
