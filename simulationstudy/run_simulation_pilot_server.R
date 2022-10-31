### run the simulation study (pilot version)


# load necessary packages ------------------------------------------------------

# install.packages("rstan")
# library(rstan)
# parallel::detectCores() # how many cores are available?
# options(mc.cores = 12) # adjust potentially (e.g.
# # explicit nr for server runs)
# rstan_options(auto_write = TRUE)
#
# install.packages("devtools")
# library(devtools)
# devtools::install_github(repo = "julia-dyck/bADRfcts")
# library(bADRfcts)
load("bundle_functions_dataobjects.RData")

# prep scenario parameters -----------------------------------------------------
pc.pilot = expand.grid(N = c(500, 3000, 5000),
                       br = c(0.01, 0.05, 0.1),
                       adr = c(0, 1),
                       rel.sd = 0.05,
                       c = 365)
pc.pilot

# run the simulation -----------------------------------------------------------

# save(testobject = 1:10, file = "/home/jdyck/ownCloud/bADR_simstudyres_pilot/test.object.RData")

# apply(pc.pilot[1:2,], 1, sim.repeat.1.scenario,
#       reps = 2,
#       save = T,
#       path = "/home/jdyck/ownCloud/bADR_simstudyres_pilot"
# )

parallel::mclapply(1:10,sim.1.scenario.1.time,
                   scenario.pars = pc.pilot[1,],
                   save = T,
                   path = getwd(),
                   mc.cores=4)





