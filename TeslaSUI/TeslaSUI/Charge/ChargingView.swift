//
//  File.swift
//  TeslaSUI
//
//  Created by Игорь Девин on 20.05.2024.
//

import SwiftUI

struct ChargingView: View {
    var body: some View {
        ZStack() {
            backgroundStackView {
                VStack {
                    HStack {
                        Spacer()
                        bacButtonView
                        Spacer()
                        chargingView
                        Spacer()
                        settingsButtonView
                        Spacer()
                    }
                    teslaImageView
                        .padding(.bottom, -60)
                        percentageView
                    sliderView
                        .padding(.bottom, 55)
                    limitsView
                        .padding(.bottom, -10)
                    ZStack {
                        withAnimation {
                            panelSuperchargersView
                        }
                        nearbyChargersView
                    }
                    Spacer()
                }
            }
        }
        .onAppear {
            opacityValue(1)
        }
        .onDisappear {
            opacityValue(0)
        }
    }
    
    @ObservedObject var viewModel = ChargingViewModel()
    @Environment(\.presentationMode) var presentation
    @State private var expandedList = false
    @State var opacityValue: (Int) -> ()
    
    private var gradient: LinearGradient {
        LinearGradient(colors: [Color.darkShadow.opacity(0.75), Color.gray.opacity(0.30)], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    private var darkBackground: LinearGradient {
        LinearGradient(colors: [.gray, .background, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    private var bacButtonView: some View {
        Button(action: {
            presentation.wrappedValue.dismiss()
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 40.0)
                    .fill(darkBackground).opacity(0.60)
                    .frame(width: 44, height: 44)
                Image(.backArrow)
                    .tint(.gray)
            }
        })
        .background(RoundedRectangle(cornerRadius: 40)
            .fill(Color.background))
        .overlay(
            Circle()
                .stroke(gradient, lineWidth: 2)
        )
        .neumorphismSelectedBackCircleStyle()
    }
    
    private var chargingView: some View {
        Text("CHARGING")
            .font(.custom("Verdana-Bold", size: 20))
            .foregroundColor(.white)
    }
    
    private var settingsButtonView: some View {
        Button(action: {
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .fill(darkBackground).opacity(0.60)
                    .frame(width: 44, height: 44)
                Image(.configure)
                    .tint(.gray)
            }
        })
        .background(RoundedRectangle(cornerRadius: 40)
            .fill(Color.background))
        .overlay(
            Circle()
                .stroke(gradient, lineWidth: 2)
        )
        .neumorphismSelectedBackCircleStyle()
    }
    
    private var teslaImageView: some View {
        Image(.teslaEnergy)
            .shadow(color: .white.opacity(0.5), radius: 20, x: 0, y: 0)
    }
    
    private var percentageView: some View {
        HStack {
            Text("\(viewModel.value)")
                .font(.custom("Verdana-Bold", size: 32))
                .foregroundColor(.white)
                .animation(.easeInOut(duration: 0.3))
            Text("%")
                .font(.custom("Verdana", size: 20))
                .foregroundColor(.gray)
        }
    }
    
    private var limitsView: some View {
        HStack {
            Spacer()
                .frame(width: 155)
            VStack(alignment: .trailing) {
                Image(.interestRateCap)
                Text("75%")
                    .foregroundColor(viewModel.value >= 75 ? .white : .gray)
            }
            .padding()
            VStack(alignment: .trailing) {
                Image(.interestRateCap)
                Text("100%")
                    .foregroundColor(viewModel.value >= 100 ? .white : .gray)
            }
        }
        .offset(y: -55)
        .font(.custom("Verdana", size: 15))
        .foregroundColor(.white)
    }
    
    private var sliderView: some View {
        VStack {
            CustomSliderCahrging(value: $viewModel.value, offset: $viewModel.offset, colorTop: $viewModel.colorTop, colorBottom: $viewModel.colorBottom, imageCircle: "sliderDrop")
                .padding(.horizontal, 65)
        }
    }
    
    private var panelSuperchargersView: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(.clear)
                        .frame(width: 338, height: expandedList ? geometry.size.height : 130)
                        .overlay {
                            RoundedRectangle(cornerRadius: 25.0)
                                .stroke(.gray, lineWidth: 10)
                                .shadow(color: .black.opacity(0.8), radius: 6, x: 6, y: 6)
                                .shadow(color: .white.opacity(0.1), radius: 5, x: -5, y: -5)
                                .clipShape(RoundedRectangle(cornerRadius: 25.0).inset(by: 5.0))
                        }
                }
                Spacer()
            }
        }
    }
    
    private var nearbyChargersView: some View {
        VStack {
            HStack {
                Text("Nearby Superchargers")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                Button(action: {
                    expandedList.toggle()
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 40)
                            .fill(darkBackground).opacity(0.60)
                            .frame(width: 44, height: 44)
                        Image(expandedList ? .arrowDown : .arrowUp)
                            .tint(.gray)
                    }
                })
                .background(RoundedRectangle(cornerRadius: 40)
                    .fill(Color.background))
                .overlay(
                    Circle()
                        .stroke(gradient, lineWidth: 2)
                )
                .neumorphismSelectedBackCircleStyle()
                
            }
            .offset(y: 40)
            Spacer()
            if expandedList {
                powerPlant
            }
        }
    }
    
    private var powerPlant: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Montreal, QC")
                    Text("2 / 4 available")
                }
                Spacer()
                VStack {
                    Image(.energyLocation)
                    Text("1.7 km")
                }
            }
            HStack {
                VStack(alignment: .leading) {
                    Text("Mascouche, QC")
                    Text("2 / 2 available")
                }
                Spacer()
                VStack {
                    Image(.energyLocation)
                    Text("1.7 km")
                }
            }
        }
        .padding(.horizontal, 60)
        .foregroundColor(.gray)
        .offset(y: -30)
        .padding(.vertical, 20)
    }
}

#Preview {
    ChargingView(opacityValue: { _ in
        
    })
        .environment(\.colorScheme, .dark)
}

