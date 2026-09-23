# R code for Example 6

# Define the three models
e <-  5
s <- 15

h0 <- function(x) (x < e & x > -e) / (2 * e)
hn <- function(x) dnorm(x, -e, s) * 2 * (x < -e)
hp <- function(x) dnorm(x,  e, s) * 2 * (x >  e)

# Define the data and likelihood
d   <-  -2
n   <- 100
sem <- sqrt((s^2 + s^2) / (2 * n))

like <- function(x) dnorm(d, x, sem)

# Define the integrands and integrate
fn <- function(x) like(x) * hn(x)
mn <- integrate(fn, -Inf, -e)$value

f0 <- function(x) like(x) * h0(x)
m0 <- integrate(f0, -e, e)$value

fp <- function(x) like(x) * hp(x)
mp <- integrate(fp, e, Inf)$value

ev <- c(mn, m0, mp)

# Apply Bayes' rule
eq19 <- function(p,m) p*m / sum(p*m)

mon_mothma  <- c(.25, .50, .25)
bail_organa <- c(.15, .70, .15)
tarkin      <- c(.10, .10, .80)

eq19(mon_mothma, ev)
# [1] 6.145693e-03 9.938539e-01 4.138483e-07
eq19(bail_organa, ev)
# [1] 2.643151e-03 9.973567e-01 1.779886e-07
eq19(tarkin, ev)
# [1] 1.221623e-02 9.877772e-01 6.581086e-06
