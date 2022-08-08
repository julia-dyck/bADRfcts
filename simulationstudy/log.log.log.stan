//
// estimated scale parameter (ass. to be lognormal distributed)
// estimated shape parameter (ass. to be lognormal distributed)
// estimated powershape parameter (ass. to be lognormal distributed)

functions {
  // log probability density function for power generalized Weibull (pgW) distribution
  real pgw_lpdf(real t, real theta, real nu, real gamma){
  return log(nu) - log(gamma) - nu*log(theta) + (nu-1)*log(t) + (1/gamma - 1)*log(1 + (t/theta)^nu)  + 1 - (1 + (t/theta)^nu)^(1/gamma);
  }

  // log survival function (= complementary cumulative distr. function) for pgW distribution
  real pgW_lccdf(real t, real theta, real nu, real gamma){
  return 1 - (1 + (t/theta)^nu)^(1/gamma);
  }

  // reparametrization for lognormal distribution:
  // expected value and standard dev. (input) to -> location parameter mu
  real lognormal_expect_stdev_to_mu(real expect, real stdev){
  return log(expect) - log(stdev^2/expect^2 + 1)/2;
  }

  // reparametrization for lognormal distribution:
  // expected value and standard dev. (input) to -> scale parameter sigma
  real lognormal_expect_stdev_to_sigma(real expect, real stdev){
  return sqrt(log(stdev^2/expect^2 + 1));
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
  real<lower=0> theta;        // scale parameter
  real<lower=0> nu;           // weibull shape parameter
  real<lower=0> gamma;        // power shape parameter
}
model {
  real t_mu = lognormal_expect_stdev_to_mu(t_expect, t_stdev);       // transform parametrization to predefined lognormal parameterization
  real t_sigma = lognormal_expect_stdev_to_sigma(t_expect, t_stdev); // ----"----
  real n_mu = lognormal_expect_stdev_to_mu(n_expect, n_stdev);       // ----"----
  real n_sigma = lognormal_expect_stdev_to_sigma(n_expect, n_stdev); // ----"----
  real g_mu = lognormal_expect_stdev_to_mu(g_expect, g_stdev);       // ----"----
  real g_sigma = lognormal_expect_stdev_to_sigma(g_expect, g_stdev); // ----"----

  target += lognormal_lpdf(theta | t_mu, t_sigma);
  target += lognormal_lpdf(nu | n_mu, n_sigma);
  target += lognormal_lpdf(gamma | g_mu, g_sigma);
  for(i in 1:N_status_e){
    target += pgw_lpdf(te[i] | theta, nu, gamma);
  }
  for(j in 1:N_status_c){
    target += pgW_lccdf(tc[j] | theta, nu, gamma);
  }
}
