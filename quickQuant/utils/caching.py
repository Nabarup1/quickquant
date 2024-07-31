# utils/caching.py

import pickle
import os

def save_to_cache(data, filename):
    """
    Save data to a cache file.

    Parameters:
    data: Data to be cached
    filename (str): Path to cache file
    """
    with open(filename, 'wb') as f:
        pickle.dump(data, f)

def load_from_cache(filename):
    """
    Load data from a cache file.

    Parameters:
    filename (str): Path to cache file

    Returns:
    Cached data
    """
    if os.path.exists(filename):
        with open(filename, 'rb') as f:
            return pickle.load(f)
    else:
        return None

__all__ = ['save_to_cache', 'load_from_cache']
