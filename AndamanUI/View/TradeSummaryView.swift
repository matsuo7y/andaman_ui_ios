//
//  GridSearchGrainDetailView.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/10/04.
//

import SwiftUI

struct TradeSummaryView: View, Identifiable {
    var id = UUID()
    var tradeSummary: TradeSummary
    
    var headerView: some View {
        LazyVGrid(columns: GridItem.flexible2, alignment: .leading, spacing: 5) {
            Text("Algorithm").foregroundColor(.blue)
            Text(tradeSummary.tradeAlgorithm.display)
            
            Text("Realized Profit").foregroundColor(.blue)
            Text(tradeSummary.realizedProfit.display())
            
            Text("Trade Count").foregroundColor(.blue)
            Text(tradeSummary.tradeCount.display)
        }
        .padding()
    }
    
    var body: some View {
        headerView
        Divider()
        TradeParamsView(tradeParams: tradeSummary.tradeParams as! TradeParams)
    }
}
