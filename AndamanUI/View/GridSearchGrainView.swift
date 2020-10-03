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
        let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
        
        return LazyVGrid(columns: columns, alignment: .leading, spacing: 5) {
            Text("Trade Pair").foregroundColor(.blue)
            Text(pair.rawValue)
            Text("Timezone").foregroundColor(.blue)
            Text(timezone.rawValue)
            Text("Direction").foregroundColor(.blue)
            Text(direction.rawValue)
            Text("Algorithm").foregroundColor(.blue)
            Text(algorithm.rawValue)
            Text("Positive").foregroundColor(.blue)
            
            let positive = NSString(format: "%.1f", self.model.grain!.positiveProportions) as String
            Text(positive).foregroundColor(.green).bold()
        }
        .padding()
    }
    
    var tradeSummariesView: some View {
        let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
        
        return ScrollView {
            LazyVGrid(columns: columns, alignment: .leading, spacing: 5) {
                Text("Realized Profit").foregroundColor(.red)
                Text("Trade Count").foregroundColor(.red)
                
                let grain = self.model.grain!
                ForEach(0..<grain.tradeSummaries.count) {
                    Text(NSString(format: "%.1f", grain.tradeSummaries[$0].realizedProfit) as String)
                    Text(NSString(format: "%d", grain.tradeSummaries[$0].tradeCount) as String)
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
        Text("fetching...")
    }
    
    var content: some View {
        self.model.grain != nil
            ? ViewBuilder.buildEither(first: successView)
            : ViewBuilder.buildEither(second: fetchView)
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
            timezone: Timezone.TokyoAM,
            direction: TradeDirection.Long,
            algorithm: TradeAlgorithm.Reaction
        )
    }
}

