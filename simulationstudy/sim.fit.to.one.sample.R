#' Simstudy: apply all models to one specific sample
#'
#' Conducts all steps from data input to simulation output generation including:
#'
#' - data preparation for stanmodel for all prior assumptions
#'
#' - fitting all model alternatives
#'
#' - extracting and returning relevant statistics from stan output:
#'   - general information "info" (noch meta), eg. prior mean and sds, fitting specifications etc.
#'   - information about the posterior distributions of nu and gamma "post"
#'   - credibility interval information "cred" for the tests
#'
#'
#'
#'
#'
#'


sim.fit.to.1.sample = function(survdat){
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
  fgg = lapply(datstan, fit.fgg)
  return(fgg)}
  fgg.fitstats = list()
  fgg.poststats = list()
  fgg.stats = list()
  for(prior.ind in 1:4){
    fgg[[prior.ind]]@model_name = "fix.gam.gam" # manually, because not working automatically
    fgg.fitstats[[prior.ind]] = stanfit.to.fitstats(fgg[[prior.ind]], datstan[[prior.ind]])
    fgg.poststats[[prior.ind]] = stanfit.to.poststats(fgg[[prior.ind]], cred.niveaus = seq(0.5, 0.95, by = 0.05))
    #already one vector for each table
    fgg.stats[[prior.ind]] = c(stanfit.to.fitstats(fgg[[prior.ind]], datstan[[prior.ind]]),
                               stanfit.to.poststats(fgg[[prior.ind]], cred.niveaus = seq(0.5, 0.95, by = 0.05)))
  }
  return(fgg.stats)
}

# include, once it works for fgg HIER WEITER

  ### fitting gam.gam.gam prior
  ggg = lapply(datstan, fit.ggg)
  for(prior.ind in 1:4){
    ggg[[prior.ind]]@model_name = "gam.gam.gam" # manually, because not working automatically
  }
  # -> extract meta statistics and
  # -> extract statistics of interest


  # ### fitting fix.log.log prior
  fll = lapply(datstan, fit.fll)
  for(prior.ind in 1:4){
    fll[[prior.ind]]@model_name = "fix.log.log" # manually, because not working automatically
  }
  # -> extract meta statistics and
  # -> extract statistics of interest


  # ### fitting log.log.log prior
  lll = lapply(datstan, fit.lll)
  for(prior.ind in 1:4){
    lll[[prior.ind]]@model_name = "log.log.log" # manually, because not working automatically
  }
  # -> extract meta statistics and
  # -> extract statistics of interest

  # bring it in a meaningful order and return as one data.frame row with identifiable colnames.
  return(...)
}




library(rstan)
options(mc.cores = parallel::detectCores())
rstan_options(auto_write = TRUE)



# testing
start = Sys.time()
testout = sim.fit.to.1.sample(survdat = testdat) # TESTEN
end = Sys.time()
testout
end - start

class(testout)


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


