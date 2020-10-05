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
    
    private func cardView(_ grain: GridSearchGrain) -> some View {
        let tradeSummary = grain.tradeSummaries[0]
        
        return Section(header: Text(
            "\(grain.tradePair.asTradeParam):\(grain.timezone.asTradeParam):\(grain.tradeDirection.asTradeParam):\(tradeSummary.tradeAlgorithm.asTradeParam)"
        )) {
            HStack {
                LazyVGrid(columns: GridItem.array2, alignment: .leading, spacing: 5) {
                    Text("Positive").foregroundColor(.blue)
                    Text(grain.positiveProportions.asTradeResult)
                    
                    Text("Realized Profit").foregroundColor(.blue)
                    Text(tradeSummary.realizedProfit.asTradeResult)
                    
                    Text("Trade Count").foregroundColor(.blue)
                    Text(tradeSummary.tradeCount.asTradeResult)
                }
                .padding()
                
                VStack(alignment: .center, spacing: 5) {
                    Text("Detail")
                    
                    Text("Adopt")
                    
                    Text("Dismiss")
                }
            }
        }
    }
    
    var successView: some View {
        VStack {
            HStack(spacing: 10) {
                Text("Done").foregroundColor(.red)
                Button(action: { self.model.refresh() }) {
                    Text("Refresh").foregroundColor(.green)
                }
            }
            
            List {
                ForEach(0..<self.model.grains!.count) {
                    cardView(self.model.grains![$0])
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
