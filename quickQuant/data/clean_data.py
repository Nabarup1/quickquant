# data/clean_data.py
import numpy as np
import pandas as pd
__all__ = ['clean_data']

def clean_data(df):
    """
    Clean data in a DataFrame.

    Parameters:
    df (pd.DataFrame): DataFrame to clean

    Returns:
    pd.DataFrame: Cleaned DataFrame
    """
    df_cleaned = df.copy()
    # Handle missing values
    df_cleaned = df_cleaned.dropna()  # Simple method; customize as needed
    # Handle outliers (example: z-score based)
    from scipy import stats
    z_scores = stats.zscore(df_cleaned.select_dtypes(include=['float64', 'int64']))
    abs_z_scores = np.abs(z_scores)
    filtered_entries = (abs_z_scores < 3).all(axis=1)
    df_cleaned = df_cleaned[filtered_entries]
    return df_cleaned
