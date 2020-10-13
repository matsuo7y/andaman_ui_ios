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
    case EurGbp
    case UsdJpy
    case AudUsd
    case AudJpy
    
    var display: String {
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
        case .EurGbp:
            return "EUR/GBP"
        case .UsdJpy:
            return "USD/JPY"
        case .AudUsd:
            return "AUD/USD"
        case .AudJpy:
            return "AUD/JPY"
        }
    }
}

enum Timezone: Int, CaseIterable, Displayable {
    case tokyoAM
    case tokyoPM
    case londonAM
    case londonPM
    case newyorkAM
    case newyorkPM
    
    var display: String {
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
}

enum TradeAlgorithm: Int, CaseIterable, Displayable {
    case reaction
    case breaking
    
    var display: String {
        switch self {
        case .reaction:
            return "Reaction"
        case .breaking:
            return "Break"
        }
    }
}

enum TradeDirection: Int, CaseIterable, Displayable {
    case long
    case short
    
    var display: String {
        switch self {
        case .long:
            return "Long"
        case .short:
            return "Short"
        }
    }
}

enum Period: Int, CaseIterable, Displayable {
    case d1
    case d7
    case d30
    case d90
    case d120
    case d360
    
    var display: String {
        switch self {
        case .d1:
            return "1 day"
        case .d7:
            return "7 days"
        case .d30:
            return "30 days"
        case .d90:
            return "90 days"
        case .d120:
            return "120 days"
        case .d360:
            return "360 days"
        }
    }
}
