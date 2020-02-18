# Introduction
Inspried by FTX, TRUMP 2020 is a futures contract on MCDEX.


# Contract Specification 

## TRUMP 2020 Futures

| Underlying Asset  | TRUMP Index, provided by Market Protocol Oracle.      | 
| -------------            |:-------------: |
| Protocols                | Market Protocol + Mai Protocol V1 |
| Trading Hours            | 24h * 7 days         |  
| Tick Size                | $0.0001. minimum price movement |   
| Lot Size                 | 1 TRUMP. minimum order quantity movement |
| Index Price Range        | Cap price($1) and Floor price($0), TRUMP expires to $1 if Donald Trump wins the 2020 US presidential elections, and $0 otherwise.        | 
| Contract Size            |      1 TRUMP         |   
| Margin                   |      Long Position Margin = (Entry Price - Floor Price) * Quantity<br/>Short Position Margin = (Cap Price - Entry Price) * Quantity<br/>Margin is locked in the smart contract until the position is closed or the contract is settled.<br/>There is NO margin call or liquidation.       |  
| Expiration Dates         |    Expirations are always at 15:00 UTC on Friday. A new futures contract with new expiry date will be added 1 hour after the expiration of the front futures contract.   |  
| Settlement Dates         |   24 hours after expiration dates.          |
| Settlement Price         |   TRUMP expires to $1 if Donald Trump wins the 2020 US presidential elections, and $0 otherwise. More detailed rules is attached            | 
| Settle Method            |   Cash settlement in collateral tokens      |  
| Between Expiration and Settlement | During this period, you can still close your position by placing an order at any appropriate price (e.g. settlement price). But you are only allowed to enter into a long position at a price lower than the settlement price or enter into a short position at a price higher than the settlement price. |
| Fees                     |   Gas fee and Market Protocol trading fee, refer to [fees](fees.md) for more details|   

## What will TRUMP expire to?
1.This contract will settle to 1 in the event that Donald Trump is elected president of the United States, and to 0 otherwise.

2.The election held in the United States on November 3, 2020 will determine who is elected president, and any person projected to receive at fewest 270 electoral votes per the electoral college system will be considered to have been elected president. 

3.Each state has a different protocol for assigning its electoral votes to a candidate. If a state assigns all its electoral votes to the person who the plurality of its voters vote for (which is the case for most states), we project that all its electoral votes will go the person the plurality of its reported voters voted for as of November 4, 2020 (according to all reporting precincts’ most recently reported numbers as of that time). Other states divide their electoral votes pro rata according to fraction of votes each candidate received, and we will project a person will receive a fraction of any such state’s electoral votes in line with the fraction of the state’s votes that person receives, as of November 4, 2020. 

4.In event that, before all states have released official vote tallies, all of {The New York Times, 538, 270toWin, Fox, CNN} have determined that a set of states electoral votes are projected to go to a specific candidate such that they’ve determined that candidate will receive 270 or more electoral votes, FTX may choose to settle the contract according to that election result.

5.In the event that some set of electoral votes cannot be projected according to the above criteria which leads to the impossibility of determining a candidate who is projected to receive 270 electoral votes by November 5, 2020, this contract will settle to $1 if Donald Trump is still president on February 1st, 2021, and $0 otherwise.
