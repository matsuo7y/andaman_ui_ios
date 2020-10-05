//
//  enums.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/09/28.
//

import Foundation

enum TradePair: Int, CaseIterable, Displayable {
    case GbpUsd
    case GbpJpy
    case GbpAud
    case EurUsd
    case EurJPY
    case EurAud
    case UsdJpy
    case AudUsd
    case AudJpy
    
    var asTradeParam: String {
        switch self {
        case .GbpUsd:
            return "GBP/USD"
        case .GbpJpy:
            return "GBP/JPY"
        case .GbpAud:
            return "GBP/AUD"
        case .EurUsd:
            return "EUR/USD"
        case .EurJPY:
            return "EUR/JPY"
        case .EurAud:
            return "EUR/AUD"
        case .UsdJpy:
            return "USD/JPY"
        case .AudUsd:
            return "AUD/USD"
        case .AudJpy:
            return "AUD/JPY"
        }
    }
    
    var asTradeResult: String {
        asTradeParam
    }
}

enum Timezone: Int, CaseIterable, Displayable {
    case tokyoAM
    case tokyoPM
    case londonAM
    case londonPM
    case newyorkAM
    case newyorkPM
    
    var asTradeParam: String {
        switch self {
        case .tokyoAM:
            return "Tokyo AM"
        case .tokyoPM:
            return "Tokyo PM"
        case .londonAM:
            return "London AM"
        case .londonPM:
            return "London PM"
        case .newyorkAM:
            return "NewYork AM"
        case .newyorkPM:
            return "NewYork PM"
        }
    }
    
    var asTradeResult: String {
        asTradeParam
    }
}

enum TradeAlgorithm: Int, CaseIterable, Displayable {
    case reaction
    case breaking
    
    var asTradeParam: String {
        switch self {
        case .reaction:
            return "Reaction"
        case .breaking:
            return "Break"
        }
    }
    
    var asTradeResult: String {
        return asTradeParam
    }
}

enum TradeDirection: Int, CaseIterable, Displayable {
    case long
    case short
    
    var asTradeParam: String {
        switch self {
        case .long:
            return "Long"
        case .short:
            return "Short"
        }
    }
    
    var asTradeResult: String {
        asTradeParam
    }
}
