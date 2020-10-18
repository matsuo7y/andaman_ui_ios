//
//  MainView.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/10/05.
//

import SwiftUI

struct MainView: View {
    @State var currentTab = 0
    
    var body: some View {
        TabView(selection: $currentTab) {
            TradeView()
                .tabItem { Text("Trade") }
                .tag(0)
                .onAppear { self.currentTab = 0 }
            
            GridSearchSelectView()
                .tabItem { Text("GS Select") }
                .tag(1)
                .onAppear { self.currentTab = 1 }
            
            GridSearchFirstView()
                .tabItem { Text("GS First") }
                .tag(2)
                .onAppear { self.currentTab = 2 }
        }
    }
}
