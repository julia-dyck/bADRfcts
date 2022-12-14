% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/hpgw_function.R
\name{hpgw}
\alias{hpgw}
\title{Power generalized Weibull hazard function}
\usage{
hpgw(x, scale = 1, shape = 1, powershape = 1, log = FALSE)
}
\arguments{
\item{x}{vector of quantiles}

\item{scale}{Scale parameter of the distribution (\eqn{\theta} in formula)}

\item{shape}{Shape parameter (\eqn{\nu} in formula)}

\item{powershape}{Powershape parameter (\eqn{\gamma} in formula)}

\item{log}{locigal argument; if TRUE, the logarithmized hazard value is returned}
}
\value{
A vector of hazard values evaluated at each of the inserted quantiles


The hazard function of the power generalized distribution is (Nikulin and Wu, 2016, p. 15-16):

\deqn{
    h(x) = \frac{\nu}{\gamma \theta^\nu}\cdot x^{\nu-1} \cdot \left[1 + \left(\frac{x}{\theta}\right)^{\nu}\right]^{\frac{1}{\gamma} - 1}
}

If both shape parameters equal 1, the pgw distribution simplifies to the exponential distribution
(implemented in \code{d/p/q/rexp} in Rpackage 'stats') with \eqn{rate = 1/scale}

If the powershape parameter equals 1, the pgw distribution simplifies to the Weibull distribution
(implemented in \code{d/p/q/rweibull} in Rpackage 'stats') with the same parametrization.
}
\description{
Power generalized Weibull hazard function
}
