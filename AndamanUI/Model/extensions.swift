//
//  extensions.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/10/04.
//

import Foundation
import SwiftUI

extension Int: Displayable {
    var display: String {
        NSString(format: "%d", self) as String
    }
}

extension Float: Displayable {
    var display: String {
        NSString(format: NSString(string: "%.1f"), self) as String
    }
    
    func display(_ digits: Int=4) -> String {
        NSString(format: NSString(string: "%.4f"), self) as String
    }
}

extension Bool: Displayable {
    var display: String {
        String(self)
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
