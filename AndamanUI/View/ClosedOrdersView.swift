//
//  ClosedOrdersView.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/10/17.
//

import SwiftUI
import Combine

struct ClosedOrdersView: View {
    @ObservedObject var model: ClosedOrdersViewModel
    @State var alertView: Alert?
    
    init(tradePair: TradePair, timezone: Timezone, direction: TradeDirection, algorithm: TradeAlgorithm) {
        self.model = ClosedOrdersViewModel(tradePair: tradePair, timezone: timezone, direction: direction, algorithm: algorithm)
    }
    
    var headerView: some View {
        LazyVGrid(columns: GridItem.flexible2, alignment: .leading, spacing: 5) {
            Text("Realized Profit").foregroundColor(.red)
            Text(self.model.resp!.realizedProfit.display())
        }
        .padding(.leading, 12)
        .padding(.bottom, 5)
    }
    
    var ordersView: some View {
        ScrollView {
            ForEach(self.model.resp!.orders, id: \.self) { order in
                HStack {
                    LazyVGrid(columns: GridItem.flexible1, alignment: .leading, spacing: 5) {
                        Text(order.tradePair.display).fontWeight(.bold)
                        Spacer()
                        Text("units \(order.units.display)")
                        Text("profit \(order.profit.display)").foregroundColor(.red)
                    }
                    .frame(width: 120, alignment: .leading)
                    .foregroundColor(.black)
                    
                    Divider()
                    
                    VStack {
                        let date = unixtime2DateString(order.timeAtOpen)
                        Text("time at open").fontWeight(.bold).frame(maxWidth: .infinity, alignment: .leading)
                        Text(date.day).frame(maxWidth: .infinity, alignment: .leading)
                        Text(date.time).frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        Text("price at open").fontWeight(.bold).frame(maxWidth: .infinity, alignment: .leading)
                        Text(order.priceAtOpen.display()).frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(width: 120, alignment: .leading)
                    
                    Divider()
                    
                    VStack {
                        let date = unixtime2DateString(order.timeAtClose!)
                        Text("time at close").fontWeight(.bold).frame(maxWidth: .infinity, alignment: .leading)
                        Text(date.day).frame(maxWidth: .infinity, alignment: .leading)
                        Text(date.time).frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        Text("price at close").fontWeight(.bold).frame(maxWidth: .infinity, alignment: .leading)
                        Text(order.priceAtClose!.display()).frame(maxWidth: .infinity, alignment: .leading)

                    }
                    .frame(width: 120, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 12)
                
                Divider()
            }
        }
    }
    
    var successView: some View {
        VStack {
            headerView
            Divider()
            ordersView
        }
    }
    
    var fetchView: some View {
        Text("fetching...")
    }
    
    @ViewBuilder
    var contentView: some View {
        if self.model.resp != nil {
            successView
        } else {
            fetchView
        }
    }
    
    private func errorHandler(_ error: Error) {
        if let _error = error as? APIError {
            self.alertView = Alert(title: Text(_error.statusCode.display), message: Text(_error.message))
        }
    }
    
    var body: some View {
        contentView
            .onAppear { self.model.fetch(errorHandler) }
            .alert(item: self.$alertView) { $0 }
    }
}

