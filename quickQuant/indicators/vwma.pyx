# vwma.pyx
# cython: boundscheck=False, wraparound=False, cdivision=True
cimport numpy as np
import numpy as np
__all__ = ['vwma']

def vwma(np.ndarray[double, ndim=1] prices, np.ndarray[double, ndim=1] volumes, int period):
    """
    Calculate the Volume Weighted Moving Average (VWMA).

    Parameters
    ----------
    prices : np.ndarray[double, ndim=1]
        Array of prices.
    volumes : np.ndarray[double, ndim=1]
        Array of volumes.
    period : int
        Number of periods over which to calculate the VWMA.

    Returns
    -------
    np.ndarray[double, ndim=1]
        Array of VWMA values.
    """
    cdef int i, j
    cdef int n = prices.shape[0]
    cdef double sum_pv, sum_v
    cdef np.ndarray[double, ndim=1] vwma_values = np.zeros(n, dtype=np.double)

    for i in range(period - 1, n):
        sum_pv = 0.0
        sum_v = 0.0
        for j in range(i - period + 1, i + 1):
            sum_pv += prices[j] * volumes[j]
            sum_v += volumes[j]
        vwma_values[i] = sum_pv / sum_v

    return vwma_values
