//
//  API.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/09/28.
//

import Foundation

protocol API {
    func gridSearchGrain(pair: TradePair, timezone: Timezone, direction: TradeDirection, algorithm: TradeAlgorithm) -> GridSearchGrainResult
    
    func firstGridSearchGrains() -> GridSearchGrainResults
}
