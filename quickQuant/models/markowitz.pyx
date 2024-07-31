# quickQuant/models/markowitz.pyx
import numpy as np
from scipy import integrate
cimport numpy as np
cimport cython
from libc.math cimport exp, log, sqrt, cos, sin, pi
__all__ = ['markowitz_portfolio']

def markowitz_portfolio(returns, cov_matrix, risk_free_rate):
    """
    Markowitz Portfolio Optimization Model.

    Parameters:
    - returns: Expected returns for each asset
    - cov_matrix: Covariance matrix of asset returns
    - risk_free_rate: Risk-free rate

    Returns:
    - Optimal portfolio weights
    """
    cdef np.ndarray[double, ndim=1] weights
    cdef double sharpe_ratio, max_sharpe_ratio, sum_weights

    n = len(returns)
    weights = np.zeros(n)
    max_sharpe_ratio = 0

    for i in range(n):
        weights[i] = 1 / n

    for i in range(n):
        sum_weights = np.sum(weights)
        sharpe_ratio = (np.dot(weights, returns) - risk_free_rate) / np.sqrt(np.dot(weights.T, np.dot(cov_matrix, weights)))

        if sharpe_ratio > max_sharpe_ratio:
            max_sharpe_ratio = sharpe_ratio

    return weights
