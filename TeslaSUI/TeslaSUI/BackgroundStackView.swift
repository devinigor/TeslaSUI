//
//  BackgroundStackView.swift
//  TeslaSUI
//
//  Created by Игорь Девин on 20.05.2024.
//

import SwiftUI

func backgroundStackView<Content: View>(content: () -> Content) -> some View {
    ZStack {
        Rectangle()
            .fill(Color(.background))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
        content()
    }
}
