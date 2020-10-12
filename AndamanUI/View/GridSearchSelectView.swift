//
//  GridSearchSelectView.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/09/28.
//

import SwiftUI

struct GridSearchSelectView: View {
    @State var pairSelected = TradePair.GbpUsd
    @State var timezoneSelected = Timezone.tokyoAM
    @State var directionSelected = TradeDirection.long
    @State var algorithmSelected = TradeAlgorithm.reaction
    
    var body: some View {
        NavigationView {
            Form {
                Picker(selection: $pairSelected, label: Text("Pair")) {
                    ForEach(TradePair.allCases, id: \.self) { Text($0.display) }
                }
                
                Picker(selection: $timezoneSelected, label: Text("Timezone")) {
                    ForEach(Timezone.allCases, id: \.self) { Text($0.display) }
                }
                
                Picker(selection: $directionSelected, label: Text("Direction")) {
                    ForEach(TradeDirection.allCases, id: \.self) { Text($0.display) }
                }
                
                Picker(selection: $algorithmSelected, label: Text("Algorithm")) {
                    ForEach(TradeAlgorithm.allCases, id: \.self) { Text($0.display) }
                }
                
                NavigationLink(destination: GridSearchGrainView(
                                pair: pairSelected,
                                timezone: timezoneSelected,
                                direction: directionSelected,
                                algorithm: algorithmSelected)
                ) {
                    Text("Select")
                }
            }
            .navigationBarTitle("Grid Search Select")
        }
    }
}
