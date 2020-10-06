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
        return SuccessResponse(message: "approved")
    }
}
