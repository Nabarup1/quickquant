# black_scholes.pyx
import numpy as np
from scipy.stats import norm
cimport numpy as np
cimport cython

@cython.boundscheck(False)
@cython.wraparound(False)

def black_scholes(double S0, double K, double T, double r, double sigma, bint call_option=True):
    """
    Black-Scholes Model for pricing European call and put options.
    
    Parameters:
    S0         : double : Current stock price
    K          : double : Strike price of the option
    T          : double : Time to maturity (in years)
    r          : double : Risk-free interest rate
    sigma      : double : Volatility of the stock
    call_option: bint   : True for call option, False for put option
    
    Returns:
    double : Price of the option
    """
    
    cdef double d1, d2, option_price
    
    d1 = (np.log(S0 / K) + (r + 0.5 * sigma**2) * T) / (sigma * np.sqrt(T))
    d2 = d1 - sigma * np.sqrt(T)
    
    if call_option:
        option_price = S0 * norm.cdf(d1) - K * np.exp(-r * T) * norm.cdf(d2)
    else:
        option_price = K * np.exp(-r * T) * norm.cdf(-d2) - S0 * norm.cdf(-d1)
    
    return option_price
