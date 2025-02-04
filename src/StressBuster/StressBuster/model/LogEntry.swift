//
//  LogEntry.swift
//  StressBuster
//
//  Created by ace on 25/11/2024.
//

import Foundation
import SwiftData

enum Mood: Codable {
    case positive
    case negative
    
    var isPositive: Bool {
        return self == .positive
    }
}

@Model
class LogEntry: Identifiable {
    // @Attribute(.unique)
    var id: UUID = UUID()
    var date: Date = Date.now
    var mood: Mood = Mood.positive
    
    init(id: UUID = UUID(), date: Date = .now, mood: Mood = .positive) {
        self.id = id
        self.date = date
        self.mood = mood
    }
}

