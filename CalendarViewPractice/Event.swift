//
//  Event.swift
//  CalendarViewPractice
//
//  Created by YUJIN KWON on 2023/09/14.
//

import Foundation

var events: [Event] = []
let calendar = Calendar.current

struct Event {
    var id: UUID = UUID()
    var date: Date
    var title: String
    var description: String
    
    var dateComponents: DateComponents {
        return calendar.dateComponents([.year, .month, .day], from: date)
    }
}


