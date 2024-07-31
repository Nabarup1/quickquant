# quickQuant/models/black_cox.pyx
import numpy as np
from scipy import integrate
cimport numpy as np
cimport cython
from libc.math cimport exp, log, sqrt, cos, sin, pi
from scipy.stats import norm

__all__ = ['black_cox_model']

def black_cox_model(S0, K, T, r, sigma, barrier):
    """
    Black-Cox Model.

    Parameters:
    - S0: Initial stock price
    - K: Strike price
    - T: Time to maturity (in years)
    - r: Risk-free interest rate
    - sigma: Volatility of the underlying stock
    - barrier: Barrier level

    Returns:
    - Option price
    """
    cdef double d1, d2, price

    d1 = (log(S0 / K) + (r + 0.5 * sigma ** 2) * T) / (sigma * sqrt(T))
    d2 = d1 - sigma * sqrt(T)

    price = S0 * norm.cdf(d1) - K * exp(-r * T) * norm.cdf(d2) - (S0 * (S0 / barrier) ** (-2 * r / sigma ** 2)) * norm.cdf(d1 - 2 * r * T / sigma)

    return price
