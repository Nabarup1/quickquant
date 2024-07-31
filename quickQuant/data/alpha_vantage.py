# data/alpha_vantage.py

import requests

API_KEY = 'your_alpha_vantage_api_key'  # Replace with your API key
__all__ = ['fetch_alpha_vantage_data']

def fetch_alpha_vantage_data(symbol, function='TIME_SERIES_DAILY'):
    """
    Fetch data from Alpha Vantage.

    Parameters:
    symbol (str): Stock ticker symbol
    function (str): Alpha Vantage function type (e.g., 'TIME_SERIES_DAILY')

    Returns:
    dict: Data from Alpha Vantage
    """
    url = f'https://www.alphavantage.co/query'
    params = {
        'function': function,
        'symbol': symbol,
        'apikey': API_KEY
    }
    response = requests.get(url, params=params)
    data = response.json()
    return data
