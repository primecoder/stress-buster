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
    var moodStats: [Date: (positive: Int, negative: Int)] = [:]
    
    func addEntry(_ mood: Mood) {
        let newEntry = LogEntry(date: .now, mood: mood)
        logEntries.append(newEntry)
        updateMoodStats()
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
    
    func updateMoodStats() {
        moodStats = logEntries.reduce(into: [:]) { stats, entry in
            stats[entry.date, default: (0, 0)] = (entry.mood.isPositive ? 1 : 0, entry.mood.isPositive ? 0 : 1)
        }
    }
}

extension LogEntryViewModel {
    static var testEntries: [LogEntry] = {
        var entries: [LogEntry] = []
        for i in 0..<10 {
            let date = Calendar.current.date(byAdding: .day, value: -i, to: .now)!
            for hour in 0..<24 {
                let randomMood: Mood = Int.random(in: 1..<100) > 50 ? .negative : .positive
                let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
                let dateEntry = Calendar.current.date(from: dateComponents)!
                entries.append(LogEntry(date: dateEntry, mood: randomMood))
                print("Adding entry: \(dateEntry) - \(randomMood)")
            }
        }
        return entries
    }()
}
