//
//  LogEntryView.swift
//  StressBuster
//
//  Created by ace on 25/11/2024.
//

import SwiftUI

struct LogEntryView: View {
    var body: some View {
        VStack {
            Button {
                print("Thumb up")
            } label: {
                Image(systemName: "hand.thumbsup.fill")
                    .resizable()
                    .padding(80)
            }
            .tint(.black)

            Spacer()
            Button {
                print("Thumb down")
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
