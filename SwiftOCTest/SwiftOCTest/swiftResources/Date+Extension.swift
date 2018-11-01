//
//  Date+Extension.swift
//  GCash
//
//  Created by huweitao on 2018/10/11.
//  Copyright © 2018年 GXI. All rights reserved.
//

import Foundation

private let dateformatter = DateFormatter()

extension Date {
    func currentZoneDate() -> Date {
        // current (UTC/GMT）
        var date:Date = self
        // system time zone (local zone)
        let zone:TimeZone = NSTimeZone.local
        // gap between local and GMT
        let second:Int = zone.secondsFromGMT()
        // add the gap
        date = date.addingTimeInterval(TimeInterval(second))
        return date
    }
    
    static func timestampToDateFormat(_ timestamp:UInt) -> String? {
        let timeInterval:TimeInterval = TimeInterval(timestamp)
        let date = Date(timeIntervalSince1970: timeInterval)
        dateformatter.dateFormat = "dd MMM yyyy|hh:mm a"
        dateformatter.locale = NSLocale.current
        let time = dateformatter.string(from: date)
        return time
    }
}
