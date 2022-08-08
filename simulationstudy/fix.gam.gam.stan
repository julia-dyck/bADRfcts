// fixed ie not estimated scale parameter
// estimated shape parameter (ass. to be gamma distributed)
// estimated powershape parameter (ass. to be gamma distributed)


functions {
  // log probability density function for power generalized Weibull (pgW) distribution
  real pgw_lpdf(real t, real theta, real nu, real gamma){
  return log(nu) - log(gamma) - nu*log(theta) + (nu-1)*log(t) + (1/gamma - 1)*log(1 + (t/theta)^nu)  + 1 - (1 + (t/theta)^nu)^(1/gamma);
  }

  // log survival function (= complementary cumulative distr. function) for pgW distribution
  real pgW_lccdf(real t, real theta, real nu, real gamma){
  return 1 - (1 + (t/theta)^nu)^(1/gamma);
  }

  // reparameterization for gamma distribution:
  // expected value and standard dev. (input) to -> shape parameter alpha
  real gamma_expect_stdev_to_alpha(real expect, real stdev){
  return expect^2/stdev^2;
  }

  // reparametrization for gamma distribution:
  // expected value and standard dev. (input) to -> rate parameter beta
  real gamma_expect_stdev_to_beta(real expect, real stdev){
  return expect/stdev^2;
  }

}

data {
  int<lower = 1> N_status_e;         // number of events in sample
  int<lower = 0> N_status_c;         // number of censored observations in sample
  vector<lower = 0>[N_status_e] te;  // time observations for events
  vector<lower = 0>[N_status_c] tc;  // time observations for censored cases
  real<lower = 0> t_expect;          // meta parameter "expectation" for scale parameter theta
  real<lower = 0> t_stdev;           // meta parameter "standard dev." for scale parameter theta
  real<lower = 0> n_expect;          // meta parameter "expectation" for shape parameter nu
  real<lower = 0> n_stdev;           // meta parameter "standard dev." for shape parameter nu
  real<lower = 0> g_expect;          // meta parameter "expectation" for shape parameter gamma
  real<lower = 0> g_stdev;           // meta parameter "standard dev." for shape parameter gamma
}
parameters {
  real<lower=0> nu;           // weibull shape parameter
  real<lower=0> gamma;        // power shape parameter
}
model {
  real n_alpha = gamma_expect_stdev_to_alpha(n_expect, n_stdev); // transform parametrization to predefined gamma parameterization
  real n_beta = gamma_expect_stdev_to_beta(n_expect, n_stdev);   // ----"----
  real g_alpha = gamma_expect_stdev_to_alpha(g_expect, g_stdev); // ----"----
  real g_beta = gamma_expect_stdev_to_beta(g_expect, g_stdev);   // ----"----

  target += gamma_lpdf(nu | n_alpha, n_beta);
  target += gamma_lpdf(gamma | g_alpha, g_beta);
  for(i in 1:N_status_e){
    target += pgw_lpdf(te[i] | t_expect, nu, gamma);
  }
  for(j in 1:N_status_c){
    target += pgW_lccdf(tc[j] | t_expect, nu, gamma);
  }
}
