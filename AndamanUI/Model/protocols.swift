//
//  protocols.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/10/04.
//

import Foundation

protocol Displayable {
    var asTradeParam: String { get }
    var asTradeResult: String { get }
}

protocol TradeParams {
    var keyValues: [(key: String, value:String)] { get }
}

extension TradeParams {
    var keyValues: [(key: String, value: String)] {
        var kvs: [(String, String)] = []
        
        for member in Mirror(reflecting: self).children {
            let key = member.label!
            
            switch member.value {
            case let value as Displayable:
                kvs.append((key, value.asTradeParam))
            default:
                kvs.append((key, "not stringable"))
            }
        }
        
        return kvs
    }
}
