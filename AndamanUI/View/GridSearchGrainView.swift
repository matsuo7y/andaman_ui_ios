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
        VStack(alignment: .leading) {
            KeyValueView(key: "Trade Pair", value: pair.rawValue)
            KeyValueView(key: "Timezone", value: timezone.rawValue)
            KeyValueView(key: "Direction", value: direction.rawValue)
            KeyValueView(key: "Algorithm", value: algorithm.rawValue)
            
            KeyValueView(key: "Positive", value: NSString(format: "%.1f", self.model.grain!.positiveProportions) as String)
        }.padding()
    }
    
    var successView: some View {
        VStack(alignment: .leading) {
            headerView
            
            List {
                ForEach(0..<self.model.grain!.tradeSummaries.count) {
                    GridSearchGrainViewListItem(index: $0, grain: self.model.grain!)
                }
            }
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

struct GridSearchGrainViewListItem: View {
    let index: Int
    let grain: GridSearchGrainResult
    
    var body: some View {
        HStack {
            Text("Realized Profit").foregroundColor(.red)
            Text(NSString(format: "%.1f", grain.tradeSummaries[index].realizedProfit) as String)
            
            Text("Trade Count").foregroundColor(.red)
            Text(NSString(format: "%d", grain.tradeSummaries[index].tradeCount) as String)
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

