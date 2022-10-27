#### generate "first" fit to refer to in the stan(..., fit, ...) argument
#### afterwards in order to save new compilation in C++



# generate a sample
prepdat = datagenUnifBr(c(100, 0.1, 1, 0.05, 365))
prepdat = survdat2pgwstanmodeldat(dat = prepdat$data,
                                  scale.mean = 1,
                                  scale.sd = 10,
                                  shape.mean = 1,
                                  shape.sd = 10,
                                  powershape.mean = 1,
                                  powershape.sd = 10
)

fst.fit.fgg = fit.fgg(datstan = prepdat, fst.fit = T)
class(fst.fit.fgg)

## generate 2nd sample
prepdat2 = datagenUnifBr(c(100, 0.1, 1, 0.05, 365))
prepdat2 = survdat2pgwstanmodeldat(dat = prepdat2$data,
                                  scale.mean = 1,
                                  scale.sd = 10,
                                  shape.mean = 1,
                                  shape.sd = 10,
                                  powershape.mean = 1,
                                  powershape.sd = 10
)

# snd.fit.fgg = fit.fgg(datstan = prepdat2)
# snd.fit.fgg
#
# cat(rstan::get_stancode(snd.fit.fgg))
# cat(rstan::get_stancode(fst.fit.fgg))





