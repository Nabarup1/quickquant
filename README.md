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
### **Models**

#### 1. **American Binomial Model**

The American Binomial Model is used to price American options, which can be exercised at any time before expiration. The model uses a binomial tree to represent possible price movements of the underlying asset over time.

- **Parameters**:
  - `S`: Current stock price
  - `K`: Strike price
  - `T`: Time to maturity (in years)
  - `r`: Risk-free interest rate
  - `sigma`: Volatility of the stock
  - `n`: Number of time steps

- **Formula**:
  The model calculates the price of an American option by creating a binomial tree and recursively calculating the option's value at each node. The option value at each node depends on whether the option is exercised early or held until later.

- **Usage Example**:
  ```python
  from quickquant.models.american_binomial import american_binomial

  S = 100.0
  K = 95.0
  T = 1.0
  r = 0.05
  sigma = 0.2
  n = 100

  call_price, put_price = american_binomial(S, K, T, r, sigma, n)

  print(f"American Call Option Price: {call_price}")
  print(f"American Put Option Price: {put_price}")
  ```

#### 2. **American Finite Difference Model**

The American Finite Difference Model is another method for pricing American options. It uses a finite difference approach to solve the partial differential equations governing the option's price.

- **Parameters**:
  - `S`: Current stock price
  - `K`: Strike price
  - `T`: Time to maturity (in years)
  - `r`: Risk-free interest rate
  - `sigma`: Volatility of the stock
  - `M`: Number of time steps

- **Formula**:
  The finite difference method discretizes the option's value function and solves the resulting system of equations using numerical methods. It accounts for the possibility of early exercise by including a free boundary condition.

- **Usage Example**:
  ```python
  from quickquant.models.american_finite_difference import american_fd

  S = 100.0
  K = 95.0
  T = 1.0
  r = 0.05
  sigma = 0.2
  M = 100

  call_price, put_price = american_fd(S, K, T, r, sigma, M)

  print(f"American Call Option Price (FD): {call_price}")
  print(f"American Put Option Price (FD): {put_price}")
  ```

#### 3. **American Trinomial Model**

The American Trinomial Model is an extension of the binomial model, using a trinomial tree that considers three possible price movements (up, down, and unchanged) at each time step.

- **Parameters**:
  - `S`: Current stock price
  - `K`: Strike price
  - `T`: Time to maturity (in years)
  - `r`: Risk-free interest rate
  - `sigma`: Volatility of the stock
  - `n`: Number of time steps

- **Formula**:
  Similar to the binomial model, the trinomial model constructs a tree, but with three branches from each node. This model can provide more accurate pricing by better approximating the continuous nature of stock prices.

- **Usage Example**:
  ```python
  from quickquant.models.american_trinomial import american_trinomial

  S = 100.0
  K = 95.0
  T = 1.0
  r = 0.05
  sigma = 0.2
  n = 100

  call_price, put_price = american_trinomial(S, K, T, r, sigma, n)

  print(f"American Call Option Price (Trinomial): {call_price}")
  print(f"American Put Option Price (Trinomial): {put_price}")
  ```

#### 4. **Asian Options**

Asian options are exotic options where the payoff depends on the average price of the underlying asset over a certain period, rather than the price at maturity. This averaging feature can reduce the option's volatility and, consequently, its price.

- **Parameters**:
  - `S`: Current stock price
  - `K`: Strike price
  - `T`: Time to maturity (in years)
  - `r`: Risk-free interest rate
  - `sigma`: Volatility of the stock
  - `n`: Number of time steps

- **Formula**:
  The model calculates the average price of the underlying asset over a specific period and uses this average in the payoff function. The pricing can be done using Monte Carlo simulations or analytical approximations.

- **Usage Example**:
  ```python
  from quickquant.models.asian_options import asian_option

  S = 100.0
  K = 95.0
  T = 1.0
  r = 0.05
  sigma = 0.2
  n = 100

  call_price, put_price = asian_option(S, K, T, r, sigma, n)

  print(f"Asian Call Option Price: {call_price}")
  print(f"Asian Put Option Price: {put_price}")
  ```

