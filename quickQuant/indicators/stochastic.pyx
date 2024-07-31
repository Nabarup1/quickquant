# stochastic.pyx
# cython: boundscheck=False, wraparound=False, cdivision=True
cimport numpy as np
import numpy as np
__all__ = ['stochastic']

def stochastic(np.ndarray[double, ndim=1] high_prices, np.ndarray[double, ndim=1] low_prices, np.ndarray[double, ndim=1] close_prices, int period):
    """
    Calculate the Stochastic Oscillator.

    Parameters
    ----------
    high_prices : np.ndarray[double, ndim=1]
        Array of high prices.
    low_prices : np.ndarray[double, ndim=1]
        Array of low prices.
    close_prices : np.ndarray[double, ndim=1]
        Array of close prices.
    period : int
        Number of periods over which to calculate the Stochastic Oscillator.

    Returns
    -------
    (np.ndarray[double, ndim=1], np.ndarray[double, ndim=1])
        Tuple of arrays (%K line, %D line).
    """
    cdef int i, j
    cdef int n = close_prices.shape[0]
    cdef double lowest_low, highest_high
    cdef np.ndarray[double, ndim=1] k_values = np.zeros(n, dtype=np.double)
    cdef np.ndarray[double, ndim=1] d_values = np.zeros(n, dtype=np.double)

    for i in range(period - 1, n):
        lowest_low = np.min(low_prices[i - period + 1:i + 1])
        highest_high = np.max(high_prices[i - period + 1:i + 1])
        k_values[i] = 100 * (close_prices[i] - lowest_low) / (highest_high - lowest_low)

    # Calculate %D as the SMA of %K
    cdef double sum_k = 0.0
    for i in range(period - 1, period - 1 + 3):
        sum_k += k_values[i]
    d_values[period - 1 + 2] = sum_k / 3

    for i in range(period - 1 + 3, n):
        sum_k = sum_k - k_values[i - 3] + k_values[i]
        d_values[i] = sum_k / 3

    return (k_values, d_values)
