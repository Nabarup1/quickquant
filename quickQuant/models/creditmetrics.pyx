# quickQuant/models/creditmetrics.pyx
import numpy as np
from scipy import integrate
cimport numpy as np
cimport cython
from libc.math cimport exp, log, sqrt, cos, sin, pi
from scipy.stats import norm

__all__ = ['creditmetrics_model']

def creditmetrics_model(S0, K, T, r, sigma, credit_spread):
    """
    CreditMetrics Model.

    Parameters:
    - S0: Initial asset value
    - K: Strike price
    - T: Time to maturity (in years)
    - r: Risk-free interest rate
    - sigma: Volatility of the asset value
    - credit_spread: Credit spread

    Returns:
    - Option price
    """
    cdef double d1, d2, price

    d1 = (log(S0 / K) + (r + credit_spread + 0.5 * sigma ** 2) * T) / (sigma * sqrt(T))
    d2 = d1 - sigma * sqrt(T)

    price = S0 * norm.cdf(d1) - K * exp(-(r + credit_spread) * T) * norm.cdf(d2)

    return price
