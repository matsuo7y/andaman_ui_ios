//
//  GridSearchGrainView.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/09/29.
//

import SwiftUI
import Combine

struct GridSearchGrainView: View {
    @ObservedObject var model: GridSearchGrainViewModel = GridSearchGrainViewModel()
    
    @State var sheetView: TradeSummaryView?
    @State var alertView: Alert?
    
    let pair: TradePair
    let timezone: Timezone
    let direction: TradeDirection
    let algorithm: TradeAlgorithm
    
    init(pair: TradePair, timezone: Timezone, direction: TradeDirection, algorithm: TradeAlgorithm) {
        self.pair = pair
        self.timezone = timezone
        self.direction = direction
        self.algorithm = algorithm
    }
    
    var headerView: some View {
        LazyVGrid(columns: GridItem.flexible2, alignment: .leading, spacing: 5) {
            let grain = self.model.grain!
            
            Text("Trade Pair").foregroundColor(.blue)
            Text(grain.key.tradePair.display)
            
            Text("Timezone").foregroundColor(.blue)
            Text(grain.key.timezone.display)
            
            Text("Direction").foregroundColor(.blue)
            Text(grain.key.tradeDirection.display)
            
            Text("Algorithm").foregroundColor(.blue)
            Text(grain.key.tradeAlgorithm.display)
            
            Text("Positive").foregroundColor(.blue)
            Text(grain.positiveProportions.display()).foregroundColor(.green).bold()
        }
        .padding()
    }
    
    var tradeSummariesView: some View {
        ScrollView {
            LazyVGrid(columns: GridItem.flexible3, alignment: .leading, spacing: 5) {
                Text("Realized Profit").foregroundColor(.red)
                Text("Trade Count").foregroundColor(.red)
                Text("")
                
                let grain = self.model.grain!
                ForEach(0..<grain.tradeSummaries.count) {
                    let tradeSummary = grain.tradeSummaries[$0]
                    
                    Text(tradeSummary.realizedProfit.display())
                    Text(tradeSummary.tradeCount.display)
                    Button(action: { self.sheetView = TradeSummaryView(tradeSummary: tradeSummary) }) {
                        Text("Detail").foregroundColor(.blue)
                    }
                }
            }
            .padding()
        }
    }
    
    var successView: some View {
        VStack(alignment: .leading) {
            headerView
            Divider()
            tradeSummariesView
        }
    }
    
    var fetchView: some View {
        Text("fetching...").fontWeight(.bold)
    }
    
    @ViewBuilder
    var content: some View {
        if self.model.grain != nil {
            successView
        } else {
            fetchView
        }
    }
    
    private func errorHandler(_ error: Error) {
        guard let _error = error as? APIError else {
            print(error)
            return
        }
        
        self.alertView = Alert(title: Text(_error.statusCode.display), message: Text(_error.message))
    }
    
    var body: some View {
        content.onAppear {
            self.model.fetch(pair: pair, timezone: timezone, direction: direction, algorithm: algorithm, errorHandler: errorHandler)
        }
        .sheet(item: self.$sheetView) { $0 }
        .alert(item: self.$alertView) { $0 }
    }
}

struct GridSearchGrainView_Previews: PreviewProvider {
    static var previews: some View {
        GridSearchGrainView(
            pair: TradePair.GbpUsd,
            timezone: Timezone.tokyoAM,
            direction: TradeDirection.long,
            algorithm: TradeAlgorithm.reaction
        )
    }
}

