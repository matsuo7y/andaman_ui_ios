//
//  TradeStatesViewModel.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/10/13.
//

import Foundation
import Combine
import Promises

class TradeStatesViewModel: ObservableObject {
    private let api = APIInstance
    private var timer: Timer?
    
    private let period: Period
    private let interval: Double
    
    @Published var resp: TradeStatesResponse?
    
    init(period: Period, interval: Double) {
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
        Promise<TradeStatesResponse>(on: .global()) { fulfill, reject in
            do {
                fulfill(try self.api.tradeStates(period: self.period))
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