#### 5. **Barrier Options**

Barrier options are path-dependent options where the payoff depends on whether the underlying asset's price reaches a certain barrier level during the option's life.

- **Parameters**:
  - `S`: Current stock price
  - `K`: Strike price
  - `T`: Time to maturity (in years)
  - `r`: Risk-free interest rate
  - `sigma`: Volatility of the stock
  - `B`: Barrier level
  - `option_type`: Type of option (e.g., "up-and-out", "down-and-in")

- **Formula**:
  The option's payoff depends on whether the asset price breaches the barrier level. The pricing can be done using closed-form solutions or numerical methods, depending on the complexity of the barrier condition.

- **Usage Example**:
  ```python
  from quickquant.models.barrier_options import barrier_option

  S = 100.0
  K = 95.0
  T = 1.0
  r = 0.05
  sigma = 0.2
  B = 110.0
  option_type = "up-and-out"

  option_price = barrier_option(S, K, T, r, sigma, B, option_type)

  print(f"Barrier Option Price: {option_price}")
  ```

#### 6. **Black-Cox Model**

The Black-Cox Model is a structural model for credit risk that extends the Merton model by incorporating a barrier level at which default occurs. It is used to price defaultable bonds and credit derivatives.

- **Parameters**:
  - `V0`: Initial value of the firm's assets
  - `D`: Face value of the firm's debt
  - `T`: Time to maturity (in years)
  - `r`: Risk-free interest rate
  - `sigma`: Volatility of the firm's asset value
  - `B`: Default barrier

- **Formula**:
  The model considers the firm's equity as a down-and-out call option on the firm's assets. If the asset value hits the barrier \( B \), the firm defaults.

- **Usage Example**:
  ```python
  from quickquant.models.black_cox import black_cox

  V0 = 100.0
  D = 80.0
  T = 1.0
  r = 0.05
  sigma = 0.2
  B = 70.0

  equity_value, P_default = black_cox(V0, D, T, r, sigma, B)

  print(f"Equity Value: {equity_value}")
  print(f"Probability of Default: {P_default}")
  ```

#### 7. **Black-Litterman Model**

The Black-Litterman Model is a portfolio optimization model that combines the investor's views with the market equilibrium to derive expected returns. It is used to overcome the issues of the traditional Markowitz model, such as extreme weights and sensitivity to input parameters.

- **Parameters**:
  - `P`: Matrix representing the investor's views
  - `Q`: Vector representing the expected returns according to the investor's views
  - `tau`: Scalar that controls the uncertainty of the prior estimate of returns
  - `omega`: Covariance matrix of the error term in the investor's views
  - `sigma`: Covariance matrix of the market returns

- **Formula**:
  The model adjusts the market equilibrium returns by incorporating the investor's views, resulting in a set of expected returns that blend market information and subjective views.

- **Usage Example**:
  ```python
  from quickquant.models.black_litterman import black_litterman

  P = [[1, 0, -1], [0, 1, -1]]
  Q = [0.05, 0.03]
  tau = 0.05
  omega = [[0.0001, 0], [0, 0.0001]]
  sigma = [[0.0004, 0.0001, 0.0002], [0.0001, 0.

0003, 0.0001], [0.0002, 0.0001, 0.0004]]

  expected_returns = black_litterman(P, Q, tau, omega, sigma)

  print(f"Expected Returns: {expected_returns}")
  ```

#### 8. **Black-Scholes Model**

The Black-Scholes Model is a mathematical model used for pricing European options. It assumes that the underlying asset's price follows a geometric Brownian motion with constant volatility and interest rate.

- **Parameters**:
  - `S`: Current stock price
  - `K`: Strike price
  - `T`: Time to maturity (in years)
  - `r`: Risk-free interest rate
  - `sigma`: Volatility of the stock

