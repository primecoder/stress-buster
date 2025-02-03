//
//  StatsView.swift
//  StressBuster
//
//  Created by ace on 25/11/2024.
//

import SwiftUI // Ace's changed really

struct StatsView: View {
    @State var vm: LogEntryViewModel = .init()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE dd/MM/yyyy"
        return formatter
    }()

    var body: some View {
        List {
            ForEach(Array(vm.moodStats.keys.sorted(by: >)), id: \.self) { key in
                let mood = vm.moodStats[key]!
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(dateFormatter.string(from: key))")
                    ZStack {
                        MoodScaleView(positiveRatio: mood.ratio, scaleHeight: 20)
                        HStack {
                            Text("\(mood.negative)")
                            Spacer()
                            Text("\(mood.positive)")
                        }
                        .padding(.horizontal, 8)
                    }
                }
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
