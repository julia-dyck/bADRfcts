### extraction of statistics of interest from the large stanfit output
### to make it more light weight

# for each repetition: save everything in one large vector containing:

# datagenerating parameters (important, once different scenarios are compared)
# ## ...
# ## ...
# ## seed before data generation

# for each model:

# model form and prior values
# ## stancode name
# ## prior means and sds

# modelfitting specifications
# ## sampler
# ## number of chains
# ## posterior sample size per chain
# ## warmup per chain

# posterior statistics
# n_eff for each parameter
# Rhat for each parameter
# min, 0.025, 0.05, ..., 0.95, 0.975, max - Quantiles for each parameter (to gen. ETIs)
#







