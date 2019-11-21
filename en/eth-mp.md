# Introduction
Traders are able to gain exposure to crypto asset without taking custody of the underlying asset,by receiving cash settlement rather than the physical delievery.


# Contract Specification

## ETH Futures

| Underlying asset  | ETH Index, provided by Market Protocol Oracle        | 
| -------------            |:-------------: | 
| Trading hours            | 24h * 7 days         |  
| Minimum tick size        |  0.05ETH             |   
| Index Price Range        |   A Cap and Floor price, which is the ±25% of the Index Price when contract is made       | 
| Expiration dates         | Expirations are always at 12:30 UTC on Friday.         |  
| Contract size            |        1ETH       |   
| Settlement Dates         |     24h after expiration dates           |   
| Settled price            |  Index price, which will still be Cap price if the index price is higher than Cap price and still be Floor price if the index price is lower than the Floor price.            | 
| Settle Method            |    Cash settlement in Collateral      |  
| Fees                     |   Gas fee and Market Protocol trading fee, refer to [fees](en/fees.md) for more details|   

