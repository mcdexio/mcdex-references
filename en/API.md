---
title: MCDEX API Reference

language_tabs:
  - shell

toc_footers:
  - <a href='https://mcdex.io'>Go To MCDEX Exchange on Main Network</a>
  - <a href='https://ropsten.mcdex.io'>Go To MCDEX Exchange on Test Network</a>

search: true
---

# Introduction

Welcome to the MCDEX API! You can use our API to access all market data, trading, and account management endpoints.

We have code example in Shell! You can view them in the dark area to the right.

# API endpoints

Rest:

https://mcdex.io/api

Websocket:

wss://mcdex.io/ws

# Authentication

## API Authentication Header

### Header Details

Mai-Authentication: {AA}#{BB}@{CC}#{DD}

AA: your ETH address begin with '0x'

BB: any string without '#'

CC: timestamp in milliseconds

DD: personalSign of CC begin with '0x'
<aside class="notice">
The signature will expire after 5 minutes.
</aside>

## JWT Authentication Header

`GET /jwt` with "Mai-Authentication" header described above.

> Response:

```json
{
  "status": 0,
  "desc": "success",
  "data": {
    "expires": 86400000, // in milliseconds
    "jwt": "<data>"
  }
}
```

Then save **data** into local storage. The next time send the following header instead of Mai-Authentication:

`Authentication: Bearer <data>`

# Public REST API

## List Markets

```shell
curl "https://mcdex.io/api/markets"
```

> Response:

```json
{
  "status": 0,
  "desc": "success",
  "data": {
    "markets": [
      {
        "id": "b2tods",
        "symbol": "BTC1220-USDT",
        "mpContractName": "BTC_USDT_COINCAP_1576828800",
        "mpContractAddress": "0xa8ae6634f0acd034fb88aabd535aff7576bb046e",
        "expirationAt": "2019-12-20T08:00:00Z",
        "collateralTokenSymbol": "USDT",
        "collateralTokenName": "Tether USD",
        "collateralTokenDecimals": 6,
        "collateralTokenAddress": "0xdac17f958d2ee523a2206206994597c13d831ec7",
        "longTokenSymbol": "LBTC_20191220",
        "longTokenName": "MARKET Protocol Long Position Token",
        "longTokenAddress": "0x22a7ea7d08319d7791f2098389e4b9ff66b43582",
        "shortTokenSymbol": "SBTC_20191220",
        "shortTokenName": "MARKET Protocol Short Position Token",
        "shortTokenAddress": "0x8914b374d507de405b18f91e2308b746c72a2dc5",
        "positionTokenDecimals": 5,
        "contractType": "MarketProtocol",
        "contractSizeSymbol": "BTC",
        "mpContractStatus": "NORMAL",
        "settlePrice": "0",
        "settleTime": null,
        "lotSize": "0.001",
        "priceFloor": "5500",
        "priceCap": "9000",
        "priceTick": "0.1",
        "priceDecimals": 1,
        "priceSymbol": "USDT",
        "oracleID": "https://api.coincap.io/v2/rates/bitcoin",
        "amountDecimals": 5,
        "asMakerFeeRate": "0",
        "asTakerFeeRate": "0",
        "gasFeeAmount": "0.5683222031232233",
        "supportedOrderTypes": [
          "limit",
          "market"
        ]
      }
    ]
  }
}
```

List all markets, including active markets and closed markets.

### HTTP Request

`GET /markets`

### Details

`lotSize` : The minimum order size of the order you can place and the minimum order size increment.

`priceTick` : The minimum price increment.

## Get a Market

```shell
curl "https://mcdex.io/api/markets/b2tods"
```

> Response:

```json
{
  "status": 0,
  "desc": "success",
  "data": {
    "market": {
      "id": "b2tods",
      "symbol": "BTC1220-USDT",
      "mpContractName": "BTC_USDT_COINCAP_1576828800",
      "mpContractAddress": "0xa8ae6634f0acd034fb88aabd535aff7576bb046e",
      "expirationAt": "2019-12-20T08:00:00Z",
      "collateralTokenSymbol": "USDT",
      "collateralTokenName": "Tether USD",
      "collateralTokenDecimals": 6,
      "collateralTokenAddress": "0xdac17f958d2ee523a2206206994597c13d831ec7",
      "longTokenSymbol": "LBTC_20191220",
      "longTokenName": "MARKET Protocol Long Position Token",
      "longTokenAddress": "0x22a7ea7d08319d7791f2098389e4b9ff66b43582",
      "shortTokenSymbol": "SBTC_20191220",
      "shortTokenName": "MARKET Protocol Short Position Token",
      "shortTokenAddress": "0x8914b374d507de405b18f91e2308b746c72a2dc5",
      "positionTokenDecimals": 5,
      "contractType": "MarketProtocol",
      "contractSizeSymbol": "BTC",
      "mpContractStatus": "NORMAL",
      "settlePrice": "0",
      "settleTime": null,
      "lotSize": "0.001",
      "priceFloor": "5500",
      "priceCap": "9000",
      "priceTick": "0.1",
      "priceDecimals": 1,
      "priceSymbol": "USDT",
      "oracleID": "https://api.coincap.io/v2/rates/bitcoin",
      "amountDecimals": 5,
      "asMakerFeeRate": "0",
      "asTakerFeeRate": "0",
      "gasFeeAmount": "0.5690071305575178",
      "supportedOrderTypes": [
        "limit",
        "market"
      ]
    }
  }
}
```

Get a market by ID.

### HTTP Request

`GET /markets/<id>`

### URL Parameters

Parameter | Description
--------- | -----------
id | The ID of the market.

## Market Status

```shell
curl "https://mcdex.io/api/markets/b2tods/status"
```

> Response:

