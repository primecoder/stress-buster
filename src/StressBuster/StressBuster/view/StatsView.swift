//
//  StatsView.swift
//  StressBuster
//
//  Created by ace on 25/11/2024.
//

import SwiftUI

struct StatsView: View {
    @State var vm: LogEntryViewModel = .init()

    var body: some View {
        List {
            ForEach(Array(vm.moodStats.keys.sorted(by: >)), id: \.self) { key in
                Text("Date: \(key)")
            }
        }
        .onAppear() {
            vm.updateMoodStats()
        }
    }
}

#Preview {
    StatsView()
}
