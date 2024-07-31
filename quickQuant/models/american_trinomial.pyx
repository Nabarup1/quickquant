# quickQuant/models/american_trinomial.pyx
import numpy as np
from scipy.stats import norm
cimport numpy as np
cimport cython

__all__ = ['american_trinomial_option']

def american_trinomial_option(S0, K, T, r, sigma, N, option_type='call'):
    """
    American Trinomial Option Pricing Model.

    Parameters:
    - S0: Initial stock price
    - K: Strike price
    - T: Time to maturity (in years)
    - r: Risk-free interest rate
    - sigma: Volatility of the underlying stock
    - N: Number of steps in the trinomial model
    - option_type: 'call' or 'put'

    Returns:
    - Option price
    """
    cdef int i, j
    cdef double dt, u, d, m, pu, pd, pm, discount
    cdef double[:,:] stock_prices, option_values

    dt = T / N
    u = np.exp(sigma * np.sqrt(2 * dt))
    d = 1 / u
    m = 1
    pu = ((np.exp(r * dt / 2) - np.exp(-sigma * np.sqrt(dt / 2))) ** 2) / ((np.exp(sigma * np.sqrt(dt / 2)) - np.exp(-sigma * np.sqrt(dt / 2))) ** 2)
    pd = ((np.exp(sigma * np.sqrt(dt / 2)) - np.exp(r * dt / 2)) ** 2) / ((np.exp(sigma * np.sqrt(dt / 2)) - np.exp(-sigma * np.sqrt(dt / 2))) ** 2)
    pm = 1 - pu - pd
    discount = np.exp(-r * dt)

    stock_prices = np.zeros((2 * N + 1, N + 1))
    option_values = np.zeros((2 * N + 1, N + 1))

    # Initialize stock prices at maturity
    for i in range(2 * N + 1):
        stock_prices[i, N] = S0 * (u ** (N - i // 2)) * (d ** (i // 2))
        if option_type == 'call':
            option_values[i, N] = max(0, stock_prices[i, N] - K)
        else:
            option_values[i, N] = max(0, K - stock_prices[i, N])

    # Backward induction
    for j in range(N-1, -1, -1):
        for i in range(2 * j + 1):
            option_values[i, j] = max(
                discount * (pu * option_values[i, j+1] + pm * option_values[i+1, j+1] + pd * option_values[i+2, j+1]),
                stock_prices[i, j] - K if option_type == 'call' else K - stock_prices[i, j]
            )

    return option_values[0, 0]
