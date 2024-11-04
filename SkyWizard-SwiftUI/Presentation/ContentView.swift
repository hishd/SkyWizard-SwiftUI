//
//  ContentView.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/10/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var currentWeatherData: CurrentWeatherData = .init()
    
    var body: some View {
        ZStack {
            backgroundColorGradient
                .ignoresSafeArea()
            houseImage
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    temperatureView
                    Spacer()
                    weatherIcon
                        .resizable()
                        .frame(width: 150, height: 150)
                }
                .frame(maxWidth: .infinity)
                currentCityView
                Spacer()
            }
            .sheet(isPresented: .constant(true), content: {
                HourlyWeatherView(hourlyData: currentWeatherData.hourlyWeatherData)
                    .padding(.horizontal, 25)
                Spacer()
                .presentationDetents([.fraction(0.4), .fraction(0.5)])
                .presentationDragIndicator(.hidden)
                .presentationBackground(.clear)
                .presentationBackgroundInteraction(
                    .enabled(upThrough: .fraction(0.4))
                )
                .interactiveDismissDisabled()
            })
            .padding()
        }
        .animation(.easeInOut, value: currentWeatherData.currentWeatherType)
    }
}

extension ContentView {
    private var backgroundColorGradient: LinearGradient {
        currentWeatherData.currentWeatherType.getWeatherTypeResource().backgroundGradient
    }
    private var mainTitleColor: Color {
        currentWeatherData.currentWeatherType.getWeatherTypeResource().mainTitleColor
    }
    private var subTitleColor: Color {
        currentWeatherData.currentWeatherType.getWeatherTypeResource().subTitleColor
    }
    private var weatherIcon: Image {
        currentWeatherData.currentWeatherType.getWeatherTypeResource().weatherIcon
    }
    private var houseImage: some View {
        currentWeatherData.currentWeatherType.getWeatherTypeResource().houseIcon
            .resizable()
            .frame(maxWidth: .infinity)
            .frame(height: 340)
            .padding()
            .padding(.top, 30)
    }
    
    private var temperatureView: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                Text("\(currentWeatherData.currentTemperature)")
                    .font(.getFont(type: .regular, size: 76))
                Text("0")
                    .font(.getFont(type: .regular, size: 26))
            }
            .foregroundStyle(mainTitleColor)
            HStack(spacing: 20) {
                SubTemperatureView(isHighTemp: true, temperature: $currentWeatherData.highestTemp)
                SubTemperatureView(isHighTemp: false, temperature: $currentWeatherData.lowestTemp)
            }
            .foregroundStyle(subTitleColor)
        }
    }
    
    private var currentCityView: some View {
        HStack {
            Text(currentWeatherData.currentCity)
                .font(.getFont(type: .medium, size: 26))
                .padding(.trailing, 10)
            Button {
                currentWeatherData.toggleWeatherType()
            } label: {
                Image(systemName: "location.circle")
                    .resizable()
                    .frame(width: 24, height: 24)
            }

        }
        .foregroundStyle(subTitleColor)
    }
}

fileprivate struct SubTemperatureView: View {
    var isHighTemp: Bool
    @Binding var temperature: Int
    
    var body: some View {
        HStack(alignment: .top, spacing: 2) {
            Text("\(isHighTemp ? "H" : "L") \(temperature)")
                .font(.getFont(type: .medium, size: 20))
                .padding(.top, 5)
            Text("0")
                .font(.getFont(type: .medium, size: 10))
        }
    }
}

class CurrentWeatherData: ObservableObject {
    @Published var currentTemperature: Int = 20
    @Published var highestTemp: Int = 24
    @Published var lowestTemp: Int = 18
    @Published var currentCity: String = "Northampton"
    @Published var currentWeatherType: WeatherType = .day_sunny
    @Published var hourlyWeatherData: [HourlyWeatherData] = (0...10).map { _ in
            .sample
    }
    
    func toggleWeatherType() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
            let type: WeatherType = WeatherType.allCases.randomElement()!
            self.currentWeatherType = type
        }
    }
}

enum WeatherType: CaseIterable {
    case day_sunny
    case day_cloudy
    case day_rainy
    case night_clear
    case night_cloudy
    case night_rainy
    case snow
    
