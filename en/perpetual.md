# Perpetual Contract

## Introduction

MCDEX Perpetual is a derivative product similar to the Futures but without an expiry date. 

Currently, MCDEX Perpetual has two trading pages:

- **Order Book** (order book trading)
- **AMM (Automatic Market Maker)** - AMM acts as a counterparty

MCDEX Perpetual features funding payments to soft-peg the price of the perpetual contract to the ETH price. 

If Perpetual trades higher than the Index price, the long position holders make a funding payment to the short position holders. This increases the holding cost for long position holders because of which they eventually execute sell orders thereby pushing the Perpetual price down towards the Index price. 

Similarly, If Perpetual trades lower than the Index price, the short position holders make a funding payment to the long position holders. This increases the holding cost for short position holders because of which they eventually execute buy orders thereby pushing the Perpetual price up towards the Index price. 

MCDEX Perpetual continuously measures the difference between Mark Price of the Perpetual contract and Chainlink’s ETH/USD Index. The percentage difference between these two prices acts as the basis for the 8-hourly funding rate applied to all outstanding perpetual contracts.

Funding payments are automatically calculated every second and are added to or subtracted from the available trading balance in your realized PNL account (which is also part of your available trading balance). You can withdraw your realized PNL balance from your Margin account at any time.

## Contract Specifications


|Contract Symbol           | 	ETH-PERP                                                |
| -------------------------|:---------------------------------------------------------: |
|Underlying Asset/Ticker   |    ETH/USD price from Chainlink                            |
|Trading Hours	           |24*7 days a week                                            |
|Minimum Lot Size|10 USD|
|Contract Size|1 USD|
|Initial Margin|10%|
|Maintenance Margin|7.5%|
|Mark Price|It is the price at which the Perpetual contract is valued during trading hours. This can (temporarily) vary from the actual Perpetual Market Price to protect against manipulative trading. Mark Price is calculated as Index price + 600 seconds EMA of (Perpetual Fair Price - Index Price).  The Perpetual Fair Price is the Mid Price of AMM.
|Delivery/Expiration|	No Delivery/Expiration|
|Delivery Method|	Cash settlement in ETH|
|Fees|	Taker fee -0.025% / Maker fee 0.075%. (no rebate). Liquidation trades are charged at 0.9% (0.825% insurance fund fees).|


## Vanilla & Inverse Contract
Consider a futures contract on ETH which is quoted in USD. Here, ETH is the base currency and USD is the quote currency. 

In a typical (aka vanilla) futures contract, the margin and profit/loss are denominated in the quote currency. Thus, a vanilla futures on ETH which is quoted in USD and is margined and settled in USD.

However, in the case of an inverse contract, margin and profit/loss are denominated in the base currency. Thus, an inverse futures on ETH that is quoted in USD is margined and settled in ETH.

In the other hand, the inverse contract mentioned above can also be considered as a corresponding vanilla contract on USD which is quoted in ETH and is margined and settled in ETH. We can just get the reciprocal of the price quoted in USD and inverse the buy/sell side to convert the inverse contract to the corresponding vanilla contract.

In MCDEX Mai 2 protocol smart contract, there is only vanilla contract. However, to improve the user experience, MCDEX performs the above conversion of ETH-PERP on UI/UX to provide an inverse contract trading experience.


## Funding Rate
Calculations of the funding rate for the Perpetual contracts are identical.

When there is a positive funding rate longs pay funding to shorts; when we have a negative funding rate, shorts pay funding to the longs. The funding rate percentage, expressed as an 8-hourly interest rate, is calculated as follows at any given point in time:

**First we calculate the Premium Rate**

```Premium Rate = ((Mark Price - Index) / Index) * 100%```

**Next we calculate the Funding Rate**

From the Premium Rate the Funding Rate can be calculated by applying a dampener. If the Premium Rate is within -0.05% and 0.05% the actual Funding Rate will be reduced to zero.

If the premium rate is lower than -0.05%, then the actual funding rate will be the Premium rate + 0.05%.
If the premium rate is higher than 0.05%, then the actual funding rate will be the Premium rate - 0.05%.
Funding Rate = Maximum (0.05%, Premium Rate) + Minimum (-0.05%, Premium Rate)

**Finally we calculate the Time Fraction**

```Time Fraction = Funding Rate Time Period / 8 hours```

The actual Funding Payment is calculated by multiplying the Funding Rate by the position size in BTC and the Time Fraction.

```Funding Payment = Funding Rate * Position Size ETH * Time Fraction```

