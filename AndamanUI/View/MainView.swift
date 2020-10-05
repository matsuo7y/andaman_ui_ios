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
            GridSearchSelectView()
                .tabItem {
                    Text("GS Select")
                }
                .tag(0)
                .onAppear {
                    self.currentTab = 0
                }
            GridSearchFirstView()
                .tabItem {
                    Text("GS First")
                }
                .tag(1)
                .onAppear {
                    self.currentTab = 1
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
