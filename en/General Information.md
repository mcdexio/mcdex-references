# General Information

## Introduction
Currently, MCDEX Perpetual has two trading pages:

- **Order Book**(order book trading)
- **AMM (Automatic Market Maker)**- AMM acts as a counterparty

MCDEX Perpetual features funding payments to soft-peg the price of the perpetual contract to the ETH price.

If Perpetual trades higher than the Index price, the long position holders make a funding payment to the short position holders. This increases the holding cost for long position holders because of which they eventually execute sell orders thereby pushing the Perpetual price down towards the Index price.

Similarly, If Perpetual trades lower than the Index price, the short position holders make a funding payment to the long position holders. This increases the holding cost for short position holders because of which they eventually execute buy orders thereby pushing the Perpetual price up towards the Index price.

MCDEX Perpetual continuously measures the difference between Mark Price of the Perpetual contract and Chainlink’s ETH/USD Index. The percentage difference between these two prices acts as the basis for the 8-hourly funding rate applied to all outstanding perpetual contracts.

Funding payments are automatically calculated every second and are added to or subtracted from the available trading balance in your realized PNL account (which is also part of your available trading balance). You can withdraw your realized PNL balance from your Margin account at any time.

## Types of Orders
**Market Order**
This type of orders matched by the best possible price (market price) at the current instant. Market orders are immediately filled.

**Limit Order**
This type of order is matched when the market price reaches the limit price set by the user. Abuy order is associated with a maximum limit (buy) price which means that the order will not be matched above the buy limit price. A sell order is associated with a minimum limit (sell) price which means that the order will not be matched below the sell limit price.

## Fee
**MP Futures**

- Makers: 0.02%
- Takers: 0.07%

**Perpetual contracts**
- Trading Fees: -0.025% for makers and 0.075% for takers.
- Gas Fees: NIL (Gas costs for alltrades are completely covered by MCDEX)
- Deposits and Withdrawals: No fees associated with depositsand withdrawals on MCDEX. However, the user is responsible for the gas costs of deposit and withdrawal transactions.

