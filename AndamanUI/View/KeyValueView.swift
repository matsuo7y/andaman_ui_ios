//
//  KeyValueView.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/09/29.
//

import SwiftUI

struct KeyValueView: View {
    let key: String
    let value: String
    
    var body: some View {
        HStack {
            Text(key).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            Text(value)
        }
    }
}

struct KeyValueView_Previews: PreviewProvider {
    static var previews: some View {
        KeyValueView(key: "key", value: "value")
    }
}
