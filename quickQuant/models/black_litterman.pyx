# quickQuant/models/black_litterman.pyx
import numpy as np
from scipy import integrate
cimport numpy as np
cimport cython
from libc.math cimport exp, log, sqrt, cos, sin, pi


__all__ = ['black_litterman']

def black_litterman(returns, cov_matrix, P, Q, risk_aversion, tau):
    """
    Black-Litterman Model.

    Parameters:
    - returns: Expected returns for each asset
    - cov_matrix: Covariance matrix of asset returns
    - P: Pick matrix for the views
    - Q: View vector
    - risk_aversion: Risk aversion coefficient
    - tau: Scale factor for the uncertainty in the prior estimate of the returns

    Returns:
    - Optimal portfolio weights
    """
    cdef np.ndarray[double, ndim=1] weights, omega, equilibrium_returns, adjusted_returns
    cdef double sum_weights

    n = len(returns)
    weights = np.zeros(n)
    omega = np.dot(np.dot(P, cov_matrix), P.T) * tau
    equilibrium_returns = risk_aversion * np.dot(cov_matrix, weights)
    adjusted_returns = equilibrium_returns + np.dot(np.dot(np.dot(cov_matrix, P.T), np.linalg.inv(np.dot(np.dot(P, cov_matrix), P.T) + omega)), Q - np.dot(P, equilibrium_returns))

    for i in range(n):
        weights[i] = 1 / n

    for i in range(n):
        sum_weights = np.sum(weights)
        weights = np.dot(np.linalg.inv(risk_aversion * cov_matrix), adjusted_returns)

    return weights
