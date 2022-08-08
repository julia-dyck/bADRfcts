# cases for pgw hazards and corresponding prior interpretation
# within the frame of the simulation study
# where the study is censored at t_c = 365

# constant hazard
# reflecting the null hypothesis that the symptom is not suspected to be an ADR

theta = 1
nu = 1
gamma = 1

plotpgw(theta, nu, gamma)



# decreasing hazard
# reflecting that the symptom is suspected to be an ADR that occurs
# shortly after first drug intake

theta = 1
nu = 0.5
gamma = 1
# empirical mean =  1.997251 -> right at the beginning of the study period
plotpgw(theta, nu, gamma)




# increasing hazard
# reflecting that the symptom is suspected to be an ADR that occurs
# at the end of the observation time

theta = 365
nu = 10
gamma = 1
# empirical mean =  347.4367 -> roughly the end of the study time until t_c = 365
plotpgw(theta, nu, gamma)



# unimodal hazard
# reflecting that the symptom is suspected to be an ADR that occurs
# somewhere within the observation time (about middle)

theta = 12
nu = 5
gamma = 15
# empirical mean =  180.1083 -> about half of observation end t_c = 365
plotpgw(theta, nu, gamma, xlim = c(0, 400))







