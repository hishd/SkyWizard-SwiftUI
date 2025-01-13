//
//  WeatherDataServiceLocalRemoteFallback.swift
//  SkyWizardWidgetExtension
//
//  Created by Hishara Dilshan on 01/01/2025.
//

import Foundation

struct WeatherDataServiceLocalRemoteFallback: WeatherDataService {
    
    let localDataService: WeatherDataService
    let remoteDataService: WeatherDataService
    
    func getWeatherData() -> WeatherEntry {
        //if connection available -> remote
        //else -> local
        //if error -> throw unavailable
        .sample
    }
}
