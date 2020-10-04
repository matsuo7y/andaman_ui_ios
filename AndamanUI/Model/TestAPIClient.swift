//
//  TestAPIClient.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/09/28.
//

import Foundation
import Combine

class TestAPIClient: API {
    static let shared = TestAPIClient()
    
    private init() {}
    
    func gridSearchGrain(pair: TradePair, timezone: Timezone, direction: TradeDirection, algorithm: TradeAlgorithm) -> Future<GridSearchGrainResponse, APIError> {
        return Future<GridSearchGrainResponse, APIError> { promise in
            sleep(1)
            
            let tradeSummary = testTradeSummaries[direction]![algorithm]!
            
            let grain =  GridSearchGrain(
                tradePair: pair,
                timezone: timezone,
                tradeDirection: direction,
                positiveProportions: 64.0,
                tradeSummaries: Array(repeating: tradeSummary, count: 144)
            )
            
            promise(.success(GridSearchGrainResponse(grain: grain)))
        }
    }
    
    func firstGridSearchGrains() -> Future<GridSearchGrainsResponse, APIError> {
        return Future<GridSearchGrainsResponse, APIError> { promise in
            sleep(1)
            
            var grains: [GridSearchGrain] = []
            
            for pair in TradePair.allCases {
                for timezone in Timezone.allCases {
                    for direction in TradeDirection.allCases {
                        for algorithm in TradeAlgorithm.allCases {
                            let tradeSummary = testTradeSummaries[direction]![algorithm]!
                            
                            let grain = GridSearchGrain(
                                tradePair: pair,
                                timezone: timezone,
                                tradeDirection: direction,
                                positiveProportions: 64.0,
                                tradeSummaries: [tradeSummary]
                            )
                            
                            grains.append(grain)
                        }
                    }
                }
            }
            
            promise(.success(GridSearchGrainsResponse(grains: grains)))
        }
    }
}
