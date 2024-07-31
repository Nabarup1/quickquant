# quickQuant/models/kalman_filter.pyx
import numpy as np
from scipy import integrate
cimport numpy as np
cimport cython
from libc.math cimport exp, log, sqrt, cos, sin, pi
from scipy.stats import norm

def kalman_filter(observations, transition_matrix, observation_matrix, transition_covariance, observation_covariance, initial_state_mean, initial_state_covariance):
    """
    Kalman Filter.

    Parameters:
    - observations: Observed data
    - transition_matrix: State transition matrix
    - observation_matrix: Observation matrix
    - transition_covariance: Covariance of the process noise
    - observation_covariance: Covariance of the observation noise
    - initial_state_mean: Initial state mean
    - initial_state_covariance: Initial state covariance

    Returns:
    - Filtered state means and covariances
    """
    cdef np.ndarray[double, ndim=1] state_means, state_covariances
    cdef double mean, covariance, kalman_gain, prediction_mean, prediction_covariance

    n_timesteps = len(observations)
    n_dim_state = len(initial_state_mean)

    state_means = np.zeros((n_timesteps, n_dim_state))
    state_covariances = np.zeros((n_timesteps, n_dim_state, n_dim_state))

    state_means[0] = initial_state_mean
    state_covariances[0] = initial_state_covariance

    for t in range(1, n_timesteps):
        prediction_mean = np.dot(transition_matrix, state_means[t-1])
        prediction_covariance = np.dot(np.dot(transition_matrix, state_covariances[t-1]), transition_matrix.T) + transition_covariance

        kalman_gain = np.dot(np.dot(prediction_covariance, observation_matrix.T), np.linalg.inv(np.dot(np.dot(observation_matrix, prediction_covariance), observation_matrix.T) + observation_covariance))

        state_means[t] = prediction_mean + np.dot(kalman_gain, (observations[t] - np.dot(observation_matrix, prediction_mean)))
        state_covariances[t] = prediction_covariance - np.dot(np.dot(kalman_gain, observation_matrix), prediction_covariance)

    return state_means, state_covariances
