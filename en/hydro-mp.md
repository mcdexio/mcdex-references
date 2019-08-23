# Hydro-MP

## Motivation

The [Market Protocol](market-protocol.md) provides a secure framework that supports decentralized issuance of index futures contracts. And the contracts'
positions are fully tokenized through Market Protocol. Although the position tokens are standard ERC20 tokens and can be traded within
any exchange that supports trading ERC20 tokens, the process of directly trading position tokens is very hard. The reasons are as follows:

First, a long trader and a short trader can not make a deal directly. One of them needs to mint a pair of position tokens (consisting of 
long position token and short position token) and sell the token of the opposite direction to the counterparty to make the deal. For 
example, the long trader mint a pair of position tokens and sell the short position position token to the short trader. Otherwise, in order to conclude the transaction, a third party (such as a market maker) need to mint the position tokens and sell the long position token to the long trader and sell the short position token to the short trader.

Second, the pricing of position token is not intuitive. Because the value of the position token is the margin of the position rather than
the value of the underlying assert, the trader need to convert the assert price to corresponding position token price with price range
(PRICE_FLOOR and PRICE_CAP):

```
Long Position Token Price = Asset Price - PRICE_FLOOR
Short Position Token Price = PRICE_CAP -  Asset Price
```

Third, traders need to deal with two kinds of position tokens (Long Position Token and Short Position Token),
each of which has both buy and sell operations. This also means that two order books are required to trade a Market
Protocol's contract. This is very different from traditional derivatives trading, which makes traders confused.

