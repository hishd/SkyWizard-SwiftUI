//
//  HouseView.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 21/11/2024.
//

import SwiftUI

struct HouseView: View {
    let lightIntensity: CGFloat
    @State private var isSceneLoading: Bool = true
    
    var body: some View {
        ZStack {
            houseImage
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
//        var view = HouseViewRepresentable(lightIntensity: weatherDataStore.weatherTypeResource.lightIntensity)
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
