//
//  TradeParamsView.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/10/12.
//

import SwiftUI
import Combine

struct TradeParamsView: View {
    @ObservedObject var model: TradeParamsViewModel
    @State var alertView: Alert?
    
    init(tradePair: TradePair, timezone: Timezone, direction: TradeDirection, algorithm: TradeAlgorithm) {
        self.model = TradeParamsViewModel(tradePair: tradePair, timezone: timezone, direction: direction, algorithm: algorithm)
    }
    
    var successView: some View {
        LazyVGrid(columns: GridItem.flexible2, alignment: .leading, spacing: 5) {
            ForEach(self.model.tradeParams!.params) { param in
                Text(param.key).foregroundColor(.red)
                Text(param.value)
            }
        }
        .padding()
    }
    
    var fetchView: some View {
        Text("fetching...")
    }
    
    @ViewBuilder
    var contentView: some View {
        if self.model.tradeParams != nil {
            successView
        } else {
            fetchView
        }
    }
    
    private func errorHandler(_ error: Error) {
        if let _error = error as? APIError {
            self.alertView = Alert(title: Text(_error.statusCode.display), message: Text(_error.message))
        }
    }
    
    var body: some View {
        contentView
            .onAppear { self.model.fetch(errorHandler) }
            .alert(item: self.$alertView) { $0 }
    }
}

