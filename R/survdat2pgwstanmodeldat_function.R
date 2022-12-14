#' reformat time-event data for usage in stanmodel.pgw
#'
#'
#'
#' @description Reformating of a matrix or dataframe containing a time-event dataset
#' with time in the first column and the event status in the second column.
#' Usable for the following stan model specifications:
#'
#' stanmodel.pgw.fix.gam.gam.repar
#'
#' stanmodel.pgw.gam.gam.gam.repar
#'
#' stanmodel.pgw.fix.logn.logn.repar
#'
#' stanmodel.pgw.logn.logn.logn.repar
#'
#'
#'
#' @details Converts time-event data to a suitable format for rstan model fitting.
#'
#'
#'@export



survdat2pgwstanmodeldat = function(dat,
                                   scale.mean,
                                   scale.sd,
                                   shape.mean,
                                   shape.sd,
                                   powershape.mean,
                                   powershape.sd){

  standat = list(N_status_e = sum(dat[,2]),
                 N_status_c = dim(dat)[1]-sum(dat[,2]),
                 te = dat[which(dat[,2]== 1),1],
                 tc = dat[which(dat[,2]== 0),1],
                 t_expect = scale.mean,
                 t_stdev = scale.sd,
                 n_expect = shape.mean,
                 n_stdev = shape.sd,
                 g_expect = powershape.mean,
                 g_stdev = powershape.sd
                 )
  return(standat)
}

# # testing
#
# testd = datagenpgw(c(100, 32, scale = 3, shape = 4, powershape = 8))
# head(testd)
#
# testdstanmod = survdat2pgwstanmodeldat(testd,
#                                        scale.mean = 3,
#                                        scale.sd = 4,
#                                        shape.mean = 5,
#                                        shape.sd = 6,
#                                        powershape.mean = 7,
#                                        powershape.sd = 8)
