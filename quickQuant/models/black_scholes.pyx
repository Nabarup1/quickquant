# quickQuant/models/black_scholes.pyx
import numpy as np
from scipy import integrate
cimport numpy as np
cimport cython
from libc.math cimport exp, log, sqrt, cos, sin, pi
from scipy.stats import norm

__all__ = ['black_scholes_call','black_scholes_put']

def black_scholes_call(double S, double K, double T, double r, double sigma):
    """
    Black-Scholes Model for Call Options.

    Parameters:
    - S: Initial stock price
    - K: Strike price
    - T: Time to maturity (in years)
    - r: Risk-free interest rate
    - sigma: Volatility of the underlying stock

    Returns:
    - Call option price
    """
    cdef double d1, d2, call_price
    
    d1 = (log(S / K) + (r + 0.5 * sigma * sigma) * T) / (sigma * sqrt(T))
    d2 = d1 - sigma * sqrt(T)
    
    call_price = S * norm.cdf(d1) - K * exp(-r * T) * norm.cdf(d2)
    
    return call_price

def black_scholes_put(double S, double K, double T, double r, double sigma):
    """
    Black-Scholes Model for Put Options.

    Parameters:
    - S: Initial stock price
    - K: Strike price
    - T: Time to maturity (in years)
    - r: Risk-free interest rate
    - sigma: Volatility of the underlying stock

    Returns:
    - Put option price
    """
    cdef double d1, d2, put_price
    
    d1 = (log(S / K) + (r + 0.5 * sigma * sigma) * T) / (sigma * sqrt(T))
    d2 = d1 - sigma * sqrt(T)
    
    put_price = K * exp(-r * T) * norm.cdf(-d2) - S * norm.cdf(-d1)
    
    return put_price