**Example 1**: With a mark price of USD 100.1 and a MCDEX Index of USD 100, the Funding Rate and Premium Rate are calculated as follows:

Premium Rate = ((100.1 - 100) / 100) * 100% = 0.10%

Funding Rate = Maximum (0.05%, 0.10%) + Minimum (-0.05%, 0.10%)
= 0.10% - 0.05% = 0.05%

Now say you have a long position of USD 100 (1ETH) for 1 minute, and during that minute the Mark Price stays on USD 100.1 and the MCDEX Index stays on 100, the funding calculation for this period is:

8 hours = 480 minutes so:

Funding Rate = 1/480 * 0.05% = 0.0001041667%

Funding Payment = 0.0001041667% * 1 ETH = 0.000001041667 ETH

The shorts receive this amount and the longs pay it.

**Example 2**: If you would hold the position in the previous example for 8 hours and the Mark Price and MCDEX Index remain on USD 100.1 and USD 100 respectively for the entire period, then the Funding Rate would be 0.05% and the Funding Payment paid by the longs and received by the shorts for that 8 hour period would have been 0.0005 ETH (or $0.05).

**Example 3**: Say the mark price is USD 100.1 for 1 minute, and the Mark Price is USD 99.9 the minute after that. All that time the Index remains the same at USD 100. Now the total funding paid in this two minute period for a 1 ETH long position is exactly 0 ETH.
The first minute you pay 1/480 * 0.05% = 0.0001041667% * 1 ETH = 0.000001041667 ETH, but the minute after that you receive exactly the same amount.

**Example 4**: The mark price is USD 100.02 and the Index remains at USD 100. Now the real time funding paid is Zero (0%), because the mark price is within the 0.05% dampener from the index (within USD 99.9 and USD 100.1).

We can check this using the Premium Rate and Funding Rate formulas

Premium Rate = ((10,002 - 10,000) / 10,000) * 100% = 0.02%

Funding Rate = Maximum (0.05%, Premium Rate) + Minimum (-0.05%, Premium Rate)

= 0.05% - 0.05% = 0.00%

In reality, the spread between the Index and the Mark Price of the Perpetual Contract changes continuously, and all those changes are taken into account. So the examples above are extreme simplifications of actual calculations of funding over a certain period.

The funding payed or received is continuously added to your cash balance.

No fees on funding: MCDEX does not charge any fees on funding and all funding is transferred between participants in the Perpetual contracts. This makes the funding a zero sum game, where longs receive all funding from shorts, or shorts receive all funding from longs.

## Mark Price
The mark price is the price at which the Perpetual contract will be valued during trading hours. This can (temporarily) vary from the actual perpetual market prices to protect against manipulative trading.

It is important to understand how the Mark Price is being calculated. We start with determining a "Fair Price". To make the Mark Price and Funding Rate independent to any off-chain facilities, MCDEX uses the “Mid Price” of the on-chain AMM as the “Fair Price”. See more details about the “Mid Price” of the AMM in the corresponding chapter.

The Mark Price is derived using both the Index and the Fair Price, by adding to the Index the 600 seconds exponential moving average (EMA) of the Fair Price - MCDEX Index.

```Mark Price = Index + 600 seconds EMA (Fair Price - Index)```

Further the Mark Price is hard limited by MCDEX Index +/- 0.5%, so under no circumstance the mark price of the future can divert more than 0.5% from the MCDEX Index.

The 600 seconds EMA is recalculated every second, so there are in total 600 time periods, where the measurement of the latest second has a weight of 2 / (600 + 1) = 0.333%

## Isolated margin

MCDEX Perpetual contract use the Isolated Margin mode.

Isolated Margin is the margin balance allocated to an individual position. Isolated Margin mode allows traders to manage their risk on their individual positions by restricting the amount of margin allocated to each one. The allocated margin balance for each position can be individually adjusted.

Trader will never lose more than the margin balance in the Isolated Margin mode. Even the trader’s position is liquidated, only the isolated margin balance gets liquidated.

As the effective leverage of the position is equal to the ```Position Value / Margin Balance```, trade can change their position’s leverage by adjust the margin balance. Depositing more collateral to the Isolated Margin reduces the effective leverage while withdrawing collateral from the Isolated Margin increase the effective leverage.

Trader can increase their position size whenever the margin balance is larger than the initial margin. And the position will get liquidated when the margin balance is less than the maintenance margin.

## Automated Market Maker
MCDEX tries to make the Perpetual contract as decentralized as possible. There are two key goals to achieve:
1. The Funding Rate & Mark Price must be derived on the block chain.
2. The traders can trade the contract without any off-chain facilities.

