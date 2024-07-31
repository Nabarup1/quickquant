# quickquant/indicators/adx.pyx

cimport cython
import numpy as np
cimport numpy as np

@cython.boundscheck(False)
@cython.wraparound(False)
def adx(np.ndarray[double, ndim=1] high_prices, np.ndarray[double, ndim=1] low_prices, np.ndarray[double, ndim=1] close_prices, int period):
    cdef:
        int i
        int size = high_prices.shape[0]
        double up_move, down_move
        np.ndarray[double, ndim=1] tr_values = np.zeros(size, dtype=np.double)
        np.ndarray[double, ndim=1] pos_dm_values = np.zeros(size, dtype=np.double)
        np.ndarray[double, ndim=1] neg_dm_values = np.zeros(size, dtype=np.double)
        np.ndarray[double, ndim=1] atr_values = np.zeros(size, dtype=np.double)
        np.ndarray[double, ndim=1] dx_values = np.zeros(size, dtype=np.double)
        double sum_tr, sum_pos_dm, sum_neg_dm, sum_dx

    # Calculate True Range (TR), Positive DM, and Negative DM
    for i in range(1, size):
        tr_values[i] = max(high_prices[i] - low_prices[i], abs(high_prices[i] - close_prices[i - 1]), abs(low_prices[i] - close_prices[i - 1]))
        up_move = high_prices[i] - high_prices[i - 1]
        down_move = low_prices[i - 1] - low_prices[i]

        pos_dm_values[i] = up_move if up_move > down_move and up_move > 0 else 0.0
        neg_dm_values[i] = down_move if down_move > up_move and down_move > 0 else 0.0

    # Sum the initial period values
    sum_tr = 0.0
    sum_pos_dm = 0.0
    sum_neg_dm = 0.0
    for i in range(1, period):
        sum_tr += tr_values[i]
        sum_pos_dm += pos_dm_values[i]
        sum_neg_dm += neg_dm_values[i]

    # Calculate ATR and DI for the first period
    atr_values[period - 1] = sum_tr / period
    pos_di = 100 * (sum_pos_dm / atr_values[period - 1])
    neg_di = 100 * (sum_neg_dm / atr_values[period - 1])

    # Calculate DX
    dx_values[period - 1] = 100 * abs(pos_di - neg_di) / (pos_di + neg_di)

    # Continue for the rest of the data
    for i in range(period, size):
        sum_tr = sum_tr - (sum_tr / period) + tr_values[i]
        sum_pos_dm = sum_pos_dm - (sum_pos_dm / period) + pos_dm_values[i]
        sum_neg_dm = sum_neg_dm - (sum_neg_dm / period) + neg_dm_values[i]

        atr_values[i] = sum_tr / period
        pos_di = 100 * (sum_pos_dm / atr_values[i])
        neg_di = 100 * (sum_neg_dm / atr_values[i])

        dx_values[i] = 100 * abs(pos_di - neg_di) / (pos_di + neg_di)

    # Calculate ADX
    sum_dx = 0.0
    for i in range(period, 2 * period):
        sum_dx += dx_values[i]

    adx_values = np.zeros(size, dtype=np.double)
    adx_values[2 * period - 1] = sum_dx / period

    for i in range(2 * period, size):
        adx_values[i] = (adx_values[i - 1] * (period - 1) + dx_values[i]) / period

    return adx_values
