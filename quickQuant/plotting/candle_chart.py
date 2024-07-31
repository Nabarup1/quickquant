# candle_chart.py
import matplotlib.pyplot as plt
import matplotlib.dates as mdates
from matplotlib.dates import date2num
import datetime

__all__ = ['candle_chart']

def candle_chart(dates, opens, highs, lows, closes):
    """
    Plot a candle chart.

    Parameters
    ----------
    dates : list of datetime
        List of dates.
    opens : list of float
        List of opening prices.
    highs : list of float
        List of high prices.
    lows : list of float
        List of low prices.
    closes : list of float
        List of closing prices.
    """
    fig, ax = plt.subplots()
    candlestick_data = [(
        date2num(datetime.datetime.strptime(d, "%Y-%m-%d")),
        o, h, l, c
    ) for d, o, h, l, c in zip(dates, opens, highs, lows, closes)]
    
    candlestick_ohlc(ax, candlestick_data, width=0.6, colorup='g', colordown='r') # type: ignore
    ax.xaxis_date()
    ax.xaxis.set_major_formatter(mdates.DateFormatter('%Y-%m-%d'))
    plt.xticks(rotation=45)
    plt.show()
