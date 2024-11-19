//
//  CurrentWeatherType.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation

//Enum for current day weather type, including all hours on current day
public enum CurrentWeatherType: CaseIterable {
    case day_sunny
    case day_cloudy
    case day_rainy
    case night_clear
    case night_cloudy
    case night_rainy
    case snow
    case undefined
}

extension CurrentWeatherType {
    public var greeting: String {
        switch self {
        case .day_sunny:
            return "The sun's smile greets the day; wear a hat if you step out."
        case .day_cloudy:
            return "Grey skies whisper calm; a light coat may serve you well."
        case .day_rainy:
            return "Rain’s embrace awaits, take your umbrella."
        case .night_clear:
            return "Stars twinkle in the velvet night; keep a warm cloak close."
        case .night_cloudy:
            return "The moon hides in clouded veils; a warm coat wards off the chill."
        case .night_rainy:
            return "Raindrops lull the night to sleep; boots and umbrella in hand if you roam."
        case .snow:
            return "Frost paints all in white; a jacket and gloves will be your allies."
        case .undefined:
            return "The sky is unknown; take your best guess."
        }
    }
}
