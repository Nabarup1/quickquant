# QuickQuant

QuickQuant is a high-performance quantitative finance library that provides implementations of the Merton Model, Black-Scholes Model, and Heston Model using Cython for speed optimization. 

## Features

- **Merton Model**: Structural credit risk model.
- **Black-Scholes Model**: European option pricing model.
- **Heston Model**: Stochastic volatility model for option pricing.

## Installation

To install QuickQuant, follow these steps:

1. Ensure you have Python 3.x installed.
2. Install QuickQuant via pip:

    ```bash
    pip install quickquant
    ```

## Usage

Here's how you can use the models provided by QuickQuant:

### Merton Model

The Merton Model is used to assess the credit risk of a company's debt. The value of the company's equity is viewed as a call option on its assets.

#### Parameters:
- `V0`: Initial value of the company's assets
- `D`: Face value of the company's debt
- `T`: Time to maturity (in years)
- `r`: Risk-free interest rate
- `sigma`: Volatility of the company's asset value

#### Example:

```python
from quickquant.merton_model import merton_model

V0 = 100.0
D = 80.0
T = 1.0
r = 0.05
sigma = 0.2

equity_value, P_default = merton_model(V0, D, T, r, sigma)

print(f"Equity Value: {equity_value}")
print(f"Probability of Default: {P_default}")
