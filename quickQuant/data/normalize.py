# data/normalize.py

import pandas as pd
from sklearn.preprocessing import StandardScaler, MinMaxScaler
__all__ = ['normalize_data']

def normalize_data(df, method='standard'):
    """
    Normalize data in a DataFrame.

    Parameters:
    df (pd.DataFrame): DataFrame to normalize
    method (str): Normalization method ('standard' or 'minmax')

    Returns:
    pd.DataFrame: Normalized DataFrame
    """
    scaler = StandardScaler() if method == 'standard' else MinMaxScaler()
    df_normalized = pd.DataFrame(scaler.fit_transform(df), columns=df.columns, index=df.index)
    return df_normalized
