//
//  HouseView.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 21/11/2024.
//

import SwiftUI
import SkyWizardEnum
import Vortex

struct HouseView: View {
    var isEffectsEnabled: Bool = true
    let lightIntensity: CGFloat
    let weatherType: CurrentWeatherType
    @State private var isSceneLoading: Bool = true
    
    var body: some View {
        ZStack {
            houseImage
                .onTapGesture {
                    print("Tapping")
                }
            
            if shouldShowRain {
                vortexView
                    .allowsHitTesting(false)
            }

            if isSceneLoading {
                sceneLoadingView
            }
        }
    }
}

extension HouseView {
    private var houseImage: some View {
        //Disabled house image
//        currentWeatherData.currentWeatherType.getWeatherTypeResource().houseIcon
        var view = HouseViewRepresentable(lightIntensity: lightIntensity)
        view.onRenderFinished = {
            print("Render finished")
            withAnimation {
                isSceneLoading = false
            }
        }
        return view
            .opacity(isSceneLoading ? 0 : 1)
            .padding(.top, 30)
    }
    
    private var sceneLoadingView: some View {
        ProgressView()
            .tint(.daySubTitle)
            .controlSize(.large)
            .isVisible(isVisible: isSceneLoading)
            .animation(.easeOut(duration: 0.3), value: isSceneLoading)
    }
}

extension HouseView {
    private var shouldShowRain: Bool {
        return isEffectsEnabled && (weatherType == .day_rainy || weatherType == .night_rainy)
    }
}

//MARK: - Vortex Resources
extension HouseView {
    private var vortexView: some View {
        ZStack {
            VortexView(HouseView.rain) {
                Circle()
                    .fill(.white)
                    .frame(width: 32)
                    .tag("circle")
            }
        }
    }
    
    private static let rain: VortexSystem = {
        VortexSystem(
            tags: ["circle"],
            position: [0.5, 0 ],
            shape: .box(width: 1.8, height: 0),
            birthRate: 400,
            lifespan: 0.5,
            speed: 1.0,
            speedVariation: 2,
            angle: .degrees(190),
            colors: .random(
                .init(red: 0.7, green: 0.7, blue: 1, opacity: 0.6),
                .init(red: 0.7, green: 0.7, blue: 1, opacity: 0.5),
                .init(red: 0.7, green: 0.7, blue: 1, opacity: 0.4)
            ),
            size: 0.09,
            sizeVariation: 0.05,
            stretchFactor: 12
        )
    }()
}
