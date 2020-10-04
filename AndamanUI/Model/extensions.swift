//
//  extensions.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/10/04.
//

import Foundation
import SwiftUI

extension Int: Stringable {
    func toString() -> String {
        NSString(format: "%d", self) as String
    }
}

extension Float: Stringable {
    func toString() -> String {
        NSString(format: NSString(string: "%.1f"), self) as String
    }
}

extension Bool: Stringable {
    func toString() -> String {
        String(self)
    }
}

extension GridItem {
    static func toArray(_ count: Int = 2) -> [GridItem] {
        Array(repeating: .init(.flexible()), count: count)
    }
}
