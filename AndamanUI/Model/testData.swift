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
    tradeAlgorithm: TradeAlgorithm.Reaction,
    realizedProfit: 500.0,
    tradeCount: 83,
    reactionTradeAlgorithmParams: reactionTradeAlgorithmParams0,
    breakTradeAlgorithmParams: nil
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
    tradeAlgorithm: TradeAlgorithm.Reaction,
    realizedProfit: -100.0,
    tradeCount: 42,
    reactionTradeAlgorithmParams: reactionTradeAlgorithmParams1,
    breakTradeAlgorithmParams: nil
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
    tradeAlgorithm: TradeAlgorithm.Break,
    realizedProfit: 200.0,
    tradeCount: 64,
    reactionTradeAlgorithmParams: nil,
    breakTradeAlgorithmParams: breakTradeAlgorithmParams0
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
    tradeAlgorithm: TradeAlgorithm.Break,
    realizedProfit: -300.0,
    tradeCount: 25,
    reactionTradeAlgorithmParams: nil,
    breakTradeAlgorithmParams: breakTradeAlgorithmParams1
)

let testTradeSummaries = [
    TradeDirection.Long: [
        TradeAlgorithm.Reaction: reactionTradeSummary0,
        TradeAlgorithm.Break: breakTradeSummary0
    ],
    
    TradeDirection.Short: [
        TradeAlgorithm.Reaction: reactionTradeSummary1,
        TradeAlgorithm.Break: breakTradeSummary1
    ]
]
