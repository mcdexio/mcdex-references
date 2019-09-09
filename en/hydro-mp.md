# Mai: A Trading Protocol for Market Contracts

## Motivation

The [Market Protocol](market-protocol.md) provides a secure framework that supports decentralized issuance of index futures contracts. The positions of the contracts are fully tokenized through Market Protocol. The position tokens of Market Protocol are standard ERC20 tokens, and traders can trade the tokens within any exchange. However, the user experience of directly trading position tokens is abysmal. The reasons are as follows:

First, a long trader and a short trader can not make a deal directly. One of them needs to mint a pair of position tokens (consisting of long position token and short position token) and sell the token of the opposite direction to the counterparty to make the deal. For example, the long trader mint a pair of position tokens and sell the short position token to the short trader. Otherwise, to conclude the transaction, a market maker is needed to mint the position tokens.  The market sells the long position token to the long trader and sells the short position token to the short trader.

Second, the pricing of the position token is not intuitive. The value of the position token is the margin of the position rather than the value of the underlying asset. As a result,  traders need to convert the assert price to corresponding position token price with the price range (PRICE_FLOOR and PRICE_CAP):

```
Long Position Token Price = Asset Price - PRICE_FLOOR
Short Position Token Price = PRICE_CAP -  Asset Price
```

Third, traders need to deal with two kinds of position tokens (Long Position Token and Short Position Token), each of which has both buy and sell operations. It means that two order books are required to trade a Market Protocol's contract. It is very different from traditional derivatives trading, which makes traders confused.

To solve the above problems and provide a trading experience similar to traditional derivatives, inspired by Hydro Protocol, we build a new smart contract called "Mai Protocol" on Ethereum.

The name Mai comes from two Chinese characters "买," which means buy and "卖," which means sell. Using pinyin (the modern system for transliterating Chinese characters to Latin letters) "买" is spelled Mǎi and "卖" is spelled Mài.

## Solution

Mai Protocol builds a trading platform that is very similar to traditional derivatives trading platforms. Mai protocol encapsulates the minting, exchange and redeeming operations for position tokens and provides only two operations, Buy and Sell, for echo Market Protocol contract. 

Traders do all trading processes through Buy and Sell operations within Mai Protocol. If the trader expects the underlying asset price to rise, he can enter the long position at the asset price by Buy operation. If the trader expects the underlying asset price to fall, then he can enter the short position by Sell operation. Besides, traders with long positions can decrease or close positions by Sell operation, and traders with short positions can decrease or close positions by Buy operation. The trader only needs to place an order on the price of the underlying asset. Mai Protocol automatically calculates the position token price corresponding to the price of the order.

The Mai Protocol relayer maintains a unified order book for each Market Protocol contract. The order book sorts all the orders by the bidding/asking prices of the underlying asset.

The match engine can match the orders on the different side of the order book. According to the positions of the two counterparties, there are four different matching types. Mai Protocol smart contract performs different processes (exchange, minting, or redeeming) for different match types:

| Trader A's Side | Trader A's Position | Trader B's Side  | Trader B's Position  | Mai Protocol Smart Contract Process             |
|-----------------|---------------------|------------------|----------------------|-------------------------------------------------|
| Buy             | Positive or Zero    |  Sell            |  Positive            | Transfer the long position token from B to A and transfer the collateral token from A to B |
| Buy             | Positive or Zero    |  Sell            |  Negative or Zero    | Mint a pair of position tokens from Market Protocol, send the long position token to A and the short position token to B |
| Buy             | Negative            |  Sell            |  Positive            | Redeem the pair of position tokens through Market Protocol and send the returned collateral tokens to A and B |
| Buy             | Negative            |  Sell            |  Positive or Zero    | Mint a pair of position tokens from Market Protocol, send the long position token to A and the short position token to B |

*"Positive" means the trader has long position tokens. "Negative" means the trader has short position tokens. "Zero" means the trader has no position token.*

When trading frequently, the position tokens may be redeemed immediately after be minted. To reduce redundant minting and redeeming operations,  Mai Protocol builds a minting pool. The pool reserves some position tokens are in advance. When minting is required, the tokens are fetched from the pool first. Only when the pool is insufficient, Mai Protocol mints the tokens from Market Protocol. When redeeming is required, the tokens are put to the pool first. Only when the pool is full, Mai Protocol redeems the tokens through Market Protocol.

## Architecture