- **Formula**:
  The Black-Scholes formula for a call option is:
  \[ C = S_0 \Phi(d_1) - K e^{-rT} \Phi(d_2) \]
  where:
  \[ d_1 = \frac{\ln(S_0/K) + (r + \sigma^2/2)T}{\sigma \sqrt{T}} \]
  \[ d_2 = d_1 - \sigma \sqrt{T} \]
  and \(\Phi\) is the cumulative distribution function of the standard normal distribution.

- **Usage Example**:
  ```python
  from quickquant.models.black_scholes import black_scholes

  S = 100.0
  K = 95.0
  T = 1.0
  r = 0.05
  sigma = 0.2

  call_price, put_price = black_scholes(S, K, T, r, sigma)

  print(f"European Call Option Price: {call_price}")
  print(f"European Put Option Price: {put_price}")
  ```

#### 9. **Cox-Ingersoll-Ross (CIR) Model**

The CIR Model is used to model the evolution of interest rates over time. It assumes that the interest rate follows a mean-reverting square root process.

- **Parameters**:
  - `r0`: Initial interest rate
  - `alpha`: Speed of reversion
  - `b`: Long-term mean level
  - `sigma`: Volatility
  - `T`: Time to maturity

- **Formula**:
  The CIR model is defined by the stochastic differential equation:
  \[ dr_t = \alpha (b - r_t) dt + \sigma \sqrt{r_t} dW_t \]
  where \( \alpha \) is the speed of mean reversion, \( b \) is the long-term mean, \( \sigma \) is the volatility, and \( W_t \) is a Wiener process.

- **Usage Example**:
  ```python
  from quickquant.models.cir import cir

  r0 = 0.03
  alpha = 0.1
  b = 0.04
  sigma = 0.02
  T = 1

  interest_rate_path = cir(r0, alpha, b, sigma, T)

  print(f"Interest Rate Path (CIR): {interest_rate_path}")
  ```

#### 10. **Merton Model**

The Merton Model extends the Black-Scholes model by incorporating a firm's capital structure and default risk. It is used to value corporate debt and equity by treating the firm's equity as a call option on its assets.

- **Parameters**:
  - `V0`: Initial value of the firm's assets
  - `D`: Face value of the firm's debt
  - `T`: Time to maturity
  - `r`: Risk-free interest rate
  - `sigma`: Volatility of the firm's asset value

- **Formula**:
  The equity value \( E \) is given by:
  \[ E = V_0 \Phi(d_1) - D e^{-rT} \Phi(d_2) \]
  where:
  \[ d_1 = \frac{\ln(V_0/D) + (r + \sigma^2/2)T}{\sigma \sqrt{T}} \]
  \[ d_2 = d_1 - \sigma \sqrt{T} \]

- **Usage Example**:
  ```python
  from quickquant.models.merton import merton

  V0 = 1000.0
  D = 800.0
  T = 1.0
  r = 0.05
  sigma = 0.2

  equity_value = merton(V0, D, T, r, sigma)

  print(f"Equity Value (Merton):

 {equity_value}")
  ```

#### 11. **CreditMetrics**

The CreditMetrics model is used to assess the credit risk of a portfolio of credit-sensitive instruments, such as bonds or loans. It evaluates the risk by estimating the potential changes in the credit quality of the portfolio's constituents over time.

- **Parameters**:
  - `portfolio`: List of credit instruments
  - `credit_transition_matrix`: Probability matrix of credit rating transitions
  - `correlation_matrix`: Correlation of credit migrations
  - `exposure`: Exposure amount for each instrument
  - `recovery_rate`: Recovery rate upon default

- **Usage Example**:
  ```python
  from quickquant.models.creditmetrics import creditmetrics

  portfolio = [...]
  credit_transition_matrix = [...]
  correlation_matrix = [...]
  exposure = [...]
  recovery_rate = 0.4

  credit_risk_value = creditmetrics(portfolio, credit_transition_matrix, correlation_matrix, exposure, recovery_rate)

  print(f"Credit Risk Value: {credit_risk_value}")
  ```

#### 12. **Heston Model**

The Heston Model is a stochastic volatility model used for option pricing. It assumes that the volatility of the asset is a random process, leading to a more accurate representation of market conditions than constant volatility models.

