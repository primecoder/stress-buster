//
//  LogEntryView.swift
//  StressBuster
//
//  Created by ace on 25/11/2024.
//

import SwiftUI
import AVFoundation

#if os(watchOS)
import WatchKit
#endif

struct LogEntryView: View {
    @State var vm: LogEntryViewModel = .init()
    
    /// A calculated property showing ratio of positive vs negative entries.
    var todayPositiveRatio: Double {
        let positiveCount = vm.todayPositiveCount()
        let negativeCount = vm.todayNegativeCount()
        return vm.calculatePositiveRatio(positive: positiveCount, negative: negativeCount)
    }
    
    @State private var thumbUpScale = 1.0
    @State private var thumbDownScale = 1.0

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ZStack {
                    VStack(spacing: 0) {
                        Rectangle()
                            .foregroundStyle(.green.opacity(0.25))
                            .frame(height: geometry.size.height * todayPositiveRatio)
                        Rectangle()
                            .foregroundStyle(.red.opacity(0.25))
                            .frame(height: geometry.size.height * (1 - todayPositiveRatio))
                    }
                    
                    VStack(alignment: .trailing) {
                        Text("\(vm.todayPositiveCount())")
                            .foregroundStyle(.green)
                            .bold()
                            .font(.system(size: 22))
                            .padding(.horizontal)
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height * todayPositiveRatio,
                                   alignment: .bottomTrailing)
                        Text("\(vm.todayNegativeCount())")
                            .foregroundStyle(.red)
                            .bold()
                            .font(.system(size: 22))
                            .padding(.horizontal)
                            .frame(height: geometry.size.height * (1 - todayPositiveRatio),
                                   alignment: .topTrailing)
                    }
                    .frame(maxWidth: .infinity)
                }
                VStack(alignment: .center) {
                    Button {
                        vm.addEntry(.positive)
                        // For list of sounds see:
                        // https://github.com/TUNER88/iOSSystemSoundsLibrary
#if os(iOS)
                        AudioServicesPlaySystemSound(1033)
#elseif os(watchOS)
                        WKInterfaceDevice.current().play(.success)
#endif
                        withAnimation(.bouncy(duration: 0.1)) {
                            thumbUpScale = 1.5
                        } completion: {
                            thumbUpScale = 1.0
                        }
                    } label: {
                        Image(systemName: "hand.thumbsup.fill")
                            .resizable()
                            .scaleEffect(thumbUpScale)
                            .foregroundStyle(.green)
                            .padding()
                    }
                    .buttonStyle(.plain)
                    .frame(width: geometry.size.width * 0.5,
                           height: geometry.size.width * 0.5)
                    
                    Button {
                        vm.addEntry(.negative)
#if os(iOS)
                        AudioServicesPlaySystemSound(1006)
#elseif os(watchOS)
                        WKInterfaceDevice.current().play(.failure)
#endif
                        withAnimation(.bouncy(duration: 0.1)) {
                            thumbDownScale = 1.5
                        } completion: {
                            thumbDownScale = 1.0
                        }
                    } label: {
                        Image(systemName: "hand.thumbsdown.fill")
                            .resizable()
                            .scaleEffect(thumbDownScale)
                            .foregroundStyle(.red)
                            .padding()
                    }
                    .buttonStyle(.plain)
                    .frame(width: geometry.size.width * 0.5,
                           height: geometry.size.width * 0.5)
                }
                .frame(maxWidth: .infinity)
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LogEntryView()
        .edgesIgnoringSafeArea(.all)
}
