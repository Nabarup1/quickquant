# quickQuant/models/cir_model.pyx
import numpy as np
from scipy import integrate
cimport numpy as np
cimport cython
from libc.math cimport exp, log, sqrt, cos, sin, pi
from scipy.stats import norm

__all__ = ['cir_model']

def cir_model(S0, K, T, r, sigma, a, b):
    """
    Cox-Ingersoll-Ross (CIR) Model.

    Parameters:
    - S0: Initial interest rate
    - K: Strike rate
    - T: Time to maturity (in years)
    - r: Risk-free interest rate
    - sigma: Volatility of the interest rate
    - a: Speed of mean reversion
    - b: Long-term mean level

    Returns:
    - Option price
    """
    cdef double B, A, price

    B = (1 - exp(-a * T)) / a
    A = exp((B - T) * (a ** 2 * b - 0.5 * sigma ** 2) / (a ** 2) - (sigma ** 2 * B ** 2) / (4 * a))

    price = A * exp(-B * r) * norm.cdf((log(S0 / (K * A)) + 0.5 * sigma ** 2 * T) / (sigma * sqrt(T)))

    return price
