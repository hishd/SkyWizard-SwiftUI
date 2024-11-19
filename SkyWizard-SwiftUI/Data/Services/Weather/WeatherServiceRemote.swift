//
//  WeatherServiceRemote.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation
import CoreLocation
import NetworkingService

final class WeatherServiceRemote: WeatherService {
    let dataTransferService: NetworkDataTransferService
    
    init(dataTransferService: NetworkDataTransferService) {
        self.dataTransferService = dataTransferService
    }
    
    func fetchWeather(for location: CLLocationCoordinate2D) async throws -> TaskType {
        let task = Task {
            let task = await dataTransferService.request(with: WeatherEndpoints.getWeather(latitude: location.latitude, longitude: location.longitude))
            let value: WeatherData = try await task.value
            return value
        }
        
        return task
    }
    
    func getWeatherType(for current: WeatherData.CurrentWeatherData) -> CurrentWeatherType {
        let code = current.weather_code
        let isDay = current.is_day == 1
        
        return switch code {
        case let code where (0...1).contains(code) && isDay:
            .day_sunny
        case let code where (2...48).contains(code) && isDay:
            .day_cloudy
        case let code where ((51...67).contains(code) || (80...82).contains(code) || (95...99).contains(code)) && isDay:
            .day_rainy
        case let code where (0...3).contains(code) && !isDay:
            .night_clear
        case let code where (45...48).contains(code) && !isDay:
            .night_cloudy
        case let code where ((51...67).contains(code) || (80...82).contains(code) || (95...99).contains(code)) && !isDay:
            .night_rainy
        case let code where (71...77).contains(code) || (85...86).contains(code):
            .snow
        default:
            .undefined
        }
    }
    
    func getWeather(for daily: WeatherData.DailyWeatherData) throws -> [DailyWeatherData] {
        var data: [DailyWeatherData] = .init()
        let dateFormatter: DateFormatter = .init()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
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
        
        return Array(data.prefix(5))
    }
    
    func getWeather(for hourly: WeatherData.HourlyWeatherData) throws -> [HourlyWeatherData] {
        var data: [HourlyWeatherData] = .init()
        let currentHour: Int = Calendar.current.component(.hour, from: .now)
        let currentDay: Int = Calendar.current.component(.day, from: .now)
        let dateFormatter: DateFormatter = .init()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        
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
            let day = Calendar.current.component(.day, from: date)
            
            if day == currentDay && hour <= currentHour {
                continue
            }
            
            let timeText = """
            \(date.formatted(.dateTime.hour(.defaultDigits(amPM: .omitted)))) \
            \(hour >= 12 ? "PM" : "AM")
            """
            
            data.append(
                .init(
                    timeText: timeText,
                    weatherType: getWeatherType(for: hourly.weather_code[index], by: date),
                    temperature: Int(hourly.temperature_2m[index])
                )
            )
        }
        
        return Array(data.prefix(12))
    }
}

extension WeatherServiceRemote {
    private func getWeatherType(for code: Int) -> DailyWeatherType {
        return switch code {
        case let code where (0...1).contains(code):
                .sunny
        case let code where (2...48).contains(code):
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
        case let code where (0...1).contains(code) && isDay:
            .day_sunny
        case let code where (2...48).contains(code) && isDay:
            .day_cloudy
        case let code where ((51...67).contains(code) || (80...82).contains(code) || (95...99).contains(code)) && isDay:
            .day_rainy
        case let code where (0...3).contains(code) && !isDay:
            .night_clear
        case let code where (45...48).contains(code) && !isDay:
            .night_cloudy
        case let code where ((51...67).contains(code) || (80...82).contains(code) || (95...99).contains(code)) && !isDay:
            .night_rainy
        case let code where (71...77).contains(code) || (85...86).contains(code):
            .snow
        default:
            .undefined
        }
    }
}
