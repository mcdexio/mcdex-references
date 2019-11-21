# Introduction
Traders are able to gain exposure to crypto asset without taking custody of the underlying asset,by receiving cash settlement rather than the physical delievery.


# Contract Specification

## ETH Futures

| Underlying Asset  | ETH Index, provided by Market Protocol Oracle        | 
| -------------            |:-------------: | 
| Trading Hours            | 24h * 7 days         |  
| Minimum Tick Size        |  0.05 ETH             |   
| Index Price Range        |   A Cap and Floor price, which is the ±25% of the Index Price when contract is made       | 
| Expiration Dates         | Expirations are always at 12:30 UTC on Friday.         |  
| Contract Size            |        1 ETH       |   
| Margin                   |         Long Position Margin = (Entry Price - Floor Price) * Quantity; Short Position Margin = (Cap Price - Entry Price) * Quantity. Margin is locked in the smart contract until the position is closed or the contract is settled.   | 
| Settlement Dates         |     24h after expiration dates           |   
| Settled Price            |  Index price, which will still be Cap price if the index price is higher than Cap price and still be Floor price if the index price is lower than the Floor price.            | 
| Settle Method            |    Cash settlement in Collateral      |  
| Fees                     |   Gas fee and Market Protocol trading fee, refer to [fees](en/fees.md) for more details|   

