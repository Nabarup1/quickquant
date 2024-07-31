# quickQuant/models/lookback_options.pyx
import numpy as np
from scipy.stats import norm
cimport numpy as np
cimport cython
__all__ = ['lookback_option']

def lookback_option(S0, K, T, r, sigma, N, option_type='call', lookback_type='fixed'):
    """
    Lookback Option Pricing Model.

    Parameters:
    - S0: Initial stock price
    - K: Strike price
    - T: Time to maturity (in years)
    - r: Risk-free interest rate
    - sigma: Volatility of the underlying stock
    - N: Number of time steps
    - option_type: 'call' or 'put'
    - lookback_type: 'fixed' or 'floating'

    Returns:
    - Option price
    """
    cdef int i, j
    cdef double dt, discount, payoff
    cdef np.ndarray[double, ndim=1] S

    dt = T / N
    discount = np.exp(-r * dt)
    S = np.zeros(N + 1)

    S[0] = S0
    for i in range(1, N + 1):
        S[i] = S[i - 1] * np.exp((r - 0.5 * sigma ** 2) * dt + sigma * np.sqrt(dt) * np.random.standard_normal())

    if lookback_type == 'fixed':
        if option_type == 'call':
            payoff = max(0, max(S) - K)
        else:
            payoff = max(0, K - min(S))
    else:
        if option_type == 'call':
            payoff = max(0, S[-1] - min(S))
        else:
            payoff = max(0, max(S) - S[-1])

    option_price = payoff * discount
    return option_price
