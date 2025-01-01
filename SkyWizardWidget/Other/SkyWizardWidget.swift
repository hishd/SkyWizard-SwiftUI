//
//  SkyWizardWidget.swift
//  SkyWizardWidgetExtension
//
//  Created by Hishara Dilshan on 31/12/2024.
//

import WidgetKit
import SwiftUI

struct SkyWizardWidget: Widget {
    let kind: String = "SkyWizard Weather"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WeatherDataProvider()) { entry in
            SkyWizardWidgetEntryView(entry: entry)
                .padding()
                .background()
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName("Weather Widget")
        .description("Weather Widget for SkyWizard")
    }
}

#Preview(as: .systemSmall) {
    SkyWizardWidget()
} timeline: {
    WeatherEntry.sample
    WeatherEntry.sample
}