```json
{
  "status": 0,
  "desc": "success",
  "data": {
    "marketID": "b2tods",
    "lastPrice": "7061.6",
    "price24hGrowthRate": "-0.0031198385024775",
    "amount24h": "0.008",
    "volume24h": "56.6591",
    "lastIndex": "7131.843151665215032"
  }
}
```

Return the status of a specific market.

### HTTP Request

`GET /markets/<id>/status`

### URL Parameters

Parameter | Description
--------- | -----------
id | The ID of the market.

## Candles

```shell
curl "https://mcdex.io/api/markets/b2tods/candles?from=1576465225&to=1576485225&granularity=300"
```

> Response:

```json
{
  "status": 0,
  "desc": "success",
  "data": {
    "candles": [
      {
        "time": 1576466400,
        "open": "7081.9",
        "close": "7081.9",
        "low": "7081.9",
        "high": "7081.9",
        "volume": "0.001"
      },
      {
        "time": 1576470300,
        "open": "7034.5",
        "close": "7034.5",
        "low": "7034.5",
        "high": "7034.5",
        "volume": "0.001"
      },
      {
        "time": 1576476300,
        "open": "7061.6",
        "close": "7061.6",
        "low": "7061.6",
        "high": "7061.6",
        "volume": "0.001"
      }
    ]
  }
}
```

Get "candles" for the market. This data is usually used to draw the k-line chart.

### HTTP Request

`GET /markets/<id>/candles`

### URL Parameters

Parameter | Description
--------- | -----------
id | The ID of the market.

### Query Parameters

Parameter | Description | Required | Type | Example
--------- | ----------- | -------- | ---- | -------
from | The first unix timestamp of the time range. | True | number | 1576465225
to | The last unix timestamp of the time range. | True | number | 1576485225
granularity | The seconds of each candle last, valid values: 300, 3600, 43200, 86400. | True | number | 300

### Details

If a candle has no trade, it won't be returned.

## Orderbook(snapshot)

```shell
curl "https://mcdex.io/api/markets/b2tods/orderbook"
```

> Response:

```json
{
  "status": 0,
  "desc": "success",
  "data": {
    "status": 0,
    "desc": "",
    "orderBook": {
      "sequence": "6769832519740604027",
      "updatedAt": "2019-12-16T08:39:18.2064109Z",
      "bids": [
        {
          "price": "7058.9",
          "amount": "0.049"
        },
        {
          "price": "7058.5",
          "amount": "0.051"
        },
        {
          "price": "7058.1",
          "amount": "0.049"
        },
        {
          "price": "6998.7",
          "amount": "0.02"
        },
        {
          "price": "6960",
          "amount": "0.02"
        },
        {
          "price": "6921.3",
          "amount": "0.02"
        }
      ],
      "asks": [
        {
          "price": "7065.5",
          "amount": "0.001"
        },
        {
          "price": "7069.1",
          "amount": "0.054"
        },
        {
          "price": "7069.5",
          "amount": "0.412"
        },
        {
          "price": "7114.7",
          "amount": "0.02"
        },
        {
          "price": "7153.3",
          "amount": "0.02"
        },
        {
          "price": "7192",
          "amount": "0.02"
        }
      ]
    }
  }
}
```

<aside class="notice">
Use WebSocket API if possible.
</aside>
Return the order book snapshot of a specific market.

### HTTP Request

`GET /markets/<id>/orderbook`

### URL Parameters

Parameter | Description
--------- | -----------
id | The ID of the market.

### Query Parameters

Parameter | Description | Required | Type | Example
--------- | ----------- | -------- | ---- | -------
level | Aggregation level, 2(default) means aggregating the same price orders, 3 means no aggretion. | False | number | 2

## Trade History(snapshot)

```shell
curl "https://mcdex.io/api/markets/b2tods/trades"
```

> Response:

```json
{
  "status": 0,
  "desc": "success",
  "data": {
    "count": 1,
    "trades": [
      {
        "id": 590,
        "marketID": "b2tods",
        "transactionHash": "0x4e96f33ffb24874631e9ae6a3d8cfb69d727e86be33a55f3444f946b353e6906",
        "transactionStatus": "SUCCESS",
        "status": "SUCCESS",
        "takerSide": "buy",
        "maker": "0x799b976ad9b5266631414c876e9635fa8f2dce96",
        "taker": "0x08312bb82a9e30d068f6b4faf854df9066e02b1f",
        "amount": "0.001",
        "price": "7065.5",
        "executedAt": "2019-12-16T08:41:30Z",
        "createdAt": "2019-12-16T08:41:32.616598Z",
        "makerFeeRate": "0",
        "takerFeeRate": "0"
      }
    ]
  }
}
```

Return the trade history snapshot of a specific market.

### HTTP Request

`GET /markets/<id>/trades`

### URL Parameters

Parameter | Description
--------- | -----------
id | The ID of the market.

### Details

Only succeeded trades will be returned.

## Fees

```shell
curl "https://mcdex.io/api/fees?marketID=b2tods&price=8000&amount=1"
```

> Response:

```json
{
  "status": 0,
  "desc": "success",
  "data": {
    "fees": {
      "gasFeeAmount": "0.5690385899380904",
      "asMakerTotalFeeAmount": "0.5690385899380904",
      "asMakerTradeFeeAmount": "0",
      "asMakerFeeRate": "0",
      "asTakerTotalFeeAmount": "0.5690385899380904",
      "asTakerTradeFeeAmount": "0",
      "asTakerFeeRate": "0"
    }
  }
}
```

Return the fees of a specific market for the specific price and amount.

### HTTP Request

`GET /fees`

### Query Parameters

Parameter | Description | Required | Type | Example
--------- | ----------- | -------- | ---- | -------
marketID | market id | True | string | b2tods
price | trade price | True | number | 8000
amount | trade amount | True | number | 1

### Details

total fee = trade fee + gas fee, trade fee = trade fee rate * (cap - floor) * 0.5 * amount.

Note that fees are different for maker and taker.

