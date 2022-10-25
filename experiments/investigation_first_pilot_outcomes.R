### investigation of first pilot runs
# ## manually look at specific estimates
# ## what do the sample distributions according to posterior means look like?
# ## when they are problematic: in which way?
# ## read about bayesian model fitting workflow and fitting diagnostics in order to
     # improve the fitting parameters (like iter, warmup, starting value specification)

# prep
library(bADRfcts)

# load the outcomes (N = 3000, br = 0.1, adr = 1) ------------------------------

load("D:/Sciebo/bADR_simstudyres_pilot/3000_0.1_1_0.05_365_bADR_sim_001bis010.RData")

View(raw.sim.table)
rst = raw.sim.table

sort(unique(rst$adr.gen.mean.time))
hist(rst$adr.gen.mean.time)

# ______________________
##### first dataset:
rst$adr.gen.mean.time[1] # true adr mean time at beginning
                         # -> expect: decreasing pgW, unimodal pgW

# mean prior and posterior values:
dat1 = rst[1:16, c(2, 4, 6, 8, 11, 16, 162)]

# correct prior assumption (beginning):
dat1[which(dat1[,1] == "beginning"),]

plotpgw(scale = 1, shape = 0.5, powershape = 1) # prior model
# empirical mean =  2.130148

plotpgw(scale = 1, shape = 5.09, powershape = 141.02) # post. model (fgg fit)
# empirical mean =  1.345576e+23
# unimodal shape

plotpgw(scale = 15.3, shape = 1.5, powershape = 22) # post. model (ggg fit)
# empirical mean =  2.808551e+12
# unimodal shape

plotpgw(scale = 1, shape = 5.1, powershape = 141) # post. model (fll fit)
# empirical mean =  6.67589e+21
# unimodal shape

plotpgw(scale = 14.98, shape = 1.49, powershape = 22.4) # post. model (fll fit)
# empirical mean =   8.995473e+13
# unimodal shape

# _________________________
##### 2nd dataset:
rst$adr.gen.mean.time[17] # true adr mean time in the middle
# -> expect: unimodal pgW

# mean prior and posterior values:
dat2 = rst[17:32, c(2, 4, 6, 8, 11, 16, 162)]

# correct prior assumption (middle):
dat2[which(dat2[,1] == "middle"),]

plotpgw(scale = 12, shape = 5, powershape = 15) # prior model
# empirical mean =  174.5945

plotpgw(scale = 12, shape = 2.72, powershape = 45.11) # post. model (fgg fit)
# empirical mean =  7.048484e+13
# unimodal shape

plotpgw(scale = 119.63, shape = 2.32, powershape = 12.9) # post. model (ggg fit)
# empirical mean =  100931.2
# unimodal shape

plotpgw(scale = 12, shape = 2.72, powershape = 45.11) # post. model (fll fit)
# empirical mean =  1.132761e+13
# unimodal shape

plotpgw(scale = 115.99, shape = 2.35, powershape = 13.4) # post. model (fll fit)
# empirical mean =  75405.43
# unimodal shape







# ______________________________________
# write a function to test the form of the posterior

pgw.form = function(res.row){
  nu = res.row[16]
  ga = res.row[162]

  if( (nu == 1) && (ga ==1)){
    print("constant")
    form = "constant"
  }

  if( (nu > 1) && (nu > ga)){
    print("increasing")
    form = "increasing"
  }

  if( (nu < 1) && (nu < ga)){
    print("decreasing")
    form = "decreasing"
  }

  if( (nu > 1) && (ga > nu)){
    print("unimodal")
    form = "unimodal"
  }

  if( (nu < 1) && (ga < nu)){
    print("bathtub shaped")
    form = "bathtub"
  }
  return(form)

}


form.vect = character(160)
for(i in 1:160){
  form.vect[i] = pgw.form(res.row = rst[i,])
}
form.vect
View(data.frame(rst$adr.gen.mean.time, rst$adr.assumption, form.vect))

table(form.vect)

decr.index = which(form.vect == "decreasing")

rst[decr.index, c(1,2, 3,16,162)]

#-----------------------------
# investigate the uncertainty of the posterior:

po.stats = data.frame(rst$th.po.mean, rst$th.po.sd, rst$nu.po.mean, rst$nu.po.sd, rst$ga.po.mean, rst$ga.po.sd)


hist(rst$nu.po.mean)
summary(rst$nu.po.mean)
sort(rst$nu.po.mean)

hist(rst$ga.po.mean)
summary(rst$ga.po.mean)
sort(rst$ga.po.mean)

