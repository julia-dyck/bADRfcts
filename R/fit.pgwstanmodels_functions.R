#' fit prespecified pgw stan models
#'
#' The functions essentially just apply the \code{rstan::stan} command with an already prespecified .stan file.
#' Within a simulation study, the function can be run in parallel on various prior meta-parameter specifications or datasets.

fit.fgg = function(datstan){
  output = rstan::stan(
    file = "simulationstudy/fix.gam.gam.stan",  # Stan program
    model_name = "fix.gam.gam.model", # model name
    data = datstan,    # named list of data
    chains = 4,             # number of Markov chains
    warmup = 100,          # number of warmup iterations per chain
    iter = 150,            # total number of iterations per chain
    cores = getOption("mc.cores", 1L) - 1,              # number of cores (one per chain)
    refresh = 1             # progress shown
  )
  return(output)
}


fit.ggg = function(datstan){
  output = rstan::stan(
  file = "simulationstudy/gam.gam.gam.stan",  # Stan program
  model_name = "gam.gam.gam.model", # model name
  data = datstan,    # named list of data
  chains = 4,             # number of Markov chains
  warmup = 100,          # number of warmup iterations per chain
  iter = 150,            # total number of iterations per chain
  cores = getOption("mc.cores", 1L) - 1,              # number of cores (one per chain)
  refresh = 1             # progress shown
  )
  return(output)
}

fit.fll = function(datstan){
  output = rstan::stan(
    file = "simulationstudy/fix.gam.gam.stan",  # Stan program
    model_name = "fix.log.log.model", # model name
    data = datstan,    # named list of data
    chains = 4,             # number of Markov chains
    warmup = 100,          # number of warmup iterations per chain
    iter = 150,            # total number of iterations per chain
    cores = getOption("mc.cores", 1L) - 1,     # number of cores (one per chain)
    refresh = 1             # progress shown
  )
  return(output)
}


test.fit1 = fit.lll(datstan = standat)

fit.lll = function(datstan){
  output = rstan::stan(
    file = "simulationstudy/log.log.log.stan",  # Stan program
    model_name = "log.log.log.model", # model name
    data = datstan,    # named list of data
    chains = 4,             # number of Markov chains
    warmup = 100,          # number of warmup iterations per chain
    iter = 150,            # total number of iterations per chain
    cores = getOption("mc.cores", 1L) - 1,              # number of cores (one per chain)
    refresh = 1             # progress shown
  )
  return(output)
}
