# heston_model.pyx
import numpy as np
from scipy import integrate
cimport numpy as np
cimport cython
from libc.math cimport exp, log, sqrt, cos, sin, pi

cdef double char_func_real(double phi, double S0, double K, double T, double r, double v0, double theta, double kappa, double sigma, double rho, bint is_call):
    cdef double u = 0.5
    if is_call:
        u = 0.5
    else:
        u = -0.5
    cdef double b = kappa - rho * sigma
    cdef double d = sqrt((rho * sigma * 1j * phi - b)**2 - (sigma**2) * (2 * u * 1j * phi - phi**2))
    cdef double g = (b - rho * sigma * 1j * phi + d) / (b - rho * sigma * 1j * phi - d)
    cdef double C = r * 1j * phi * T + kappa * theta / (sigma**2) * ((b - rho * sigma * 1j * phi + d) * T - 2 * log((1 - g * exp(d * T)) / (1 - g)))
    cdef double D = (b - rho * sigma * 1j * phi + d) / (sigma**2) * ((1 - exp(d * T)) / (1 - g * exp(d * T)))
    return exp(C + D * v0 + 1j * phi * log(S0 / K))

cdef double heston_integrand(double phi, double S0, double K, double T, double r, double v0, double theta, double kappa, double sigma, double rho, bint is_call):
    cdef double integrand = (exp(-1j * phi * log(K)) * char_func_real(phi, S0, K, T, r, v0, theta, kappa, sigma, rho, is_call)) / (1j * phi)
    return integrand.real

@cython.boundscheck(False)
@cython.wraparound(False)
def heston_option_price(double S0, double K, double T, double r, double v0, double theta, double kappa, double sigma, double rho, bint is_call=True):
    """
    Heston Model for pricing European call and put options using Fourier transform.
    
    Parameters:
    S0         : double : Current stock price
    K          : double : Strike price of the option
    T          : double : Time to maturity (in years)
    r          : double : Risk-free interest rate
    v0         : double : Initial variance
    theta      : double : Long-term variance
    kappa      : double : Speed of reversion
    sigma      : double : Volatility of volatility
    rho        : double : Correlation between asset price and variance
    is_call    : bint   : True for call option, False for put option
    
    Returns:
    double : Price of the option
    """
    
    cdef double P1, P2, call_price, put_price, discount_factor
    cdef double limit = 100.0
    cdef double tol = 1e-10

    P1, err1 = integrate.quad(heston_integrand, 0, limit, args=(S0, K, T, r, v0, theta, kappa, sigma, rho, True), limit=limit, epsabs=tol)
    P2, err2 = integrate.quad(heston_integrand, 0, limit, args=(S0, K, T, r, v0, theta, kappa, sigma, rho, False), limit=limit, epsabs=tol)

    discount_factor = exp(-r * T)
    call_price = S0 * 0.5 + (1 / pi) * P1 - K * discount_factor * (0.5 + (1 / pi) * P2)
    put_price = call_price - S0 + K * discount_factor
    
    if is_call:
        return call_price
    else:
        return put_price
