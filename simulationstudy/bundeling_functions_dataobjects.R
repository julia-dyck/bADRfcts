#### saving all fcts and data in one RData file

# purpose: use them on machines where i cannot install the package from github


# WARNING: CHANGES IN FILE NAMES HAVE TO BE UPDATED IN HERE AS WELL !

#set package development - directory
setwd("D:/github_projects_homeoffice_access/bADRfcts")

# functions:

source("R/datagenUnifBr.R")

source("R/dpgw_function.R")

source("R/fit.fgg_function_1kernel_version.R")

source("R/hpgw_function.R")

source("R/plotpgw_function.R")

source("R/ppgw_function.R")

source("R/qpgw_function.R")

source("R/ropehdi_function.R")

source("R/rpgw_function.R")

source("R/sim.fit.to.1.sample.R")

source("R/sim.rep.1.scenario.R")

source("R/spgw_function.R")

source("R/stanfit.to.fitstats.R")

source("R/stanfit.to.poststats.R")

source("R/survdat2pgwstanmodeldat_function.R")

# data objects

load("data/first.fits.RData")

#load("data/stanmodel.pgw.fix.gam.gam.repar.RData")

#load("data/stanmodel.pgw.gam.gam.gam.repar.RData")

#load("data/stanmodel.pgw.fix.logn.logn.repar.RData")

#load("data/stanmodel.pgw.logn.logn.logn.repar.RData")

load("data/testdat.RData")







