# experiment: extract posterior stats from stanfit object


# function --------------------------------------------------------------------
stanfit.to.poststats = function(stanfit.object){
  obj = stanfit.object

  post_summary = summary(obj, pars = c("nu", "gamma"), probs = c())$summary
  poststats = c(nu = post_summary[1,], ga = post_summary[2,])
  return(poststats)
}



# testin


test.poststats = stanfit.to.poststats(testout[[1]])
test.poststats
as.vector(t(test.poststats))
c(nu = test.poststats[1,], ga = test.poststats[2,])
