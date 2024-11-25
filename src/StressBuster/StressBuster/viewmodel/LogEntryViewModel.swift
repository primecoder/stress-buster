//
//  LogEntryViewModel.swift
//  StressBuster
//
//  Created by ace on 25/11/2024.
//

import Foundation

class LogEntryViewModel: ObservableObject {
    @Published var logEntries: [LogEntry] = []
    
    func addEntry(_ mood: Mood) {
        let newEntry = LogEntry(date: .now, mood: mood)
        logEntries.append(newEntry)
    }
}
