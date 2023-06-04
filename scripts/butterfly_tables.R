################################################################################
# Create Butterfly Tables
################################################################################
library(xtable)
library(stringr)
####################
# Full table 
####################
txt_name <- "data/butterfly_top3_habitat.txt"
tbl <- read.table(txt_name, header = T)
names(tbl) <- c("coefficient", "estimate", "se", "$t$", "$p$")
tbl$coefficient <- tolower(str_replace(tbl$coefficient, "_", "."))
tbl$`$p$`[tbl$`$p$` < .Machine$double.eps] = .Machine$double.eps


print.xtable(xtable(tbl, digits=20), include.rownames = F)


txt_name <- "data/butterfly_14_coefficients.csv"
tbl <- read.csv(txt_name)
tbl <- t(tbl)
rownames(tbl) <- tolower(rownames(tbl))


print.xtable(xtable(tbl, digits=20))


####################
# small table 
####################
txt_name <- "data/butterfly_top3_habitat.txt"
tbl <- read.table(txt_name, header = T)
names(tbl) <- c("coefficient", "estimate", "se", "$t$", "$p$")
tbl$coefficient <- tolower(str_replace(tbl$coefficient, "_", "."))
tbl$`$p$`[tbl$`$p$` < .Machine$double.eps] = .Machine$double.eps


print.xtable(xtable(tbl, digits=20), include.rownames = F)

####################
# Top3 all covariates
####################
txt_name <- "data/butterfly_top3_coefficients.txt"
tbl <- read.table(txt_name, header = T)
names(tbl) <- c("coefficient", "estimate", "se", "$t$", "$p$")
tbl$coefficient <- tolower(str_replace(tbl$coefficient, "_", "."))
tbl$`$p$`[tbl$`$p$` < .Machine$double.eps] = .Machine$double.eps
print.xtable(xtable(tbl, digits=20), include.rownames = F)
