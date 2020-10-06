//
//  GridSearchFirstViewModel.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/10/05.
//

import Foundation
import Combine
import Promises

class GridSearchFirstViewModel: ObservableObject {
    private let api = TestAPIClient.shared
    
    @Published var firsts: [GridSearchGrainKey: GridSearchGrainFirstValue]?
    @Published var error: APIError?
    
    var keys: [GridSearchGrainKey] {
        var keys: [GridSearchGrainKey] = []
        for tradePair in TradePair.allCases {
            for timezone in Timezone.allCases {
                for direction in TradeDirection.allCases {
                    keys.append(GridSearchGrainKey(tradePair: tradePair, timezone: timezone, direction: direction))
                }
            }
        }
        return keys
    }
    
    func makeFirsts(_ flatFirsts: [GridSearchGrainFirst]) -> [GridSearchGrainKey: GridSearchGrainFirstValue] {
        var firsts: [GridSearchGrainKey: GridSearchGrainFirstValue] = [:]
        
        for first in flatFirsts {
            let key = GridSearchGrainKey(tradePair: first.tradePair, timezone: first.timezone, direction: first.tradeDirection)
            let realizedProfit = first.tradeSummary.realizedProfit
            
            if var value = firsts[key] {
                if value.maxRealizedProfit < realizedProfit && realizedProfit > 0 {
                    value.maxRealizedProfit = realizedProfit
                    value.selected = value.firsts.count
                }
                
                value.firsts.append(first)
                firsts[key] = value
            } else {
                var selected = -1
                if realizedProfit > 0 {
                    selected = 0
                }
                
                firsts[key] = GridSearchGrainFirstValue(firsts: [first], maxRealizedProfit: realizedProfit, selected: selected)
            }
        }
        
        return firsts
    }
    
    func fetch() {
        Promise<GridSearchGrainFirstsResponse>(on: .global()) { fulfill, reject in
            do {
                fulfill(try self.api.gridSearchGrainFirsts())
            } catch(let error) {
                reject(error)
            }
        }
        .then(on: .global()) { resp in
            Promise<[GridSearchGrainKey: GridSearchGrainFirstValue]> { fulfill, _ in
                fulfill(self.makeFirsts(resp.firsts))
            }
        }
        .then { firsts in
            self.firsts = firsts
        }
        .catch { error in
            if let _error = error as? APIError {
                self.error = _error
            } else {
                print(error)
            }
        }
    }
    
    func refresh() {
        self.firsts = nil
        self.error = nil
        self.fetch()
    }
    
    func adopt(key: GridSearchGrainKey, selected: Int) -> AlertError? {
        if var value = self.firsts![key] {
            if value.firsts[selected].tradeSummary.realizedProfit > 0 {
                value.selected = selected
                self.firsts![key] = value
                return nil
            }
            return AlertError(title: "Adopt Error", message: "realized profit should be positive")
        }
        return AlertError(title: "Adopt Error", message: "no key")
    }
    
    func dismiss(key: GridSearchGrainKey) {
        if var value = self.firsts![key] {
            value.selected = -1
            self.firsts![key] = value
        }
    }
}

struct GridSearchGrainKey: Hashable {
    var tradePair: TradePair
    var timezone: Timezone
    var direction: TradeDirection
}

struct GridSearchGrainFirstValue {
    var firsts: [GridSearchGrainFirst]
    var maxRealizedProfit: Float
    var selected: Int
}
