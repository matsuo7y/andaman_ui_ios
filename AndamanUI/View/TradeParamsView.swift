//
//  TradeParamsView.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/10/12.
//

import SwiftUI

struct TradeParamsView: View {
    var tradeParams: TradeParams
    
    var body: some View {
        LazyVGrid(columns: GridItem.flexible2, alignment: .leading, spacing: 5) {
            ForEach(tradeParams.params) { param in
                Text(param.key).foregroundColor(.red)
                Text(param.value)
            }
        }
        .padding()
    }
}

