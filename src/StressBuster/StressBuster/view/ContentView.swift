//
//  ContentView.swift
//  StressBuster
//
//  Created by ace on 25/11/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var vm = LogEntryViewModel()
    
    var body: some View {
        TabView {
            Tab("Buster", systemImage: "hand.thumbsup") {
                LogEntryView(vm: vm)
                    .edgesIgnoringSafeArea(.all)
            }
            Tab("Stats", systemImage: "list.bullet.rectangle") {
                StatsView(vm: vm)
            }
            Tab("Settings", systemImage: "gearshape.2") {
                SettingsView(vm: vm)
            }
        }
    }
}

#Preview {
    ContentView()
        .edgesIgnoringSafeArea(.all)
}
