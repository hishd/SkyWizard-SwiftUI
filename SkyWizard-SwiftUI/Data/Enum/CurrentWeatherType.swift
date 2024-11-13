//
//  CurrentWeatherType.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation

//Enum for current day weather type, including all hours on current day
enum CurrentWeatherType: CaseIterable {
    case day_sunny
    case day_cloudy
    case day_rainy
    case night_clear
    case night_cloudy
    case night_rainy
    case snow
    case undefined
}