- **Parameters**:
  - `S`: Current stock price
  - `K`: Strike price
  - `T`: Time to maturity
  - `r`: Risk-free interest rate
  - `kappa`: Rate of mean reversion
  - `theta`: Long-term variance
  - `sigma`: Volatility of variance
  - `rho`: Correlation between asset returns and variance
  - `v0`: Initial variance

- **Usage Example**:
  ```python
  from quickquant.models.heston import heston

  S = 100.0
  K = 95.0
  T = 1.0
  r = 0.05
  kappa = 2.0
  theta = 0.02
  sigma = 0.2
  rho = -0.5
  v0 = 0.04

  call_price, put_price = heston(S, K, T, r, kappa, theta, sigma, rho, v0)

  print(f"Call Option Price (Heston): {call_price}")
  print(f"Put Option Price (Heston): {put_price}")
  ```

#### 13. **Hull-White Model**

The Hull-White model is a short-rate model used to price interest rate derivatives. It is an extension of the Vasicek model that includes a time-dependent mean reversion level, allowing it to fit the initial term structure of interest rates perfectly.

- **Parameters**:
  - `r0`: Initial short rate
  - `alpha`: Speed of mean reversion
  - `sigma`: Volatility
  - `T`: Time to maturity

- **Formula**:
  \[ dr(t) = (\theta(t) - \alpha r(t)) dt + \sigma dW(t) \]

- **Usage Example**:
  ```python
  from quickquant.models.hull_white import hull_white

  r0 = 0.03
  alpha = 0.1
  sigma = 0.02
  T = 1

  short_rate_path = hull_white(r0, alpha, sigma, T)

  print(f"Short Rate Path (Hull-White): {short_rate_path}")
  ```

#### 14. **Kalman Filter**

The Kalman Filter is an algorithm that uses a series of measurements observed over time, containing noise, to produce estimates of unknown variables. It is widely used in time series analysis and control systems.

- **Parameters**:
  - `initial_state`: Initial state estimate
  - `initial_covariance`: Initial covariance estimate
  - `transition_matrix`: State transition matrix
  - `observation_matrix`: Observation matrix
  - `process_covariance`: Covariance of the process noise
  - `observation_covariance`: Covariance of the observation noise

- **Usage Example**:
  ```python
  from quickquant.models.kalman_filter import kalman_filter

  initial_state = [0.0, 0.0]
  initial_covariance = [[1.0, 0.0], [0.0, 1.0]]
  transition_matrix = [[1.0, 0.0], [0.0, 1.0]]
  observation_matrix = [[1.0, 0.0], [0.0, 1.0]]
  process_covariance = [[0.1, 0.0], [0.0, 0.1]]
  observation_covariance = [[0.01, 0.0], [0.0, 0.01]]

  states, covariances = kalman_filter(initial_state, initial_covariance, transition_matrix, observation_matrix, process_covariance, observation_covariance)

  print(f"Estimated States: {states}")
  print(f"Covariances: {covariances}")
  ```

#### 15. **Lookback Options**

Lookback options are a type of exotic option that allow the holder to "look back" over time and determine the payoff based on the optimal price of the underlying asset.

- **Parameters**:
  - `S`: Current stock price
  - `K`: Strike price
  - `T`: Time to maturity
  - `r`: Risk-free interest rate
  - `sigma`: Volatility of the stock
  - `option_type`: Type of option ("call" or "put")

- **Usage Example**:
  ```python
  from quickquant.models.lookback_options import lookback_option

  S = 100.0
  K = 95.0
  T = 1.0
  r = 0.05
  sigma = 0.2
  option_type = "call"

  lookback_price = lookback_option(S, K, T, r, sigma, option_type)

  print(f"Lookback Option Price: {lookback_price}")
  ```

#### 16. **Markowitz Model**

The Markowitz Model, also known as Modern Portfolio Theory (MPT), is a framework for constructing an investment portfolio that maximizes expected return for a given level of risk.

