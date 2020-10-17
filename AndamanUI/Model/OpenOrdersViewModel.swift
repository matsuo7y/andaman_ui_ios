//
//  OpenOrdersViewModel.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/10/17.
//

import Foundation
import Combine
import Promises

class OpenOrdersViewModel: ObservableObject {
    private let api = APIInstance
    private var timer: Timer?
    
    private let tradePair: TradePair
    private let timezone: Timezone
    private let direction: TradeDirection
    private let algorithm: TradeAlgorithm
    private let interval: Double
    
    @Published var resp: OpenOrdersResponse?
    
    init(tradePair: TradePair, timezone: Timezone, direction: TradeDirection, algorithm: TradeAlgorithm, interval: Double) {
        self.tradePair = tradePair
        self.timezone = timezone
        self.direction = direction
        self.algorithm = algorithm
        self.interval = interval
    }
    
    func start(_ errorHandler: @escaping (Error) -> ()) {
        self.timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true, block: { _ in
            self.fetch(errorHandler)
        })
    }
    
    func end() {
        self.timer?.invalidate()
    }
    
    func fetch(_ errorHandler: @escaping (Error) -> ()) {
        Promise<OpenOrdersResponse>(on: .global()) { fulfill, reject in
            do {
                fulfill(try self.api.openOrders(pair: self.tradePair, timezone: self.timezone, direction: self.direction, algorithm: self.algorithm))
            } catch(let error) {
                reject(error)
            }
        }
        .then { self.resp = $0 }
        .catch { errorHandler($0)}
    }
    
    deinit {
        self.end()
    }
}
