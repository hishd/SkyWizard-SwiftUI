//
//  HourlyWeatherItem.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 05/11/2024.
//

import SwiftUI

struct HourlyWeatherItem: View {
    let data: HourlyWeatherData
    
    init(hourlyWeatherData: HourlyWeatherData) {
        self.data = hourlyWeatherData
    }
    
    var body: some View {
        VStack(spacing: 12) {
            Text(data.timeText)
                .font(.getFont(type: .medium, size: 18))
                .foregroundStyle(.dayTitle)
            Image(data.imageName)
                .resizable()
                .frame(width: 36, height: 36)
            HStack(alignment: .top, spacing: 3) {
                Text("\(data.temperature)")
                    .font(.getFont(type: .semibold, size: 20))
                Text("0")
                    .font(.getFont(type: .semibold, size: 10))
            }
            .foregroundStyle(.dayTitle)
        }
    }
}