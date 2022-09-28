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
#'   - credibility intervals for the tests (will be conducted afterwards)
#'   - 0 to 100 percentiles of the posterior distribution (to roughly estimate the
#'     probability mass within the region of practical equivalence for the null value)
#'
#'
#'
#'
#'
#'


sim.fit.to.1.sample = function(survdat, sample.seed = NULL){
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
  # 3. prior starting values reflecting hyp: "adr occuring towards end of observation period"
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
  adr.assumption = c("none", "beginning", "end", "middle")

  ### fitting fix.gam.gam model
  fgg = lapply(datstan, fit.fgg)
  ### extracting relevant statistics
  fgg.stats = list()
  for(prior.ind in 1:4){
    fgg[[prior.ind]]@model_name = "fix.gam.gam" # manually, because not working automatically
    #already one stats vector per fit in a list
    fgg.stats[[prior.ind]] = cbind(as.data.frame(sample.seed = sample.seed),
                                   stanfit.to.fitstats(stanfit.object = fgg[[prior.ind]],
                                                       stan.dat = datstan[[prior.ind]],
                                                       assumed.pr = adr.assumption[prior.ind]),
                                   as.data.frame(stanfit.to.poststats(stanfit.object = fgg[[prior.ind]],
                                                                      cred.niveaus = seq(0.5, 0.95, by = 0.05))))
  }
  return(fgg.stats)

  ### fitting gam.gam.gam model
  ggg = lapply(datstan, fit.ggg)
  ### extracting relevant statistics
  ggg.stats = list()
  for(prior.ind in 1:4){
    ggg[[prior.ind]]@model_name = "gam.gam.gam" # manually, because not working automatically
    #already one stats vector per fit in a list
    ggg.stats[[prior.ind]] = cbind(sample.seed = sample.seed,
                                   stanfit.to.fitstats(stanfit.object = ggg[[prior.ind]],
                                                       stan.dat = datstan[[prior.ind]],
                                                       assumed.pr = adr.assumption[prior.ind]),
                                   as.data.frame(stanfit.to.poststats(stanfit.object = ggg[[prior.ind]],
                                                                      cred.niveaus = seq(0.5, 0.95, by = 0.05))))
  }


  ### fitting fix.log.log model
  fll = lapply(datstan, fit.fll)
  ### extracting relevant statistics
  fll.stats = list()
  for(prior.ind in 1:4){
    fll[[prior.ind]]@model_name = "fix.log.log" # manually, because not working automatically
    #already one stats vector per fit in a list
    fll.stats[[prior.ind]] = cbind(sample.seed = sample.seed,
                                   stanfit.to.fitstats(stanfit.object = fll[[prior.ind]],
                                                       stan.dat = datstan[[prior.ind]],
                                                       assumed.pr = adr.assumption[prior.ind]),
                                   as.data.frame(stanfit.to.poststats(stanfit.object = fll[[prior.ind]],
                                                                      cred.niveaus = seq(0.5, 0.95, by = 0.05))))
  }

  ### fitting log.log.log model
  lll = lapply(datstan, fit.lll)
  ### extracting relevant statistics
  lll.stats = list()
  for(prior.ind in 1:4){
    lll[[prior.ind]]@model_name = "log.log.log" # manually, because not working automatically
    #already one stats vector per fit in a list
    lll.stats[[prior.ind]] = cbind(sample.seed = sample.seed,
                                   stanfit.to.fitstats(stanfit.object = lll[[prior.ind]],
                                                       stan.dat = datstan[[prior.ind]],
                                                       assumed.pr = adr.assumption[prior.ind]),
                                   as.data.frame(stanfit.to.poststats(stanfit.object = lll[[prior.ind]],
                                                                      cred.niveaus = seq(0.5, 0.95, by = 0.05))))
  }

  stats.list = c(fgg.stats, ggg.stats, fll.stats, lll.stats)

  return(stats.list)
  #return(rbind(fgg.stats[[1]], fgg.stats[[2]], fgg.stats[[3]], fgg.stats[[4]]))
}


#  testing ---------------------------------------------------------------------

library(rstan)
options(mc.cores = parallel::detectCores())
rstan_options(auto_write = TRUE)



# testing

testft1s = sim.fit.to.1.sample(survdat = testdat, sample.seed = 123) # TESTEN
# TODO: sample.seed wieder heraus nehmen. Das stielt Zeit, hat nicht wirklich mehrwert und
# macht alles umständlicher. Odile hat schon recht. Der Code zum Laufen lassen sollte
# bereit gestellt werden, damit man die Sim laufen lassen kann und sieht, ob die
# Average ergebnisse sich reproduzieren lassen, statt den code mit denselben seeds laufen
# zu lassen. Davon hat man nichts, außer vllt die gewissheit, dass der
# bereitgestellte Code wirklich das macht, was versprochen wurde.
testft1s
summary(testft1s)



long.out = rbind(testft1s[[1]], testft1s[[2]])
test.df = do.call("rbind", testft1s)

dim(long.out)
View(test.df)
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

rstan::summary(fit)$summary

## END OF DOC


