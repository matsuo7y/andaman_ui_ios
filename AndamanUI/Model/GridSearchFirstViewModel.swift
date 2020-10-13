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
    private let api = APIInstance
    
    @Published var firstsDict: [GridSearchGrainKey: GridSearchGrainFirstValue]?
    
    var approvedTradeGrains: [ApprovedTradeGrain]?
    
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
    
    func fetch(_ errorHandler: @escaping (Error) -> ()) {
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
        .then { self.firstsDict = $0 }
        .catch { errorHandler($0) }
    }
    
    func refresh(_ errorHandler: @escaping (Error) -> ()) {
        self.firstsDict = nil
        self.fetch(errorHandler)
    }
    
    func adopt(key: GridSearchGrainKey, index: Int) -> AlertError? {
        guard var value = self.firstsDict![key] else {
            return AlertError(title: "Adopt Error", message: "no key")
        }
        
        if value.firsts[index].tradeSummary.realizedProfit > 0 {
            value.selected[index] = true
            self.firstsDict![key] = value
            return nil
        }
        
        return AlertError(title: "Adopt Error", message: "realized profit should be positive")
    }
    
    func dismiss(key: GridSearchGrainKey, index: Int) {
        if var value = self.firstsDict![key] {
            value.selected[index] = false
            self.firstsDict![key] = value
        }
    }
    
    func beforeApprove(successHandler: @escaping (AlertWarning) -> (), errorHandler: @escaping (AlertError) -> ()) {
        Promise<AlertWarning>(on: .global()) { fulfill, reject in
            guard self.firstsDict != nil else {
                reject(AlertError(title: "Approve", message: "refresh before approve"))
                return
            }
            
            fulfill(AlertWarning(title: "Really approve?"))
        }
        .then { successHandler($0) }
        .catch { errorHandler($0 as! AlertError) }
     }
    
    func approve(successHandler: @escaping (SuccessResponse) -> (), errorHandler: @escaping (Error) -> ()) {
        Promise<SuccessResponse>(on: .global()) { fulfill, reject in
            var grains: [ApprovedTradeGrain] = []
            
            for (_, value) in self.firstsDict! {
                for (i, first) in value.firsts.enumerated() {
                    if value.selected[i] {
                        let key = TradeGrainKey(
                            tradePair: first.key.tradePair,
                            timezone: first.key.timezone,
                            tradeDirection: first.key.tradeDirection,
                            tradeAlgorithm: first.key.tradeAlgorithm
                        )
                        
                        grains.append(ApprovedTradeGrain(key: key, tradeParams: first.tradeSummary.tradeParams))
                    }
                }
            }
            
            do {
                fulfill(try self.api.approveTradeGrains(grains: grains))
            } catch(let error) {
                reject(error)
            }
        }
        .then { successHandler($0) }
        .catch { errorHandler($0) }
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
