### extraction of statistics of interest from the large stanfit output
### to make it more light weight

# for each repetition: save everything in one large vector containing:

# datagenerating parameters (important, once different scenarios are compared)
# [, -] (data generating process)    # <- when only one alternative -> (...)
# [, 1] sample size
# [, 2] backround rate
# [, 3] ADR rate
# [, 4] mean of ADR event-time (randomly drawn)
# [, -] (relative sd of ADR event-time)
# [, 5] seed before data generation (can be used to merge outcomes for different models based on the same data)

# for each model:

# model form and prior values
# [, 6] stancode name
# [, 7] prior theta mean
# [, 8] prior theta sd
# [, 9] prior nu mean
# [,10] prior nu sd
# [,11] prior gamma mean
# [,12] prior gamma sd

# modelfitting specifications
# [, -] (sampler/algorithm -> NUTS)
# [, -] (number of chains -> 4 by default)
# [, -] posterior sample size per chain (set to ????)
# [, -] model seed (automatically generated) -> to be saved the first time, used for reproductions
# [, -] elapsed time

# posterior statistics for nu
# [, ..] nu.mean
# [, ..] nu.sd
# [, 13] nu.n_eff
# [, 14] nu.Rhat
# [, 15:34] nu.ETIs (nu.ETI.50.l, nu.ETI.50.u, nu.ETI.55.l, nu.ETI.55.u,..., nu.ETI.95.l, nu.ETI.95.u)
# [, 35:54] nu.HDIs (nu.HDI.50.l, nu.HDI.50.u, nu.HDI.55.l, nu.HDI.55.u,..., nu.HDI.95.l, nu.HDI.95.u)
# [, 55:154] nu.percentiles to estimate prob mass within ropes (nu.perc.0, nu.perc.1, ..., nu.perc.100)
# [, 155] nu.n_eff for each parameter
# [, 156] nu.Rhat for each parameter
# [, x:y] nu.ETIs (nu.ETI.50.l, nu.ETI.50.u, nu.ETI.55.l, nu.ETI.55.u,..., nu.ETI.95.l, nu.ETI.95.u)
# [, x:y] nu.HDIs (nu.HDI.50.l, nu.HDI.50.u, nu.HDI.55.l, nu.HDI.55.u,..., nu.HDI.95.l, nu.HDI.95.u)
# [, x:y] nu.percentiles to estimate prob mass within ropes (nu.perc.0, nu.perc.1, ..., nu.perc.100)


# posterior statistics for gamma







