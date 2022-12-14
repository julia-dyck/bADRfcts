% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ppgw_function.R
\name{ppgw}
\alias{ppgw}
\title{Power generalized Weibull cumulative distribution function}
\usage{
ppgw(x, scale = 1, shape = 1, powershape = 1)
}
\arguments{
\item{x}{vector of quantiles}

\item{scale}{Scale parameter of the distribution (\eqn{\theta} in formula)}

\item{shape}{Shape parameter (\eqn{\nu} in formula)}

\item{powershape}{Powershape parameter (\eqn{\gamma} in formula)}
}
\value{
A vector of cumulative probability values evaluated at each of the inserted quantiles


The density function of the power generalized distribution is (Nikulin and Wu, 2016, p. 15-16):

\deqn{
    F(x) = 1 - exp \left\{ 1 - \left[ 1 + \left(\frac{x}{\theta}\right)^{\nu}\right]^{\frac{1}{\gamma}} \right\}
}

If both shape parameters equal 1, the pgw distribution simplifies to the exponential distribution
(implemented in \code{d/p/q/rexp} in Rpackage 'stats') with \eqn{rate = 1/scale}

If the powershape parameter equals 1, the pgw distribution simplifies to the Weibull distribution
(implemented in \code{d/p/q/rweibull} in Rpackage 'stats') with the same parametrization.
}
\description{
Power generalized Weibull cumulative distribution function
}
