//
//  TradeGrainStatesViewModel.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/10/12.
//

import Foundation
import Combine
import Promises

class TradeGrainStatesViewModel: ObservableObject {
    private let api = APIInstance
    private var timer: Timer?
    
    private let tradePair: TradePair
    private let timezone: Timezone
    private let period: Period
    private let interval: Double
    
    @Published var resp: TradeGrainStatesResponse?
    
    init(tradePair: TradePair, timezone: Timezone, period: Period, interval: Double) {
        self.tradePair = tradePair
        self.timezone = timezone
        self.period = period
        self.interval = interval
    }
    
    func start(_ errorHandler: @escaping (Error) -> ()) {
        self.timer = Timer.scheduledTimer(withTimeInterval: self.interval, repeats: true, block: { _ in
            self.fetch(errorHandler)
        })
    }
    
    func end() {
        self.timer?.invalidate()
    }
    
    func fetch(_ errorHandler: @escaping (Error) -> ()) {
        Promise<TradeGrainStatesResponse>(on: .global()) { fulfill, reject in
            do {
                fulfill(try self.api.tradeGrainStates(pair: self.tradePair, timezone: self.timezone, period: self.period))
            } catch(let error) {
                reject(error)
            }
        }
        .then { self.resp = $0 }
        .catch { errorHandler($0) }
    }
    
    deinit {
        self.end()
    }
}