# Private REST API

## My Market Trades

```shell
curl "https://mcdex.io/api/markets/b2tods/trades/mine" -H "Mai-Authentication: xxx"
```

> Response:

```json
{
  "status": 0,
  "desc": "success",
  "data": {
    "count": 25,
    "trades": [
      {
        "id": 590,
        "transactionID": 626,
        "status": "SUCCESS",
        "marketID": "b2tods",
        "maker": "0x799b976ad9b5266631414c876e9635fa8f2dce96",
        "taker": "0x08312bb82a9e30d068f6b4faf854df9066e02b1f",
        "takerSide": "buy",
        "makerOrderID": "0xf1dda2ef3cfabbca6ec5c4f3dd58f133ef8c22addb762ca219e2dbafe5988d55",
        "takerOrderID": "0x4852b0aa277454f29c103014320881d534f8046b8df949490773705a8369b9bb",
        "sequence": 0,
        "amount": "0.001",
        "price": "7065.5",
        "createdAt": "2019-12-16T08:41:32.616598Z",
        "makerFeeRate": "0",
        "takerFeeRate": "0",
        "makerRebateRate": "0",
        "transactionStatus": "SUCCESS",
        "transactionHash": "0x4e96f33ffb24874631e9ae6a3d8cfb69d727e86be33a55f3444f946b353e6906",
        "executedAt": "2019-12-16T08:41:30Z"
      }
    ]
  }
}
```

Return your trades of a specific market.

### HTTP Request

`GET /markets/<id>/trades/mine`

### URL Parameters

Parameter | Description
--------- | -----------
id | The ID of the market

### Query Parameters

Parameter | Description | Required | Type | Example
--------- | ----------- | -------- | ---- | -------
status | Only the trades with the specific status will be returned. Valid values: all(default), INIT, SIGNED, SIGN_FAIL, PENDING, SUCCESS, EXECUTE_FAIL, OVERWRITTEN. | False | string | all
page | Used for pagination. Default 1. | False | number | 1
perPage | Used for pagination. The maximum valid value is 10000. Default 20. | False | number | 20


## All My Trades

```shell
curl "https://mcdex.io/api/trades/mine" -H "Mai-Authentication: xxx"
```

> Response:

```json
{
  "status": 0,
  "desc": "success",
  "data": {
    "count": 1,
    "trades": [
      {
        "id": 575,
        "transactionID": 611,
        "status": "SUCCESS",
        "marketID": "b2tods",
        "maker": "0x799b976ad9b5266631414c876e9635fa8f2dce96",
        "taker": "0xd4ead225ed5448ec531c2dc06f0d22a64db6ad1f",
        "takerSide": "sell",
        "makerOrderID": "0x1c9e4cf73b784dac6c81daaf1c4e9c586286ee1485d9c9e75cf89a07ecbf0d6d",
        "takerOrderID": "0x00d03a25688bce18b6495013adccfdb91bf58d284d8c493d55d47ee1021f951a",
        "sequence": 0,
        "amount": "0.001",
        "price": "7118.2",
        "createdAt": "2019-12-15T22:11:14.102954Z",
        "makerFeeRate": "0",
        "takerFeeRate": "0",
        "makerRebateRate": "0",
        "transactionStatus": "SUCCESS",
        "transactionHash": "0xdee4bd71e852f4be255646a570b891ac93c4d094212e60a42f921f3f66f20545",
        "executedAt": "2019-12-15T22:11:38Z"
      }
    ]
  }
}
```

Return all your trades.

### HTTP Request

`GET /trades/mine`

### Query Parameters

Parameter | Description | Required | Type | Example
--------- | ----------- | -------- | ---- | -------
status | Only the trades with the specific status will be returned. Valid values: all(default), INIT, SIGNED, SIGN_FAIL, PENDING, SUCCESS, EXECUTE_FAIL, OVERWRITTEN. | False | string | all
page | Used for pagination. Default 1. | False | number | 1
perPage | Used for pagination. The maximum valid value is 10000. Default 20. | False | number | 20

## My Orders

```shell
curl "https://mcdex.io/api/orders?marketID=b2tods" -H "Mai-Authentication: xxx"
```

> Response:

```json
{
  "status": 0,
  "desc": "success",
  "data": {
    "count": 1,
    "orders": [
      {
        "id": "0xec1bb8c3adfa8305e2c8b5e02992e812cfc013e183e772f7e2c5b51b69828111",
        "traderAddress": "0x799b976ad9b5266631414c876e9635fa8f2dce96",
        "marketID": "b2tods",
        "side": "sell",
        "price": "7057",
        "amount": "0.001",
        "status": "pending",
        "type": "limit",
        "version": "mai-v1",
        "availableAmount": "0.001",
        "confirmedAmount": "0",
        "filledPrice": "0",
        "canceledAmount": "0",
        "pendingAmount": "0",
        "makerFeeRate": "0",
        "takerFeeRate": "0",
        "makerRebateRate": "0",
        "gasFeeAmount": "0.5684570058987931",
        "createdAt": "2019-12-16T09:03:22.063236Z",
        "updatedAt": "2019-12-16T09:03:22.063236Z",
        "expiresAt": "2019-12-16T09:33:22Z",
        "cancelReasons": [],
        "symbol": "BTC1220-USDT",
        "contractSizeSymbol": "BTC",
        "priceSymbol": "USDT",
        "priceTick": "0.1"
      }
    ]
  }
}
```

Return your orders of a specific market.

### HTTP Request

`GET /orders`

### Query Parameters

Parameter | Description | Required | Type | Example
--------- | ----------- | -------- | ---- | -------
marketID | Market id, return all if none | False | string | b2tods
status |  Only the orders with this status will be returned. Valid values: all, canceled, pending(default), partial_filled, full_filled. | False | string | pending
page | Used for pagination. Default 1. | False | number | 1
perPage | Used for pagination. The maximum valid value is 10000. Default 20. | False | number | 20

