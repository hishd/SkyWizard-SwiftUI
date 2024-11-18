//
//  DailyWeatherView.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 04/11/2024.
//

import SwiftUI

struct DailyWeatherView: View {
    let weatherData: [DailyWeatherData]
    
    var body: some View {
        VStack(spacing: 20) {
            ForEach(weatherData) { weatherItem in
                DailyWeatherItem(weatherItem: weatherItem)
            }
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .frame(height: 260)
        .glass(cornerRadius: 10, opacity: 0.9)
    }
}

#if DEBUG
#Preview {
    DailyWeatherView(weatherData: [.sample])
}
#endif
