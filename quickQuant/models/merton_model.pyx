# quickQuant/models/merton_model.pyx

import numpy as np
cimport numpy as np
from scipy.stats import norm
__all__ = ['merton_model']

cdef extern from "math.h":
    double exp(double)
    double log(double)
    double sqrt(double)

cpdef tuple merton_model(double V0, double D, double T, double r, double sigma):
    """
    Merton Model for Structural Credit Risk.

    Parameters:
    - V0: Initial value of the company's assets
    - D: Face value of the company's debt
    - T: Time to maturity (in years)
    - r: Risk-free interest rate
    - sigma: Volatility of the company's asset value

    Returns:
    - Equity value
    - Probability of default
    """
    cdef double d1, d2, equity_value, P_default

    d1 = (log(V0 / D) + (r + 0.5 * sigma**2) * T) / (sigma * sqrt(T))
    d2 = d1 - sigma * sqrt(T)

    equity_value = V0 * norm.cdf(d1) - D * exp(-r * T) * norm.cdf(d2)
    P_default = norm.cdf(-d2)

    return equity_value, P_default