### Details

Status `pending` means the order in the order book or the matched order is being broadcasted.

Status `partial_filled` means a part of order is filled and the rest is canceled. The partial_filled order is not in the order book.

## My Orders by IDs

```shell
curl --data '{"orderIDs":["0xec1bb8c3adfa8305e2c8b5e02992e812cfc013e183e772f7e2c5b51b69828111"]}' 'https://mcdex.io/api/orders/byids' -H "Mai-Authentication: xxx" -H "Content-Type: application/json"
```

> Response:

```json
{
  "status": 0,
  "desc": "success",
  "data": {
    "count": 1,
    "orders": [
      {
        "id": "0xec1bb8c3adfa8305e2c8b5e02992e812cfc013e183e772f7e2c5b51b69828111",
        "traderAddress": "0x799b976ad9b5266631414c876e9635fa8f2dce96",
        "marketID": "b2tods",
        "side": "sell",
        "price": "7057",
        "amount": "0.001",
        "status": "full_filled",
        "type": "limit",
        "version": "mai-v1",
        "availableAmount": "0",
        "confirmedAmount": "0.001",
        "filledPrice": "7057",
        "canceledAmount": "0",
        "pendingAmount": "0",
        "makerFeeRate": "0",
        "takerFeeRate": "0",
        "makerRebateRate": "0",
        "gasFeeAmount": "0.5684570058987931",
        "createdAt": "2019-12-16T09:03:22.063236Z",
        "updatedAt": "2019-12-16T09:25:19.259812Z",
        "expiresAt": "2019-12-16T09:33:22Z",
        "cancelReasons": [],
        "symbol": "BTC1220-USDT",
        "contractSizeSymbol": "BTC",
        "priceSymbol": "USDT",
        "priceTick": "0.1"
      }
    ]
  }
}
```

Return your orders by ids.

### HTTP Request

`POST /orders/byids`

### Body JSON Parameters

Parameter | Description | Required | Type | Example
--------- | ----------- | -------- | ---- | -------
orderIDs | The list of order ids. | True | list | [0xec1bb8c3adfa8305e2c8b5e02992e812cfc013e183e772f7e2c5b51b69828111]

## My Order

```shell
curl "https://mcdex.io/api/orders/0xec1bb8c3adfa8305e2c8b5e02992e812cfc013e183e772f7e2c5b51b69828111" -H "Mai-Authentication: xxx"
```

> Response:

```json
{
  "status": 0,
  "desc": "success",
  "data": {
    "order": {
      "id": "0xec1bb8c3adfa8305e2c8b5e02992e812cfc013e183e772f7e2c5b51b69828111",
      "traderAddress": "0x799b976ad9b5266631414c876e9635fa8f2dce96",
      "marketID": "b2tods",
      "side": "sell",
      "price": "7057",
      "amount": "0.001",
      "status": "full_filled",
      "type": "limit",
      "version": "mai-v1",
      "availableAmount": "0",
      "confirmedAmount": "0.001",
      "filledPrice": "7057",
      "canceledAmount": "0",
      "pendingAmount": "0",
      "makerFeeRate": "0",
      "takerFeeRate": "0",
      "makerRebateRate": "0",
      "gasFeeAmount": "0.5684570058987931",
      "createdAt": "2019-12-16T09:03:22.063236Z",
      "updatedAt": "2019-12-16T09:25:19.259812Z",
      "expiresAt": "2019-12-16T09:33:22Z",
      "cancelReasons": [],
      "symbol": "BTC1220-USDT",
      "contractSizeSymbol": "BTC",
      "priceSymbol": "USDT",
      "priceTick": "0.1"
    }
  }
}
```

Return your order by a id.

### HTTP Request

`GET /orders/<id>`

### URL Parameters

Parameter | Description
--------- | -----------
id | The ID of the order.

## My Trades Related to My Order

```shell
curl "https://mcdex.io/api/orders/0xec1bb8c3adfa8305e2c8b5e02992e812cfc013e183e772f7e2c5b51b69828111/trades" -H "Mai-Authentication: xxx"
```

> Response:

```json
{
  "status": 0,
  "desc": "success",
  "data": {
    "count": 1,
    "trades": [
      {
        "id": 594,
        "transactionID": 630,
        "status": "SUCCESS",
        "marketID": "b2tods",
        "maker": "0x799b976ad9b5266631414c876e9635fa8f2dce96",
        "taker": "0x08312bb82a9e30d068f6b4faf854df9066e02b1f",
        "takerSide": "buy",
        "makerOrderID": "0xec1bb8c3adfa8305e2c8b5e02992e812cfc013e183e772f7e2c5b51b69828111",
        "takerOrderID": "0x1bdb7103d99d39f58718c0f724b8acc4f5453b0100bb463366d1b47d7dd8efd4",
        "sequence": 0,
        "amount": "0.001",
        "price": "7057",
        "createdAt": "2019-12-16T09:23:40.133561Z",
        "makerFeeRate": "0",
        "takerFeeRate": "0",
        "makerRebateRate": "0",
        "transactionStatus": "SUCCESS",
        "transactionHash": "0x78a6b0327f1d7a4b08a1fc28dee78b5528decadda860b9e50370b8bcfdb54f19",
        "executedAt": "2019-12-16T09:25:16Z"
      }
    ]
  }
}
```

Return the trades related to your specific order.

### HTTP Request

`GET /orders/<id>/trades`

### URL Parameters

Parameter | Description
--------- | -----------
id | The ID of the order.


## My Positions

```shell
curl "https://mcdex.io/api/account/positions" -H "Mai-Authentication: xxx"
```

> Response:

