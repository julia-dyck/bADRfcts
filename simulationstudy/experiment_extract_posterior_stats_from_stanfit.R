# experiment: extract posterior stats from stanfit object


# function --------------------------------------------------------------------
stanfit.to.poststats = function(stanfit.object){
  obj = stanfit.object

  post_summary = summary(obj, pars = c("nu", "gamma"), probs = c())$summary
  poststats = list(nu = post_summary[1,], ga = post_summary[2,])
  return(poststats)
}



# testin

test.poststats = stanfit.to.poststats(testout[[1]])
test.poststats
test.poststats$nu
test.poststats$ga


c(nu = test.poststats$nu,
  ga = test.poststats$ga) # <- reorder list elements within a vector later on like this
