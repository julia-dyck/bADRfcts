## extract statistics from stanfit object

stanfit.to.metastats = function(stanfit.object, stan.data){
  obj = stanfit.object

  # stancode name
  stancode.name = obj@model_name

  # prior specifications
  th.pr.mean = stan.dat$t_expect
  th.pr.sd = stan.dat$t_stdev
  nu.pr.mean = stan.dat$n_expect
  nu.pr.sd = stan.dat$n_stdev
  ga.pr.mean = stan.dat$g_expect
  ga.pr.sd = stan.dat$g_stdev

  # seed generated within model fitting
  mod.seed = rstan::get_seed(obj)

  run.time = sum(get_elapsed_time(obj))/60 # in minutes

  # HIER WEITER

}
