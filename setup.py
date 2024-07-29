from setuptools import setup, Extension
from Cython.Build import cythonize
extensions = [
    Extension("quickquant.models.black_scholes", ["quickquant/models/black_scholes.pyx"]),
    Extension("quickquant.models.merton_model", ["quickquant/models/merton_model.pyx"]),
    Extension("quickquant.models.heston_model", ["quickquant/models/heston_model.pyx"]),
    Extension("quickquant.models.american_option", ["quickquant/models/american_option.pyx"]),
    Extension("quickquant.models.exotic_options", ["quickquant/models/exotic_options.pyx"]),
    Extension("quickquant.models.interest_rate", ["quickquant/models/interest_rate.pyx"]),
    Extension("quickquant.models.credit_risk", ["quickquant/models/credit_risk.pyx"]),
    Extension("quickquant.models.portfolio_optimization", ["quickquant/models/portfolio_optimization.pyx"]),
    Extension("quickquant.indicators.moving_averages", ["quickquant/indicators/moving_averages.pyx"]),
    Extension("quickquant.indicators.bollinger_bands", ["quickquant/indicators/bollinger_bands.pyx"]),
    Extension("quickquant.indicators.rsi", ["quickquant/indicators/rsi.pyx"]),
    Extension("quickquant.indicators.macd", ["quickquant/indicators/macd.pyx"]),
    Extension("quickquant.indicators.stochastic", ["quickquant/indicators/stochastic.pyx"]),
    Extension("quickquant.ml.price_prediction", ["quickquant/ml/price_prediction.pyx"]),
    Extension("quickquant.ml.trading_strategies", ["quickquant/ml/trading_strategies.pyx"]),
]

setup(
    name="quickquant",
    version="0.1.1",
    author="Nabarup Ghosh",
    author_email="nabarupeducation@gmail.com",
    description="A fast quant finance library",
    ext_modules=cythonize(extensions),
    license="Apache License 2.0",
    packages=["quickquant", "quickquant.models", "quickquant.indicators", "quickquant.ml", "quickquant.data", "quickquant.utils"],
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: Apache Software License",
        "Operating System :: OS Independent",
    ],
)
