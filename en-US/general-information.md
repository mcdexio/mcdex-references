# General Information

## Introduction
Monte Carlo Decentralized Exchange (MCDEX) is a decentralized derivatives exchange - a trading platform enabling efficient and transparent trading with leverages.

At present, there are two types of contracts live on MCDEX:

**MP Futures**
- MP Futures is an innovative financial tool with an expiration date. The leverage is set by the Cap and Floor price.
- It is a fully collateralized margin system with no margin calls. It means that the price above the Cap price is treated as the Cap price and the price below the Floor price is treated as the Floor price.

**Perpetual Contracts**
- Perpetual is a Futures contract but without an expiry date.
- The market price is soft-pegged to the spot price of the underlying asset via a funding mechanism.

## Types of Orders
**Market Order**

This type of orders matched by the best possible price (market price) at the current instant. Market orders are immediately filled.

**Limit Order**

This type of order is matched when the market price reaches the limit price set by the user. A buy order is associated with a maximum limit (buy) price which means that the order will not be matched above the buy limit price. A sell order is associated with a minimum limit (sell) price which means that the order will not be matched below the sell limit price.

## Fee
**MP Futures**

- Makers: 0.02%
- Takers: 0.07%

**Perpetual contracts**

Trade with order book:
- Trading Fees: 0% for makers and 0.15% for takers. 
- Small order (Quantity < 12000 USD) trading fees: 0% for makers and 1% for takers. 
- Gas Fees: NIL (Gas costs for all trades are completely covered by MCDEX)

Trade with AMM:
- trading Fees: 0.3% goes to the liquidity provider
- Gas Fees: Users will pay gas fees by themselves.

For Order book & AMM:
- Deposits and Withdrawals: No fees associated with deposits and withdrawals on MCDEX. However, the user is responsible for the gas costs of deposit and withdrawal transactions.
- Liquidations: Liquidations are charged a higher fee than normal. The surplus fees of liquidations will automatically fund the insurance fund. 7.5% penalty fee - 4.5% goes to the liquidator, 3% goes to the insurance fund.
