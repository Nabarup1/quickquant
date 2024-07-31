# utils/optimizations.py

import numpy as np
import pandas as pd
from scipy.optimize import minimize

def optimize_function(func, x0, bounds=None, constraints=None):
    """
    Optimize a function using scipy's minimize.

    Parameters:
    func (callable): Function to minimize
    x0 (array-like): Initial guess
    bounds (tuple, optional): Bounds for variables
    constraints (dict, optional): Constraints definition

    Returns:
    result: Optimization result object
    """
    result = minimize(func, x0, bounds=bounds, constraints=constraints)
    return result

def optimize_dataframe(df, columns_to_optimize):
    """
    Perform optimizations on DataFrame columns.

    Parameters:
    df (pd.DataFrame): DataFrame containing data
    columns_to_optimize (list): List of columns to optimize

    Returns:
    pd.DataFrame: DataFrame with optimized columns
    """
    df_optimized = df.copy()
    # Example optimization: normalize columns
    for col in columns_to_optimize:
        df_optimized[col] = (df[col] - df[col].mean()) / df[col].std()
    return df_optimized

__all__ = ['optimize_function', 'optimize_dataframe']
