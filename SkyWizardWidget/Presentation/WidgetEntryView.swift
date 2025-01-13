//
//  SkyWizardWidget.swift
//  SkyWizardWidget
//
//  Created by Hishara Dilshan on 29/12/2024.
//

import SwiftUI

struct WidgetEntryView : View {
    var entry: WeatherDataProvider.Entry

    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date.formatted(date: .omitted, time: .complete))

            Text("City:")
            Text(entry.city)
        }
    }
}

extension WidgetEntryView {    
    var weatherIcon: Image {
        switch entry.weatherType {
        case .day_cloudy:
                .init(.weatherDayCloudy)
        case .day_rainy:
                .init(.weatherDayRainy)
        case .day_sunny:
                .init(.weatherDaySunny)
        case .night_cloudy:
                .init(.weatherNightCloudy)
        case .night_rainy:
                .init(.weatherNightRainy)
        case .night_clear:
                .init(.weatherNightClear)
        case .snow:
                .init(.weatherSnow)
        case .undefined:
                .init(.weatherUnknown)
        }
    }
}
