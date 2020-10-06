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
    
    @Published var firstsDict: [GridSearchGrainKey: GridSearchGrainFirstValue]?
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
    
    private func makeFirstsDict(_ flatFirsts: [GridSearchGrainFirst]) -> [GridSearchGrainKey: GridSearchGrainFirstValue] {
        var firsts: [GridSearchGrainKey: GridSearchGrainFirstValue] = [:]
        
        for first in flatFirsts {
            let key = GridSearchGrainKey(tradePair: first.key.tradePair, timezone: first.key.timezone, direction: first.key.tradeDirection)
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
            Promise<[GridSearchGrainKey: GridSearchGrainFirstValue]> { fulfill, _ in
                fulfill(self.makeFirstsDict(resp.firsts))
            }
        }
        .then { firsts in
            self.firstsDict = firsts
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
        self.firstsDict = nil
        self.error = nil
        self.fetch()
    }
    
    func adopt(key: GridSearchGrainKey, index: Int) -> AlertError? {
        if var value = self.firstsDict![key] {
            if value.firsts[index].tradeSummary.realizedProfit > 0 {
                value.selected[index] = true
                self.firstsDict![key] = value
                return nil
            }
            return AlertError(title: "Adopt Error", message: "realized profit should be positive")
        }
        return AlertError(title: "Adopt Error", message: "no key")
    }
    
    func dismiss(key: GridSearchGrainKey, index: Int) {
        if var value = self.firstsDict![key] {
            value.selected[index] = false
            self.firstsDict![key] = value
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
    var selected: [Bool]
}
