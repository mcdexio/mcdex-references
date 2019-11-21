# Introduction
Traders are able to gain exposure to crypto asset without taking custody of the underlying asset,by receiving cash settlement rather than the physical delievery.


# Contract Specification 

## BTC Futures

| Underlying asset/Ticker  | BTC Index,provided by Market Protocol Oracle         | 
| -------------            |:-------------: | 
| Trading hours            | 24h*7 days         |  
| Minimum tick size        |  0.001BTC              |   
| Index Price Range        |   a Cap and Floor price,which is the ±25% of the Index Price when contract is made       | 
| Expiration dates         |          |  
| Contract size            |      1BTC         |   
| Settlement Dates         |     24h after expiration dates           |   
| Settled price            |  Index price ,which will still be Cap price if the index price is higher than Cap price and still be Floor price if the index price is lower than the Floor price.            | 
| Settle Method            |    Cash settlement in Collateral      |  
| Fees                     |   Gas fee and Market Protocol trading fee,refer to [fees](en/fees.md) for more details|   


