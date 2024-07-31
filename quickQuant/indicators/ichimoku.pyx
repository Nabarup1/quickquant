# ichimoku.pyx
# cython: boundscheck=False, wraparound=False, cdivision=True
cimport numpy as np
import numpy as np

__all__ = ['ichimoku']

def ichimoku(np.ndarray[double, ndim=1] high_prices, np.ndarray[double, ndim=1] low_prices, np.ndarray[double, ndim=1] close_prices, int period1, int period2, int period3):
    """
    Calculate the Ichimoku Cloud.

    Parameters
    ----------
    high_prices : np.ndarray[double, ndim=1]
        Array of high prices.
    low_prices : np.ndarray[double, ndim=1]
        Array of low prices.
    close_prices : np.ndarray[double, ndim=1]
        Array of close prices.
    period1 : int
        Number of periods for Tenkan-sen.
    period2 : int
        Number of periods for Kijun-sen.
    period3 : int
        Number of periods for Senkou Span B.

    Returns
    -------
    (np.ndarray[double, ndim=1], np.ndarray[double, ndim=1], np.ndarray[double, ndim=1], np.ndarray[double, ndim=1])
        Tuple of arrays (Tenkan-sen, Kijun-sen, Senkou Span A, Senkou Span B).
    """
    cdef int i
    cdef int n = high_prices.shape[0]
    cdef double max_high, min_low
    cdef np.ndarray[double, ndim=1] tenkan_sen = np.zeros(n, dtype=np.double)
    cdef np.ndarray[double, ndim=1] kijun_sen = np.zeros(n, dtype=np.double)
    cdef np.ndarray[double, ndim=1] senkou_span_a = np.zeros(n, dtype=np.double)
    cdef np.ndarray[double, ndim=1] senkou_span_b = np.zeros(n, dtype=np.double)

    for i in range(period1 - 1, n):
        max_high = np.max(high_prices[i - period1 + 1:i + 1])
        min_low = np.min(low_prices[i - period1 + 1:i + 1])
        tenkan_sen[i] = (max_high + min_low) / 2

    for i in range(period2 - 1, n):
        max_high = np.max(high_prices[i - period2 + 1:i + 1])
        min_low = np.min(low_prices[i - period2 + 1:i + 1])
        kijun_sen[i] = (max_high + min_low) / 2

    for i in range(period2 - 1, n):
        senkou_span_a[i] = (tenkan_sen[i] + kijun_sen[i]) / 2

    for i in range(period3 - 1, n):
        max_high = np.max(high_prices[i - period3 + 1:i + 1])
        min_low = np.min(low_prices[i - period3 + 1:i + 1])
        senkou_span_b[i] = (max_high + min_low) / 2

    return (tenkan_sen, kijun_sen, senkou_span_a, senkou_span_b)
