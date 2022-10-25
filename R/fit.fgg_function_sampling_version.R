#' fit prespecified pgw stan models (version 2)
#'
#' The functions essentially just apply the \code{rstan::stanmodel} and
#' \code{rstan::sampling} command with an already prespecified .stan file.
#'
#' WICHTIG: warmup (1000) und iter (6000) muss noch angepasst werden!
#'
#'
#'


fit.fgg = function(datstan){
  output = rstan::stan(
    file = "stanfiles/fix.gam.gam.stan",  # Stan program
    model_name = "fix.gam.gam.model", # model name
    data = datstan,    # named list of data
    chains = 4,             # number of Markov chains
    warmup = 100,          # number of warmup iterations per chain
    iter = 600,            # total number of iterations per chain (including warmup)
    cores = 1,              # number of cores
    refresh = -1             # progress not shown
  )
  return(output)
}

#test.fit = fit.fgg(standat)
#test.fit


#' fit prespecified pgw stan models
#'
#' The functions essentially just apply the \code{rstan::stan} command with an already prespecified .stan file.
#' Within a simulation study, the function can be run in parallel on various prior meta-parameter specifications or datasets.
#'
#' WICHTIG: warmup (1000) und iter (15000) muss noch angepasst werden!
#'
#' @export
#'



fit.ggg = function(datstan){
  output = rstan::stan(
    file = "stanfiles/gam.gam.gam.stan",  # Stan program
    model_name = "gam.gam.gam.model", # model name
    data = datstan,    # named list of data
    chains = 4,             # number of Markov chains
    warmup = 100,          # number of warmup iterations per chain
    iter = 600,            # total number of iterations per chain (including warmup)
    cores = 1,              # number of cores
    refresh = -1             # progress not shown
  )
  return(output)
}

#' fit prespecified pgw stan models
#'
#' The functions essentially just apply the \code{rstan::stan} command with an already prespecified .stan file.
#' Within a simulation study, the function can be run in parallel on various prior meta-parameter specifications or datasets.
#'
#' WICHTIG: warmup (1000) und iter (15000) muss noch angepasst werden!
#'
#' @export
#'



fit.fll = function(datstan){
  output = rstan::stan(
    file = "stanfiles/fix.gam.gam.stan",  # Stan program
    model_name = "fix.log.log.model", # model name
    data = datstan,    # named list of data
    chains = 4,             # number of Markov chains
    warmup = 100,          # number of warmup iterations per chain
    iter = 600,            # total number of iterations per chain (including warmup)
    cores = 1,              # number of cores
    refresh = -1             # progress not shown
  )
  return(output)
}

#' fit prespecified pgw stan models
#'
#' The functions essentially just apply the \code{rstan::stan} command with an already prespecified .stan file.
#' Within a simulation study, the function can be run in parallel on various prior meta-parameter specifications or datasets.
#'
#' WICHTIG: warmup (1000) und iter (15000) muss noch angepasst werden!
#'
#' @export
#'



fit.lll = function(datstan){
  output = rstan::stan(
    file = "stanfiles/log.log.log.stan",  # Stan program
    model_name = "log.log.log.model", # model name
    data = datstan,    # named list of data
    chains = 4,             # number of Markov chains
    warmup = 100,          # number of warmup iterations per chain
    iter = 600,            # total number of iterations per chain (including warmup)
    cores = 1,              # number of cores (one per chain)
    refresh = -1             # progress not shown
  )
  return(output)
}
