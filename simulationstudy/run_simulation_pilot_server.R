### run the simulation study (pilot version)


# load necessary packages ------------------------------------------------------

# install.packages("rstan", version = "2.26.13", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))
# library(rstan)
# parallel::detectCores() # how many cores are available?
# options(mc.cores = 12) # adjust potentially (e.g.
# # explicit nr for server runs)
# rstan_options(auto_write = TRUE)

load("bundle_functions_dataobjects.RData")

# prep scenario parameters -----------------------------------------------------
pc.pilot = as.matrix(expand.grid(N = c(500, 3000, 5000),
                       br = c(0.01, 0.05, 0.1),
                       adr = c(0, 1),
                       rel.sd = 0.05,
                       c = 365))
pc.pilot

# run the simulation -----------------------------------------------------------

s = sim.repeat.1.scenario(counter = 87, scenario.pars = pc.pilot[1,], save = T,
                          path = "/home/jdyck/ownCloud/bADR_simstudyres_pilot")


# apply(pc.pilot[1:2,], 1, sim.repeat.1.scenario,
#       reps = 2,
#       save = T,
#       path = "/home/jdyck/ownCloud/bADR_simstudyres_pilot"
# )

# parallel::mclapply(3:10, sim.1.scenario.1.time,
#                    scenario.pars = pc.pilot[18,],
#                    save = T,
#                    path = "/home/jdyck/ownCloud/bADR_simstudyres_pilot",
#                    mc.cores=12)
#