```json
{
  "status": 0,
  "desc": "success",
  "data": {
    "positions": [
      {
        "trader": "0x799b976ad9b5266631414c876e9635fa8f2dce96",
        "marketID": "b2tods",
        "side": "long",
        "entryPrice": "7105.2294270833333334",
        "amount": "0.006",
        "unknownPriceAmount": "0",
        "openedAt": "2019-12-14T04:30:59Z",
        "symbol": "BTC1220-USDT",
        "priceSymbol": "USDT",
        "contractSizeSymbol": "BTC"
      }
    ]
  }
}
```

Return the positions of all markets.

### HTTP Request

`GET /account/positions`

## My Closed Positions

```shell
curl "https://mcdex.io/api/account/closed_positions" -H "Mai-Authentication: xxx"
```

> Response:

```json
{
  "status": 0,
  "desc": "success",
  "data": {
    "closedPositions": [
      {
        "id": "584",
        "transactionHash": "0x936ffd757e7ffc5056db77c7f8bf06b05920d7cc02c961a29546f9724468ce09",
        "trader": "0x799b976ad9b5266631414c876e9635fa8f2dce96",
        "marketID": "b2tods",
        "side": "long",
        "amount": "0.001",
        "openedAt": "2019-12-14T04:30:59Z",
        "closedAt": "2019-12-16T06:07:41Z",
        "protocol": "mai",
        "entryPrice": "7105.2294270833333334",
        "exitPrice": "7061.6",
        "symbol": "BTC1220-USDT",
        "priceSymbol": "USDT",
        "contractSizeSymbol": "BTC"
      }
    ],
    "count": 1
  }
}
```

Return the closed positions of all markets.

### HTTP Request

`GET /account/closed_positions`

### Query Parameters

Parameter | Description | Required | Type | Example
--------- | ----------- | -------- | ---- | -------
page | Used for pagination. Default 1. | False | number | 1
perPage | Used for pagination. The maximum valid value is 10000. Default 20. | False | number | 20

## Available Balances

```shell
curl "https://mcdex.io/api/account/tokenBalances?marketID=b2tods" -H "Mai-Authentication: xxx"
```

> Response:

```json
{
  "status": 0,
  "desc": "success",
  "data": {
    "balances": [
      {
        "marketID": "b2tods",
        "longPosition": {
          "symbol": "LBTC_20191220",
          "address": "0x22a7ea7d08319d7791f2098389e4b9ff66b43582",
          "balance": "400",
          "locked": "0",
          "allowance": "999999999999999999999999999999998900",
          "potential": "0",
          "decimals": 5
        },
        "shortPosition": {
          "symbol": "SBTC_20191220",
          "address": "0x8914b374d507de405b18f91e2308b746c72a2dc5",
          "balance": "0",
          "locked": "0",
          "allowance": "1000000000000000000000000000000000000",
          "potential": "0",
          "decimals": 5
        },
        "collateral": {
          "symbol": "USDT",
          "address": "0xdac17f958d2ee523a2206206994597c13d831ec7",
          "balance": "64362846",
          "locked": "0",
          "allowance": "999999999999999999999999999999999999999999999999999999789572085",
          "potential": "0",
          "decimals": 6
        }
      }
    ]
  }
}
```

Get balances of long token, short token and collateral token.

### HTTP Request
`GET /account/tokenBalances`

### URL Parameters

Parameter | Description | Required
--------- | ----------- | --------
marketID | The ID of the market, return balances of all markets if none. | False

## Build Order

```shell
curl --data '{"amount": "0.01", "price": "6920", "side": "buy", "expires": 1800, "orderType": "limit", "marketID": "b2tods"}' "https://mcdex.io/api/orders/build" -H "Mai-Authentication: xxx" -H "Content-Type: application/json"
```

> Response:

```json
{
  "status": 0,
  "desc": "success",
  "data": {
    "order": {
      "id": "0xbddcc767dc44c8ec098833cadaa1ace0e09330f84ebf140ee0c9e541e1930ce7",
      "marketID": "b2tods",
      "side": "buy",
      "type": "limit",
      "price": "6920",
      "amount": "0.01",
      "json": {
        "trader": "0x08312bb82a9e30d068f6b4faf854df9066e02b1f",
        "relayer": "0x5ff086d54201ec4aa20a12537dfedd192015a26a",
        "marketContractAddress": "0xa8ae6634f0acd034fb88aabd535aff7576bb046e",
        "amount": "1000",
        "price": "69200",
        "gasTokenAmount": "568128",
        "signature": "",
        "data": "0x0100005df76a95000000000000005b27926ee6c6929400000000000000000000"
      },
      "asMakerFeeRate": "0",
      "asTakerFeeRate": "0",
      "makerRebateRate": "0",
      "gasFeeAmount": "0.5681285012630313",
      "expiresAt": 1576495765
    }
  }
}
```

Build an unsigned order. The next step is signing the returned id and placing order with id and signature.

### HTTP Request

`POST /orders/build`

### Body JSON Parameters

Parameter | Description | Required | Type | Example
--------- | ----------- | -------- | ---- | -------
amount | Order amount. | True | string | "1"
price | Order price. | True | string | "6920"
side | Order side, "buy" or "sell". | True | string | "buy"
expires | The time before the order expires, in seconds | True | number | 1800
orderType | Order type, "limit" or "market". | True | string | "limit"
marketID | Market id. | True | string | b2tods


## Place Order

```shell
curl --data '{"orderID": "0xb767f3c7c1a828e7f2b73648cefb4e14ec158840695017fd0d7ecc97f2c10abe", "signature": "0x1c0100000000000000000000000000000000000000000000000000000000000063496baec1d4e92ddc853e01fe6a1a49459c0499a86cefacaa95e32979e0c0a548eb730a046cfcbc730f383214eefc3b723c9ef5ebf9a4de25cf1b1fefc0694a"}' "https://mcdex.io/api/orders" -H "Mai-Authentication: xxx" -H "Content-Type: application/json"
```

> Response:

