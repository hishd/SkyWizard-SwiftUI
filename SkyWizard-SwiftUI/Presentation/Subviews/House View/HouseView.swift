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
            
            if isEffectsEnabled {
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
        var lastLaunchTime = Date.now
        
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
        
        return ZStack {
            VortexViewReader { proxy in
                VStack {
                    VortexView(HouseView.fireworks.makeUniqueCopy()) {
                        Circle()
                            .fill(.white)
                            .frame(width: 32)
                            .blur(radius: 5)
                            .blendMode(.plusLighter)
                            .tag("circle")
                    }.frame(height: 400)
                    
                    Spacer()
                }
                
                houseView
                .onTapGesture {
                    //Check time interval difference is less than 500, if yes return
                    guard Date().timeIntervalSince(lastLaunchTime) > 0.65 else { return }
                    proxy.burst()
                    lastLaunchTime = Date.now
                }
            }
        }
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
    private var vortexView: some View {
        switch weatherType {
        case .day_rainy, .night_rainy:
            rainVortexView
        case .snow:
            snowVortexView
        default:
            EmptyView()
        }
    }
}

//MARK: - Vortex Resources
extension HouseView {
    private var rainVortexView: some View {
        ZStack {
            VortexView(HouseView.rain) {
                Circle()
                    .fill(.white)
                    .frame(width: 32)
                    .tag("circle")
            }
        }
    }
    
    private var snowVortexView: some View {
        ZStack {
            VortexView(.snow) {
                Circle()
                    .fill(.white)
                    .frame(width: 18)
                    .blur(radius: 5)
                    .tag("circle")
            }
        }
    }
    
    private static let rain: VortexSystem = {
        VortexSystem(
            tags: ["circle"],
            position: [0.5, 0 ],
            shape: .box(width: 1.8, height: 0),
            birthRate: 20,
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
    
    private static let fireworks: VortexSystem = {
        let sparkles = VortexSystem(
            tags: ["circle"],
            spawnOccasion: .onUpdate,
            emissionLimit: 1,
            lifespan: 0.5,
            speed: 0.05,
            angleRange: .degrees(90),
            colors: .single(.yellow),
            size: 0.05
        )

        let explosion = VortexSystem(
            tags: ["circle"],
            spawnOccasion: .onDeath,
            position: [0.5, 1],
            birthRate: 100_000,
            emissionLimit: 500,
            speed: 0.5,
            speedVariation: 1,
            angleRange: .degrees(360),
            acceleration: [0, 1.5],
            dampingFactor: 4,
            colors: .randomRamp(
                [.white, .pink, .pink],
                [.white, .blue, .blue],
                [.white, .green, .green],
                [.white, .orange, .orange],
                [.white, .cyan, .cyan]
            ),
            size: 0.15,
            sizeVariation: 0.1,
            sizeMultiplierAtDeath: 0
        )

        let mainSystem = VortexSystem(
            tags: ["circle"],
            secondarySystems: [sparkles, explosion],
            position: [0.5, 1],
            birthRate: 0,
            emissionLimit: 1000,
            burstCount: 1,
            burstCountVariation: 0,
            speed: 1.5,
            speedVariation: 0.75,
            angleRange: .degrees(60),
            dampingFactor: 2,
            colors: .single(.red),
            size: 0.15,
            stretchFactor: 4
        )

        return mainSystem
    }()
}
