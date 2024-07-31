# plotting/heikin_ashi.py

import matplotlib.pyplot as plt
import pandas as pd

__all__ = ['heikin_ashi']

def heikin_ashi(df, title='Heikin-Ashi Chart'):
    """
    Plot Heikin-Ashi Candlestick chart.

    Parameters:
    df (pd.DataFrame): DataFrame with columns ['Date', 'Open', 'High', 'Low', 'Close']
    title (str): Title of the chart
    """
    df = df.copy()
    df['Heikin_Open'] = (df['Open'].shift(1) + df['Close'].shift(1)) / 2
    df['Heikin_Close'] = (df['Open'] + df['High'] + df['Low'] + df['Close']) / 4
    df['Heikin_High'] = df[['High', 'Heikin_Open', 'Heikin_Close']].max(axis=1)
    df['Heikin_Low'] = df[['Low', 'Heikin_Open', 'Heikin_Close']].min(axis=1)

    fig, ax = plt.subplots(figsize=(10, 6))
    
    for i in range(len(df)):
        color = 'green' if df['Heikin_Close'][i] >= df['Heikin_Open'][i] else 'red'
        ax.plot([df.index[i], df.index[i]], [df['Heikin_Low'][i], df['Heikin_High'][i]], color=color)
        ax.add_patch(plt.Rectangle((df.index[i] - 0.3, df['Heikin_Open'][i]), 0.6, df['Heikin_Close'][i] - df['Heikin_Open'][i],
                                   color=color, edgecolor='black'))

    ax.set_title(title)
    plt.xticks(rotation=45)
    plt.show()
