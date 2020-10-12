//
//  API.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/09/28.
//

import Foundation

protocol API {
    func gridSearchGrain(pair: TradePair, timezone: Timezone, direction: TradeDirection, algorithm: TradeAlgorithm) throws -> GridSearchGrainResponse
    
    func gridSearchGrainFirsts() throws -> GridSearchGrainFirstsResponse
    
    func approveTradeGrains(grains: [ApprovedTradeGrain]) throws -> SuccessResponse
    
    func tradeGrainStatues(timezone: Timezone, period: Period) throws -> TradeGrainStatusesResponse
    
    func tradeGrainParam(pair: TradePair, timezone: Timezone, direction: TradeDirection, algorithm: TradeAlgorithm) throws -> TradeGrainParamsResponse
    
    func openOrders(pair: TradePair, timezone: Timezone, direction: TradeDirection, algorithm: TradeAlgorithm) throws -> OpenOrdersResponse
    
    func closedOrders(pair: TradePair, timezone: Timezone, direction: TradeDirection, algorithm: TradeAlgorithm, count: Int, offset: Int) throws -> ClosedOrdersResponse
}

struct APIError: Error, Identifiable {
    var id = UUID()
    let statusCode: Int
    let message: String
}
