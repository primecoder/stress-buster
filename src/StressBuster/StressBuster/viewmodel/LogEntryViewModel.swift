//
//  LogEntryViewModel.swift
//  StressBuster
//
//  Created by ace on 25/11/2024.
//

import Foundation

@Observable
class LogEntryViewModel {
    var logEntries: [LogEntry] = testEntries
    
    func addEntry(_ mood: Mood) {
        let newEntry = LogEntry(date: .now, mood: mood)
        logEntries.append(newEntry)
    }
    
    func todayPositiveCount() -> Int {
        logEntries
            .filter { Calendar.current.isDateInToday($0.date) && $0.mood.isPositive }
            .count
    }
    
    func todayNegativeCount() -> Int {
        logEntries
            .filter { Calendar.current.isDateInToday($0.date) && !$0.mood.isPositive }
            .count
    }
}

extension LogEntryViewModel {
    static var testEntries: [LogEntry] = {
        var entries: [LogEntry] = []
        for i in 0..<10 {
            let date = Calendar.current.date(byAdding: .day, value: -i, to: .now)!
            for hour in 0..<24 {
                let randomMood: Mood = Int.random(in: 1..<100) > 50 ? .negative : .positive
                let dateHour = Calendar.current.date(byAdding: .hour, value: hour, to: date)!
                entries.append(LogEntry(date: dateHour, mood: randomMood))
            }
        }
        return entries
    }()
}
