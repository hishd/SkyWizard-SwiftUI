//
//  ContentView.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/10/2024.
//

import SwiftUI
import Lottie
import SceneKit

struct WeatherView: View {
    @StateObject private var currentWeatherData: WeatherViewData = .init()
    @State private var isPresented: Bool = false
    @State private var isSceneLoading: Bool = true
    
    var body: some View {
        ZStack {
            backgroundColorGradient
                .ignoresSafeArea()
            houseImage
                .ignoresSafeArea()
            weatherIcon
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    temperatureView
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 16)
                currentCityView
                Spacer()
            }.padding()
            
            sheetView
        }
        .animation(.easeInOut, value: currentWeatherData.currentWeatherType)
        .onTapGesture {
            guard isPresented else { return }
            withAnimation {
                isPresented.toggle()
            }
        }
        .overlay {
            ProgressView()
                .tint(.daySubTitle)
                .controlSize(.large)
                .isVisible(isVisible: isSceneLoading)
                .animation(.easeOut(duration: 0.3), value: isSceneLoading)
        }
    }
}

extension WeatherView {
    private var backgroundColorGradient: LinearGradient {
        currentWeatherData.currentWeatherType.getWeatherTypeResource().backgroundGradient
    }
    private var mainTitleColor: Color {
        currentWeatherData.currentWeatherType.getWeatherTypeResource().mainTitleColor
    }
    private var subTitleColor: Color {
        currentWeatherData.currentWeatherType.getWeatherTypeResource().subTitleColor
    }
    private var weatherIcon: some View {
        VStack {
            LottieView(animation: .named(currentWeatherData.currentWeatherType.getWeatherTypeResource().weatherIconAnimationName))
                .playing(loopMode: .loop)
                .resizable()
                .frame(width: 180, height: 180)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    private var houseImage: some View {
        //Disabled house image
//        currentWeatherData.currentWeatherType.getWeatherTypeResource().houseIcon
        var view = HouseViewRepresentable(lightIntensity: currentWeatherData.currentWeatherType.getWeatherTypeResource().lightIntensity)
        view.onRenderFinished = {
            print("Render finished")
            withAnimation {
                isSceneLoading = false
            }
        }
        
        return view
            .opacity(isSceneLoading ? 0 : 1)
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
            HStack(spacing: 8) {
                Text("Real feel:")
                    .font(.getFont(type: .medium, size: 18))
                SubTemperatureView(temperature: $currentWeatherData.realFeel)
            }
            .padding(.top, 6)
            .foregroundStyle(mainTitleColor)
        }
    }
    
    private var currentCityView: some View {
        HStack {
            Text(currentWeatherData.currentCity)
                .font(.getFont(type: .medium, size: 26))
                .padding(.trailing, 5)
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
    
    private var sheetView: some View {
        SheetView(isBackgroundVisible: false, isPresented: $isPresented) {
            VStack {
                HourlyWeatherView(hourlyData: currentWeatherData.hourlyWeatherData)
                    .padding(.horizontal, 25)
                DailyWeatherView(weatherData: currentWeatherData.dailyWeatherData)
                    .padding(.horizontal, 25)
                Button {
                    
                } label: {
                    Text("Application Settings")
                        .font(.getFont(type: .semibold, size: 16))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundStyle(.dayTitle)
                        .background(.white)
                        .clipShape(.rect(cornerRadius: 10))
                        .padding(.horizontal, 25)
                }
            }
        }
    }
}

struct WeatherTypeResource {
    let backgroundGradient: LinearGradient
    let houseIcon: Image
    let weatherIcon: Image
    let weatherIconAnimationName: String
    let mainTitleColor: Color
    let subTitleColor: Color
    let lightIntensity: CGFloat
}

extension CurrentWeatherType {
#warning("Implement the resources for the undefined weather case")
    func getWeatherTypeResource() -> WeatherTypeResource {
        return switch self {
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
                    weatherIconAnimationName: "sunny.json",
                    mainTitleColor: .dayTitle,
                    subTitleColor: .daySubTitle,
                    lightIntensity: 600
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
                    weatherIconAnimationName: "cloudy_sun.json",
                    mainTitleColor: .dayTitle,
                    subTitleColor: .daySubTitle,
                    lightIntensity: 250
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
                    weatherIconAnimationName: "rainy.json",
                    mainTitleColor: .dayTitle,
                    subTitleColor: .daySubTitle,
                    lightIntensity: 400
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
                    weatherIconAnimationName: "night.json",
                    mainTitleColor: .nightTitle,
                    subTitleColor: .nightSubTitle,
                    lightIntensity: 600
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
                    weatherIconAnimationName: "cloudy.json",
                    mainTitleColor: .nightTitle,
                    subTitleColor: .nightSubTitle,
                    lightIntensity: 200
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
                    weatherIconAnimationName: "night_rainy.json",
                    mainTitleColor: .nightTitle,
                    subTitleColor: .nightSubTitle,
                    lightIntensity: 100
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
                    weatherIconAnimationName: "snow.json",
                    mainTitleColor: .dayTitle,
                    subTitleColor: .daySubTitle,
                    lightIntensity: 600
                )
        case .undefined:
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
                    weatherIconAnimationName: "sunny.json",
                    mainTitleColor: .dayTitle,
                    subTitleColor: .daySubTitle,
                    lightIntensity: 600
                )
        }
    }
}

#Preview {
    WeatherView()
}
