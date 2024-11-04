//
//  HourlyWeatherView.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 03/11/2024.
//

import SwiftUI

struct HourlyWeatherData: Identifiable {
    let id: UUID = .init()
    let timeText: String
    let imageName: String
    let temperature: Int
    
    #if DEBUG
    static let sample: HourlyWeatherData = .init(
        timeText: "10 am",
        imageName: "forecast_ic_sunny",
        temperature: 20
    )
    #endif
}

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

struct HourlyWeatherView: View {
    let hourlyData: [HourlyWeatherData]
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundStyle(.sheetHandle)
                .frame(width: 56, height: 4.5)
                .padding(.top, 4)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(hourlyData) { data in
                        HourlyWeatherItem(hourlyWeatherData: data)
                    }
                }.padding(.horizontal, 10)
            }
            .padding(.top, 10)
            .padding(.horizontal, 10)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .glass(cornerRadius: 10, opacity: 0.95)
    }
}

#Preview {
    VStack {
        LinearGradient(colors: [.blue, .red], startPoint: .topTrailing, endPoint: .bottomLeading)
            .ignoresSafeArea()
    }
    .sheet(isPresented: .constant(true)) {
        HourlyWeatherView(hourlyData: [.sample, .sample, .sample, .sample, .sample, .sample])
        .presentationDetents([.fraction(0.4), .fraction(0.6)])
        .presentationDragIndicator(.hidden)
        .presentationBackground(.clear)
        .presentationBackgroundInteraction(
            .enabled(upThrough: .fraction(0.4))
        )
        .interactiveDismissDisabled()
        Spacer()
    }
}
