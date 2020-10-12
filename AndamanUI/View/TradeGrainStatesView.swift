//
//  TradeGrainStatesView.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/10/12.
//

import SwiftUI
import Combine

struct TradeGrainStatesView: View {
    @ObservedObject var model: TradeGrainStatesViewModel
    
    @State var alertView: Alert?
    
    init(timezone: Timezone, period: Period) {
        self.model = TradeGrainStatesViewModel(timezone: timezone, period: period, interval: 4.0)
    }
    
    var headerView: some View {
        LazyVGrid(columns: GridItem.flexible2, alignment: .leading, spacing: 5) {
            Text("Unrealized Profit").foregroundColor(.blue)
            Text(self.model.resp!.unrealizedProfit.display())
            
            Text("Realized Profit").foregroundColor(.red)
            Text(self.model.resp!.realizedProfit.display())
        }
        .padding()
    }
    
    var statesView: some View {
        ScrollView {
            ForEach(self.model.resp!.states, id: \.self) { state in
                HStack {
                    LazyVGrid(columns: GridItem.flexible1, alignment: .leading, spacing: 5) {
                        Text(state.key.tradePair.display).fontWeight(.bold)
                        Text(state.key.timezone.display)
                        Text(state.key.tradeDirection.display)
                        Text(state.key.tradeAlgorithm.display)
                    }
                    .frame(width: 100, alignment: .leading)
                    
                    Divider()
                    
                    VStack {
                        Text("open").fontWeight(.bold).frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        Text(state.open.profit.display()).frame(maxWidth: .infinity, alignment: .leading).foregroundColor(.blue)
                        Spacer()
                        Text(state.open.count.display).frame(maxWidth: .infinity, alignment: .leading).foregroundColor(.blue).fontWeight(.bold)
                    }
                    .frame(width: 100, alignment: .leading)
                    
                    Divider()
                    
                    VStack {
                        Text("closed").fontWeight(.bold).frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        Text(state.closed.profit.display()).frame(maxWidth: .infinity, alignment: .leading).foregroundColor(.red)
                        Spacer()
                        Text(state.closed.count.display).frame(maxWidth: .infinity, alignment: .leading).foregroundColor(.red).fontWeight(.bold)
                    }
                    .frame(width: 100, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 12)
                
                Divider()
            }
        }
    }
    
    var successView: some View {
        VStack {
            headerView
            Divider()
            statesView
        }
    }
    
    var fetchView: some View {
        Text("fetching...")
    }
    
    @ViewBuilder
    var contentView: some View {
        if self.model.resp != nil {
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
            .onAppear { self.model.fetch(errorHandler: errorHandler) }
            .onDisappear { self.model.end() }
            .alert(item: self.$alertView) { $0 }
    }
}
