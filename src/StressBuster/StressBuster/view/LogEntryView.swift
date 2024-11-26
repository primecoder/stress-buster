//
//  LogEntryView.swift
//  StressBuster
//
//  Created by ace on 25/11/2024.
//

import SwiftUI

struct LogEntryView: View {
    @State var vm: LogEntryViewModel = .init()
    
    var todayPositiveRatio: Double {
        let positiveCount = Double(vm.todayPositiveCount())
        let negativeCount = Double(vm.todayNegativeCount())
        let totalCount = Double(positiveCount + negativeCount)
        
        if positiveCount == negativeCount {
            return 0.5
        }
        
        if totalCount > 0 {
            let ratio = Double(positiveCount / totalCount)
            return ratio
        } else {
            return 0
        }
    }
    
    var body: some View {
        VStack {
            Button {
                vm.addEntry(.positive)
            } label: {
                Image(systemName: "hand.thumbsup.fill")
                    .resizable()
                    .padding(80)
            }
            .tint(.green)
            
            Text("Positive: \(vm.todayPositiveCount()), Negative: \(vm.todayNegativeCount())")
            MoodScaleView(positiveRatio: todayPositiveRatio)
            
            Button {
                vm.addEntry(.negative)
            } label: {
                Image(systemName: "hand.thumbsdown.fill")
                    .resizable()
                    .padding(80)
            }
            .tint(.red)
        }
        .padding()
    }
}

#Preview {
    LogEntryView()
}
