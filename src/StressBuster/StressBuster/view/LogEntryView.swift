//
//  LogEntryView.swift
//  StressBuster
//
//  Created by ace on 25/11/2024.
//

import SwiftUI
import AVFoundation

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
    
    @State private var thumbUpScale = 1.0
    @State private var thumbDownScale = 1.0

    var body: some View {
        VStack {
            Button {
                vm.addEntry(.positive)
                // For list of sounds see:
                // https://github.com/TUNER88/iOSSystemSoundsLibrary
                AudioServicesPlaySystemSound(1033)
                withAnimation(.bouncy(duration: 0.2)) {
                    thumbUpScale = 1.5
                } completion: {
                    thumbUpScale = 1.0
                }
            } label: {
                Image(systemName: "hand.thumbsup.fill")
                    .resizable()
                    .padding(80)
                    .scaleEffect(thumbUpScale)
            }
            .tint(.green)
            
            Text("Positive: \(vm.todayPositiveCount()), Negative: \(vm.todayNegativeCount())")
            MoodScaleView(positiveRatio: todayPositiveRatio)
            
            Button {
                vm.addEntry(.negative)
                AudioServicesPlaySystemSound(1006)
                withAnimation(.bouncy(duration: 0.2)) {
                    thumbDownScale = 1.5
                } completion: {
                    thumbDownScale = 1.0
                }
            } label: {
                Image(systemName: "hand.thumbsdown.fill")
                    .resizable()
                    .padding(80)
                    .scaleEffect(thumbDownScale)
            }
            .tint(.red)
        }
        .padding()
    }
}

#Preview {
    LogEntryView()
}
