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
    var id: UUID
    var date: Date
    var mood: Mood
    
    init(id: UUID = UUID(), date: Date, mood: Mood) {
        self.id = id
        self.date = date
        self.mood = mood
    }
}