```json
{
  "status":0,
  "desc":"success"
}
```

Sign and place order.

### Sign Option 1: ethSign

// step 1: orderID => sign

web3.eth.sign(web3.eth.accounts[0], orderID, function(err, result) { console.log(err, result) } )

// step 2: padding v. The "signature": 0x{v}00000000000000000000000000000000000000000000000000000000000000{r}{s}

signature = '0x' + sign.slice(130) + '0'.repeat(62) + sign.slice(2, 130)

### Sign Option 2: EIP712

// step 1: get eip712Msg

```
eip712Msg = {
  types: {
    EIP712Domain: [
      { name: 'name', type: 'string' }
    ],
    Order: [
      { name: 'trader', type: 'address' },
      { name: 'relayer', type: 'address' },
      { name: 'marketContractAddress', type: 'address' },
      { name: 'amount', type: 'uint256' },
      { name: 'price', type: 'uint256' },
      { name: 'gasTokenAmount', type: 'uint256' },
      { name: 'data', type: 'bytes32' }
    ]
  },
  domain: { name: 'Mai Protocol' },
  primaryType: 'Order',
  message: data.order.json
}
```

step 2: eip712Msg => signature

rsv = await provider.send('eth_signTypedData_v3', [from, JSON.stringify(eip712Msg)])

signature = vrs = '0x' + rsv.slice(130) + '01' + '0'.repeat(60) + rsv.slice(2, 130)

### HTTP Request

`POST /orders`

### Body JSON Parameters

Parameter | Description | Required | Type | Example
--------- | ----------- | -------- | ---- | -------
orderID | Order id, the id returned when build order | True | string | "0xb767f3c7c1a828e7f2b73648cefb4e14ec158840695017fd0d7ecc97f2c10abe"
signature | Sign with one of the methods described above. | True | string | "0x1c0100000000000000000000000000000000000000000000000000000000000063496baec1d4e92ddc853e01fe6a1a49459c0499a86cefacaa95e32979e0c0a548eb730a046cfcbc730f383214eefc3b723c9ef5ebf9a4de25cf1b1fefc0694a"

## Cancel Order

```shell
curl -X "DELETE" "https://mcdex.io/api/orders/0xb767f3c7c1a828e7f2b73648cefb4e14ec158840695017fd0d7ecc97f2c10abe" -H "Mai-Authentication: xxx"
```

> Response:

```json
{
  "status":0,
  "desc":"success"
}
```

### HTTP Request

`DELETE /orders/<id>`

### URL Parameters

Parameter | Description
--------- | -----------
id | The ID of the order.

## Cancel All Orders

```shell
proxychains curl -X "DELETE" --data '{"marketID": "b2tods"}' "https://mcdex.io/api/orders" -H "Mai-Authentication: xxx" -H 'Content-Type: application/json'
```

> Response:

```json
{
  "status":0,
  "desc":"success"
}
```

### HTTP Request

`DELETE /orders`

### Body JSON Parameters

Parameter | Description | Required | Type | Example
--------- | ----------- | -------- | ---- | -------
marketID | The ID of the market. | True | string | "b2tods"

# WebSocket API

## Market Channel

<aside class="notice">
Don't forget to unsubscribe the previous market's channel when market changed.
</aside>

### Commands

{"type":"unsubscribe","channels":["Market#BTC190610-DAI"]}

{"type":"subscribe","channels":["Market#BTC190712-DAI"]}

```
When connected
```
```json
{
  "type":"level2OrderbookSnapshot",
  "marketID":"BTC190712-DAI",
  "sequence": 1,
  "updatedAt": "2019-11-15T09:21:20.441646431Z",
  "bids":[],
  "asks":[]
}
```
```
When order updated
```
```json
{
  "type":"level2OrderbookUpdate",
  "marketID":"BTC190712-DAI",
  "sequence": 1,
  "updatedAt": "2019-11-15T09:21:20.441646431Z",
  "side":"buy",
  "price":"8000",
  "amount":"0.0001"
}
```
```
Trade history (update)
```
```json
{
  "type": "newMarketTrade",
  "trade": {
    "amount": "1",
    "createdAt": "2019-09-04T04:02:40.514987Z",
    "executedAt": "2019-09-04T04:02:43Z",
    "id": 25,
    "maker": "0xfe4493ce82fee8dcf1a4ea59026509237fc4cf75",
    "makerOrderID": "0xc5096de1615b17530648e5dc50778a9eb40b9064b3266e33b7af2379282b3828",
    "marketID": "BTC190712-DAI",
    "price": "8000",
    "sequence": 0,
    "status": "SUCCESS", // trade status: INIT, SIGNED, SIGN_FAIL, PENDING, SUCCESS, EXECUTE_FAIL, OVERWRITTEN
    "taker": "0xfe4493ce82fee8dcf1a4ea59026509237fc4cf75",
    "takerOrderID": "0x9c3f094821b3d4a8d3a281516864f75e38a5c1c5e5a6325ccc7e3e23569cd255",
    "takerSide": "buy",
    "transactionHash": "0x1ab01020e0237b3ba80373a9e45bb4a585bb9a47706534ccad9272e1182ddc09",
    "transactionID": 21,
    "updatedAt": "2019-09-04T04:02:44.037482725Z"
  }
}
```

## Trader Channel

<aside class="notice">
Don't forget to unsubscribe the previous trader's channel when account changed in the MetaMask.
</aside>

### Commands

{"type":"unsubscribe","channels":["TraderAddress#0x9757400188f2f54b83ac4dc290ab89dde526da10"]}

{"type":"subscribe","channels":["TraderAddress#0xfe4493ce82fee8dcf1a4ea59026509237fc4cf75"]}

