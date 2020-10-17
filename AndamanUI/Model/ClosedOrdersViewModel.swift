//
//  ClosedOrdersViewModel.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/10/17.
//

import Foundation
import Combine
import Promises

class ClosedOrdersViewModel: ObservableObject {
    private let api = APIInstance
    
    private let tradePair: TradePair
    private let timezone: Timezone
    private let direction: TradeDirection
    private let algorithm: TradeAlgorithm
    
    @Published var resp: ClosedOrdersResponse?
    
    init(tradePair: TradePair, timezone: Timezone, direction: TradeDirection, algorithm: TradeAlgorithm) {
        self.tradePair = tradePair
        self.timezone = timezone
        self.direction = direction
        self.algorithm = algorithm
    }
    
    func fetch(_ errorHandler: @escaping (Error) -> (), count: Int = 20, offset: Int = 0) {
        Promise<ClosedOrdersResponse>(on: .global()) { fulfill, reject in
            do {
                fulfill(try self.api.closedOrders(
                            pair: self.tradePair, timezone: self.timezone, direction: self.direction, algorithm: self.algorithm,
                            count: count, offset: offset))
            } catch(let error) {
                reject(error)
            }
        }
        .then { self.resp = $0 }
        .catch { errorHandler($0) }
    }
}
