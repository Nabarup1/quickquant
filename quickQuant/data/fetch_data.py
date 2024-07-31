# data/fetch_data.py

from yahoo_finance import fetch_stock_data
from alpha_vantage import fetch_alpha_vantage_data
__all__ = ['fetch_data']

def fetch_data(source, *args, **kwargs):
    """
    Fetch data from specified source.

    Parameters:
    source (str): Data source ('yahoo' or 'alpha_vantage')
    *args: Arguments to pass to the fetch function
    **kwargs: Keyword arguments to pass to the fetch function

    Returns:
    pd.DataFrame or dict: Fetched data
    """
    if source == 'yahoo':
        return fetch_stock_data(*args, **kwargs)
    elif source == 'alpha_vantage':
        return fetch_alpha_vantage_data(*args, **kwargs)
    else:
        raise ValueError("Unsupported data source")
