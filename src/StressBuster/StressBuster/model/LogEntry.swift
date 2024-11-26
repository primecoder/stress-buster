//
//  LogEntry.swift
//  StressBuster
//
//  Created by ace on 25/11/2024.
//

import Foundation


enum Mood {
    case positive
    case negative
    
    var isPositive: Bool {
        return self == .positive
    }
}

struct LogEntry: Identifiable {
    let id: UUID = UUID()
    let date: Date
    let mood: Mood
}

