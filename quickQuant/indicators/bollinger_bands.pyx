# bollinger_bands.pyx
# cython: boundscheck=False, wraparound=False, cdivision=True
cimport numpy as np
import numpy as np

__all__ = ['bollinger_bands']

def bollinger_bands(np.ndarray[double, ndim=1] prices, int period, double num_std):
    """
    Calculate the Bollinger Bands.

    Parameters
    ----------
    prices : np.ndarray[double, ndim=1]
        Array of prices.
    period : int
        Number of periods over which to calculate the SMA.
    num_std : double
        Number of standard deviations for the upper and lower bands.

    Returns
    -------
    (np.ndarray[double, ndim=1], np.ndarray[double, ndim=1], np.ndarray[double, ndim=1])
        Tuple of arrays (middle_band, upper_band, lower_band).
    """
    cdef int i
    cdef int n = prices.shape[0]
    cdef double sum = 0.0
    cdef np.ndarray[double, ndim=1] middle_band = np.zeros(n, dtype=np.double)
    cdef np.ndarray[double, ndim=1] upper_band = np.zeros(n, dtype=np.double)
    cdef np.ndarray[double, ndim=1] lower_band = np.zeros(n, dtype=np.double)
    
    for i in range(period):
        sum += prices[i]
    
    for i in range(period, n):
        sum += prices[i]
        middle_band[i] = sum / period
        std_dev = np.std(prices[i-period+1:i+1])
        upper_band[i] = middle_band[i] + num_std * std_dev
        lower_band[i] = middle_band[i] - num_std * std_dev
        sum -= prices[i - period + 1]

    return (middle_band, upper_band, lower_band)
