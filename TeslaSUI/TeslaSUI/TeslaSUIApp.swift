//
//  TeslaSUIApp.swift
//  TeslaSUI
//
//  Created by Игорь Девин on 20.05.2024.
//

import SwiftUI

@main
struct Tesla_SUIApp: App {
    var body: some Scene {
        WindowGroup {
            TeslaLogoView()
                .environment(\.colorScheme, .dark)
        }
    }
}

