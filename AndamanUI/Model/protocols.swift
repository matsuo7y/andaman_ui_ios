//
//  protocols.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/10/04.
//

import Foundation

protocol Displayable {
    var display: String { get }
}

protocol TradeParams {
    var params: [TradeParam] { get }
}

extension TradeParams {
    var params: [TradeParam] {
        var kvs: [TradeParam] = []
        
        for member in Mirror(reflecting: self).children {
            let key = member.label!
            
            switch member.value {
            case let value as Displayable:
                kvs.append(TradeParam(key: key, value: value.display))
            default:
                kvs.append(TradeParam(key: key, value: "not displayable"))
            }
        }
        
        return kvs
    }
}

struct TradeParam: Identifiable {
    var id = UUID()
    let key: String
    let value: String
}