- **Parameters**:
  - `expected_returns`: Expected returns of the assets
  - `cov_matrix`: Covariance matrix of asset returns
  - `risk_free_rate`: Risk-free rate

- **Usage Example**:
  ```python
  from quickquant.models.markowitz import markowitz

  expected_returns = [0.1, 0.15, 0.12]
  cov_matrix = [[0.005, -0.010, 0.004], [-0.010, 0.040, -0.002], [0.004, -0.002, 0.023]]
  risk_free_rate = 0.03

  optimal_weights = markowitz(expected_returns, cov_matrix, risk_free_rate)

  print(f"Optimal Weights (Markowitz): {optimal_weights}")
  ```

#### 17. **Risk Parity**

Risk Parity is an investment strategy that focuses on allocating risk equally across different assets, rather than allocating capital. The goal is to achieve a more balanced risk profile in the portfolio.

- **Parameters**:
  - `expected_returns`: Expected returns of the assets
  - `cov_matrix`: Covariance matrix of asset returns

- **Usage Example**:
  ```python
  from quickquant.models.risk_parity import risk_parity

  expected_returns = [0.1, 0.15, 0.12]
  cov_matrix = [[0.005, -0.010, 0.004], [-0.010, 0.040, -0.002], [0.004, -0.002, 0.023]]

  risk_parity_weights = risk_parity(expected_returns, cov_matrix)

  print(f"Risk Parity Weights: {risk_parity_weights}")
  ```

#### 18. **Swaptions**

Swaptions are options on interest rate swaps. There are two main types of swaptions: payer swaptions, which give the holder the right to enter into a swap as the fixed-rate payer, and receiver swaptions, which give the holder the right to enter into a swap as the fixed-rate receiver.

- **Parameters**:
- 'S0': Initial swap rate
- 'K': Strike swap rate
- 'T': Time to maturity (in years)
- 'r': Risk-free interest rate
- 'sigma': Volatility of the swap rate
- 'swap_rate': Swap rate
- 'option_type': Type of swaption ('payer' or 'receiver')

- **Formula**:
The Black's model formula for swaption pricing is used here:

\[ d1 = \frac{\log(\frac{S0}{K}) + (r + 0.5 \sigma^2) T}{\sigma \sqrt{T}} \]
\[ d2 = d1 - \sigma \sqrt{T} \]

For a payer swaption:
\[ \text{price} = S0 \cdot N(d1) - K \cdot e^{-rT} \cdot N(d2) \]

For a receiver swaption:
\[ \text{price} = K \cdot e^{-rT} \cdot N(-d2) - S0 \cdot N(-d1) \]

Where \( N(\cdot) \) denotes the cumulative distribution function of the standard normal distribution.

- **Usage Example**:
```python
from quickquant.models.swaptions import swaption_price

S0 = 0.03
K = 0.025
T = 1.0
r = 0.01
sigma = 0.02
swap_rate = 0.03
option_type = 'payer'

price = swaption_price(S0, K, T, r, sigma, swap_rate, option_type)

print(f"Swaption Price: {price}")
```

#### 19. **Vasicek Model**

The Vasicek model is a mathematical model describing the evolution of interest rates. It assumes that interest rates follow a mean-reverting process, where rates tend to revert to a long-term average over time.

- **Parameters**:
- 'S0': Initial interest rate
- 'K': Strike rate
- 'T': Time to maturity (in years)
- 'r': Risk-free interest rate
- 'sigma': Volatility of the interest rate
- 'a': Speed of mean reversion
- 'b': Long-term mean level

- **Formula**:
The short rate \( r(t) \) in the Vasicek model is given by the stochastic differential equation:

\[ dr(t) = a(b - r(t))dt + \sigma dW(t) \]

Where:
- \( a \) is the speed of mean reversion
- \( b \) is the long-term mean level
- \( \sigma \) is the volatility
- \( W(t) \) is a Wiener process

The price of a zero-coupon bond in the Vasicek model can be computed using:

