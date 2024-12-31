//
//  WeatherEntry.swift
//  SkyWizardWidgetExtension
//
//  Created by Hishara Dilshan on 31/12/2024.
//

import Foundation
import WidgetKit
import SkyWizardEnum

struct WeatherEntry: TimelineEntry {
    let date: Date = .init()
    let weatherType: CurrentWeatherType
    let temperature: Int
    let city: String
    let realFeel: Int
}

#if DEBUG
extension WeatherEntry {
    static let sample: WeatherEntry = .init(
        weatherType: .day_cloudy,
        temperature: 20,
        city: "Colombo",
        realFeel: 25
    )
}
#endif
