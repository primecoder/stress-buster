//
//  LogEntryViewModel.swift
//  StressBuster
//
//  Created by ace on 25/11/2024.
//

import Foundation

@Observable
class LogEntryViewModel {
    var logEntries: [LogEntry] = blank
    var moodStats: [Date: (positive: Int, negative: Int, ratio: Double)] = [:]
    
    var settingsClickSoundEnabled: Bool = false {
        didSet {
            UserDefaults.standard.set(settingsClickSoundEnabled, forKey: "clickSoundEnabled")
        }
    }
    
    init() {
        settingsClickSoundEnabled = UserDefaults.standard.bool(forKey: "clickSoundEnabled")
    }
    
    /// Add new mood entry with current time.
    ///
    /// For demonstration purpose, only date portions (day, month, year) are used.
    func addEntry(_ mood: Mood) {
        let dateComponents = Calendar.current.dateComponents(
            [.year, .month, .day],
            from: .now
        )
        let dateForEntry = Calendar.current.date(from: dateComponents)!
        let newEntry = LogEntry(date: dateForEntry, mood: mood)
        logEntries.append(newEntry)
        updateMoodStats()
    }
    
    /// Count number of positive mood entiries for the current date.
    func todayPositiveCount() -> Int {
        logEntries
            .filter { Calendar.current.isDateInToday($0.date) && $0.mood.isPositive }
            .count
    }
    
    /// Count number of negative mood entries for the current date.
    func todayNegativeCount() -> Int {
        logEntries
            .filter { Calendar.current.isDateInToday($0.date) && !$0.mood.isPositive }
            .count
    }
    
    func updateMoodStats() {
        
        // Clear mood stats, before update.
        // This is destructive and expensive but ok for demo for now.
        moodStats.removeAll()
        
        logEntries.forEach { logEntry in
            let (posCount, negCount, _) = moodStats[logEntry.date] ?? (0, 0, 0.0)
            let logEntryMoodPositive = logEntry.mood.isPositive ? 1 : 0
            let logEntryMoodNegative = logEntry.mood.isPositive ? 0 : 1
            moodStats[logEntry.date] = (
                posCount + logEntryMoodPositive,
                negCount + logEntryMoodNegative,
                calculatePositiveRatio(
                    positive: posCount + logEntryMoodPositive,
                    negative: negCount + logEntryMoodNegative
                )
            )
        }
    }
}

extension LogEntryViewModel {
    static var blank: [LogEntry] = []
    
    static var testEntries: [LogEntry] = {
        var entries: [LogEntry] = []
        for i in 1..<10 {
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
    
    func calculatePositiveRatio(positive: Int, negative: Int) -> Double {
        if (positive == negative) {
            return 0.5
        }
        return Double(positive) / Double(positive + negative)
    }
}
