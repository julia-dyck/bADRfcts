#' Simulation study: replicate one scenario
#'
#' repeat the data generation and fitting and results output for
#' one scenario parameter combination
#'
#' @param scenario.pars Vector with parametervalues, that specify the data
#'        generating scenario. See function \code{datagenUnifBr} for
#'        details.
#' @param reps number of repeated simulations for one scenario
#' @param save logical: states whether output is to be saved in a specified file
#'        (T) or in the global environment (F)
#' @param path file path specifying where to save the output if save = T
#'
#' @return a data frame object (named \code{raw.sim.table}) containing all fitting and
#'         posterior sample statistics of the simulation runs (statistics are
#'         gathered using the \code{stanfit.to.fitstats} and \code{stanfit.to.poststats}
#'         function).
#'                      generating scenario. See function \code{datagenUnifBr} for
#'                      details.
#'
#'
#' @export
#'
#'



sim.repeat.1.scenario = function(counter.vect = 1:100,
                                 scenario.pars,
                                 path = getwd()){
  # scenario.pars[1] = sample size
  # scenario.pars[2] = backround rate
  # scenario.pars[3] = ADR rate
  # scenario.pars[4] = relative st. dev. of ADR
  # scenario.pars[5] = censoring time

  # reps = number of repetitions for this scenario
  # save = whether output is to be saved in a specified file (T) or in the global environment (F)
  # path = where to save the output if save = T
  #------------------------------

  sapply(counter.vect, sim.1.scenario.1.time,
        scenario.pars = scenario.pars,
        save = T,
        path = path
        )
}


### testing
# on the office pc
sim.repeat.1.scenario(scenario.pars = c(100,0.25, 1, 0.05, 365),
                      reps = 2,
                      save = T,
                      path = "C:/Users/jdyck/sciebo/bADR_simstudyres_pilot")

# on the laptop
sim.repeat.1.scenario(counter.vect = 3:4, scenario.pars = c(100,0.25, 1, 0.05, 365),
                      path = "D:/Sciebo/bADR_simstudyres_pilot")

# output in environment
test.reps = sim.repeat.1.scenario(scenario.pars = c(100,0.25, 1, 0.05, 365),
                                  reps = 2,
                                  save = F)
test.reps
dim(test.reps)
str(test.reps)
View(test.reps)




## END OF DOC
