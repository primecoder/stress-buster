//
//  LogEntryViewModel.swift
//  StressBuster
//
//  Created by ace on 25/11/2024.
//

import Foundation

@Observable
class LogEntryViewModel {
    var logEntries: [LogEntry] = []
    
    func addEntry(_ mood: Mood) {
        let newEntry = LogEntry(date: .now, mood: mood)
        logEntries.append(newEntry)
    }
    
    func todayPositiveCount() -> Int {
        logEntries
            .filter { $0.mood.isPositive }
            .count
    }
    
    func todayNegativeCount() -> Int {
        logEntries
            .filter { !$0.mood.isPositive }
            .count
    }
}
