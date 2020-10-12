//
//  TestAPIClient.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/09/28.
//

import Foundation

class TestAPIClient: API {
    static let shared = TestAPIClient()
    
    private init() {}
    
    func gridSearchGrain(pair: TradePair, timezone: Timezone, direction: TradeDirection, algorithm: TradeAlgorithm) throws -> GridSearchGrainResponse {
        sleep(1)
        
        let tradeSummary = testTradeSummaries[direction]![algorithm]!
        
        let grain =  GridSearchGrain(
            key: TradeGrainKey(
                tradePair: pair,
                timezone: timezone,
                tradeDirection: direction,
                tradeAlgorithm: algorithm
            ),
            positiveProportions: 64.0,
            tradeSummaries: Array(repeating: tradeSummary, count: 144)
        )
        
       return GridSearchGrainResponse(grain: grain)
    }
    
    func gridSearchGrainFirsts() throws -> GridSearchGrainFirstsResponse {
        sleep(1)
        
        var firsts: [GridSearchGrainFirst] = []
        
        for pair in TradePair.allCases {
            for timezone in Timezone.allCases {
                for direction in TradeDirection.allCases {
                    for algorithm in TradeAlgorithm.allCases {
                        let tradeSummary = testTradeSummaries[direction]![algorithm]!
                        
                        let first = GridSearchGrainFirst(
                            key: TradeGrainKey(
                                tradePair: pair,
                                timezone: timezone,
                                tradeDirection: direction,
                                tradeAlgorithm: algorithm
                            ),
                            positiveProportions: 64.0,
                            tradeSummary: tradeSummary
                        )
                        
                        firsts.append(first)
                    }
                }
            }
        }
        
        return GridSearchGrainFirstsResponse(firsts: firsts)
    }
    
    func approveTradeGrains(grains: [ApprovedTradeGrain]) throws -> SuccessResponse {
        sleep(1)
        return SuccessResponse(message: "Approved")
    }
    
    private var pollCount = 0
    
    func tradeGrainStatues(timezone: Timezone, period: Period) throws -> TradeGrainStatesResponse {
        sleep(1)
        
        pollCount += 1
        
        let count = testTradeCounts.count
        let count1 = pollCount % count
        let count2 = (pollCount + 4) % count
        
        var statuses: [TradeGrainState] = []
        
        var i = 0
        for pair in TradePair.allCases {
            for timezone in Timezone.allCases {
                for direction in TradeDirection.allCases {
                    for algorithm in TradeAlgorithm.allCases {
                        let key = TradeGrainKey(tradePair: pair, timezone: timezone, tradeDirection: direction, tradeAlgorithm: algorithm)
                        
                        statuses.append(
                            TradeGrainState(
                                key: key,
                                open: testTradeCounts[(count1 + i) % count],
                                closed: testTradeCounts[(count2 + i) % count]
                            )
                        )
                        
                        i += 1
                    }
                }
            }
        }
        
        return TradeGrainStatesResponse(unrealizedProfit: testProfits[count1], realizedProfit: testProfits[count2], states: statuses)
    }
    
    func tradeGrainParam(pair: TradePair, timezone: Timezone, direction: TradeDirection, algorithm: TradeAlgorithm) throws -> TradeGrainParamsResponse {
        sleep(1)
        
        let key = TradeGrainKey(tradePair: pair, timezone: timezone, tradeDirection: direction, tradeAlgorithm: algorithm)
        let tradeParams = testTradeSummaries[direction]![algorithm]!.tradeParams
        
        return TradeGrainParamsResponse(key: key, params: tradeParams)
    }
    
    func openOrders(pair: TradePair, timezone: Timezone, direction: TradeDirection, algorithm: TradeAlgorithm) throws -> OpenOrdersResponse {
        sleep(1)
        
        pollCount += 1
        let orders = (0..<5).map { testOpenOrders[ (pollCount + $0) % testOpenOrders.count ]}
        
        return OpenOrdersResponse(orders: orders)
    }
    
    func closedOrders(pair: TradePair, timezone: Timezone, direction: TradeDirection, algorithm: TradeAlgorithm, count: Int=50, offset: Int=0) throws -> ClosedOrdersResponse {
        sleep(1)
        
        let all = 120
        let _count = all - offset > count ? count : all - offset
        let orders = Array(repeating: testClosedOrder, count: _count)
        
        return ClosedOrdersResponse(orders: orders, paging: OffsetPafing(all: all, count: _count, offset: offset))
    }
}
