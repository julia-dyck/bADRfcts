% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fit.fgg_function.R,
%   R/fit.fgg_function_1kernel_version.R
\name{fit.fgg}
\alias{fit.fgg}
\title{fit prespecified pgw stan models}
\usage{
fit.fgg(datstan, fst.fit = F)

fit.fgg(datstan, fst.fit = F)
}
\arguments{
\item{datstan}{time-event data in list format. Can be formatted using
\code{survdat2pgwstanmodeldat} function.}

\item{fst.fit}{logical: whether it is the first fit of this kind of function
(if not, the previous stan fitting outcome is used to retrieve the
model structure rather than recompiling it from the C++ code).}
}
\description{
The functions essentially just apply the \code{rstan::stan} command with an already prespecified .stan file.
Within a simulation study, the function can be run in parallel on various prior meta-parameter specifications or datasets.

The functions essentially just apply the \code{rstan::stanmodel} and
\code{rstan::sampling} command with an already prespecified .stan file.
}
\details{
WICHTIG: warmup (1000) und iter (15000) muss noch angepasst werden!

WICHTIG: warmup (1000) und iter (6000) muss noch angepasst werden!
}
