# MCTrade: A Trading Protocol for Market Contracs

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

In order to solve the above problems and provide a trading experience similar to traditional derivatives, inspired by Hydro Protocol, we 
build a novel smart contract called "MCTrade Protocol" on Ethereum.

## Solution

MCTrade build a trading platform that is very similar to traditional derivatives trarding platforms. MCTrade protocol encapsulates the 
minting, exchange and redeeming operations for position tokens and provides only two operations, Buy and Sell, for echo Market 
Protocol contract. 

Traders do all trading processes through Buy and Sell operations within MCTrade Protocol. If the trader expects the underlying asset
price to 
rise, he can enter the long position at the asset price by Buy operation. If the trader expects the underlying asset price to 
fall, the he can enter the short position by Sell operation. Besides, traders with long positions can decrease or close positions by 
Sell operation and traders with short positions can decrease or close positions by Buy operation. The trader only need to place order
on the price of the underlying asset. MCTrade will automatically calculate the position token price corresponding to the price of the
order.

A unified order book is maintained for each Market Protocol contract within MCTrade. All the orders in the order book are sorted by the 
bidding/asking prices of the underlying asset.

Orders on the different side of the order book can be matched. According to the positions of the two counterparties, there are 4 
different matching types. MCTrade smart contract performs different processes (exchange, minting or redeeming) for different match 
types:

| Trader A's Side | Trader A's Position | Trader B's Side  | Trader B's Position  | MCTrade smart contract process                 |
|-----------------|---------------------|------------------|----------------------|-------------------------------------------------|
| Buy             | Positive or Zero    |  Sell            |  Positive            | Transfer the long position token from B to A and transfer the collateral token from A to B |
| Buy             | Positive or Zero    |  Sell            |  Negative or Zero    | Mint a pair of position tokens from Market Protocol, send the long position token to A and the short position token to B |
| Buy             | Negative            |  Sell            |  Positive            | Redeem the pair of position tokens through Market Potocol and send the returned collateral tokens to A and B |
| Buy             | Negative            |  Sell            |  Positive or Zero    | Mint a pair of position tokens from Market Protocol, send the long position token to A and the short position token to B |

*"Positive" means the trader has long position tokens. "Negative" means the trader has short position tokens. "Zero" means the trader
has no position token.*

When trading frequently, the position tokens may be redeemed immediately after be minted. In order to smooth this process and reduce 
unnecessary minting and redeeming, a minting pool is set within MCTrade Protocol. Some position tokens are reserved in advance in the
mint pool. When minting is required, the tokens are feteched from the pool first. Only when the pool is insufficient, the tokens will be 
minted from Market Protocol. When redeeming is required, the tokens are put to the pool first. Only when the pool is full, the tokens 
will be redeemed through Market Protocol.

## Architecture
