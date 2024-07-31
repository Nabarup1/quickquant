# atr.pyx
# cython: boundscheck=False, wraparound=False, cdivision=True
cimport numpy as np
import numpy as np

def atr(np.ndarray[double, ndim=1] high_prices, np.ndarray[double, ndim=1] low_prices, np.ndarray[double, ndim=1] close_prices, int period):
    """
    Calculate the Average True Range (ATR).

    Parameters
    ----------
    high_prices : np.ndarray[double, ndim=1]
        Array of high prices.
    low_prices : np.ndarray[double, ndim=1]
        Array of low prices.
    close_prices : np.ndarray[double, ndim=1]
        Array of close prices.
    period : int
        Number of periods over which to calculate the ATR.

    Returns
    -------
    np.ndarray[double, ndim=1]
        Array of ATR values.
    """
    cdef int i
    cdef int n = high_prices.shape[0]
    cdef double tr = 0.0
    cdef np.ndarray[double, ndim=1] tr_values = np.zeros(n, dtype=np.double)
    cdef np.ndarray[double, ndim=1] atr_values = np.zeros(n, dtype=np.double)

    for i in range(1, n):
        tr = max(high_prices[i] - low_prices[i], abs(high_prices[i] - close_prices[i - 1]), abs(low_prices[i] - close_prices[i - 1]))
        tr_values[i] = tr

    atr_values[period - 1] = np.sum(tr_values[1:period]) / period

    for i in range(period, n):
        atr_values[i] = (atr_values[i - 1] * (period - 1) + tr_values[i]) / period

    return atr_values
