//
//  GridSearchGrainViewModel.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/09/29.
//

import Foundation
import Combine
import Promises

class GridSearchGrainViewModel: ObservableObject {
    private let api = TestAPIClient.shared
    
    @Published var grain: GridSearchGrain?
    
    func fetch(pair: TradePair, timezone: Timezone, direction: TradeDirection, algorithm: TradeAlgorithm, errorHandler: @escaping (Error) -> ()) {
        Promise<GridSearchGrainResponse>(on: .global()) { fulfill, reject in
            do {
                fulfill(try self.api.gridSearchGrain(pair: pair, timezone: timezone, direction: direction, algorithm: algorithm))
            } catch(let error) {
                reject(error)
            }
        }
        .then { self.grain = $0.grain }
        .catch { errorHandler($0) }
    }
}
