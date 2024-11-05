//
//  DailyWeatherView.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 04/11/2024.
//

import SwiftUI

struct DailyWeatherData: Identifiable {
    let id: UUID = UUID()
    let dateString: String
    let icon: String
    let tempHigh: Int
    let tempLow: Int
    
    #if DEBUG
    static let sample: Self = .init(dateString: "12 Oct, Friday", icon: "forecast_ic_sunny", tempHigh: 24, tempLow: 18)
    #endif
}

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

#Preview {
    DailyWeatherView(weatherData: [.sample])
}
