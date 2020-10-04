//
//  GridSearchGrainViewModel.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/09/29.
//

import Foundation
import Combine

class GridSearchGrainViewModel: ObservableObject {
    private let api = TestAPIClient.shared
    
    var cancellable: AnyCancellable?
    
    @Published var grain: GridSearchGrain?
    @Published var error: APIError?
    
    func fetch(pair: TradePair, timezone: Timezone, direction: TradeDirection, algorithm: TradeAlgorithm) {
        cancellable = Deferred {
            self.api.gridSearchGrain(pair: pair, timezone: timezone, direction: direction, algorithm: algorithm)
        }
        .subscribe(on: DispatchQueue.global())
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                self.error = error
            }
        }, receiveValue: { value in
            self.grain = value.grain
        })
    }
}
