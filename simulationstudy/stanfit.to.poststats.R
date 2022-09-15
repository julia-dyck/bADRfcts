### extract sample from stanfit output
### and calculate all credible interval alternatives
### goal: write a function, that does that for the relevant parameters nu and gamma


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
#'




# function --------------------------------------------------------------------
stanfit.to.poststats = function(stanfit.object, cred.niveaus = seq(0.5, 0.95, by = 0.05)){
  obj = stanfit.object

  ######## extraction of posterior summary stats
  post_summary = summary(obj, pars = c("nu", "gamma"), probs = c())$summary
  poststats = list(nu = post_summary[1,], ga = post_summary[2,])

  nu.post.stats = poststats$nu
  names(nu.post.stats) = paste0("nu.po.", names(nu.post.stats))

  ga.post.stats = poststats$ga
  names(ga.post.stats) = paste0("ga.po.", names(ga.post.stats))


  ######## extraction of posterior samples for credible interval calculation
  post.sample = rstan::extract(obj, pars = c("nu", "gamma"))
  # results in
  # ## post.sample$nu = posterior sample of nu, representing the posterior distribution
  # ## post.sample$gam = posterior sample of gamma, representing the posterior distribution

  # credibility/confidence niveaus 1-alpha
    # 5% ETI and HDI
    # 10% ETI and HDI
    # ...
    # 95% ETI and HDI

  # calculate equal tailed intervals (ETIs)
  nu.eti = matrix(nrow = length(cred.niveaus), ncol = 2)
  for(i in 1:length(cred.niveaus)){
    nu.eti[i,] = quantile(post.sample$nu, probs = 0.5 + c(-1,1)*cred.niveaus[i]/2)
  }
  nu.eti = c(t(nu.eti)) # transform to vector
  names(nu.eti) = paste0("nu.eti",rep(cred.niveaus, each = 2), rep(c("l","u"), times = length(cred.niveaus)) )


  ga.eti = matrix(nrow = length(cred.niveaus), ncol = 2)
  for(i in 1:length(cred.niveaus)){
    ga.eti[i,] = quantile(post.sample$gamma, probs = 0.5 + c(-1,1)*cred.niveaus[i]/2)
  }
  ga.eti = c(t(ga.eti)) # transform to vector
  names(ga.eti) = paste0("ga.eti",rep(cred.niveaus, each = 2), rep(c("l","u"), times = length(cred.niveaus)) )


  # calculate highest density intervals (HDIs)

  nu.hdi = t(sapply(cred.niveaus, HDInterval::hdi, object = post.sample$nu))
  nu.hdi = c(t(nu.hdi)) # transform to vector
  names(nu.hdi) = paste0("nu.hdi",rep(cred.niveaus, each = 2), rep(c("l","u"), times = length(cred.niveaus)) )


  ga.hdi = t(sapply(cred.niveaus, HDInterval::hdi, object = post.sample$gamma))
  ga.hdi = c(t(ga.hdi)) # transform to vector
  names(ga.hdi) = paste0("ga.hdi",rep(cred.niveaus, each = 2), rep(c("l","u"), times = length(cred.niveaus)) )

  # calculate percentilec

  nu.per = quantile(post.sample$nu, probs = (0:100)/100)
  names(nu.per) = paste0("nu.per", names(nu.per))

  ga.per = quantile(post.sample$gamma, probs = (0:100)/100)
  names(ga.per) = paste0("ga.per", names(ga.per))

  return(list(nu = c(nu.post.stats, nu.eti, nu.hdi, nu.per),
              ga = c(ga.post.stats, ga.eti, ga.hdi, ga.per))) # format to be adjusted: need long vector with label for each entry

}

# function testin --------------------------------------------------------------


stats.out = stanfit.to.poststats(testout[[2]], cred.niveaus = c(0.7,0.8,0.9))
stats.out
View(stats.out)

# add to package folder when finished

## END of Doc
