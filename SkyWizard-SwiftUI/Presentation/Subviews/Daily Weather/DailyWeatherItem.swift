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
        HStack(spacing: 3) {
            Text(weatherItem.dateString)
                .font(.getFont(type: .medium, size: 17))
            Spacer()
            Image(weatherItem.icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 28)
            tempLowView
            tempHighView
        }
        .foregroundStyle(.dayTitle)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 14)
    }
}

extension DailyWeatherItem {
    var tempLowView: some View {
        HStack(alignment: .top, spacing: 0) {
            Text("L \(weatherItem.tempLow)")
                .font(.getFont(type: .medium, size: 15))
                .padding(.top, 5)
            Text("0")
                .font(.getFont(type: .medium, size: 8))
        }
        .frame(width:44)
    }
    
    var tempHighView: some View {
        HStack(alignment: .top, spacing: 0) {
            Text("H \(weatherItem.tempHigh)")
                .font(.getFont(type: .medium, size: 15))
                .padding(.top, 5)
            Text("0")
                .font(.getFont(type: .medium, size: 8))
        }
        .frame(width:44)
    }
}
