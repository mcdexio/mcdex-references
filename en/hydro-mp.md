# Hydro-MP

## Motivation

The [Market Protocol](market-protocol.md) provides a secure framework that supports decentralized issuance of index futures contracts. 
And the positions of the contracts are fully tokenized through Market Protocol. Although the position tokens are standard ERC20 tokens 
and can be traded within any exchange that supports trading ERC20 tokens, the user experience of directly trading position tokens is very poor. The reasons are as follows:

First, a long trader and a short trader can not make a deal directly. One of them needs to mint a pair of position tokens (consisting of 
long position token and short position token) and sell the token of the opposite direction to the counterparty to make the deal. For 
example, the long trader mint a pair of position tokens and sell the short position position token to the short trader. Otherwise, in 
order to conclude the transaction, a third party (such as a market maker) need to mint the position tokens and sell the long position 
token to the long trader and sell the short position token to the short trader.

Second, the pricing of position token is not intuitive. Because the value of the position token is the margin of the position rather 
than the value of the underlying assert, the trader need to convert the assert price to corresponding position token price with price 
range (PRICE_FLOOR and PRICE_CAP):

```
Long Position Token Price = Asset Price - PRICE_FLOOR
Short Position Token Price = PRICE_CAP -  Asset Price
```

Third, traders need to deal with two kinds of position tokens (Long Position Token and Short Position Token),
each of which has both buy and sell operations. This also means that two order books are required to trade a Market
Protocol's contract. This is very different from traditional derivatives trading, which makes traders confused.

In order to solve the above problems and provide a trading experience similar to traditional derivatives, we design a new trading 
protocol called "Hydro-MP" based on [Hydro Protocol](https://hydroprotocol.io/).

## Solution

Hydro-MP build a trading platform that is very similar to traditional derivatives trarding platforms. Hydro-MP protocol encapsulates the 
minting, exchange and redeeming operations for position tokens and provides only two operations (Long and Short) for echo Market 
Protocol contract. 

Traders do all trading processes through Long and Short operations within Hydro-MP. If the trader expects the underlying asset price to 
rise, he can enter the long position at the asset price by Long operation. If the trader expects the underlying asset price to 
fall, the he can enter the short position by Short operation. Besides, traders with long positions can decrease or close positions by 
Short operation and traders with short positions can decrease or close positions by Long operation.

There are four types of orders, which are transparent to traders, inside Hydro-MP: 
- Buy "long position token" in collateral token: increase the long position
- Sell "long position token" for collateral token: decrease the long position
- Buy "short position token" in collateral token: increase the short position
- Sell "short position token" for collateral token: decrease the short position

At any time, the trader only needs to place an order to Long or Short the contract. Hydro-MP will automatically set the type of the 
order according to the type of operation and the position of the trader:

| Operation | Whether the trader has short position| Order Type                              |
|-----------|--------------------------------------|-----------------------------------------|
| Long      | No                                   |  Buy "long position token"              |
| Long      | Yes                                  |  Sell "short position token"            |

| Operation | Whether the trader has long position| Order Type                              |
|-----------|-------------------------------------|-----------------------------------------|
| Short     | No                                  |  Buy "short position token"             |
| Short     | Yes                                 |  Sell "long position token"             |

The trader only need to place order on the price of the underlying asset. Hydro-MP will automatically calculate the position token price
corresponding to the price of the order.

A unified order book is maintained for each Market Protocol contract within Hydro-MP. The orders buying "long position token" and the 
orders selling "short position token" are on the buy-side of the order book. The orders buying "short position token" and the orders 
selling "long position token" are on the sell-side of the order book. All the orders in the order book are sorted by the bidding/asking 
prices of the underlying asset.

Orders on the different side of the order book can be matched. Pairwise matching forms four match types. Hydro-MP performs different processes (exchange, minting or redeeming) for different match types:

| Part A                    | Part B                     | Hydro-MP process                                                     |
|---------------------------|----------------------------|----------------------------------------------------------------------|
| Buy "long position token" | Sell "long position token" |Send the long position token to A and the collateral token to B       |
| Buy "short position token"| Sell "short position token"|Send the short position token to A and the collateral token to B      |
| Buy "long position token" | Buy "short position token" |Mint a pair of position tokens from Market Protocol, send the long position token to A and the short position token to B|
| Sell "long position token"| Sell "short position token"|Redeem the pair of position tokens through Market Potocol and send the returned collateral tokens to A and B|

## Architecture
