#' Simulation study: replicate one scenario
#'
#' repeat the datageneration and fitting and results output for
#' one scenario parameter combination
#'
#'
#'
#'
#'
#'
#'
#'
#'
#'
#' @export
#'
#'


sim.repeat.1.scenario = function(scenario.pars, reps = 100, save = T, path = if(save ==T){getwd()}){
  # scenario.pars[1] = sample size
  # scenario.pars[2] = backround rate
  # scenario.pars[3] = ADR rate
  # scenario.pars[4] = relative st. dev. of ADR
  # scenario.pars[5] = censoring time

  # reps = number of repetitions for this scenario


  gendata.and.fit = function(){
    # simulate data set based on given scenario
    sim.dat = bADRfcts::datagenUnifBr(genpar = scenario.pars)
    # fit models
    fit.output = sim.fit.to.1.sample(sim.dat)
    # hier alle steps bis zum output pro rep einfügen.

    return(fit.output)
  }

  raw.sim.table = replicate(n = reps, expr = gendata.and.fit(), simplify = F)
  raw.sim.table = do.call(what = "rbind", raw.sim.table)

  if(save == T){
    filename = paste(c(scenario.pars, "bADR_sim.RData") ,collapse="_")
    save(raw.sim.table, file=paste0(path, "/", filename))
  }

  if(save == F){
    return(raw.sim.table)
  }
}


#### testing
# sim.repeat.1.scenario(scenario.pars = c(100,0.25, 1, 0.05, 365),
#                       reps = 2,
#                       save = T,
#                       path = "C:/Users/jdyck/sciebo/ADR_bayes_R/Simstudy_output_pilot")
#
# test.reps = sim.repeat.1.scenario(scenario.pars = c(100,0.25, 1, 0.05, 365),
#                                   reps = 2,
#                                   save = F)
# test.reps
# dim(test.reps)
# str(test.reps)
# View(test.reps)




## END OF DOC
