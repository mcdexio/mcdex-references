

Although the position tokens are standard ERC20 tokens and can be traded on any exchange that supports ERC20, the process of directly trading position token is not easy. The reasons are as follows:

First, the value of the position token is the margin of the position. However, the pricing of position token is not intuitive. After pricing the underlying assets, the trader need to convert the assert price to corresponding position token price with price range (PRICE_FLOOR and PRICE_CAP):

```
Long Position Token Price = Asset Price - PRICE_FLOOR
Short Position Token Price = PRICE_CAP -  Asset Price
```

Second, traders need to deal with two kinds of position tokens (Long Position Token and Short Position Token), each of which has both buy and sell operations. This also means that two order books are required to trade a Market Protocol's contract.

Third, 

