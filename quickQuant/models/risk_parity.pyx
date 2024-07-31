# quickQuant/models/risk_parity.pyx
import numpy as np
from scipy.stats import norm
cimport numpy as np
cimport cython

__all__ = ['risk_parity']

def risk_parity(returns, cov_matrix):
    """
    Risk Parity Model.

    Parameters:
    - returns: Expected returns for each asset
    - cov_matrix: Covariance matrix of asset returns

    Returns:
    - Optimal portfolio weights
    """
    cdef np.ndarray[double, ndim=1] weights, risk_contribution
    cdef double sum_weights

    n = len(returns)
    weights = np.zeros(n)
    risk_contribution = np.zeros(n)

    for i in range(n):
        weights[i] = 1 / n

    for i in range(n):
        sum_weights = np.sum(weights)
        risk_contribution = np.dot(cov_matrix, weights) * weights / np.dot(weights.T, np.dot(cov_matrix, weights))

        for j in range(n):
            weights[j] = risk_contribution[j] / sum_weights

    return weights
