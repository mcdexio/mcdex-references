# MP到期合约

## 简介
MP期货是一种创新的金融工具。

与期货合约的相似之处：
- 有到期日期
- 支持杠杆

杠杆率由上限价格和下限价格确定。交割结算方式是现金结算，避免了通过实物交割来获得加密资产的风险敞口。

与期货合约的不同之处：
- 每个合约都有上限价格和下限价格。任何超出价格上限或低于价格下限的价格都将被视为上限价格/下限价格。
- 保证金完全抵押，无需追加保证金。

## TRUMP 2020合约参数

| 标的物               | TRUMP指数，由 Market Protocol 预言机提供。      | 
| ---------------------|:----------------------------------------------: |
| 协议                 | Market Protocol + Mai Protocol V1 |
| 交易时间             | 7 天 * 24小时        |  
| 最小价格变动单位     | 0.001美元 |   
| 最小委托数量变动单位 | 1 TRUMP |
| 指数价格区间         | 价格上限（$1）和价格下限（$0），如果唐纳德·特朗普赢得2020年美国总统大选，TRUMP合约将会以$1交割，否则会以$0交割。       | 
| 每张合约大小         | 1 TRUMP         |   
| 保证金               | 多头保证金 = (持仓价 - 价格下限) * 持仓大小<br/>空头保证金 = (价格上限 - 持仓价) * 持仓大小<br/>保证金被锁定在智能合约中，直到平仓或交割。<br/>没有追加保证金或强制平仓。     |  
| 到期时间             | 2020-11-5 00:00:00 UTC   |  
| 交割时间             | 到期24小时后进行交割。          |
| 交割价格             | 如果唐纳德·特朗普赢得2020年美国总统大选，TRUMP合约将以$1交割，否则以$0交割。            | 
| 交割方式             | 以保证金代币进行现金结算。      |  
| 已到期但未交割时     | 在此期间，你仍然可以以任何合适的价格（如：交割价）提交委托来平仓。但要开仓的话，只能以低于交割价的价格开多，或以高于交割价的价格开空。 |
| 费用                 | Gas费： 详见 [手续费](/zh-CN/general-information.md#fee)  <br>Market Protocol交易费： 挂单方： 0.02%，吃单方： 0.07% | 

## 架构

![mai-arch](../en-US/asset/mai-arch.png)

## 审计

Mai Protocol已通过ChainSecurity审核。查看 [审计报告](https://github.com/mcdexio/mai-protocol/blob/master/audit/ChainSecurity_MaiProtocol.pdf).

# 开发相关
* [MCDEX订单簿API](https://mcdex.io/doc/api)
* [合约文件](https://github.com/mcdexio/documents)
* [合约源码](https://github.com/mcdexio/mai-protocol)