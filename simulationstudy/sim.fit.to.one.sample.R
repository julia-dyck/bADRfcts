#' Simstudy: apply all models to one specific sample
#'
#' Conducts all steps from data input to simulation output generation including:
#'
#' - data preparation for stanmodel for all prior assumptions
#'
#' - fitting all model alternatives
#'
#' - extracting and returning relevant statistics from stan output
#'
#'
#'
#'
#'
#'


sim.fit.to.one.sample = function(survdat){
  ### Data and prior prep
  datstan = list()
  # 1. prior starting values reflecting hyp: "no adr risk over time"
  # data reformatting
  datstan[[1]] = survdat2pgwstanmodeldat(dat = survdat,
                                    scale.mean = 1, scale.sd = 10,
                                    shape.mean = 1, shape.sd = 10,
                                    powershape.mean = 1, powershape.sd = 10)
  # 2. prior starting values reflecting hyp: "adr occuring at beginning of observation period"
  # data reformatting
  datstan[[2]] = survdat2pgwstanmodeldat(dat = survdat,
                                     scale.mean = 1, scale.sd = 10,
                                     shape.mean = 0.5, shape.sd = 10,
                                     powershape.mean = 1, powershape.sd = 10)
  # 3. prior starting values reflecting hyp: "adr occuring towards end of observatin period"
  # data reformatting
  datstan[[3]] = survdat2pgwstanmodeldat(dat = survdat,
                                     scale.mean = 365, scale.sd = 10,
                                     shape.mean = 10, shape.sd = 10,
                                     powershape.mean = 1, powershape.sd = 10)
  # 4. prior starting values reflecting hyp: "adr occuring within middle of the observation period"
  # data reformatting
  datstan[[4]] = survdat2pgwstanmodeldat(dat = survdat,
                                     scale.mean = 12, scale.sd = 10,
                                     shape.mean = 5, shape.sd = 10,
                                     powershape.mean = 15, powershape.sd = 10)
  ### fitting fix.gam.gam prior
  fits.fgg = list()
   for(i in 1:4){
     fits.fgg[[i]] = rstan::stan(
       file = "simulationstudy/fix.gam.gam.stan",  # Stan program
       model_name = "fix.gam.gam.model", # model name
       data = datstan[[i]],    # named list of data
       chains = 4,             # number of Markov chains
       warmup = 1000,          # number of warmup iterations per chain
       iter = 15000,            # total number of iterations per chain
       cores = getOption("mc.cores", 1L) - 1,     # number of cores (one per chain)
       refresh = 1             # progress shown
     )
   }

  ### fitting gam.gam.gam prior
  fits.ggg = list()
  for(i in 1:4){
    fits.ggg[[i]] = rstan::stan(
      file = "simulationstudy/gam.gam.gam.stan",  # Stan program
      model_name = "gam.gam.gam.model", # model name
      data = datstan[[i]],    # named list of data
      chains = 4,             # number of Markov chains
      warmup = 1000,          # number of warmup iterations per chain
      iter = 15000,            # total number of iterations per chain
      cores = getOption("mc.cores", 1L) - 1,              # number of cores (one per chain)
      refresh = 1             # progress shown
    )
  }

  ### fitting fix.log.log prior
  fits.fll = list()
  for(i in 1:4){
    fits.fll[[i]] = rstan::stan(
      file = "simulationstudy/fix.gam.gam.stan",  # Stan program
      model_name = "fix.log.log.model", # model name
      data = datstan[[i]],    # named list of data
      chains = 4,             # number of Markov chains
      warmup = 1000,          # number of warmup iterations per chain
      iter = 15000,            # total number of iterations per chain
      cores = getOption("mc.cores", 1L) - 1,     # number of cores (one per chain)
      refresh = 1             # progress shown
    )
  }

  ### fitting log.log.log prior
  fits.lll = list()
  for(i in 1:4){
    fits.lll[[i]] = rstan::stan(
      file = "simulationstudy/log.log.log.stan",  # Stan program
      model_name = "log.log.log.model", # model name
      data = datstan[[i]],    # named list of data
      chains = 4,             # number of Markov chains
      warmup = 1000,          # number of warmup iterations per chain
      iter = 15000,            # total number of iterations per chain
      cores = getOption("mc.cores", 1L) - 1,              # number of cores (one per chain)
      refresh = 1             # progress shown
    )
  }

  return(list(fits.fgg, fits.ggg, fits.fll, fits.lll))
}


# testing
start = Sys.time()
testout = sim.fit.to.one.sample(survdat = testdat) # TESTEN
end = Sys.time()
testout
end - start


library(rstan)
options(mc.cores = parallel::detectCores())
rstan_options(auto_write = TRUE)


## Achtung: führt zu session aborted
# fit <- rstan::sampling(stanmodel.pgw.fix.gam.gam.repar, data = standat, iter = 500,
#                      warmup = 100, chains = 4, cores = 4)


standat = survdat2pgwstanmodeldat(testdat, 10,10,10,10,10,10)

# with an external stan file
fit <- rstan::stan(
  file = "simulationstudy/fix.log.log.stan",  # Stan program
  data = standat,         # named list of data
  chains = 4,             # number of Markov chains
  warmup = 100,          # number of warmup iterations per chain
  iter = 500,            # total number of iterations per chain
  cores = 4,              # number of cores (could use one per chain)
  refresh = 0             # no progress shown
)

summary(fit)$summary

## END OF DOC


