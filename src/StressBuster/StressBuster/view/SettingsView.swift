//
//  SettingsView.swift
//  StressBuster
//
//  Created by ace on 14/1/2025.
//

import SwiftUI

struct SettingsView: View {
    @State var vm: LogEntryViewModel = .init()
    
    var body: some View {
        VStack {
            Toggle("Enable click sound",
                   isOn: $vm.settingsClickSoundEnabled)
        }
        .padding()
    }
}

#Preview {
    SettingsView()
}
