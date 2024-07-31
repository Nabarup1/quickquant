# data/yahoo_finance.py

import yfinance as yf # type: ignore
__all__ = ['yfinance']

def yfinance(ticker, start_date, end_date):
    """
    Fetch stock data from Yahoo Finance.

    Parameters:
    ticker (str): Stock ticker symbol
    start_date (str): Start date in 'YYYY-MM-DD' format
    end_date (str): End date in 'YYYY-MM-DD' format

    Returns:
    pd.DataFrame: DataFrame with stock data
    """
    stock_data = yf.download(ticker, start=start_date, end=end_date)
    return stock_data
