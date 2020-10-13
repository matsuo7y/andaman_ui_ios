//
//  TradeParamsViewModel.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/10/13.
//

import Foundation
import Combine
import Promises

class TradeParamsViewModel: ObservableObject {
    private let api = APIInstance
    
    private let tradePair: TradePair
    private let timezone: Timezone
    private let direction: TradeDirection
    private let algorithm: TradeAlgorithm
    
    @Published var tradeParams: TradeParams?
    
    init(tradePair: TradePair, timezone: Timezone, direction: TradeDirection, algorithm: TradeAlgorithm) {
        self.tradePair = tradePair
        self.timezone = timezone
        self.direction = direction
        self.algorithm = algorithm
    }
    
    func fetch(_ errorHandler: @escaping (Error) -> ()) {
        Promise<TradeGrainParamsResponse>(on: .global()) { fulfill, reject in
            do {
                fulfill(try self.api.tradeGrainParam(pair: self.tradePair, timezone: self.timezone, direction: self.direction, algorithm: self.algorithm))
            } catch(let error) {
                reject(error)
            }
        }
        .then {
            if let tradeParams = $0.params as? TradeParams {
                self.tradeParams = tradeParams
            }
        }
        .catch { errorHandler($0) }
    }
}
