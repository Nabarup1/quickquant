# volume_profile.pyx
# cython: boundscheck=False, wraparound=False, cdivision=True
cimport numpy as np
import numpy as np
__all__ = ['volume_profile']

def volume_profile(np.ndarray[double, ndim=1] prices, np.ndarray[double, ndim=1] volumes, int bins):
    """
    Calculate the Volume Profile.

    Parameters
    ----------
    prices : np.ndarray[double, ndim=1]
        Array of prices.
    volumes : np.ndarray[double, ndim=1]
        Array of volumes.
    bins : int
        Number of bins for the volume profile.

    Returns
    -------
    (np.ndarray[double, ndim=1], np.ndarray[double, ndim=1])
        Tuple of arrays (price levels, volume at each level).
    """
    cdef int i
    cdef int n = prices.shape[0]
    cdef double price_min = np.min(prices)
    cdef double price_max = np.max(prices)
    cdef double bin_size = (price_max - price_min) / bins
    cdef np.ndarray[double, ndim=1] volume_profile = np.zeros(bins, dtype=np.double)
    cdef np.ndarray[double, ndim=1] price_levels = np.linspace(price_min, price_max, bins)

    for i in range(n):
        bin_index = int((prices[i] - price_min) / bin_size)
        if bin_index >= bins:
            bin_index = bins - 1
        volume_profile[bin_index] += volumes[i]

    return (price_levels, volume_profile)
