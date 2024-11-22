//
//  HouseView.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 21/11/2024.
//

import SwiftUI
import SkyWizardEnum
import SpriteKit
import Lottie

struct HouseView: View {
    var isEffectsEnabled: Bool = true
    let lightIntensity: CGFloat
    let weatherType: CurrentWeatherType
    @State private var isSceneLoading: Bool = true
    
    var body: some View {
        ZStack {
            houseImage
            
            if isEffectsEnabled {
                GeometryReader { proxy in
                    let height = proxy.frame(in: .local).height
                    let width = proxy.frame(in: .local).width
                    createEffect(for: weatherType, width: width, height: height)
                        .ignoresSafeArea()
                        .allowsHitTesting(false)
                }
            }

            if isSceneLoading {
                sceneLoadingView
            }
        }
    }
}

extension HouseView {
    private var houseImage: some View {
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

extension HouseView {
    @ViewBuilder
    private func createEffect(for weatherType: CurrentWeatherType, width: CGFloat, height: CGFloat) -> some View {
        switch weatherType {
        case .day_cloudy, .day_sunny, .night_cloudy, .night_clear, .undefined:
            EmptyView()
        case .day_rainy, .night_rainy:
            SpriteView(scene: RainScene(size: .init(width: width, height: height)), options: [.allowsTransparency])
        case .snow:
            SpriteView(scene: SnowScene(size: .init(width: width, height: height)), options: [.allowsTransparency])
        }
    }
}

fileprivate final class RainScene: SKScene {
    override func sceneDidLoad() {
        scaleMode = .resizeFill
        backgroundColor = .clear
        anchorPoint = .init(x: 0.55, y: 1)
        
        let node = SKEmitterNode(fileNamed: "rain_fall")
        assert(node != nil, "Rainfall Node not found")
        node!.particlePositionRange.dx = size.width
        addChild(node!)
    }
}

fileprivate final class SnowScene: SKScene {
    override func sceneDidLoad() {
        scaleMode = .resizeFill
        backgroundColor = .clear
        anchorPoint = .init(x: 0.55, y: 1)
        
        let node = SKEmitterNode(fileNamed: "snow_fall")
        assert(node != nil, "Snowfall Node not found")
        node!.particlePositionRange.dx = size.width
        addChild(node!)
    }
}
