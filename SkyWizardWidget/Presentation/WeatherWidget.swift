//
//  SkyWizardWidget.swift
//  SkyWizardWidget
//
//  Created by Hishara Dilshan on 29/12/2024.
//

import SwiftUI

struct SkyWizardWidgetEntryView : View {
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
