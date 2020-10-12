//
//  definitions.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/09/28.
//

import Foundation

// Internal
struct AlertError: Error {
    var title: String
    var message: String
}

struct AlertWarning {
    var title: String
}

// Definitions for Grid Search
struct ReactionTradeAlgorithmParams: TradeParams {
    let tradeDirectionLong: Bool
    
    let smallFrameLength: Int
    let largeFrameLength: Int
    
    let pipsGapForCreateOrder: Float
    let pipsForStopLoss: Float
    let pipsForAdditionalOrder: Float
    
    let timeForProfit1: Int
    let timeForProfit2: Int
    let timeForProfit3: Int
    
    let pipsForProfit1: Float
    let pipsForProfit2: Float
    let pipsForProfit3: Float
}

struct BreakTradeAlgorithmParams: TradeParams {
    let tradeDirectionLong: Bool
    
    let smallFrameLength: Int
    let largeFrameLength: Int
    
    let pipsGapForCreateOrder: Float
    let pipsForStopLoss: Float
    let pipsForAdditionalOrder: Float
    
    let timeForProfit1: Int
    let timeForProfit2: Int
    let timeForProfit3: Int
    
    let pipsForProfit1: Float
    let pipsForProfit2: Float
    let pipsForProfit3: Float
}

struct TradeSummary {
    let tradeAlgorithm: TradeAlgorithm
    let realizedProfit: Float
    let tradeCount: Int
    let tradeParams: Any
}

struct TradeGrainKey {
    let tradePair: TradePair
    let timezone: Timezone
    let tradeDirection: TradeDirection
    let tradeAlgorithm: TradeAlgorithm
}

struct GridSearchGrain {
    let key: TradeGrainKey
    let positiveProportions: Float
    let tradeSummaries: [TradeSummary]
}

struct GridSearchGrainFirst {
    let key: TradeGrainKey
    let positiveProportions: Float
    let tradeSummary: TradeSummary
}

// Definitions for Trade
struct TradeGrainStatus {
    let key: TradeGrainKey
    let open: TradeCount
    let closed: TradeCount
}

struct TradeCount {
    let count: Int
    let profit: Float
}

struct Order {
    let tradePair: TradePair
    let units: Float
    let timeAtOpen: Int
    let priceAtOpen: Float
    let timeAtClose: Int?
    let priceAtClose: Float?
    let profit: Float
}

struct OffsetPafing {
    let all: Int
    let count: Int
    let offset: Int
}

// Response for Grid Search
struct GridSearchGrainResponse {
    let grain: GridSearchGrain
}

struct GridSearchGrainFirstsResponse {
    let firsts: [GridSearchGrainFirst]
}

// Response for Trade
struct TradeGrainStatusesResponse {
    let unrealizedProfit: Float
    let realizedProfit: Float
    let statuses: [TradeGrainStatus]
}

struct TradeGrainParamsResponse {
    let key: TradeGrainKey
    let params: Any
}

struct OpenOrdersResponse {
    let orders: [Order]
}

struct ClosedOrdersResponse {
    let orders: [Order]
    let paging: OffsetPafing
}

// Response for General
struct SuccessResponse {
    let message: String
}

// Requests
struct ApprovedTradeGrain {
    let key: TradeGrainKey
    let tradeParams: Any
}

struct ApprovedTradeGrainsRequest {
    let grains: [ApprovedTradeGrain]
}
