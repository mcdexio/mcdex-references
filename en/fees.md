# Fees

##  NO Gas Fee

All transactions on the Ethereum network cost gas, a fee that is paid to miners in order to process the transaction. Currently, MCDEX charge no gas fees.

We will reivew the fee structure in Sep. 2020.


## Market Protocol Contracts

The trading fee is calculated as follows:


```
  Price Base = (Price Floor + Price Cap) * 0.5
  Maker Fee = Price Base * Quantity * Maker Fee Rate
  Taker Fee = Price Base * Quantity * Taker Fee Rate
```

| Maker Fee Rate | Taker Fee Rate |
|----------------|----------------|
|      0.02%     |       0.07%    |



For example, the Market Protocol Contract's price floor is 7000 DAI and price cap is 15000 DAI. Some taker buys 10 contracts from a maker.
The taker fee is `(7000 + 15000) * 0.5 * 10 * 0.1% = 110 DAI` and the maker fee is `(7000 + 15000) * 0.5 * 10 * 0.05% = 55 DAI`.
