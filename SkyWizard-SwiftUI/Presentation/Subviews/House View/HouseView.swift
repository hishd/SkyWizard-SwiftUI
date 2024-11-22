//
//  HouseView.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 21/11/2024.
//

import SwiftUI
import SkyWizardEnum

struct HouseView: View {
    var isEffectsEnabled: Bool = true
    let lightIntensity: CGFloat
    let weatherType: CurrentWeatherType
    @State private var isSceneLoading: Bool = true
    
    var body: some View {
        ZStack {
            houseImage
            
//            if isEffectsEnabled {
//                vortexView
//                    .allowsHitTesting(false)
//            }

            if isSceneLoading {
                sceneLoadingView
            }
        }
    }
}

extension HouseView {
    private var houseImage: some View {
//        var lastLaunchTime = Date.now
        
        var view = HouseViewRepresentable(lightIntensity: lightIntensity)
        view.onRenderFinished = {
            print("Render finished")
            withAnimation {
                isSceneLoading = false
            }
        }
        
        let houseView = view
            .opacity(isSceneLoading ? 0 : 1)
            .padding(.top, 30)
        
        return houseView
    }
    
    private var sceneLoadingView: some View {
        ProgressView()
            .tint(.daySubTitle)
            .controlSize(.large)
            .isVisible(isVisible: isSceneLoading)
            .animation(.easeOut(duration: 0.3), value: isSceneLoading)
    }
}

//extension HouseView {
//    @ViewBuilder
//    private var vortexView: some View {
//        switch weatherType {
//        case .day_rainy, .night_rainy:
//            rainVortexView
//        case .snow:
//            snowVortexView
//        default:
//            EmptyView()
//        }
//    }
//}
