//
//  extensions.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/10/04.
//

import Foundation
import SwiftUI

extension Int: Displayable {
    var asTradeParam: String {
        NSString(format: "%d", self) as String
    }
    
    var asTradeResult: String {
        asTradeParam
    }
}

extension Float: Displayable {
    var asTradeParam: String {
        NSString(format: NSString(string: "%.1f"), self) as String
    }
    
    var asTradeResult: String {
        NSString(format: NSString(string: "%.4f"), self) as String
    }
}

extension Bool: Displayable {
    var asTradeParam: String {
        String(self)
    }
    
    var asTradeResult: String {
        asTradeParam
    }
}

extension GridItem {
    static func toFlexibles(_ count: Int) -> [GridItem] {
        Array(repeating: .init(.flexible()), count: count)
    }
    
    static var flexible1: [GridItem] {
        toFlexibles(1)
    }
    
    static var flexible2: [GridItem] {
        toFlexibles(2)
    }
    
    static var flexible3: [GridItem] {
        toFlexibles(3)
    }
}

extension Alert: Identifiable {
    public var id: UUID { UUID() }
}
