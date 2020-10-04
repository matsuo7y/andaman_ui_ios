//
//  GridSearchGrainDetailView.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/10/04.
//

import SwiftUI

struct TradeSummaryView: View {
    let tradeSummary: TradeSummary
    
    @ViewBuilder
    private func paramsView(_ params: Any) -> some View {
        if let _params = params as? TradeParams {
            LazyVGrid(columns: GridItem.toArray(), alignment: .leading, spacing: 5) {
                ForEach(0..<_params.keyValues.count) {
                    let param = _params.keyValues[$0]
                    Text(param.key).foregroundColor(.red)
                    Text(param.value)
                }
            }
            .padding()
        } else {
            EmptyView()
        }
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
    
    var body: some View {
        headerView
        Divider()
        paramsView(tradeSummary.tradeParams)
    }
}
