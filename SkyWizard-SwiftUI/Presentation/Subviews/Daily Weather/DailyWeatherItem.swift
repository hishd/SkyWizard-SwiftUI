//
//  DailyWeatherItem.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 05/11/2024.
//

import SwiftUI

struct DailyWeatherItem: View {
    let weatherItem: DailyWeatherData
    
    var body: some View {
        HStack {
            Text(weatherItem.dateString)
                .font(.getFont(type: .medium, size: 18))
            Spacer()
            Image(weatherItem.icon)
                .resizable()
                .frame(width: 28, height: 28)
            tempLowView
            tempHighView
        }
        .foregroundStyle(.dayTitle)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 18)
    }
}

extension DailyWeatherItem {
    var tempLowView: some View {
        HStack(alignment: .top, spacing: 2) {
            Text("L \(weatherItem.tempLow)")
                .font(.getFont(type: .medium, size: 16))
                .padding(.top, 5)
            Text("0")
                .font(.getFont(type: .medium, size: 8))
        }
    }
    
    var tempHighView: some View {
        HStack(alignment: .top, spacing: 2) {
            Text("H \(weatherItem.tempHigh)")
                .font(.getFont(type: .medium, size: 16))
                .padding(.top, 5)
            Text("0")
                .font(.getFont(type: .medium, size: 8))
        }
    }
}
