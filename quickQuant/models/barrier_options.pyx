# quickQuant/models/barrier_options.pyx
import numpy as np
from scipy.stats import norm
cimport numpy as np
cimport cython

__all__ = ['barrier_option']

def barrier_option(S0, K, T, r, sigma, barrier, barrier_type='up_and_out', option_type='call'):
    """
    Barrier Option Pricing Model.

    Parameters:
    - S0: Initial stock price
    - K: Strike price
    - T: Time to maturity (in years)
    - r: Risk-free interest rate
    - sigma: Volatility of the underlying stock
    - barrier: Barrier level
    - barrier_type: 'up_and_out', 'up_and_in', 'down_and_out', 'down_and_in'
    - option_type: 'call' or 'put'

    Returns:
    - Option price
    """
    cdef double d1, d2, price

    d1 = (np.log(S0 / K) + (r + 0.5 * sigma ** 2) * T) / (sigma * np.sqrt(T))
    d2 = d1 - sigma * np.sqrt(T)

    if barrier_type == 'up_and_out':
        if S0 >= barrier:
            return 0
        price = S0 * norm.cdf(d1) - K * np.exp(-r * T) * norm.cdf(d2)
    elif barrier_type == 'up_and_in':
        if S0 >= barrier:
            price = S0 * norm.cdf(d1) - K * np.exp(-r * T) * norm.cdf(d2)
        else:
            return 0
    elif barrier_type == 'down_and_out':
        if S0 <= barrier:
            return 0
        price = S0 * norm.cdf(d1) - K * np.exp(-r * T) * norm.cdf(d2)
    elif barrier_type == 'down_and_in':
        if S0 <= barrier:
            price = S0 * norm.cdf(d1) - K * np.exp(-r * T) * norm.cdf(d2)
        else:
            return 0

    return price
