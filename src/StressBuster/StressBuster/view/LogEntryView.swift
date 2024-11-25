//
//  LogEntryView.swift
//  StressBuster
//
//  Created by ace on 25/11/2024.
//

import SwiftUI

struct LogEntryView: View {
    @State var vm: LogEntryViewModel = .init()
    
    var body: some View {
        VStack {
            Button {
                vm.addEntry(.positive)
            } label: {
                Image(systemName: "hand.thumbsup.fill")
                    .resizable()
                    .padding(80)
            }
            .tint(.black)

            Text("Positive: \(vm.todayPositiveCount()), Negative: \(vm.todayNegativeCount())")
            
            Button {
                vm.addEntry(.negative)
            } label: {
                Image(systemName: "hand.thumbsdown.fill")
                    .resizable()
                    .padding(80)
            }
            .tint(.black)
        }
    }
}

#Preview {
    LogEntryView()
}
