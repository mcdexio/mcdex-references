# Fees

## Market Protocol Contracts

Fee is calculated as follows:


```
  Price Base = (Price Floor + Price Cap) * 0.5
  Maker Fee = Price Base * Quantity * Maker Fee Rate
  Taker Fee = Price Base * Quantity * Taker Fee Rate
```

| Maker Fee Rate | Taker Fee Rate |
|----------------|----------------|
|    0.2%        | 0.3%           |

For example, the Market Protocol Contract's price floor is 7000 DAI and price cap is 15000 DAI. Some taker buys 10 contracts from a maker.
The taker fee is `(7000+15000)*0.5*10*0.3% = 330 DAI` and the maker fee is `(7000+15000)*0.5*10*0.2% = 220 DAI`.
