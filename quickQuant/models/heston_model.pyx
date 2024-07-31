# quickQuant/models/heston_model.pyx

import numpy as np
cimport numpy as np
from scipy.stats import norm

__all__ = ['heston_call_price','heston_put_price']

cdef extern from "math.h":
    double exp(double)
    double sqrt(double)

cpdef double heston_call_price(double S0, double K, double T, double r, double kappa, double theta, double sigma, double rho, double v0, int N=10000):
    """
    Heston Model for European Call Option Pricing.

    Parameters:
    - S0: Initial stock price
    - K: Strike price
    - T: Time to maturity (in years)
    - r: Risk-free interest rate
    - kappa: Rate of mean reversion of variance
    - theta: Long-term mean variance
    - sigma: Volatility of variance
    - rho: Correlation between the two Brownian motions
    - v0: Initial variance
    - N: Number of simulation paths (default is 10000)

    Returns:
    - Call option price
    """
    cdef double dt = T / N
    cdef double sqrt_dt = sqrt(dt)
    cdef np.ndarray[double, ndim=1] S = np.empty(N)
    cdef np.ndarray[double, ndim=1] v = np.empty(N)
    cdef np.ndarray[double, ndim=1] prices = np.empty(N)
    cdef int i, j

    for i in range(N):
        S[i] = S0
        v[i] = v0

    for j in range(1, N):
        for i in range(N):
            dW1 = np.random.normal(0, 1) * sqrt_dt
            dW2 = rho * dW1 + sqrt(1 - rho**2) * np.random.normal(0, 1) * sqrt_dt
            v[i] = max(v[i] + kappa * (theta - v[i]) * dt + sigma * sqrt(v[i]) * dW2, 0)
            S[i] = S[i] * exp((r - 0.5 * v[i]) * dt + sqrt(v[i]) * dW1)

        prices[i] = max(S[i] - K, 0)

    return exp(-r * T) * np.mean(prices)

cpdef double heston_put_price(double S0, double K, double T, double r, double kappa, double theta, double sigma, double rho, double v0, int N=10000):
    """
    Heston Model for European Put Option Pricing.

    Parameters:
    - S0: Initial stock price
    - K: Strike price
    - T: Time to maturity (in years)
    - r: Risk-free interest rate
    - kappa: Rate of mean reversion of variance
    - theta: Long-term mean variance
    - sigma: Volatility of variance
    - rho: Correlation between the two Brownian motions
    - v0: Initial variance
    - N: Number of simulation paths (default is 10000)

    Returns:
    - Put option price
    """
    cdef double dt = T / N
    cdef double sqrt_dt = sqrt(dt)
    cdef np.ndarray[double, ndim=1] S = np.empty(N)
    cdef np.ndarray[double, ndim=1] v = np.empty(N)
    cdef np.ndarray[double, ndim=1] prices = np.empty(N)
    cdef int i, j

    for i in range(N):
        S[i] = S0
        v[i] = v0

    for j in range(1, N):
        for i in range(N):
            dW1 = np.random.normal(0, 1) * sqrt_dt
            dW2 = rho * dW1 + sqrt(1 - rho**2) * np.random.normal(0, 1) * sqrt_dt
            v[i] = max(v[i] + kappa * (theta - v[i]) * dt + sigma * sqrt(v[i]) * dW2, 0)
            S[i] = S[i] * exp((r - 0.5 * v[i]) * dt + sqrt(v[i]) * dW1)

        prices[i] = max(K - S[i], 0)

    return exp(-r * T) * np.mean(prices)
