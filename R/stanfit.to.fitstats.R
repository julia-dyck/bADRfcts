#' extract meta and prior statistics from stanfit object
#'
#' The function extracts information about the model fitting and prior specifications for the parameters to be estimated.
#'
#' @param stanfit.object the estimated stan model output
#' @param stan.dat the data inserted for model fitting
#'
#'
#' @return Information about the model fitting, such as:
#' \item{model.seed}{the seed was generated and set to make the posterior samples reproducible}
#' \item{stancode.name}{to identify the used model}
#' \item{th.pr.mean}{prior mean of parameter theta}
#' \item{th.pr.sd}{prior standard deviation of parameter theta}
#' \item{nu.pr.mean}{prior mean of parameter nu}
#' \item{nu.pr.sd}{prior standard deviation of parameter nu}
#' \item{ga.pr.mean}{prior mean of parameter gamma}
#' \item{ga.pr.sd}{prior standard deviation of parameter gamma}
#' \item{run.min}{running time in minutes}
#'
#' @export
#'

stanfit.to.fitstats = function(stanfit.object, stan.dat, assumed.pr){
  obj = stanfit.object

  # seed generated within model fitting
  mod.seed = rstan::get_seed(obj)

  # stancode name
  stancode.name = obj@model_name

  # prior specifications
  adr.assumption = assumed.pr
  th.pr.mean = stan.dat$t_expect
  th.pr.sd = stan.dat$t_stdev
  nu.pr.mean = stan.dat$n_expect
  nu.pr.sd = stan.dat$n_stdev
  ga.pr.mean = stan.dat$g_expect
  ga.pr.sd = stan.dat$g_stdev

  run.min = sum(rstan::get_elapsed_time(obj))/60 # in minutes

  fitstats = data.frame(mod.seed,
                         stancode.name,
                         adr.assumption,
                         th.pr.mean,
                         th.pr.sd,
                         nu.pr.mean,
                         nu.pr.sd,
                         ga.pr.mean,
                         ga.pr.sd,
                         run.min)
  return(fitstats)
}

# testin
# testout.fitstats = stanfit.to.fitstats(stanfit.object = testout[[1]], stan.dat = standat, assumed.pr = "none")
# testout.fitstats
# str(testout.fitstats)