\[ B(t,T) = \frac{1 - e^{-a(T-t)}}{a} \]
\[ A(t,T) = \exp \left( (B(t,T) - (T-t)) \left( \frac{a^2b - 0.5\sigma^2}{a^2} \right) - \frac{\sigma^2 B(t,T)^2}{4a} \right) \]

The bond price \( P(t,T) \) is then:

\[ P(t,T) = A(t,T) \exp(-B(t,T)r(t)) \]

- **Usage Example**:
```python
from quickquant.models.vasicek_model import vasicek_model

S0 = 0.03
K = 0.025
T = 1.0
r = 0.01
sigma = 0.02
a = 0.1
b = 0.05

price = vasicek_model(S0, K, T, r, sigma, a, b)

print(f"Vasicek Model Price: {price}")
```

### Technical Indicators

#### 1. **Simple Moving Average (SMA)**
The Simple Moving Average is calculated by taking the arithmetic mean of a given set of values over a specified period.

- **Formula**:
  \[ \text{SMA} = \frac{1}{n} \sum_{i=1}^{n} P_i \]
  where \( n \) is the number of periods, and \( P_i \) is the price at period \( i \).

- **Usage Example**:
  ```python
  from quickquant.indicators import sma

  sma_values = sma(data['close'], period=20)
  print(sma_values)
  ```

#### 2. **Exponential Moving Average (EMA)**
The Exponential Moving Average gives more weight to recent prices to reduce lag.

- **Formula**:
  \[ \text{EMA} = \text{Price}_{\text{today}} \times k + \text{EMA}_{\text{yesterday}} \times (1 - k) \]
  where \( k = \frac{2}{n + 1} \) and \( n \) is the number of periods.

- **Usage Example**:
  ```python
  from quickquant.indicators import ema

  ema_values = ema(data['close'], period=20)
  print(ema_values)
  ```

#### 3. **Bollinger Bands**
Bollinger Bands consist of a middle band (SMA) and two outer bands at a distance of \( k \) standard deviations.

- **Formula**:
  - **Upper Band**: \( \text{SMA} + k \times \text{StdDev} \)
  - **Lower Band**: \( \text{SMA} - k \times \text{StdDev} \)

- **Usage Example**:
  ```python
  from quickquant.indicators import bollinger_bands

  upper_band, middle_band, lower_band = bollinger_bands(data['close'], period=20, num_std=2)
  print(upper_band, middle_band, lower_band)
  ```

#### 4. **Average Directional Index (ADX)**
The ADX measures the strength of a trend.

- **Formula**:
  ADX is derived from the Positive Directional Index (+DI) and the Negative Directional Index (-DI), which measure the strength of positive and negative trends, respectively.

- **Usage Example**:
  ```python
  from quickquant.indicators import adx

  adx_values = adx(data['high'], data['low'], data['close'], period=14)
  print(adx_values)
  ```

#### 5. **Stochastic Oscillator**
The Stochastic Oscillator compares a particular closing price of a security to a range of its prices over a certain period.

- **Formula**:
  \[ \%K = \frac{(C - L_{14})}{(H_{14} - L_{14})} \times 100 \]
  \[ \%D = \text{SMA}(\%K) \]
  where \( C \) is the most recent closing price, \( L_{14} \) is the lowest price over the last 14 periods, and \( H_{14} \) is the highest price over the last 14 periods.

- **Usage Example**:
  ```python
  from quickquant.indicators import stochastic

  stochastic_values = stochastic(data['high'], data['low'], data['close'], period=14)
  print(stochastic_values)
  ```


#### 6. **Ichimoku Cloud **
The Ichimoku Cloud comprises several lines that indicate various aspects of the market.

