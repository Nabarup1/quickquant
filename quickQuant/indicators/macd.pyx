# macd.pyx
# cython: boundscheck=False, wraparound=False, cdivision=True
cimport numpy as np
import numpy as np

__all__ = ['macd']

def ema(np.ndarray[double, ndim=1] prices, int period):
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

def macd(np.ndarray[double, ndim=1] prices):
    """
    Calculate the Moving Average Convergence Divergence (MACD).

    Parameters
    ----------
    prices : np.ndarray[double, ndim=1]
        Array of prices.

    Returns
    -------
    (np.ndarray[double, ndim=1], np.ndarray[double, ndim=1], np.ndarray[double, ndim=1])
        Tuple of arrays (MACD line, Signal line, MACD Histogram).
    """
    cdef int n = prices.shape[0]
    cdef np.ndarray[double, ndim=1] ema_12 = ema(prices, 12)
    cdef np.ndarray[double, ndim=1] ema_26 = ema(prices, 26)
    cdef np.ndarray[double, ndim=1] macd_line = ema_12 - ema_26
    cdef np.ndarray[double, ndim=1] signal_line = ema(macd_line, 9)
    cdef np.ndarray[double, ndim=1] macd_histogram = macd_line - signal_line

    return (macd_line, signal_line, macd_histogram)
