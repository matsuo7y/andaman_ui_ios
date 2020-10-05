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
        LazyVGrid(columns: GridItem.array2, alignment: .leading, spacing: 5) {
            Text("Trade Pair").foregroundColor(.blue)
            Text(pair.asTradeParam)
            
            Text("Timezone").foregroundColor(.blue)
            Text(timezone.asTradeParam)
            
            Text("Direction").foregroundColor(.blue)
            Text(direction.asTradeParam)
            
            Text("Algorithm").foregroundColor(.blue)
            Text(algorithm.asTradeParam)
            
            Text("Positive").foregroundColor(.blue)
            Text(self.model.grain!.positiveProportions.asTradeResult).foregroundColor(.green).bold()
        }
        .padding()
    }
    
    var tradeSummariesView: some View {
        ScrollView {
            LazyVGrid(columns: GridItem.array3, alignment: .leading, spacing: 5) {
                Text("Realized Profit").foregroundColor(.red)
                Text("Trade Count").foregroundColor(.red)
                Text("")
                
                let grain = self.model.grain!
                ForEach(0..<grain.tradeSummaries.count) {
                    let tradeSummary = grain.tradeSummaries[$0]
                    
                    Text(tradeSummary.realizedProfit.asTradeResult)
                    Text(tradeSummary.tradeCount.asTradeResult)
                    NavigationLink(destination: TradeSummaryView(tradeSummary: tradeSummary)) {
                        Text("Detail")
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
    
    var errorView: some View {
        VStack {
            Text(String(self.model.error!.statusCode))
            Text(self.model.error!.message)
        }
    }
    
    var fetchView: some View {
        Text("fetching...")
    }
    
    @ViewBuilder
    var content: some View {
        if self.model.grain != nil {
            successView
        } else if self.model.error != nil {
            errorView
        } else {
            fetchView
        }
    }
    
    var body: some View {
        content.onAppear {
            self.model.fetch(pair: pair, timezone: timezone, direction: direction, algorithm: algorithm)
        }
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

