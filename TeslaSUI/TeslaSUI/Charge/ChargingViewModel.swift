//
//  ChargingViewModel.swift
//  TeslaSUI
//
//  Created by Игорь Девин on 20.05.2024.
//

import SwiftUI

final class ChargingViewModel: ObservableObject {
    @Published var value = 0
    @Published var offset = 100.0
    @Published var colorTop = Color.battaryTopOn
    @Published var colorBottom = Color.battaryBottomOn
}
