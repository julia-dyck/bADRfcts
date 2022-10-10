### scenario-parameter combinations:


## for pilot study
pilot.pc = expand.grid(N = c(500, 3000, 5000),
                       br = c(0.01, 0.05, 0.1),
                       adr = c(0, 1),
                       rel.sd = 0.05,
                       c = 365)
pilot.pc




# ---------------------------------------------------------
# more scenarios:
pc = expand.grid(N = c())
#....
