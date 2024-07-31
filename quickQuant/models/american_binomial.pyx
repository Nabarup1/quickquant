# quickQuant/models/american_binomial.pyx

import numpy as np
cimport numpy as np

__all__ = ['american_binomial']

def american_binomial(double S0, double K, double T, double r, double sigma, int N, bint is_call):
    """
    Price an American option using the binomial tree method.
    
    Parameters:
    S0 : double - Initial stock price
    K : double - Strike price
    T : double - Time to maturity (in years)
    r : double - Risk-free interest rate
    sigma : double - Volatility
    N : int - Number of time steps
    is_call : bint - True for call option, False for put option
    
    Returns:
    double - Option price
    """
    cdef double dt = T / N
    cdef double u = np.exp(sigma * np.sqrt(dt))
    cdef double d = 1 / u
    cdef double q = (np.exp(r * dt) - d) / (u - d)
    cdef int i, j
    
    # Initialize asset prices at maturity
    cdef np.ndarray[np.double_t, ndim=1] ST = np.zeros(N + 1)
    for i in range(N + 1):
        ST[i] = S0 * (u ** i) * (d ** (N - i))
    
    # Initialize option values at maturity
    cdef np.ndarray[np.double_t, ndim=1] option_values = np.zeros(N + 1)
    for i in range(N + 1):
        if is_call:
            option_values[i] = max(0, ST[i] - K)
        else:
            option_values[i] = max(0, K - ST[i])
    
    # Step backwards through tree
    for j in range(N - 1, -1, -1):
        for i in range(j + 1):
            ST[i] = S0 * (u ** i) * (d ** (j - i))
            option_values[i] = max(np.exp(-r * dt) * (q * option_values[i + 1] + (1 - q) * option_values[i]), 
                                   (ST[i] - K) if is_call else (K - ST[i]))
    
    return option_values[0]
