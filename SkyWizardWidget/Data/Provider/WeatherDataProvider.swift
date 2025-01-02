//
//  WeatherDataProvider.swift
//  SkyWizardWidgetExtension
//
//  Created by Hishara Dilshan on 01/01/2025.
//

import WidgetKit

struct WeatherDataProvider: TimelineProvider {
    
    let service: WeatherDataService = WeatherDataServiceLocalRemoteFallback(
        localDataService: WeatherDataServiceLocal(),
        remoteDataService: WeatherDataServiceRemote()
    )
    
    func placeholder(in context: Context) -> WeatherEntry {
        .sample
    }

    func getSnapshot(in context: Context, completion: @escaping (WeatherEntry) -> ()) {
        let entry: WeatherEntry = .sample
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<WeatherEntry>) -> ()) {
        let currentDate = Date()
        
        let weatherData = service.getWeatherData()
        let nextUpdateDate = Calendar.current.date(byAdding: .minute, value: 15, to: currentDate)!
        let timeline = Timeline(entries: [weatherData], policy: .after(nextUpdateDate))
        completion(timeline)
    }
}
