//
//  SysSound.swift
//  StressBuster
//
//  Created by ace on 31/1/2025.
//

// For list of sounds see:
// iOS - https://github.com/TUNER88/iOSSystemSoundsLibrary
// mac - https://stackoverflow.com/questions/68391322/how-to-play-the-macos-trash-system-sound
//

import Foundation
import AVFoundation

#if os(watchOS)
    import WatchKit
#endif

/// Type of sound to produce: positive or negative.
enum SoundType {
    case positive
    case negative
}

func sysSound(_ type: SoundType, soundEnabled: Bool = true) {
    guard soundEnabled else { return }
    switch type {
    case .positive:
#if os(watchOS)
        WKInterfaceDevice.current().play(.success)
#elseif os(macOS)
        AudioServicesPlaySystemSound(9)
#elseif os(iOS)
        // AudioServicesPlaySystemSound(1013)
        AudioServicesPlaySystemSound(1013)
#endif
    case .negative:
#if os(watchOS)
        WKInterfaceDevice.current().play(.failure)
#elseif os(macOS)
        AudioServicesPlaySystemSound(10)
#elseif os(iOS)
        AudioServicesPlaySystemSound(1053)
#endif
    }
}
