//
//  GridSearchSelectView.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/09/28.
//

import SwiftUI

struct GridSearchSelectView: View {
    @State var pairSelected = 0
    @State var timezoneSelected = 0
    @State var algorithmSelected = 0
    @State var directionSelected = 0
    
    var body: some View {
        NavigationView {
            Form {
                Picker(selection: $pairSelected, label: Text("Pair")) {
                    ForEach(0..<TradePair.allCases.count) {
                        Text(TradePair.allCases[$0].rawValue)
                    }
                }
                
                Picker(selection: $timezoneSelected, label: Text("Timezone")) {
                    ForEach(0..<Timezone.allCases.count) {
                        Text(Timezone.allCases[$0].rawValue)
                    }
                }
                
                Picker(selection: $directionSelected, label: Text("Direction")) {
                    ForEach(0..<TradeDirection.allCases.count) {
                        Text(TradeDirection.allCases[$0].rawValue)
                    }
                }
                
                Picker(selection: $algorithmSelected, label: Text("Algorithm")) {
                    ForEach(0..<TradeAlgorithm.allCases.count) {
                        Text(TradeAlgorithm.allCases[$0].rawValue)
                    }
                }
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Select")
                }
            }
            .navigationBarTitle("Select Grid Search")
        }
    }
}

struct GridSearchSelectView_Previews: PreviewProvider {
    static var previews: some View {
        GridSearchSelectView()
    }
}
