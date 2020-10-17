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
    
    private let countPerPage = 10
    
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
        List {
            ForEach(self.model.resp!.orders, id: \.self) { order in
                HStack {
                    LazyVGrid(columns: GridItem.flexible1, alignment: .leading, spacing: 5) {
                        Text(order.tradePair.display).fontWeight(.bold)
                        Spacer()
                        Text("units \(order.units.display)")
                        Text("profit \(order.profit.display)").foregroundColor(.red)
                    }
                    .frame(width: 110, alignment: .leading)
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
            }
        }
    }
    
    private func currentPage() -> Int {
        guard let paging = self.model.resp?.paging else { return 0 }
        return Int(Float(paging.offset) / Float(countPerPage))
    }
    
    private func numPages() -> Int {
        guard let paging = self.model.resp?.paging else { return 0 }
        return Int(ceil(Float(paging.all) / Float(countPerPage)))
    }
    
    var pagerView: some View {
        HStack {
            let paging = self.model.resp!.paging
            
            Text("0").font(.headline)
            
            Button(action: { self.model.fetch(errorHandler, count: countPerPage, offset: 0) }) {
                Text("<").fontWeight(.bold).font(.title)
            }
            
            Button(action: { self.model.fetch(errorHandler, count: countPerPage, offset: currentPage() > 0 ? paging.offset - countPerPage : paging.offset) }) {
                Text("<").font(.title)
            }
            
            Text(paging.offset.display).font(.headline)
            
            Button(action: { self.model.fetch(errorHandler, count: countPerPage, offset: currentPage() < numPages() - 1 ? paging.offset + countPerPage : paging.offset) }) {
                Text(">").font(.title)
            }
            
            Button(action: { self.model.fetch(errorHandler, count: countPerPage, offset: numPages() > 0 ? (numPages() - 1) * countPerPage : 0) }) {
                Text(">").fontWeight(.bold).font(.title)
            }
            
            Text(paging.all.display).font(.headline)
        }
    }
    
    var successView: some View {
        VStack {
            headerView
            Divider()
            ordersView
            Divider()
            pagerView
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
            .onAppear { self.model.fetch(errorHandler, count: countPerPage, offset: 0) }
            .alert(item: self.$alertView) { $0 }
    }
}

