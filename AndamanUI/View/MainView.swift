//
//  MainView.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/10/05.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            GridSearchSelectView()
                .tabItem {
                    Text("GS Select")
                }
            Text("test")
                .tabItem {
                    Text("GS First")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