```
When balance/locking changed
```
```json
{
  "market_id":"BTC190712-DAI",
  "type":"lockedBalanceChange"
}
```
```
When creating an order
```
```json
{
  "type": "orderChange",
  "order": {
    "amount": "1",
    "availableAmount": "1",
    "canceledAmount": "0",
    "confirmedAmount": "0",
    "createdAt": "2019-09-04T03:45:04.766591635Z",
    "gasFeeAmount": "0.165", // in collateral. example: DAI
    "id": "0x5b84b0033f053f5210cd6713aa4bc81cb86ecc2118228f32e8688c9d8209697e",
    "makerFeeRate": "0.001",
    "makerRebateRate": "0",
    "marketID": "BTC190712-DAI",
    "pendingAmount": "0",
    "price": "8000",
    "side": "buy",
    "status": "pending", // order status: pending, partial_filled, full_filled, canceled
    "takerFeeRate": "0.003",
    "traderAddress": "0xfe4493ce82fee8dcf1a4ea59026509237fc4cf75",
    "type": "limit",
    "updatedAt": "2019-09-04T03:45:04.772992938Z",
    "version": "mai-v1"
  }
}
```
```
When canceling an order
```
```json
{
  "type": "orderChange",
  "order": {
    "amount": "1",
    "availableAmount": "0",
    "canceledAmount": "1",
    "confirmedAmount": "0",
    "createdAt": "2019-09-04T03:45:04.766592Z",
    "gasFeeAmount": "0.165", // in collateral. example: DAI
    "id": "0x5b84b0033f053f5210cd6713aa4bc81cb86ecc2118228f32e8688c9d8209697e",
    "makerFeeRate": "0.001",
    "makerRebateRate": "0",
    "marketID": "BTC190712-DAI",
    "pendingAmount": "0",
    "price": "8000",
    "side": "buy",
    "status": "canceled", // order status: pending, partial_filled, full_filled, canceled
    "takerFeeRate": "0.003",
    "traderAddress": "0xfe4493ce82fee8dcf1a4ea59026509237fc4cf75",
    "type": "limit",
    "updatedAt": "2019-09-04T03:47:33.321000377Z",
    "version": "mai-v1"
  }
}
```
```
When trade established or changed
```
```json
{
  "type": "tradeChange",
  "trade": {
    "amount": "1",
    "createdAt": "2019-09-04T04:02:40.514986846Z",
    "executedAt": "0001-01-01T00:00:00Z",
    "id": 25,
    "maker": "0xfe4493ce82fee8dcf1a4ea59026509237fc4cf75",
    "makerOrderID": "0xc5096de1615b17530648e5dc50778a9eb40b9064b3266e33b7af2379282b3828",
    "marketID": "BTC190712-DAI",
    "price": "8000",
    "sequence": 0,
    "status": "pending", // trade status: INIT, SIGNED, SIGN_FAIL, PENDING, SUCCESS, EXECUTE_FAIL, ABORT
    "taker": "0xfe4493ce82fee8dcf1a4ea59026509237fc4cf75",
    "takerOrderID": "0x9c3f094821b3d4a8d3a281516864f75e38a5c1c5e5a6325ccc7e3e23569cd255",
    "takerSide": "buy",
    "transactionHash": "",
    "transactionID": 21,
    "updatedAt": "2019-09-04T04:02:40.515333505Z"
  }
}
```
```
When user's position is reducing
```
```json
{
  "type": "newClosedPosition"
  "position": {
    "id":
    "transactionHash":
    "trader":
    "marketID":
    "side":
    "amount":
    "openedAt":
    "closedAt":
    "protocol":
    "entryPrice":
    "exitPrice":
  }
}
```

## Full Channel

### Command

{"type":"subscribe","channels":["Full#BTC20290604-DAI"]}

