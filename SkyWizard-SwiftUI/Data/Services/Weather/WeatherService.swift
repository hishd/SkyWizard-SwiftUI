//
//  WeatherService.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation
import CoreLocation

protocol WeatherService {
    typealias TaskType = Task<WeatherData, Error>
    func fetchWeather(for location: CLLocationCoordinate2D) async throws -> TaskType
}

extension WeatherService {
    func getWeatherType(for current: WeatherData.CurrentWeatherData) -> CurrentWeatherType {
        let code = current.weather_code
        let isDay = current.is_day == 1
        
        return switch code {
        case let code where (0...3).contains(code) && isDay:
            .day_sunny
        case let code where (45...48).contains(code) && isDay:
            .day_cloudy
        case let code where ((51...67).contains(code) || (80...82).contains(code) || (95...99).contains(code)) && isDay:
            .day_rainy
        case let code where (0...3).contains(code) && !isDay:
            .day_sunny
        case let code where (45...48).contains(code) && !isDay:
            .day_cloudy
        case let code where ((51...67).contains(code) || (80...82).contains(code) || (95...99).contains(code)) && !isDay:
            .day_rainy
        case let code where (71...77).contains(code) || (85...86).contains(code):
            .snow
        default:
            .undefined
        }
    }
    
    func getWeatherType(for daily: WeatherData.DailyWeatherData) throws -> [DailyWeatherData] {
        var data: [DailyWeatherData] = .init()
        let dateFormatter: DateFormatter = .init()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard !daily.time.isEmpty else {
            throw WeatherServiceError.invalidData(message: "Empty time data found.")
        }
        
        guard Set(
            [
                daily.temperature_2m_max.count,
                daily.temperature_2m_min.count,
                daily.time.count,
                daily.weather_code.count
            ]
        ).count == 1 else {
            throw WeatherServiceError.invalidData(message: "Inconsistent data found.")
        }
        
        
        for index in 0..<daily.time.count {
            guard let date = dateFormatter.date(from: daily.time[index]) else {
                throw WeatherServiceError.invalidData(message: "Invalid date format found.")
            }
            
            let dateText = """
            \(date.formatted(.dateTime.day())) \
            \(date.formatted(.dateTime.month(.abbreviated))), \
            \(date.formatted(.dateTime.weekday(.wide)))
            """

            data.append(.init(
                dateString: dateText,
                tempHigh: Int(daily.temperature_2m_max[index]),
                tempLow: Int(daily.temperature_2m_min[index]),
                weatherType: getWeatherType(for: daily.weather_code[index])
            ))
        }
        
        return data
    }
    
    func getWeatherType(for hourly: WeatherData.HourlyWeatherData) throws -> [HourlyWeatherData] {
        var data: [HourlyWeatherData] = .init()
        let currentHour: Int = Calendar.current.component(.hour, from: .now)
        let dateFormatter: DateFormatter = .init()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard !hourly.time.isEmpty else {
            throw WeatherServiceError.invalidData(message: "Empty time data found.")
        }
        
        guard Set(
            [
                hourly.time.count,
                hourly.temperature_2m.count,
                hourly.weather_code.count
            ]
        ).count == 1 else {
            throw WeatherServiceError.invalidData(message: "Inconsistent data found.")
        }
        
        
        for index in 0..<hourly.time.count {
            guard let date = dateFormatter.date(from: hourly.time[index]) else {
                throw WeatherServiceError.invalidData(message: "Invalid date format found.")
            }
            
            let hour = Calendar.current.component(.hour, from: date)
            
            if hour == currentHour {
                continue
            }
            
            let timeText = """
            \(date.formatted(.dateTime.hour(.defaultDigits(amPM: .abbreviated)))) \
            \(hour >= 12 ? "PM" : "AM")
            """
            
            data.append(
                .init(
                    timeText: timeText,
                    isDay: hour <= 12,
                    weatherType: getWeatherType(for: hourly.weather_code[index], by: date),
                    temperature: Int(hourly.temperature_2m[index])
                )
            )
        }
        
        return data
    }
    
    private func getWeatherType(for code: Int) -> DailyWeatherType {
        return switch code {
        case let code where (0...3).contains(code):
                .sunny
        case let code where (45...48).contains(code):
                .cloudy
        case let code where ((51...67).contains(code) || (80...82).contains(code) || (95...99).contains(code)):
                .rainy
        case let code where (0...3).contains(code):
                .sunny
        case let code where (45...48).contains(code):
                .cloudy
        case let code where ((51...67).contains(code) || (80...82).contains(code) || (95...99).contains(code)):
                .rainy
        case let code where (71...77).contains(code) || (85...86).contains(code):
                .snow
        default:
                .undefined
        }
    }
    
    private func getWeatherType(for code: Int, by time: Date) -> CurrentWeatherType {
        let isDay = Calendar.current.component(.hour, from: time) < 18
        
        return switch code {
        case let code where (0...3).contains(code) && isDay:
            .day_sunny
        case let code where (45...48).contains(code) && isDay:
            .day_cloudy
        case let code where ((51...67).contains(code) || (80...82).contains(code) || (95...99).contains(code)) && isDay:
            .day_rainy
        case let code where (0...3).contains(code) && !isDay:
            .day_sunny
        case let code where (45...48).contains(code) && !isDay:
            .day_cloudy
        case let code where ((51...67).contains(code) || (80...82).contains(code) || (95...99).contains(code)) && !isDay:
            .day_rainy
        case let code where (71...77).contains(code) || (85...86).contains(code):
            .snow
        default:
            .undefined
        }
    }
}

enum WeatherServiceError: LocalizedError {
    case invalidResponse(message: String)
    case invalidData(message: String)
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse(let message):
          return message
        case .invalidData(let message):
            return message
        }
    }
}
