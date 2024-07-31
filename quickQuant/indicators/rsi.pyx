# rsi.pyx
# cython: boundscheck=False, wraparound=False, cdivision=True
cimport numpy as np
import numpy as np

__all__ = ['rsi']

def rsi(np.ndarray[double, ndim=1] prices, int period):
    """
    Calculate the Relative Strength Index (RSI).

    Parameters
    ----------
    prices : np.ndarray[double, ndim=1]
        Array of prices.
    period : int
        Number of periods over which to calculate the RSI.

    Returns
    -------
    np.ndarray[double, ndim=1]
        Array of RSI values.
    """
    cdef int i
    cdef int n = prices.shape[0]
    cdef double gain = 0.0
    cdef double loss = 0.0
    cdef double avg_gain = 0.0
    cdef double avg_loss = 0.0
    cdef double rs = 0.0
    cdef np.ndarray[double, ndim=1] rsi_values = np.zeros(n, dtype=np.double)

    for i in range(1, period):
        if prices[i] > prices[i - 1]:
            gain += prices[i] - prices[i - 1]
        else:
            loss += prices[i - 1] - prices[i]

    avg_gain = gain / period
    avg_loss = loss / period

    for i in range(period, n):
        if prices[i] > prices[i - 1]:
            gain = prices[i] - prices[i - 1]
            loss = 0.0
        else:
            loss = prices[i - 1] - prices[i]
            gain = 0.0

        avg_gain = (avg_gain * (period - 1) + gain) / period
        avg_loss = (avg_loss * (period - 1) + loss) / period

        if avg_loss == 0:
            rsi_values[i] = 100
        else:
            rs = avg_gain / avg_loss
            rsi_values[i] = 100 - (100 / (1 + rs))

    return rsi_values
