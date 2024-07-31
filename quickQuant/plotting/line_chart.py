# plotting/line_chart.py

import matplotlib.pyplot as plt
__all__ = ['line_chart']

def line_chart(x, y, title='Line Chart', xlabel='X-axis', ylabel='Y-axis'):
    """
    Plot a line chart.

    Parameters:
    x (list or np.array): X-axis data
    y (list or np.array): Y-axis data
    title (str): Title of the chart
    xlabel (str): Label for X-axis
    ylabel (str): Label for Y-axis
    """
    plt.figure(figsize=(10, 6))
    plt.plot(x, y, color='blue', marker='o')
    plt.title(title)
    plt.xlabel(xlabel)
    plt.ylabel(ylabel)
    plt.grid(True)
    plt.show()
