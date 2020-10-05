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
    
    var promise: Any?
    
    @Published var grains: [GridSearchGrainKey: GridSearchGrainValue]?
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
    
    func makeGrains(_ flatGrains: [GridSearchGrain]) -> [GridSearchGrainKey: GridSearchGrainValue] {
        var grains: [GridSearchGrainKey: GridSearchGrainValue] = [:]
        
        for grain in flatGrains {
            let key = GridSearchGrainKey(tradePair: grain.tradePair, timezone: grain.timezone, direction: grain.tradeDirection)
            let realizedProfit = grain.tradeSummaries[0].realizedProfit
            
            if var value = grains[key] {
                if value.maxRealizedProfit < realizedProfit && realizedProfit > 0 {
                    value.maxRealizedProfit = realizedProfit
                    value.selected = value.grains.count
                }
                
                value.grains.append(grain)
                grains[key] = value
            } else {
                var selected = -1
                if realizedProfit > 0 {
                    selected = 0
                }
                
                grains[key] = GridSearchGrainValue(grains: [grain], maxRealizedProfit: realizedProfit, selected: selected)
            }
        }
        
        return grains
    }
    
    func fetch() {
        promise = Promise<GridSearchGrainsResponse>(on: .global()) { fulfill, reject in
            do {
                fulfill(try self.api.firstGridSearchGrains())
            } catch(let error) {
                reject(error)
            }
        }
        .then(on: .global()) { resp in
            Promise<[GridSearchGrainKey: GridSearchGrainValue]> { fulfill, _ in
                fulfill(self.makeGrains(resp.grains))
            }
        }
        .then { grains in
            self.grains = grains
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
        self.grains = nil
        self.error = nil
        self.fetch()
    }
}

struct GridSearchGrainKey: Hashable {
    var tradePair: TradePair
    var timezone: Timezone
    var direction: TradeDirection
}

struct GridSearchGrainValue {
    var grains: [GridSearchGrain]
    var maxRealizedProfit: Float
    var selected: Int
}
