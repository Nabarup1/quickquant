# QuickQuant

QuickQuant is a high-performance quantitative finance library that provides a comprehensive set of financial models, technical indicators, and plotting functionalities using Cython for speed optimization.

## Features

- **Financial Models**: Merton Model, Black-Scholes Model, Heston Model.
- **Technical Indicators**: SMA, EMA, Bollinger Bands, ADX, Stochastic Oscillator, Ichimoku Cloud, Volume Profile, VWMA.
- **Plotting Functionalities**: Candle charts, various financial plots.

## Installation

To install QuickQuant, follow these steps:

1. Ensure you have Python 3.x installed.
2. Install QuickQuant via pip:

    ```bash
    pip install quickquant
    ```

## Usage

Here's how you can use the various components provided by QuickQuant:

### Financial Models

#### Merton Model

The Merton Model is used to assess the credit risk of a company's debt. The value of the company's equity is viewed as a call option on its assets.

**Parameters:**
- `V0`: Initial value of the company's assets
- `D`: Face value of the company's debt
- `T`: Time to maturity (in years)
- `r`: Risk-free interest rate
- `sigma`: Volatility of the company's asset value

**Example:**

```python
from quickquant.models.merton_model import merton_model

V0 = 100.0
D = 80.0
T = 1.0
r = 0.05
sigma = 0.2

equity_value, P_default = merton_model(V0, D, T, r, sigma)

print(f"Equity Value: {equity_value}")
print(f"Probability of Default: {P_default}")
```

#### Black-Scholes Model

The Black-Scholes Model is used for pricing European call and put options.

**Parameters:**
- `S`: Current stock price
- `K`: Strike price
- `T`: Time to maturity (in years)
- `r`: Risk-free interest rate
- `sigma`: Volatility of the stock

**Example:**

```python
from quickquant.models.black_scholes_model import black_scholes

S = 100.0
K = 95.0
T = 1.0
r = 0.05
sigma = 0.2

call_price, put_price = black_scholes(S, K, T, r, sigma)

print(f"Call Option Price: {call_price}")
print(f"Put Option Price: {put_price}")
```

#### Heston Model

The Heston Model is used for pricing options with stochastic volatility.

**Parameters:**
- `S`: Current stock price
- `K`: Strike price
- `T`: Time to maturity (in years)
- `r`: Risk-free interest rate
- `kappa`: Rate at which volatility reverts to the long-term mean
- `theta`: Long-term mean of the volatility
- `sigma`: Volatility of the volatility
- `rho`: Correlation between the asset price and its volatility
- `v0`: Initial variance

**Example:**

```python
from quickquant.models.heston_model import heston_model

S = 100.0
K = 95.0
T = 1.0
r = 0.05
kappa = 2.0
theta = 0.02
sigma = 0.2
rho = -0.5
v0 = 0.04

call_price, put_price = heston_model(S, K, T, r, kappa, theta, sigma, rho, v0)

print(f"Call Option Price: {call_price}")
print(f"Put Option Price: {put_price}")
```

### Technical Indicators

#### Simple Moving Average (SMA)

The Simple Moving Average is calculated by taking the arithmetic mean of a given set of values over a specified period.

**Example:**

```python
from quickquant.indicators import sma

sma_values = sma(data['close'], period=20)
print(sma_values)
```

#### Exponential Moving Average (EMA)

The Exponential Moving Average gives more weight to recent prices to reduce lag.

**Example:**

```python
from quickquant.indicators import ema

ema_values = ema(data['close'], period=20)
print(ema_values)
```

#### Bollinger Bands

Bollinger Bands consist of a middle band (SMA) and two outer bands at a distance of \( k \) standard deviations.

**Example:**

```python
from quickquant.indicators import bollinger_bands

upper_band, middle_band, lower_band = bollinger_bands(data['close'], period=20, num_std=2)
print(upper_band, middle_band, lower_band)
```

#### Average Directional Index (ADX)

The ADX measures the strength of a trend.

**Example:**

```python
from quickquant.indicators import adx

adx_values = adx(data['high'], data['low'], data['close'], period=14)
print(adx_values)
```

#### Stochastic Oscillator

The Stochastic Oscillator compares a particular closing price of a security to a range of its prices over a certain period.

**Example:**

```python
from quickquant.indicators import stochastic

stochastic_values = stochastic(data['high'], data['low'], data['close'], period=14)
print(stochastic_values)
```

#### Ichimoku Cloud

The Ichimoku Cloud is a collection of indicators that show support and resistance levels, as well as momentum and trend direction.

**Example:**

```python
from quickquant.indicators import ichimoku

tenkan_sen, kijun_sen, senkou_span_a, senkou_span_b, chikou_span = ichimoku(data['high'], data['low'], data['close'])
print(tenkan_sen, kijun_sen, senkou_span_a, senkou_span_b, chikou_span)
```

#### Volume Profile

The Volume Profile shows the distribution of volume over price levels.

**Example:**

```python
from quickquant.indicators import volume_profile

volume_profile_values = volume_profile(data['close'], data['volume'])
print(volume_profile_values)
```

#### Volume Weighted Moving Average (VWMA)

The VWMA weights the moving average by volume.

**Example:**

```python
from quickquant.indicators import vwma

vwma_values = vwma(data['close'], data['volume'], period=20)
print(vwma_values)
```

### Plotting Functionalities

#### Candle Chart

The candle chart is used to visualize price movements of an asset over time.

**Example:**

```python
from quickquant.plotting.candle_chart import plot_candle_chart

plot_candle_chart(data['open'], data['high'], data['low'], data['close'], data['volume'])
```

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request.

## License

QuickQuant is licensed under the Apache License 2.0. See the `LICENSE` file for more details.

## Contact

For any questions or suggestions, feel free to contact the author.
Nabarup Ghosh
nabarupeducation@gmail.com
```
