#' @title stan Models pgw distribution
#'
#' @description Prepared stanmodels allow Bayesian fitting of a
#' power generalized Weibull model with log-normal prior assumption for each parameter.
#'
#' @docType stanmodel
#'
#' @usage rstan::sampling(object = stanmodel.pgw.fix.gam.gam.repar, data = ..., ...)
#' rstan::sampling(object = stanmodel.pgw.gam.gam.gam.repar, data = ..., ...)
#' rstan::sampling(object = stanmodel.pgw.fix.logn.logn.repar, data = ..., ...)
#' rstan::sampling(object = stanmodel.pgw.logn.logn.logn.repar, data = ..., ...)
#'
#' @details The data argument in the \code{rstan::sampling} command needs to be a time-event
#' dataset reformatted with the \code{bADRfcts::survdat2pgwstanmodeldat} function.
#'
#' For information on further arguments in the fitting function see \code{?rstan::sampling}.
#'
#'
#' @keywords pgw stanmodel
#'
#' @name stanmodel.pgw
#'
NULL

#' @rdname stanmodel.pgw
"stanmodel.pgw.fix.gam.gam.repar"

#' @rdname stanmodel.pgw
"stanmodel.pgw.gam.gam.gam.repar"

#' @rdname stanmodel.pgw
"stanmodel.pgw.fix.logn.logn.repar"

#' @rdname stanmodel.pgw
"stanmodel.pgw.logn.logn.logn.repar"
