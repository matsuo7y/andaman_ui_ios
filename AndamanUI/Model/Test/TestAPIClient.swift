//
//  TestAPIClient.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/09/28.
//

import Foundation

class TestAPIClient: API {
    func gridSearchGrain(pair: TradePair, timezone: Timezone, direction: TradeDirection, algorithm: TradeAlgorithm) -> GridSearchGrainResult {
        let tradeSummary = tradeSummaries[direction]![algorithm]!
        
        return GridSearchGrainResult(
            tradePair: pair,
            timezone: timezone,
            tradeDirection: direction,
            positiveProportions: 64.0,
            tradeSummaries: [tradeSummary, tradeSummary, tradeSummary])
    }
    
    func firstGridSearchGrains() -> GridSearchGrainResults {
        <#code#>
    }
}
