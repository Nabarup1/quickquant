# merton_model.pyx
import numpy as np
from scipy.stats import norm
cimport numpy as np
cimport cython

@cython.boundscheck(False)
@cython.wraparound(False)
def merton_model(double V0, double D, double T, double r, double sigma):
    """
    Merton Model for pricing equity as a call option on the firm's assets.
    
    Parameters:
    V0    : double   : Initial value of the company's assets
    D     : double   : Face value of the company's debt
    T     : double   : Time to maturity (in years)
    r     : double   : Risk-free interest rate
    sigma : double   : Volatility of the company's asset value
    
    Returns:
    double : Value of the company's equity
    double : Probability of default
    """
    
    cdef double d1, d2, equity_value, P_default
    
    d1 = (np.log(V0 / D) + (r + 0.5 * sigma**2) * T) / (sigma * np.sqrt(T))
    d2 = d1 - sigma * np.sqrt(T)
    
    equity_value = V0 * norm.cdf(d1) - D * np.exp(-r * T) * norm.cdf(d2)
    P_default = 1 - norm.cdf(d2)
    
    return equity_value, P_default
