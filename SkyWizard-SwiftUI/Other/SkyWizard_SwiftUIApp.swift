//
//  SkyWizard_SwiftUIApp.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/10/2024.
//

import SwiftUI
import DependencyInjector

@main
struct SkyWizard_SwiftUIApp: App {
    @Injectable(\.weatherDataStore) var weatherDataStore: WeatherDataStore
    
    var body: some Scene {
        WindowGroup {
            WeatherView()
                .environmentObject(weatherDataStore)
        }
    }
}
