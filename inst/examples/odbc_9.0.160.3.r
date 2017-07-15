library(odbc)
mapfile <- "C:\\data\\Radian\\odbc\\Drawing_9.0.map"
dstring <- sprintf("Driver={Manifold 9.0 Project Driver (Experimental) (*.map)};DBQ=%s;ReadOnly=true;", mapfile)

con <- dbConnect(odbc::odbc(), .connection_string  = dstring)

con
# <OdbcConnection>  Database: C:\data\Radian\odbc\Drawing_9.0.map
# Radian Studio 9.0 Universal Edition (build 9.0.160.3) Version:  9.00.0003


dbFetch(dbSendQuery(con, "SELECT * FROM Tabl WHERE ID = 1"))

library(dplyr)
tbl(con, "SELECT ID FROM Tabl WHERE ID = 1") %>% explain()
tbl(con, "mfd_meta") %>% explain()
## ok
odbc::dbGetInfo(con)
dbIsValid(con)
dbListTables(con)
#[1] "mfd_root"     "mfd_meta"     "DrawingTable" "Tabl"
dbExistsTable(con, "DrawingTable")
dbListFields(con, "mfd_meta")
dbReadTable(con, "mfd_meta")

dbFetch(dbSendQuery(con, "SELECT * FROM Tabl"))



mapfile <- "C:\\data\\Radian\\odbc\\Drawing_9.0.map"
dsnstring <- sprintf("Driver={Manifold 9.0 Project Driver (*.map)};DBQ=%s;", mapfile)
con <- RODBC::odbcDriverConnect(dsnstring, rows_at_time = 1, believeNRows = FALSE)

#con <- RODBC::odbcDriverConnect(dsnstring)
RODBC::sqlTables(con)
str(RODBC::sqlTables(con))
as.data.frame(RODBC::odbcGetInfo(con))
RODBC::sqlTypeInfo(con)

sqlQuery(con, "SELECT Name FROM mfd_meta")

