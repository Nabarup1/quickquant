# quickQuant/models/asian_options.pyx
import numpy as np
from scipy.stats import norm
cimport numpy as np
cimport cython

__all__ = ['asian_option']

def asian_option(S0, K, T, r, sigma, N, M, option_type='call', average_type='arithmetic'):
    """
    Asian Option Pricing Model.

    Parameters:
    - S0: Initial stock price
    - K: Strike price
    - T: Time to maturity (in years)
    - r: Risk-free interest rate
    - sigma: Volatility of the underlying stock
    - N: Number of time steps for averaging
    - M: Number of Monte Carlo simulations
    - option_type: 'call' or 'put'
    - average_type: 'arithmetic' or 'geometric'

    Returns:
    - Option price
    """
    cdef int i, j
    cdef double dt, sum_payoff, payoff
    cdef np.ndarray[double, ndim=1] S

    dt = T / N
    S = np.zeros(N + 1)

    sum_payoff = 0.0
    for i in range(M):
        S[0] = S0
        for j in range(1, N + 1):
            S[j] = S[j - 1] * np.exp((r - 0.5 * sigma ** 2) * dt + sigma * np.sqrt(dt) * np.random.standard_normal())
        
        if average_type == 'arithmetic':
            avg_price = np.mean(S)
        else:
            avg_price = np.exp(np.mean(np.log(S)))

        if option_type == 'call':
            payoff = max(0, avg_price - K)
        else:
            payoff = max(0, K - avg_price)

        sum_payoff += payoff

    option_price = (sum_payoff / M) * np.exp(-r * T)
    return option_price
