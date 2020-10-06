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
    
    @Published var firsts: [GridSearchGrainSimpleKey: GridSearchGrainFirstValue]?
    @Published var error: APIError?
    
    var keys: [GridSearchGrainSimpleKey] {
        var keys: [GridSearchGrainSimpleKey] = []
        for tradePair in TradePair.allCases {
            for timezone in Timezone.allCases {
                for direction in TradeDirection.allCases {
                    keys.append(GridSearchGrainSimpleKey(tradePair: tradePair, timezone: timezone, direction: direction))
                }
            }
        }
        return keys
    }
    
    private func makeFirsts(_ flatFirsts: [GridSearchGrainFirst]) -> [GridSearchGrainSimpleKey: GridSearchGrainFirstValue] {
        var firsts: [GridSearchGrainSimpleKey: GridSearchGrainFirstValue] = [:]
        
        for first in flatFirsts {
            let key = GridSearchGrainSimpleKey(tradePair: first.key.tradePair, timezone: first.key.timezone, direction: first.key.tradeDirection)
            let realizedProfit = first.tradeSummary.realizedProfit
            
            if var value = firsts[key] {
                let selected = realizedProfit > 0 ? true : false
                
                value.firsts.append(first)
                value.selected.append(selected)
                
                firsts[key] = value
            } else {
                let selected = realizedProfit > 0 ? true : false
                firsts[key] = GridSearchGrainFirstValue(firsts: [first], selected: [selected])
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
            Promise<[GridSearchGrainSimpleKey: GridSearchGrainFirstValue]> { fulfill, _ in
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
    
    func adopt(key: GridSearchGrainSimpleKey, index: Int) -> AlertError? {
        if var value = self.firsts![key] {
            if value.firsts[index].tradeSummary.realizedProfit > 0 {
                value.selected[index] = true
                self.firsts![key] = value
                return nil
            }
            return AlertError(title: "Adopt Error", message: "realized profit should be positive")
        }
        return AlertError(title: "Adopt Error", message: "no key")
    }
    
    func dismiss(key: GridSearchGrainSimpleKey, index: Int) {
        if var value = self.firsts![key] {
            value.selected[index] = false
            self.firsts![key] = value
        }
    }
}

struct GridSearchGrainSimpleKey: Hashable {
    var tradePair: TradePair
    var timezone: Timezone
    var direction: TradeDirection
}

struct GridSearchGrainFirstValue {
    var firsts: [GridSearchGrainFirst]
    var selected: [Bool]
}