    struct WeatherTypeResource {
        let backgroundGradient: LinearGradient
        let houseIcon: Image
        let weatherIcon: Image
        let weatherIconAnimationName: String
        let mainTitleColor: Color
        let subTitleColor: Color
    }
    
    func getWeatherTypeResource() -> WeatherTypeResource {
        switch self {
        case .day_sunny:
                .init(
                    backgroundGradient: .init(
                        colors: [
                            .init(hex: "#FFFCEF"),
                            .init(hex: "#EAE2B2")
                        ],
                        startPoint: .topTrailing,
                        endPoint: .bottomLeading
                    ),
                    houseIcon: Image(.houseDaySunny),
                    weatherIcon: Image(.weatherDaySunny),
                    weatherIconAnimationName: "weather_day_sunny.json",
                    mainTitleColor: .dayTitle,
                    subTitleColor: .daySubTitle
                )
        case .day_cloudy:
                .init(
                    backgroundGradient: .init(
                        colors: [
                            .init(hex: "#FCF9EA"),
                            .init(hex: "#CCCCCC")
                        ],
                        startPoint: .topTrailing,
                        endPoint: .bottomLeading
                    ),
                    houseIcon: Image(.houseDayCloudy),
                    weatherIcon: Image(.weatherDayCloudy),
                    weatherIconAnimationName: "weather_day_sunny.json",
                    mainTitleColor: .dayTitle,
                    subTitleColor: .daySubTitle
                )
        case .day_rainy:
                .init(
                    backgroundGradient: .init(
                        colors: [
                            .init(hex: "#FAFCFF"),
                            .init(hex: "#807C69")
                        ],
                        startPoint: .topTrailing,
                        endPoint: .bottomLeading
                    ),
                    houseIcon: Image(.houseDayRainy),
                    weatherIcon: Image(.weatherDayRainy),
                    weatherIconAnimationName: "weather_day_sunny.json",
                    mainTitleColor: .dayTitle,
                    subTitleColor: .daySubTitle
                )
        case .night_clear:
                .init(
                    backgroundGradient: .init(
                        colors: [
                            .init(hex: "#E5E5E5"),
                            .init(hex: "#2A2D68")
                        ],
                        startPoint: .topTrailing,
                        endPoint: .bottomLeading
                    ),
                    houseIcon: Image(.houseNightClear),
                    weatherIcon: Image(.weatherNightClear),
                    weatherIconAnimationName: "weather_day_sunny.json",
                    mainTitleColor: .nightTitle,
                    subTitleColor: .nightSubTitle
                )
        case .night_cloudy:
                .init(
                    backgroundGradient: .init(
                        colors: [
                            .init(hex: "#C7C8F2"),
                            .init(hex: "#191A2F")
                        ],
                        startPoint: .topTrailing,
                        endPoint: .bottomLeading
                    ),
                    houseIcon: Image(.houseNightCloudy),
                    weatherIcon: Image(.weatherNightCloudy),
                    weatherIconAnimationName: "weather_day_sunny.json",
                    mainTitleColor: .nightTitle,
                    subTitleColor: .nightSubTitle
                )
        case .night_rainy:
                .init(
                    backgroundGradient: .init(
                        colors: [
                            .init(hex: "#37398D"),
                            .init(hex: "#16171C")
                        ],
                        startPoint: .topTrailing,
                        endPoint: .bottomLeading
                    ),
                    houseIcon: Image(.houseNightRainy),
                    weatherIcon: Image(.weatherNightRainy),
                    weatherIconAnimationName: "weather_day_sunny.json",
                    mainTitleColor: .nightTitle,
                    subTitleColor: .nightSubTitle
                )
        case .snow:
                .init(
                    backgroundGradient: .init(
                        colors: [
                            .init(hex: "#FDFDFD"),
                            .init(hex: "#CBEFFF")
                        ],
                        startPoint: .topTrailing,
                        endPoint: .bottomLeading
                    ),
                    houseIcon: Image(.houseSnow),
                    weatherIcon: Image(.weatherSnow),
                    weatherIconAnimationName: "weather_day_sunny.json",
                    mainTitleColor: .dayTitle,
                    subTitleColor: .daySubTitle
                )
        }
    }
}

#Preview {
    ContentView()
}
