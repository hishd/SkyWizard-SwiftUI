//
//  SkyWizardWidget.swift
//  SkyWizardWidgetExtension
//
//  Created by Hishara Dilshan on 31/12/2024.
//

import WidgetKit
import SwiftUI
import SkyWizardEnum

struct SkyWizardWidget: Widget {
    let kind: String = "SkyWizard Weather"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WeatherDataProvider()) { entry in
            if #available(iOS 17.0, *) {
                WidgetEntryView(entry: entry)
                    .containerBackground(getBackgroundGradient(for: entry.weatherType), for: .widget)
            } else {
                WidgetEntryView(entry: entry)
                    .padding()
                    .background(getBackgroundGradient(for: entry.weatherType))
            }
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName("Weather Widget")
        .description("Weather Widget for SkyWizard")
    }
}

extension SkyWizardWidget {
    private func generateGradient(startHex: String, endHex: String) -> LinearGradient {
        .init(
            colors: [
                .init(hex: startHex),
                .init(hex: endHex)
            ],
            startPoint: .topTrailing,
            endPoint: .bottomLeading
        )
    }
    
    private func getBackgroundGradient(for weatherType: CurrentWeatherType) -> LinearGradient {
        switch weatherType {
        case .day_cloudy:
            generateGradient(startHex: "#FCF9EA", endHex: "#CCCCCC")
        case .day_rainy:
            generateGradient(startHex: "#FAFCFF", endHex: "#807C69")
        case .day_sunny:
            generateGradient(startHex: "#FFFCEF", endHex: "#EAE2B2")
        case .night_cloudy:
            generateGradient(startHex: "#C7C8F2", endHex: "#191A2F")
        case .night_rainy:
            generateGradient(startHex: "#37398D", endHex: "#16171C")
        case .night_clear:
            generateGradient(startHex: "#E5E5E5", endHex: "#291888")
        case .snow:
            generateGradient(startHex: "#FDFDFD", endHex: "#CBEFFF")
        case .undefined:
            generateGradient(startHex: "#D3D3D3", endHex: "#5C5C5C")
        }
    }
}

#Preview(as: .systemSmall) {
    SkyWizardWidget()
} timeline: {
    WeatherEntry.sample
    WeatherEntry.sample
}
