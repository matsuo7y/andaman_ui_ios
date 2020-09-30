//
//  API.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/09/28.
//

import Foundation
import Combine

protocol API {
    func gridSearchGrain(pair: TradePair, timezone: Timezone, direction: TradeDirection, algorithm: TradeAlgorithm) -> Future<GridSearchGrainResponse, APIError>
    
    func firstGridSearchGrains() -> Future<GridSearchGrainsResponse, APIError>
}

struct APIError: Error {
    let statusCode: Int
    let message: String
}
