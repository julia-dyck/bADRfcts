### extract sample from stanfit output
### and calculate all credible interval alternatives
### goal: write a function, that does that for the relevant parameters nu and gamma



# function --------------------------------------------------------------------
stanfit.to.cred.ints = function(stanfit.object, cred.niveaus = seq(0.05, 0.95, by = 0.05)){
  obj = stanfit.object

  # extraction of posterior samples
  post.sample = rstan::extract(obj, pars = c("nu", "gamma"))
  nu.post = post.sample$nu
  gam.post = post.sample$gam

  # credibility/confidence niveaus 1-alpha
    # 5% ETI and HDI
    # 10% ETI and HDI
    # ...
    # 95% ETI and HDI

  # calculate equal tailed intervals (ETIs)
  nu.eti = matrix(nrow = length(cred.niveaus), ncol = 2)
  for(i in 1:length(cred.niveaus)){
    nu.eti[i,] = quantile(sampl$nu, probs = 0.5 + c(-1,1)*cred.niveaus[i]/2)
  }

  gam.eti = matrix(nrow = length(cred.niveaus), ncol = 2)
  for(i in 1:length(cred.niveaus)){
    gam.eti[i,] = quantile(sampl$gam, probs = 0.5 + c(-1,1)*cred.niveaus[i]/2)
  }

  # calculate highest density intervals (HDIs)

  nu.hdi = t(sapply(cred.niveaus, HDInterval::hdi, object = sampl$nu))

  gam.hdi = t(sapply(cred.niveaus, HDInterval::hdi, object = sampl$gam))


  return(list(nu.eti, nu.hdi, gam.eti, gam.hdi)) # format to be adjusted: need long vector with label for each entry

}

# function testin --------------------------------------------------------------


interval.out = stanfit.to.cred.ints(testout[[4]][[4]], cred.niveaus = c(0.7,0.8,0.9))
interval.out


# add to package folder when finished

## END of Doc