As a consequence, MCDEX introduces an Automated Market Maker(AMM) to the perpetual smart contract. The AMM provides the on-chain liquidity. Traders can trade with the AMM at any time at a price determined by the AMM’s price formula.

When design the AMM, there are several options of the price formula. To caution, we adopted the constant product (x * y = k) model as the price model at the beginning. The advantage of this model is that it has been widely used in Uniswap and has been well verified. The disadvantage of this model used in the Perpetual contract is low capital efficiency. Based on thorough research, we will upgrade the pricing formula of AMM in the future to obtain better capital efficiency.

The AMM has a long position and collateral tokens in its liquidity pool. Let x be the available margin of the AMM’s liquidity pool. Let y be the long position size of the pool.

We make the leverage of the long position is 1x always. Thus, when the long position of the pool increases/decreases by Δy at trading price P:
- the margin occupied by the position increases/decreases by Δy * P
- the available margin x decreases/increases by Δy * P. 

This setting makes the position of AMM always fully collateralized (the, thus the position of AMM will never be liquidated. As a result, the Funding Rate & Mark Price, which is derived from the Mid Price of the AMM, is always available on the chain.

The trading price is determined by the ratio of x and y so that the product x * y is preserved. 
The formula for the trading price P can be derived from the x * y constraint:

```
P( Δy ) = x / ( y + Δy )  
P( Δy ) = x / ( y + Δy )
```

Where, |Δy| is the amount which the trader want to trade. When the trader sells to the pool, Δy is positive. When the trader buys from the pool, Δy is negative. After trading, the x and y parameters are updated as follows:

```
Δx = P( Δy )∙Δy

x' = x- Δx

y' = y + Δy
```

It can be proved that:
```
x∙y = x'∙y'
```
The value of ```x/y``` is called the “Mid Price” of the AMM. And it is used for calculating the Funding Rate and Mark Price.

Trade with the AMM cost a 0.075% trading fee. Among them, 0.025% is the dev fee, and 0.05% will be left in the pool as a fee for the liquidity provider.

## Provide liquidity to AMM

### Add Liquidity

Anyone can add liquidity to the AMM’s liquidity pool and get shares of the pool. To add liquidity, the trader calls the smart contract to do as follows:
1. Send collateral tokens to the pool. Let c be the amount of the collateral tokens.
2. Trade with the AMM as a short at the Mid Price x/y. The amount of the trade is calculated as follows:

```
Liquidity(c) = c/(2x/y) = cy/2x
```

After this operation, the x and y parameters are updated as follows:

```
x' = x+c/2
y' = y + Liquidity(c) = y + cy/2x
x'/y' = (x+c/2)/(y+cy/2x) = (x(2x+c))/(y(2x+c)) = x/y
```

The Mid Price ```x/y``` is not changed after this operation.
The liquidity provider gets the share tokens of the pool.

Suppose the trader has no position at first. After adding liquidity to the AMM, the trader will have a short position in the margin account. However, considering the trader has shares of the long position in the pool simultaneously, the net position size of the trader is still zero.

### Remove Liquidity
Share token holders can remove liquidity from the pool and redeem the share tokens. Let s be the trader’s share (percent) of the pool. To remove liquidity, the trader calls smart contract to do as follows:
1. Trade with the AMM as a long at the Mid Price ```x/y```. The amount of the trade is ```c = y∙s```
2. Get ```2x∙s``` collateral tokens from the pool. 

It can be proved that the Mid Price ```x/y``` is not changed after this operation.


## Trade with the Order Book
In order to improve the liquidity, MCDEX Provides an off-chain order book for trading the Perpetual contract. The order book server can only match the orders for the traders. The server can never touch the trader’s on-china margin account. 

To trade with the order book, the trader sign their orders and send the orders to the order book server. The order book server matches the orders in the order book and send match result to the smart contract on the block chain. The smart contract first validate the order’s signature and match result. If the validation passed, the trades are made according to the match result for the orders’ owners.

### Target Leverage

No matter trade with the AMM or with the order book, the effective leverage of the position is always the ```Position Value / Margin Balance``` and the maximum leverage to open position is ```1 / Initial Margin rate```

However, the trader could set a “Target Leverage” when trade with the order book. The order book engine uses the target leverage to calculate the Position Margin and Order margin and automatically cancel the orders that may push the position’s leverage above the target leverage. 

Remember that the target leverage is only a setting in the off-chain order book server. Even the trader sets low target leverage, the effective leverage of the on-chain position may be higher or lower than the target leverage. For example, the trader withdraws collateral tokens from the margin account, leading to the increment of the effective leverage. Another example, the profit of the position increases continuously, which results in an increase in the margin balance and the decrease of effective leverage.

### Position & Order Margin
The order book server calculates the available margin for placing new orders as follow: (as the vanilla contract)

```
Available = Margin Balance – Position Margin – Order Margin – Withdraw Locked
Position Margin = Mark Price * Position Size / Target Leverage
```

```Order Margin``` is the margin balance reserved for the active orders by order book server. The order which closes position cost no order margin. For the orders that open positions, the order is calculated:
```
Open Order Margin = Order Price * Order Amount / Target Leverage + Potential Loss + Fee
Buy Order Potential Loss = Max((Order Price – Mark Price) * Order Amount, 0)
Sell Order Potential Loss = Max((Mark Price – Order Price) * Order Amount, 0)
```

The order margin of the buy orders and sell orders are calculated separately. And the total order margin is:
```
Order Margin = Max(Buy Orders’ Margin, Sell Orders’ Margin)
```

Withdraw Locked is the amount of margin reserved for withdrawal. See more information about the Withdraw Locked in the next section.
Broker & Withdraw Time Lock

Because the order book server can only match the orders for the trader and cannot really lock any margin balance like the centralized exchange. A trader could terminate the transaction that is already matched and sent to the block chain’s memory pool but has not executed by the miners, by withdrawing the margin or trading with the AMM to make the available margin insufficient. The trader terminates the transactions may because of the price changes to an unconformable price. However, the termination, which can be seen as a kind of so-called “front run”, breaks the orders’ match result and deprives the trading opportunities of the other traders.

To prevent this kind of termination, the order book server needs to be able to detect changes in the margin account in time and cancel orders that cannot be executed on the block chain. As a result, the trader has more rules to follow when trade with the order book:

1.	The trader needs to declare the order book server as his/her “broker” to match order for him/her. The declaration will take effect after 3 block confirmations (time lock). And the AMM is also a special "broker". Thus switching broker between the order book server and AMM requires declaration.

2.	The trader needs to "apply" before withdrawing from margin balance when use an order book. The application will take effect after 3 block confirmations (time lock) automatically without anyone’s permission. The order book server takes the applied amount as “Withdraw Locked”. The 3 block time is long enough for the order book server to cancel orders if the margin balance is insufficient. The trader need not apply before withdrawal if his/her “broker” is the AMM.

## Index Oracle

The Index Price feed is from Chainlink. MCDEX Perpetual relies on the fairness and correctness of the index Oracle. Some crypto projects are committed to providing decentralized Oracle services. Although not perfect, we think that using Chainlink as an oracle in the early days is a good choice.

## Auto liquidation

Mai2 Perpetual smart contract calculates the margin account as follows (as the vanilla contract):

```
Margin Balance = Cash Balance + UPNL
Long’s PNL = (Mark Price – Entry Price) * Position Size
Short’s PNL = (Entry Price - Mark Price) * Position Size
Maintenance Margin = Mark Price * Position Size * Maintenance Margin Rate
Initial Margin = Mark Price * Position Size * Maintenance Margin Rate
```

Bankrupt Price is the mark price which makes the margin balance to zero.

When an account ‘s margin balance is lower than the maintenance margin, positions in the account will be incrementally reduced to keep the initial margin lower than the equity in the account.

Anyone can liquidate the unsafe margin account without the account owner’s permission. The liquidator takes over the unsafe positions at the Mark Price, and the account pays a liquidation penalty to both the liquidator and the insurance fund. As the unsafe positions are transferred to the liquidator after the liquidation, the liquidator must have enough margin balance to keep the position safe.

If the Mark Price is worse than the Bankrupt Price when liquidation, the difference between Mark Price and Bankrupt Price is the loss of the liquidation. The loss is first made up by the insurance fund. If the fund is insufficient to cover the loss, the smart contract will socialize the loss. In this case, all the opponent position holders share the loss according to their position size.

## Global Settlement
Because of the inefficieny of the block chain infrastructure, liquidation mechanism is limited. In extreame situations, there will be mass social loss.During this time, MCDEX will evaluate the situation and set the settlement price if necessary and put the contract into global settlement situation. When into this situation, all trades will be aborted.The accounts without enough margin will be liquidated at settlment price. When liquidation ends, users can settle his positions with settlement price and withdraw all the remain margin balance.
