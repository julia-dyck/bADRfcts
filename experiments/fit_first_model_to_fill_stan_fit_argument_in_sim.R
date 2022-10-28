#### generate "first" fit to refer to in the stan(..., fit, ...) argument
#### afterwards in order to save new compilation in C++



# generate a sample (not important, what characteristics)
prepdat = datagenUnifBr(c(100, 0.1, 1, 0.05, 365))
prepdat = survdat2pgwstanmodeldat(dat = prepdat$data,
                                  scale.mean = 1,
                                  scale.sd = 10,
                                  shape.mean = 1,
                                  shape.sd = 10,
                                  powershape.mean = 1,
                                  powershape.sd = 10
)


# fit first fgg model (for compiling purposes)
fst.fit.fgg = fit.fgg(datstan = prepdat, fst.fit = T)


# fit first ggg model (for compiling purposes)
fst.fit.ggg = fit.ggg(datstan = prepdat, fst.fit = T)


# fit first fll model (for compiling purposes)
fst.fit.fll = fit.fll(datstan = prepdat, fst.fit = T)


# fit first lll model (for compiling purposes)
fst.fit.lll = fit.lll(datstan = prepdat, fst.fit = T)





