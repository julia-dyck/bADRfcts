### repeat the datageneration to fitting and results output fct


sim.repeat.1.scenario = function(scenario.pars, reps = 100){
  # scenario.pars[1] = sample size
  # scenario.pars[2] = backround rate
  # scenario.pars[3] = ADR rate
  # scenario.pars[4] = relative st. dev. of ADR
  # scenario.pars[5] = censoring time

  # reps = number of repetitions for this scenario


  gendata.and.fit = function(scenario.pars){
    # simulate data set based on given scenario
    sim.dat = bADRfcts::datagenUnifBr(genpar = scenario.pars)
    # fit models
    fit.output = sim.fit.to.1.sample(sim.dat)
    # hier alle steps bis zum output pro rep einfügen.

    return(fit.output)
  }

  out = t(sapply(datagenseed.vect, gendata.given.sc))
  return(out)
}

test.reps = sim.repeat.1.scenario(scenario.pars = c(10,0.25, 1, 0.05, 365), datagenseed.vect = NULL, reps = 2)
test.reps


# todos:
# prepare an RData file with

# ## parcombis per scenario





## END OF DOC
