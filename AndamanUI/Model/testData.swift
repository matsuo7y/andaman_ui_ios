//
//  testData.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/09/28.
//

import Foundation

let reactionTradeAlgorithmParams0 = ReactionTradeAlgorithmParams(
    tradeDirectionLong: true,
    smallFrameLength: 30,
    largeFrameLength: 60,
    pipsGapForCreateOrder: 10.0,
    pipsForStopLoss: -100.0,
    pipsForAdditionalOrder: -5.0,
    timeForProfit1: 20,
    timeForProfit2: 40,
    timeForProfit3: 60,
    pipsForProfit1: 20.0,
    pipsForProfit2: 10.0,
    pipsForProfit3: 5.0
)

let reactionTradeSummary0 = TradeSummary(
    tradeAlgorithm: TradeAlgorithm.reaction,
    realizedProfit: 500.0,
    tradeCount: 83,
    tradeParams: reactionTradeAlgorithmParams0
)

let reactionTradeAlgorithmParams1 = ReactionTradeAlgorithmParams(
    tradeDirectionLong: false,
    smallFrameLength: 60,
    largeFrameLength: 120,
    pipsGapForCreateOrder: 20.0,
    pipsForStopLoss: -150.0,
    pipsForAdditionalOrder: -20.0,
    timeForProfit1: 45,
    timeForProfit2: 90,
    timeForProfit3: 135,
    pipsForProfit1: 30.0,
    pipsForProfit2: 15.0,
    pipsForProfit3: 10.0
)

let reactionTradeSummary1 = TradeSummary(
    tradeAlgorithm: TradeAlgorithm.reaction,
    realizedProfit: -100.0,
    tradeCount: 42,
    tradeParams: reactionTradeAlgorithmParams1
)

let breakTradeAlgorithmParams0 = BreakTradeAlgorithmParams(
    tradeDirectionLong: true,
    smallFrameLength: 45,
    largeFrameLength: 90,
    pipsGapForCreateOrder: 15.0,
    pipsForStopLoss: -120.0,
    pipsForAdditionalOrder: -15.0,
    timeForProfit1: 50,
    timeForProfit2: 100,
    timeForProfit3: 150,
    pipsForProfit1: 40.0,
    pipsForProfit2: 20.0,
    pipsForProfit3: 10.0
)

let breakTradeSummary0 = TradeSummary(
    tradeAlgorithm: TradeAlgorithm.breaking,
    realizedProfit: 200.0,
    tradeCount: 64,
    tradeParams: breakTradeAlgorithmParams0
)

let breakTradeAlgorithmParams1 = BreakTradeAlgorithmParams(
    tradeDirectionLong: false,
    smallFrameLength: 60,
    largeFrameLength: 120,
    pipsGapForCreateOrder: 20.0,
    pipsForStopLoss: -150.0,
    pipsForAdditionalOrder: -20.0,
    timeForProfit1: 45,
    timeForProfit2: 90,
    timeForProfit3: 135,
    pipsForProfit1: 30.0,
    pipsForProfit2: 15.0,
    pipsForProfit3: 10.0
)

let breakTradeSummary1 = TradeSummary(
    tradeAlgorithm: TradeAlgorithm.breaking,
    realizedProfit: -300.0,
    tradeCount: 25,
    tradeParams: breakTradeAlgorithmParams1
)

let testTradeSummaries = [
    TradeDirection.long: [
        TradeAlgorithm.reaction: reactionTradeSummary0,
        TradeAlgorithm.breaking: breakTradeSummary0
    ],
    
    TradeDirection.short: [
        TradeAlgorithm.reaction: reactionTradeSummary1,
        TradeAlgorithm.breaking: breakTradeSummary1
    ]
]

let testTradeCounts = [
    TradeCount(count: 0, profit: -12.0),
    TradeCount(count: 5, profit: -6.0),
    TradeCount(count: 7, profit: -1.102),
    TradeCount(count: 9, profit: 1.467),
    TradeCount(count: 13, profit: 3.98),
    TradeCount(count: 24, profit: 8.0963),
    TradeCount(count: 13, profit: 78.2434),
    TradeCount(count: 89, profit: 126.3464)
]

var testProfits: [Float] = [
    34.2,
    -12.4765,
    472.1256,
    -124.679,
    25.39,
    98.736,
    -46.87,
    136.3478
]

var testOpenOrders = [
    Order(tradePair: TradePair.GbpUsd, units: 10000.0, timeAtOpen: 1600939486, priceAtOpen: 1.2372, timeAtClose: nil, priceAtClose: nil, profit: 3.6),
    Order(tradePair: TradePair.GbpUsd, units: 10000.0, timeAtOpen: 1596365014, priceAtOpen: 1.5467, timeAtClose: nil, priceAtClose: nil, profit: 4.5),
    Order(tradePair: TradePair.GbpUsd, units: 10000.0, timeAtOpen: 1604356572, priceAtOpen: 1.1937, timeAtClose: nil, priceAtClose: nil, profit: 22.8),
    Order(tradePair: TradePair.GbpUsd, units: 10000.0, timeAtOpen: 1601813284, priceAtOpen: 1.7498, timeAtClose: nil, priceAtClose: nil, profit: 15.5),
    Order(tradePair: TradePair.GbpUsd, units: 10000.0, timeAtOpen: 1609445384, priceAtOpen: 1.3367, timeAtClose: nil, priceAtClose: nil, profit: 8.2),
]

func testClosedOrder(index: Int) -> Order {
    return Order(
        tradePair: TradePair.UsdJpy, units: 1000.0, timeAtOpen: 1602484464, priceAtOpen: Float(index), timeAtClose: 1602486772, priceAtClose: 105.783, profit: 23.5
    )
}
