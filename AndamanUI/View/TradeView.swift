//
//  TradeView.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/10/12.
//

import SwiftUI

struct TradeView: View {
    @State var timezoneSelected = Timezone.tokyoAM
    @State var periodSelected = Period.d1
    
    var body: some View {
        NavigationView {
            Form {
                Picker(selection: $timezoneSelected, label: Text("Timezone")) {
                    ForEach(Timezone.allCases, id: \.self) { Text($0.display) }
                }
                
                Picker(selection: $periodSelected, label: Text("Period")) {
                    ForEach(Period.allCases, id: \.self) { Text($0.display) }
                }
                
                NavigationLink(destination: TradeGrainStatesView(timezone: timezoneSelected, period: periodSelected)) {
                    Text("Select")
                }
            }
            .navigationTitle(Text("Trade"))
        }
    }
}

