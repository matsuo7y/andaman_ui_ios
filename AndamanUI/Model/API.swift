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
}

struct APIError: Error, Identifiable {
    var id = UUID()
    let statusCode: Int
    let message: String
}
