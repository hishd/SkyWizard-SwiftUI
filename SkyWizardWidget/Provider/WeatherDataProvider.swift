//
//  WeatherDataProvider.swift
//  SkyWizardWidgetExtension
//
//  Created by Hishara Dilshan on 01/01/2025.
//

import WidgetKit

struct WeatherDataProvider: TimelineProvider {
    func placeholder(in context: Context) -> WeatherEntry {
        .sample
    }

    func getSnapshot(in context: Context, completion: @escaping (WeatherEntry) -> ()) {
        let entry: WeatherEntry = .sample
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<WeatherEntry>) -> ()) {
        var entries: [WeatherEntry] = []

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
