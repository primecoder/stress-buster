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
}

struct LogEntry {
    let date: Date
    let mood: Mood
}
