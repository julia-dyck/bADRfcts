% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/survdat2pgwstanmodeldat_function.R
\name{survdat2pgwstanmodeldat}
\alias{survdat2pgwstanmodeldat}
\title{reformat time-event data for usage in stanmodel.pgw}
\usage{
survdat2pgwstanmodeldat(
  dat,
  scale.mean,
  scale.sd,
  shape.mean,
  shape.sd,
  powershape.mean,
  powershape.sd
)
}
\description{
Reformating of a matrix or dataframe containing a time-event dataset
with time in the first column and the event status in the second column.
Usable for the following stan model specifications:

stanmodel.pgw.fix.gam.gam.repar

stanmodel.pgw.gam.gam.gam.repar

stanmodel.pgw.fix.logn.logn.repar

stanmodel.pgw.logn.logn.logn.repar
}
\details{
Converts time-event data to a suitable format for rstan model fitting.
}
