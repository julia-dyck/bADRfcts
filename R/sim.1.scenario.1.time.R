#' Simulation study: conduct one replication of one scenario
#'
#' conducts the data generation, fitting and results output for
#' one scenario parameter combination one time.
#'
#' @param counter what repetition number is it?
#' @param scenario.pars Vector with parameter values, that specify the data
#'        generating scenario. See function \code{datagenUnifBr} for
#'        details.
#' @param save logical: states whether output is to be saved in a specified file
#'        (T) or in the global environment (F)
#' @param path file path specifying where to save the output if save = T
#'
#' @return a data frame object (named \code{raw.sim.table}) containing all fitting and
#'         posterior sample statistics of the simulation runs (statistics are
#'         gathered using the \code{stanfit.to.fitstats} and \code{stanfit.to.poststats}
#'         function).
#'
#' @seealso for the generating scenario: see function \code{datagenUnifBr} for
#'                      details.
#'
#'
#' @export



sim.1.scenario.1.time = function(counter,
                                 scenario.pars,
                                 save = T,
                                 path = if(save ==T){getwd()}){
  # counter = what repetition number

  # scenario.pars[1] = sample size
  # scenario.pars[2] = backround rate
  # scenario.pars[3] = ADR rate
  # scenario.pars[4] = relative st. dev. of ADR
  # scenario.pars[5] = censoring time

  # save = whether output is to be saved in a specified file (T)
  #        or in the global environment (F)

  # path = where to save the output if save = T
  #-------------------------------------------------

  # 1. simulate data set based on given scenario
  sim.dat = datagenUnifBr(genpar = scenario.pars)

  # 2. fit models
  raw.sim.table = sim.fit.to.1.sample(sim.dat)

  # save result
  if(save == T){
    filename = paste(c(scenario.pars, "bADR_sim", counter, ".RData") ,collapse="_")
    save(raw.sim.table, file=paste0(path, "/", filename))
  }

  if(save == F){
    return(raw.sim.table)
  }

}



# testit

# sim.1.scenario.1.time(counter = 1,
#                       scenario.pars = c(100, 0.1, 1, 0.05, 365),
#                       save = F,
#                       path = "simulationstudy"
#                       )
#
#
#
#
