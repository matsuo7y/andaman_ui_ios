//
//  GridSearchGrainDetailView.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/10/04.
//

import SwiftUI

struct TradeSummaryView: View {
    let tradeSummary: TradeSummary
    
    private func paramsView(_ params: TradeParams) -> some View {
        LazyVGrid(columns: GridItem.toArray(), alignment: .leading, spacing: 5) {
            ForEach(0..<params.keyValues.count) {
                let param = params.keyValues[$0]
                Text(param.key).foregroundColor(.red)
                Text(param.value)
            }
        }
        .padding()
    }
    
    var headerView: some View {
        LazyVGrid(columns: GridItem.toArray(), alignment: .leading, spacing: 5) {
            Text("Algorithm").foregroundColor(.blue)
            Text(tradeSummary.tradeAlgorithm.rawValue)
            
            Text("Realized Profit").foregroundColor(.blue)
            Text(tradeSummary.realizedProfit.toString())
            
            Text("Trade Count").foregroundColor(.blue)
            Text(tradeSummary.tradeCount.toString())
        }
        .padding()
    }
    
    @ViewBuilder
    var contentView: some View {
        if tradeSummary.tradeAlgorithm == TradeAlgorithm.Reaction {
            paramsView(tradeSummary.reactionTradeAlgorithmParams!)
        } else {
            paramsView(tradeSummary.breakTradeAlgorithmParams!)
        }
    }
    
    var body: some View {
        headerView
        Divider()
        contentView
    }
}