- **Components**:
  - **Tenkan-sen (Conversion Line)**: Average of the highest high and lowest low over the last 9 periods.
    \[ \text{Tenkan-sen} = \frac{\text{Highest High} + \text{Lowest Low}}{2} \]
  - **Kijun-sen (Base Line)**: Average of the highest high and lowest low over the last 26 periods.
    \[ \text{Kijun-sen} = \frac{\text{Highest High} + \text{Lowest Low}}{2} \]
  - **Senkou Span A (Leading Span A)**: Average of the Tenkan-sen and Kijun-sen, plotted 26 periods ahead.
    \[ \text{Senkou Span A} = \frac{\text{Tenkan-sen} + \text{Kijun-sen}}{2} \]
  - **Senkou Span B (Leading Span B)**: Average of the highest high and lowest low over the last 52 periods, plotted 26 periods ahead.
    \[ \text{Senkou Span B} = \frac{\text{Highest High} + \text{Lowest Low}}{2} \]
  - **Chikou Span (Lagging Span)**: The closing price plotted 26 periods in the past.

- **Usage Example**:
  ```python
  from quickquant.indicators import ichimoku

  tenkan_sen, kijun_sen, senkou_span_a, senkou_span_b, chikou_span = ichimoku(data['high'], data['low'], data['close'])
  print(tenkan_sen, kijun_sen, senkou_span_a, senkou_span_b, chikou_span)
  ```

#### 7. **Volume Profile**
Volume Profile displays the distribution of volume over various price levels.

- **Formula**: 
  Volume Profile calculates the total volume traded at each price level during a specified period.

- **Usage Example**:
  ```python
  from quickquant.indicators import volume_profile

  volume_profile_values = volume_profile(data['close'], data['volume'])
  print(volume_profile_values)
  ```

#### 8. **Volume Weighted Moving Average (VWMA)**
VWMA places more weight on prices with higher volume, providing a more accurate picture of price movements.

- **Formula**:
  \[ \text{VWMA} = \frac{\sum (P_i \times V_i)}{\sum V_i} \]
  where \( P_i \) and \( V_i \) are the price and volume at period \( i \), respectively.

- **Usage Example**:
  ```python
  from quickquant.indicators import vwma

  vwma_values = vwma(data['close'], data['volume'], period=20)
  print(vwma_values)
  ```

---

#### 9. **ATR (Average True Range)**

The Average True Range (ATR) is a technical analysis indicator that measures market volatility by decomposing the entire range of an asset price for a given period. The ATR is typically used to measure the volatility of a stock or market index.

- **Parameters**:
- 'prices': List of historical prices (usually high, low, close prices)
- 'n': Number of periods to calculate the ATR

- **Formula**:
1. True Range (TR) is defined as the maximum of:
   - Current high minus current low
   - Absolute value of current high minus previous close
   - Absolute value of current low minus previous close

\[ TR_t = \max (H_t - L_t, |H_t - C_{t-1}|, |L_t - C_{t-1}|) \]

2. Average True Range (ATR) is then calculated as the moving average of the True Range over \( n \) periods.

\[ ATR_t = \frac{1}{n} \sum_{i=t-n+1}^{t} TR_i \]

- **Usage Example**:
```python
from quickquant.models.atr import average_true_range

prices = [
    {"high": 120, "low": 115, "close": 118},
    {"high": 122, "low": 116, "close": 121},
    {"high": 125, "low": 120, "close": 123},
    # Add more price data as needed
]
n = 14

atr_value = average_true_range(prices, n)

print(f"Average True Range (ATR): {atr_value}")
```

#### 10. **MACD (Moving Average Convergence Divergence)**

The Moving Average Convergence Divergence (MACD) is a trend-following momentum indicator that shows the relationship between two moving averages of an asset's price. The MACD is calculated by subtracting the 26-period Exponential Moving Average (EMA) from the 12-period EMA.

- **Parameters**:
- 'prices': List of historical closing prices
- 'short_period': Number of periods for the short-term EMA (typically 12)
- 'long_period': Number of periods for the long-term EMA (typically 26)
- 'signal_period': Number of periods for the signal line EMA (typically 9)

- **Formula**:
1. Calculate the short-term EMA:

\[ EMA_{\text{short}} = \text{EMA}_{12} \]

2. Calculate the long-term EMA:

\[ EMA_{\text{long}} = \text{EMA}_{26} \]

3. MACD line:

\[ MACD = EMA_{\text{short}} - EMA_{\text{long}} \]

4. Signal line:

