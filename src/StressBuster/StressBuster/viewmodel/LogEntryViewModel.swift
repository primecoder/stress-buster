//
//  LogEntryViewModel.swift
//  StressBuster
//
//  Created by ace on 25/11/2024.
//

import Foundation
import SwiftData


@Observable
class LogEntryViewModel {
    private let container = try? ModelContainer(for: LogEntry.self)

    @MainActor
    var logEntries: [LogEntry] = blank
    var moodStats: [Date: (positive: Int, negative: Int, ratio: Double)] = [:]
    
    var settingsClickSoundEnabled: Bool = false {
        didSet {
            UserDefaults.standard.set(settingsClickSoundEnabled, forKey: "clickSoundEnabled")
        }
    }
    
    @MainActor
    init() {
        settingsClickSoundEnabled = UserDefaults.standard.bool(forKey: "clickSoundEnabled")
        
        if let container = container {
            if let fetchedEntries = try? container.mainContext.fetch(
                FetchDescriptor<LogEntry>()
            ) {
                logEntries = fetchedEntries
            }
        }
    }
    
    /// Add new mood entry with current time.
    ///
    /// For demonstration purpose, only date portions (day, month, year) are used.
    @MainActor
    func addEntry(_ mood: Mood) {
        let dateComponents = Calendar.current.dateComponents(
            [.year, .month, .day],
            from: .now
        )
        let dateForEntry = Calendar.current.date(from: dateComponents)!
        let newEntry = LogEntry(date: dateForEntry, mood: mood)
        logEntries.append(newEntry)
        if let container = container {
            container.mainContext.insert(newEntry)
            do {
                try container.mainContext.save()
            } catch {
                print("ERROR> saving log entry: \(error)")
            }
        }
        updateMoodStats()
    }
    
    /// Count number of positive mood entiries for the current date.
    @MainActor
    func todayPositiveCount() -> Int {
        logEntries
            .filter { Calendar.current.isDateInToday($0.date) && $0.mood.isPositive }
            .count
    }
    
    /// Count number of negative mood entries for the current date.
    @MainActor
    func todayNegativeCount() -> Int {
        logEntries
            .filter { Calendar.current.isDateInToday($0.date) && !$0.mood.isPositive }
            .count
    }
    
    @MainActor
    func reloadData() {
        if let container = container {
            if let fetchedEntries = try? container.mainContext.fetch(
                FetchDescriptor<LogEntry>()
            ) {
                logEntries = fetchedEntries
            }
        }
        updateMoodStats()
    }
    
    @MainActor
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
    @MainActor static let blank: [LogEntry] = []
    
    @MainActor static let testEntries: [LogEntry] = {
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
