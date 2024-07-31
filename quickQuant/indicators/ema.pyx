# ema.pyx
# cython: boundscheck=False, wraparound=False, cdivision=True
cimport numpy as np
import numpy as np
__all__ = ['ema']

def ema(np.ndarray[double, ndim=1] prices, int period):
    """
    Calculate the Exponential Moving Average (EMA).

    Parameters
    ----------
    prices : np.ndarray[double, ndim=1]
        Array of prices.
    period : int
        Number of periods over which to calculate the EMA.

    Returns
    -------
    np.ndarray[double, ndim=1]
        Array of EMA values.
    """
    cdef int i
    cdef int n = prices.shape[0]
    cdef double alpha = 2.0 / (period + 1)
    cdef double ema_prev = prices[0]
    cdef np.ndarray[double, ndim=1] ema_values = np.zeros(n, dtype=np.double)

    ema_values[0] = ema_prev

    for i in range(1, n):
        ema_prev = (prices[i] - ema_prev) * alpha + ema_prev
        ema_values[i] = ema_prev

    return ema_values
