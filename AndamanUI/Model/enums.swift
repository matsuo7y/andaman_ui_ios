//
//  enums.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/09/28.
//

import Foundation

enum TradePair: String, CaseIterable {
    case GbpUsd = "GBP_USD"
    case GbpJpy = "GBP_JPY"
    case GbpAud = "GBP_AUD"
    case EurUsd = "EUR_USD"
    case EurJPY = "EUR_JPY"
    case EurAud = "EUR_AUD"
    case UsdJpy = "USD_JPY"
    case AudUsd = "AUD_USD"
    case AudJpy = "AUD_JPY"
}

enum Timezone: String, CaseIterable {
    case TokyoAM, TokyoPM
    case LondonAM, LondonPM
    case NewYorkAM, NewYorkPM
}

enum TradeAlgorithm: String, CaseIterable {
    case Reaction, Break
}

enum TradeDirection: String, CaseIterable {
    case Long, Short
}
