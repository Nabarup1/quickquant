# quickQuant/models/swaptions.pyx
import numpy as np
from scipy import integrate
cimport numpy as np
cimport cython
from libc.math cimport exp, log, sqrt, cos, sin, pi
from scipy.stats import norm
__all__ = ['swaption_price']

def swaption_price(S0, K, T, r, sigma, swap_rate, option_type='payer'):
    """
    Swaption Pricing Model.

    Parameters:
    - S0: Initial swap rate
    - K: Strike swap rate
    - T: Time to maturity (in years)
    - r: Risk-free interest rate
    - sigma: Volatility of the swap rate
    - swap_rate: Swap rate
    - option_type: 'payer' or 'receiver'

    Returns:
    - Swaption price
    """
    cdef double d1, d2, price

    d1 = (log(S0 / K) + (r + 0.5 * sigma ** 2) * T) / (sigma * sqrt(T))
    d2 = d1 - sigma * sqrt(T)

    if option_type == 'payer':
        price = S0 * norm.cdf(d1) - K * exp(-r * T) * norm.cdf(d2)
    else:
        price = K * exp(-r * T) * norm.cdf(-d2) - S0 * norm.cdf(-d1)

    return price
