//
//  utils.swift
//  AndamanUI
//
//  Created by Yuki Matsuo on 2020/10/17.
//

import Foundation

func unixtime2DateString(_ unixtime: Int) -> (day: String, time: String) {
    let date = Date(timeIntervalSince1970: Double(unixtime) as TimeInterval)
    let formatter = DateFormatter()
    
    formatter.dateFormat = "MMM dd"
    let day = formatter.string(from: date)
    
    formatter.dateFormat = "HH:mm:ss"
    let time = formatter.string(from: date)
    
    return (day, time)
}
