# plotting/bar_chart.py

import matplotlib.pyplot as plt

__all__ = ['bar_chart']

def bar_chart(categories, values, title='Bar Chart', xlabel='Categories', ylabel='Values', color='blue'):
    """
    Plot a bar chart.

    Parameters:
    categories (list): List of category names
    values (list): List of values corresponding to categories
    title (str): Title of the chart
    xlabel (str): Label for X-axis
    ylabel (str): Label for Y-axis
    color (str): Color of the bars
    """
    plt.figure(figsize=(10, 6))
    plt.bar(categories, values, color=color)
    plt.title(title)
    plt.xlabel(xlabel)
    plt.ylabel(ylabel)
    plt.xticks(rotation=45)
    plt.grid(axis='y')
    plt.show()
