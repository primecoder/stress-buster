//
//  MoodScaleView.swift
//  StressBuster
//
//  Created by ace on 26/11/2024.
//

import SwiftUI

struct MoodScaleView: View {
    var positiveRatio: Double = 0.5
    var scaleHeight: CGFloat = 12
    
    private var guardPositiveRatio: Double {
        if positiveRatio < 1 {
            positiveRatio
        } else {
            1.0
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Rectangle()
                    .frame(height: scaleHeight)
                    .foregroundStyle(.red)
                    .frame(
                        width: geometry.size.width - (geometry.size.width * guardPositiveRatio),
                        height: scaleHeight
                    )
                Rectangle()
                    .foregroundStyle(.green)
                    .frame(width: geometry.size.width * guardPositiveRatio, height: scaleHeight)
            }
            .padding(0)
        }
        .frame(height: scaleHeight)
    }
}

#Preview {
    VStack {
        MoodScaleView(positiveRatio: 0.0)
        MoodScaleView(positiveRatio: 0.5)
        MoodScaleView(positiveRatio: 1.1)
        MoodScaleView(positiveRatio: 0.25)
    }
    .padding(.top, 100)
    .padding(.horizontal, 50)
}