```
When connected
```
```json
{
  "type": "level3OrderbookSnapshot",
  "marketID": "BTC20290604-DAI",
  "sequence": 1,
  "updatedAt": "2019-11-15T09:21:20.441646431Z",
  "bids": [
    {
      "id": "0xcc4f8c162cc441644d14ea7d5d5150f5087f15d4f579ec1ec61ca2fd31f94379",
      "price": "9002",
      "amount": "1"
    }
  ],
  "asks": []
}
```
```
When creating an order
```
```json
{
  "type": "orderChange",
  "order": {
    "amount": "1",
    "availableAmount": "1",         // availableAmount == amount
    "canceledAmount": "0",
    "confirmedAmount": "0",
    "createdAt": "2019-10-09T09:38:08.662507404Z",
    "gasFeeAmount": "0.198", // in collateral. example: DAI
    "id": "0xeddf25e8258412657b1cbbc970c2409e667646f37506054581e85a6e00fe3163",
    "makerFeeRate": "0.001",
    "makerRebateRate": "0",
    "marketID": "BTC20290604-DAI",
    "pendingAmount": "0",
    "price": "9002",
    "side": "buy",
    "status": "pending",
    "takerFeeRate": "0.003",
    "traderAddress": "0x39e38953aa0822bac469da1c252815ddefbfb515",
    "type": "limit",
    "updatedAt": "2019-10-09T09:38:08.666987272Z",
    "version": "mai-v1"
  }
}
```
```
When canceling an order
```
```json
{
  "type": "orderChange",
  "order": {
    "amount": "1",
    "availableAmount": "0", // available == 0
    "canceledAmount": "1",
    "confirmedAmount": "0",
    "createdAt": "2019-10-09T08:44:02.564588Z",
    "gasFeeAmount": "0.198", // in collateral. example: DAI
    "id": "0xcc4f8c162cc441644d14ea7d5d5150f5087f15d4f579ec1ec61ca2fd31f94379",
    "makerFeeRate": "0.001",
    "makerRebateRate": "0",
    "marketID": "BTC20290604-DAI",
    "pendingAmount": "0",
    "price": "9002",
    "side": "buy",
    "status": "canceled",
    "takerFeeRate": "0.003",
    "traderAddress": "0x39e38953aa0822bac469da1c252815ddefbfb515",
    "type": "limit",
    "updatedAt": "2019-10-09T09:40:03.204111519Z",
    "version": "mai-v1"
  }
}
```
```
When matched
```
```json
{
  "type": "tradeChange",
  "trade": {
    "amount": "0.5",
    "createdAt": "2019-10-09T09:42:05.353779898Z",
    "executedAt": null,
    "id": 7,
    "maker": "0xfe4493ce82fee8dcf1a4ea59026509237fc4cf75",
    "makerOrderID": "0x068458cbfcf058473d55daa5eaa8384664faab34475b54636c56d12fa148ea65",
    "marketID": "BTC20290604-DAI",
    "price": "9002",
    "sequence": 0,
    "status": "INIT",  // means a "new trade"
    "taker": "0x39e38953aa0822bac469da1c252815ddefbfb515",
    "takerOrderID": "0x3f009c2b4c67020505b101233b104f4e21b766074199778a985cd50fec4c8c59",
    "takerSide": "buy",
    "transactionHash": null,
    "transactionID": 7
  }
}
```
```
When trade confirmed
```
```json
{
  "type": "tradeChange",
  "trade": {
    "amount": "0.5",
    "createdAt": "2019-10-09T09:42:05.35378Z",
    "executedAt": "2019-10-09T09:42:06Z",
    "id": 7,
    "maker": "0xfe4493ce82fee8dcf1a4ea59026509237fc4cf75",
    "makerOrderID": "0x068458cbfcf058473d55daa5eaa8384664faab34475b54636c56d12fa148ea65",
    "marketID": "BTC20290604-DAI",
    "price": "9002",
    "sequence": 0,
    "status": "SUCCESS",
    "taker": "0x39e38953aa0822bac469da1c252815ddefbfb515",
    "takerOrderID": "0x3f009c2b4c67020505b101233b104f4e21b766074199778a985cd50fec4c8c59",
    "takerSide": "buy",
    "transactionHash": "0x985caffb2666c1e749346774c77b7024fc39ebf6bd78271e07129ba5f6cac618",
    "transactionID": 7
  }
}

{
  "type": "newMarketTrade",
  "trade": {
    "amount": "0.5",
    "createdAt": "2019-10-09T09:42:05.35378Z",
    "executedAt": "2019-10-09T09:42:06Z",
    "id": 7,
    "maker": "0xfe4493ce82fee8dcf1a4ea59026509237fc4cf75",
    "makerOrderID": "0x068458cbfcf058473d55daa5eaa8384664faab34475b54636c56d12fa148ea65",
    "marketID": "BTC20290604-DAI",
    "price": "9002",
    "sequence": 0,
    "status": "SUCCESS",  // always SUCCESS
    "taker": "0x39e38953aa0822bac469da1c252815ddefbfb515",
    "takerOrderID": "0x3f009c2b4c67020505b101233b104f4e21b766074199778a985cd50fec4c8c59",
    "takerSide": "buy",
    "transactionHash": "0x985caffb2666c1e749346774c77b7024fc39ebf6bd78271e07129ba5f6cac618",
    "transactionID": 7
  }
}

{
  "type": "orderChange",
  "order": {
    "amount": "1",  // order amount
    "availableAmount": "0.5",
    "canceledAmount": "0",
    "confirmedAmount": "0.5", // confirmed > 0
    "createdAt": "2019-10-09T09:41:55.054039Z",
    "gasFeeAmount": "0.198", // in collateral. example: DAI
    "id": "0x068458cbfcf058473d55daa5eaa8384664faab34475b54636c56d12fa148ea65",
    "makerFeeRate": "0.001",
    "makerRebateRate": "0",
    "marketID": "BTC20290604-DAI",
    "pendingAmount": "0",
    "price": "9002",
    "side": "sell",
    "status": "full_filled",  // full_filled or partial_filled
    "takerFeeRate": "0.003",
    "traderAddress": "0xfe4493ce82fee8dcf1a4ea59026509237fc4cf75",
    "type": "limit",
    "updatedAt": "2019-10-09T09:42:07.238283592Z",
    "version": "mai-v1"
  }
}
```

## DexStatus Channel

### Command

{"type":"subscribe","channels":["DexStatus"]}

```
when connected
```
```json
{
  "type":"dexStatusSnapshot",
  "marketsStatus":
    [
      {
        "marketID":"BTC291001-DAI",
        "lastPrice":"0",
        "lastIndex":"0"
      }
    ]
}
```
```
when lastPrice changed in ANY market
```
```json
{
  "type":"dexLastPriceChange",
  "status":
    {
      "lastIndex":"0",
      "lastPrice":"8500",
      "marketID":"BTC20290604-DAI"
    }
}
```
```
when ANY market goes into SETTLING status
```
```json
{
  "type":"dexMarketContractStatusChange",
  "status":
    {
      "marketID":"BTC291001-DAI",
      "mpContractStatus":"SETTLING",
      "settlePrice":"6000",
      "settleTime":"2019-11-20T06:39:01Z"
    }
}
```
```
when ANY market goes into SETTLED status
```
```json
{
  "type":"dexMarketContractStatusChange",
  "status":
    {
      "marketID":"BTC291001-DAI",
      "mpContractStatus":"SETTLED",
      "settlePrice":"6000",
      "settleTime":"2019-11-20T06:39:01Z"
    }
}
```

# Errors

The MCDEX API uses the following error codes:

Error Code | Meaning
---------- | -------
-1 | internal server error
-2 | validation error
-3 | http params error
-4 | market not found
-5 | invalid price amount
-6 | order id do not exist
-7 | bad signature
-8 | insufficient balance
-9 | insufficient allowance
-10 | http params validation fail
-11 | authentication failed
-12 | order id do not exist or is not owned by current address
-13 | http error
-14 | api rate-limit error
-15 | order expires must in range [5m, 30days]
