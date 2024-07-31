# quickQuant/models/american_finite_difference.pyx
import numpy as np
from scipy.stats import norm
cimport numpy as np
cimport cython

__all__ = ['american_finite_difference_option']

def american_finite_difference_option(S0, K, T, r, sigma, N, M, option_type='call'):
    """
    American Finite Difference Option Pricing Model.

    Parameters:
    - S0: Initial stock price
    - K: Strike price
    - T: Time to maturity (in years)
    - r: Risk-free interest rate
    - sigma: Volatility of the underlying stock
    - N: Number of time steps
    - M: Number of price steps
    - option_type: 'call' or 'put'

    Returns:
    - Option price
    """
    cdef int i, j
    cdef double dt, ds, discount
    cdef double[:, :] option_values

    dt = T / N
    ds = 2 * S0 / M
    discount = np.exp(-r * dt)

    option_values = np.zeros((M + 1, N + 1))

    # Boundary conditions
    for i in range(M + 1):
        if option_type == 'call':
            option_values[i, N] = max(0, i * ds - K)
        else:
            option_values[i, N] = max(0, K - i * ds)

    for j in range(N + 1):
        if option_type == 'call':
            option_values[0, j] = 0
            option_values[M, j] = max(0, M * ds - K)
        else:
            option_values[0, j] = max(0, K)
            option_values[M, j] = 0

    # Backward induction
    for j in range(N - 1, -1, -1):
        for i in range(1, M):
            delta = (option_values[i + 1, j + 1] - option_values[i - 1, j + 1]) / (2 * ds)
            gamma = (option_values[i + 1, j + 1] - 2 * option_values[i, j + 1] + option_values[i - 1, j + 1]) / (ds ** 2)
            theta = -0.5 * sigma ** 2 * i ** 2 * gamma - r * i * delta + r * option_values[i, j + 1]
            option_values[i, j] = max(discount * option_values[i, j + 1] + dt * theta, i * ds - K if option_type == 'call' else K - i * ds)

    return option_values[int(S0 / ds), 0]
