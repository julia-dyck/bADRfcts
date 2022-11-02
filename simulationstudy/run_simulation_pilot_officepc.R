### run the simulation study (pilot version)


# load necessary packages ------------------------------------------------------

install.packages("rstan", version = "2.26.13", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))
# install.packages("rstan") <- correct version, specify from where!!!
library(rstan)
parallel::detectCores() # how many cores are available?
options(mc.cores = 7) # adjust potentially (e.g.
                                            # explicit nr for server runs)
rstan_options(auto_write = TRUE)

# # devtools::install_github(repo = "julia-dyck/bADRfcts") <- most updated version
# devtools::install_github(repo = "julia-dyck/bADRfcts@155e1ce47eec5242ef5d2959009a2fcd85980501")
# # this is the package version in which rstan multicore settings are still used;
# # compiling one "first model" for each model form was not done, yet, a that point.
library(bADRfcts)


# prep scenario parameters -----------------------------------------------------
pc.pilot = expand.grid(N = c(500, 3000, 5000),
                       br = c(0.01, 0.05, 0.1),
                       adr = c(0, 1),
                       rel.sd = 0.05,
                       c = 365)
pc.pilot

# run the simulation -----------------------------------------------------------


apply(pc.pilot[7:9,], 1, sim.repeat.1.scenario,
      reps = 10,
      save = T,
      path = "C:/Users/jdyck/sciebo/bADR_simstudyres_pilot"
      )



