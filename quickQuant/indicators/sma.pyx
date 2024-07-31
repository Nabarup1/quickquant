# indicators/sma.pyx

cimport numpy as np
import numpy as np

__all__ = ['sma']

def sma(np.ndarray[np.float64_t, ndim=1] data, int period):
    cdef int n = data.shape[0]
    cdef np.ndarray[np.float64_t, ndim=1] result = np.empty(n - period + 1, dtype=np.float64)
    cdef int i, j
    cdef double sum

    for i in range(n - period + 1):
        sum = 0.0
        for j in range(period):
            sum += data[i + j]
        result[i] = sum / period

    return result
