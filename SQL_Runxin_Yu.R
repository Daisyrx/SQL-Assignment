pacman::p_load(tidyverse,readxl,RSQLite,DBI)

donars_des <- read_excel("Top MA Donors 2016-2020.xlsx",sheet = 1)
contrib_all <- read_excel("Top MA Donors 2016-2020.xlsx",sheet = 2)
JFC <- read_excel("Top MA Donors 2016-2020.xlsx",sheet = 3)

transaction <- select(contrib_all,
                      fectransid,date,amount,type,contribid,fam,cycle,recipid,cmteid)%>%distinct()

contributors <- select(contrib_all,
                       contribid,fam,contrib,lastname,State,City,Zip,Fecoccemp,orgname)%>%distinct()

recipients <- select(contrib_all,
                     recipid,recipient,party,recipcode)%>%distinct()

orgs <- select(contrib_all,
               orgname,ultorg)%>%distinct()%>%na.omit()

# create a normalized table for donators, try out queries

db <- RSQLite::datasetsDb()

donars <- dbConnect(SQLite(),"Donars Performance.db")
dbWriteTable(donars,"transaction",transaction)
dbWriteTable(donars,"contributors",contributors)
dbWriteTable(donars,"orgs",orgs)
dbWriteTable(donars,"recipients",recipients)