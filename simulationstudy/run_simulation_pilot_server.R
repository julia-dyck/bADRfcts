### run the simulation study (pilot version)


# load necessary packages ------------------------------------------------------

# install.packages("rstan") <- correct version, specify from where!!!
library(rstan)
parallel::detectCores() # how many cores are available?
options(mc.cores = 12) # adjust potentially (e.g.
# explicit nr for server runs)
rstan_options(auto_write = TRUE)

# devtools::install_github(repo = "julia-dyck/bADRfcts") <- does the command work?
library(bADRfcts)


# prep scenario parameters -----------------------------------------------------
pc.pilot = expand.grid(N = c(500, 3000, 5000),
                       br = c(0.01, 0.05, 0.1),
                       adr = c(0, 1),
                       rel.sd = 0.05,
                       c = 365)
pc.pilot

# run the simulation -----------------------------------------------------------

save(testobject = 1:10, file = "/home/jdyck/ownCloud/bADR_simstudyres_pilot/test.object.RData")

# apply(pc.pilot[1:2,], 1, sim.repeat.1.scenario,
#       reps = 2,
#       save = T,
#       path = "/home/jdyck/ownCloud/bADR_simstudyres_pilot"
# )