\[ \text{Signal Line} = EMA_{\text{MACD}, 9} \]

- **Usage Example**:
```python
from quickquant.models.macd import macd

prices = [110, 112, 111, 115, 117, 120, 125, 130, 128, 127]
short_period = 12
long_period = 26
signal_period = 9

macd_line, signal_line, histogram = macd(prices, short_period, long_period, signal_period)

print(f"MACD Line: {macd_line}")
print(f"Signal Line: {signal_line}")
print(f"Histogram: {histogram}")
```

### 11. **RSI (Relative Strength Index)**

The Relative Strength Index (RSI) is a momentum oscillator that measures the speed and change of price movements. The RSI oscillates between 0 and 100 and is typically used to identify overbought or oversold conditions in an asset.

- **Parameters**:
- 'prices': List of historical closing prices
- 'n': Number of periods to calculate the RSI (typically 14)

- **Formula**:
1. Calculate the average gain and average loss over the period \( n \):
   - Average Gain:

\[ \text{Avg Gain} = \frac{1}{n} \sum_{i=1}^{n} \text{Gain}_i \]

   - Average Loss:

\[ \text{Avg Loss} = \frac{1}{n} \sum_{i=1}^{n} \text{Loss}_i \]

2. Calculate the Relative Strength (RS):

\[ RS = \frac{\text{Avg Gain}}{\text{Avg Loss}} \]

3. Calculate the RSI:

\[ RSI = 100 - \frac{100}{1 + RS} \]

- **Usage Example**:
```python
from quickquant.models.rsi import rsi

prices = [110, 112, 111, 115, 117, 120, 125, 130, 128, 127]
n = 14

rsi_value = rsi(prices, n)

print(f"Relative Strength Index (RSI): {rsi_value}")
```

### Plotting Functionalities
#### 1. **Candle Chart**
A candle chart visualizes the price movements of an asset over time. Each "candle" represents four key pieces of data: the open, high, low, and close prices for a specific time period.

- **Parameters**:
  - `open`: Array of opening prices
  - `high`: Array of high prices
  - `low`: Array of low prices
  - `close`: Array of closing prices
  - `volume`: Array of volumes (optional)

- **Usage Example**:
  ```python
  from quickquant.plotting.candle_chart import plot_candle_chart

  plot_candle_chart(data['open'], data['high'], data['low'], data['close'], data['volume'])
  ```

#### 2. **Line Chart**
A line chart is a simple way to display information as a series of data points connected by straight line segments. It's often used to visualize a time series.

- **Parameters**:
  - `data`: Array of data points to be plotted
  - `labels`: Array of labels for the x-axis (optional)

- **Usage Example**:
  ```python
  from quickquant.plotting.line_chart import plot_line_chart

  plot_line_chart(data['close'])
  ```

#### 3. **Heikin-Ashi Chart**
Heikin-Ashi charts are a variant of candlestick charts that use modified open-close data to filter out market noise.

- **Parameters**:
  - `open`: Array of opening prices
  - `high`: Array of high prices
  - `low`: Array of low prices
  - `close`: Array of closing prices

- **Usage Example**:
  ```python
  from quickquant.plotting.heikin_ashi import plot_heikin_ashi

  plot_heikin_ashi(data['open'], data['high'], data['low'], data['close'])
  ```

#### 4. **Bar Chart**
Bar charts represent price changes for a specified time interval as vertical bars.

- **Parameters**:
  - `open`: Array of opening prices
  - `high`: Array of high prices
  - `low`: Array of low prices
  - `close`: Array of closing prices

- **Usage Example**:
  ```python
  from quickquant.plotting.bar_chart import plot_bar_chart

  plot_bar_chart(data['open'], data['high'], data['low'], data['close'])
  ```

---
## Contributing

Contributions are welcome! Please fork the repository and submit a pull request.

## License

QuickQuant is licensed under the Apache License 2.0. See the `LICENSE` file for more details.

## Contact

For any questions or suggestions, feel free to contact the author.
Nabarup Ghosh
nabarupeducation@gmail.com
```
