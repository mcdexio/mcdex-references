# Introduction
Traders are able to gain exposure to crypto asset without taking custody of the underlying asset,by receiving cash settlement rather than the physical delievery.


# Contract Specification 

## BTC Futures

| Underlying Asset  | BTC Index,provided by Market Protocol Oracle         | 
| -------------            |:-------------: | 
| Trading Hours            | 24h * 7 days         |  
| Minimum Tick Size        |  0.001 BTC              |   
| Index Price Range        |   a Cap and Floor price, which is the ±25% of the Index Price when contract is made       | 
| Expiration Dates         |    Expirations are always at 12:30 UTC on Friday. Currently there are 2 weekly futures (collateraled in USDT and DAI). A new future with new expiry date will be added 1 hour after the expiration of the front future.   |  
| Contract Size            |      1 BTC         |   
| Margin                   |      Long Position Margin = (Entry Price - Floor Price) * Quantity; Short Position Margin = (Cap Price - Entry Price) * Quantity .Margin is locked in the smart contract until the position is closed or the contract is settled.       |  
| Settlement Dates         |     24h after expiration dates           |   
| Settled Price            |  Index price, which will still be Cap price if the index price is higher than Cap price and still be Floor price if the index price is lower than the Floor price.            | 
| Settle Method            |    Cash settlement in Collateral      |  
| Fees                     |   Gas fee and Market Protocol trading fee, refer to [fees](en/fees.md) for more details|   

