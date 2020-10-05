//
//  GridSearchFirstViewModel.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/10/05.
//

import Foundation
import Combine

class GridSearchFirstViewModel: ObservableObject {
    private let api = TestAPIClient.shared
    
    var cancellable: AnyCancellable?
    
    @Published var grains: [GridSearchGrain]?
    @Published var error: APIError?
    
    func fetch() {
        cancellable = Deferred {
            self.api.firstGridSearchGrains()
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
            self.grains = value.grains
        })
    }
    
    func refresh() {
        self.grains = nil
        self.error = nil
        self.fetch()
    }
}
