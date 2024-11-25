//
//  ContentView.swift
//  StressBuster
//
//  Created by ace on 25/11/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Buster", systemImage: "hand.thumbsup") {
                LogEntryView()
            }
            Tab("Stats", systemImage: "list.bullet.rectangle") {
                StatsView()
            }
        }
    }
}

#Preview {
    ContentView()
}
