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
    
    @State var sheetView: TradeSummaryView?
    @State var alertView: Alert?
    
    @ViewBuilder
    private func cardView(_ key: GridSearchGrainKey) -> some View {
        if let value = self.model.firstsDict![key] {
            VStack {
                Text("\(key.tradePair.display):\(key.timezone.display):\(key.direction.display)")
                    .font(.headline)
                    .fontWeight(.bold)
                    .background(Color.secondary)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    
                
                ForEach(0..<value.firsts.count) {
                    let i = $0
                    let first = value.firsts[i]
                    let tradeSummary = first.tradeSummary
                    let background = value.selected[i] ? Color.green.opacity(0.15) : Color.red.opacity(0.15)
                    
                    HStack {
                        LazyVGrid(columns: GridItem.flexible2, alignment: .leading, spacing: 5) {
                            Text("Algorithm").foregroundColor(.blue)
                            Text(first.key.tradeAlgorithm.display)
                            
                            Text("Positive").foregroundColor(.blue)
                            Text(first.positiveProportions.display())
                            
                            Text("Realized Profit").foregroundColor(.blue)
                            Text(tradeSummary.realizedProfit.display())
                            
                            Text("Trade Count").foregroundColor(.blue)
                            Text(tradeSummary.tradeCount.display)
                        }
                        .background(background)
                        .frame(width: 280)
                        
                        VStack(alignment: .center, spacing: 5) {
                            Button(action: { self.sheetView = TradeSummaryView(tradeSummary: tradeSummary) }) {
                                Text("Detail").foregroundColor(.blue)
                            }
                            
                            Button(action: {
                                if let error = self.model.adopt(key: key, index: i) {
                                    self.alertView = Alert(title: Text(error.title), message: Text(error.message))
                                }
                            }) {
                                Text("Adopt").foregroundColor(.green)
                            }
                            
                            Button(action: { self.model.dismiss(key: key, index: i) }) {
                                Text("Dismiss").foregroundColor(.red)
                            }
                        }
                        .frame(width: 100)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                }
            }
        } else {
            EmptyView()
        }
    }
    
    var successView: some View {
        ScrollView {
            ForEach(0..<self.model.keys.count) {
                cardView(self.model.keys[$0])
                Divider()
            }
        }
    }
    
    var fetchView: some View {
        VStack {
            Spacer()
            Text("fetching...").fontWeight(.bold)
            Spacer()
        }
    }
    
    @ViewBuilder
    var content: some View {
        if self.model.firstsDict !=  nil {
            successView
        } else {
            fetchView
        }
    }
    
    private func beforeApproveSuccessHandler(warning: AlertWarning) {
        self.alertView = Alert(
            title: Text(warning.title),
            primaryButton: .destructive(
                Text("OK"),
                action: { self.model.approve(successHandler: approveSuccessHandler, errorHandler: errorHandler) }
            ),
            secondaryButton: .cancel()
        )
    }
    
    private func approveSuccessHandler(resp: SuccessResponse) {
        self.alertView = Alert(title: Text(resp.message))
    }
    
    private func errorHandler(_ error: Error) {
        switch error {
        case let apiError as APIError:
            self.alertView = Alert(title: Text(apiError.statusCode.display), message: Text(apiError.message))
        case let alertError as AlertError:
            self.alertView = Alert(title: Text(alertError.title), message: Text(alertError.message))
        default:
            print(error)
        }
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Button(action: { self.model.beforeApprove(successHandler: beforeApproveSuccessHandler, errorHandler: errorHandler) }) {
                    Text("Approve").foregroundColor(.green)
                }
                
                Button(action: { self.model.refresh(errorHandler) }) {
                    Text("Refresh").foregroundColor(.blue)
                }
            }
            
            content.onAppear { self.model.fetch(errorHandler) }
            .sheet(item: self.$sheetView) { $0 }
            .alert(item: self.$alertView) { $0 }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}
