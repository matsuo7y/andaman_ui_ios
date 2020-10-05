//
//  GridSearchFirstView.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/10/05.
//

import SwiftUI
import Combine

struct GridSearchFirstView: View {
    @ObservedObject var model: GridSearchFirstViewModel = GridSearchFirstViewModel()
    
    @ViewBuilder
    private func cardView(_ key: GridSearchGrainKey) -> some View {
        if let value = self.model.grains![key] {
            Section(header: Text(
                "\(key.tradePair.asTradeParam):\(key.timezone.asTradeParam):\(key.direction.asTradeParam)"
            )) {
                VStack {
                    ForEach(0..<value.grains.count) {
                        let grain = value.grains[$0]
                        let tradeSummary = grain.tradeSummaries[0]
                        
                        HStack {
                            LazyVGrid(columns: GridItem.array2, alignment: .leading, spacing: 5) {
                                Text("Algorithm").foregroundColor(.blue)
                                Text(tradeSummary.tradeAlgorithm.asTradeResult)
                                
                                Text("Positive").foregroundColor(.blue)
                                Text(grain.positiveProportions.asTradeResult)
                                
                                Text("Realized Profit").foregroundColor(.blue)
                                Text(tradeSummary.realizedProfit.asTradeResult)
                                
                                Text("Trade Count").foregroundColor(.blue)
                                Text(tradeSummary.tradeCount.asTradeResult)
                            }
                            .background(Color.green.opacity(0.15))
                            .frame(width: 280)
                            
                            VStack(alignment: .center, spacing: 5) {
                                Text("Adopt").foregroundColor(.green)
                                
                                Text("Dismiss").foregroundColor(.red)
                            }
                        }
                    }
                }
            }
        } else {
            EmptyView()
        }
    }
    
    var successView: some View {
        VStack {
            HStack(spacing: 10) {
                Text("Done").foregroundColor(.blue)
                Button(action: { self.model.refresh() }) {
                    Text("Refresh").foregroundColor(.green)
                }
            }
            
            List {
                ForEach(0..<self.model.keys.count) {
                    cardView(self.model.keys[$0])
                }
            }
        }
    }
    
    var errorView: some View {
        VStack {
            Text(self.model.error!.statusCode.asTradeResult)
            Text(self.model.error!.message)
        }
    }
    
    var fetchView: some View {
        Text("fetching...")
    }
    
    @ViewBuilder
    var content: some View {
        if self.model.grains !=  nil {
            successView
        } else if self.model.error != nil {
            errorView
        } else {
            fetchView
        }
    }
    
    var body: some View {
        content.onAppear {
            self.model.fetch()
        }
    }
}

struct GridSearchFirstView_Previews: PreviewProvider {
    static var previews: some View {
        GridSearchFirstView()
    }
}
