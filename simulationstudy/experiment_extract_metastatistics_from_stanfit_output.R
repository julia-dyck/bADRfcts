## extract statistics from stanfit object

stanfit.to.metastats = function(stanfit.object, stan.dat){
  obj = stanfit.object

  # seed generated within model fitting
  mod.seed = rstan::get_seed(obj)

  # stancode name
  stancode.name = obj@model_name

  # prior specifications
  th.pr.mean = stan.dat$t_expect
  th.pr.sd = stan.dat$t_stdev
  nu.pr.mean = stan.dat$n_expect
  nu.pr.sd = stan.dat$n_stdev
  ga.pr.mean = stan.dat$g_expect
  ga.pr.sd = stan.dat$g_stdev

  run.time = sum(rstan::get_elapsed_time(obj))/60 # in minutes

  metastats = data.frame(mod.seed,
                         stancode.name,
                         th.pr.mean,
                         th.pr.sd,
                         nu.pr.mean,
                         nu.pr.sd,
                         ga.pr.mean,
                         ga.pr.sd,
                         run.time)
  return(metastats)
}


test.meta = stanfit.to.metastats(stanfit.object = test.fit, stan.dat = standat)
dim(test.meta)
nrow(test.meta)
ncol(test.meta)
colnames(test.meta)
