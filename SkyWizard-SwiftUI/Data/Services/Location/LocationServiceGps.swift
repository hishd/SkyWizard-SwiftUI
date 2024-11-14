//
//  LocationService.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 12/11/2024.
//

import Foundation
import CoreLocation
import OSLog
import Combine

enum LocationServiceError: LocalizedError {
    case locationUnavailable
    case locationDeniedAccess
}

extension LocationServiceError {
    var errorDescription: String? {
        switch self {
        case .locationUnavailable:
            return "Location is unavailable"
        case .locationDeniedAccess:
            return "Location access is denied"
        }
    }
}

final class LocationServiceGps: NSObject, LocationService, CLLocationManagerDelegate {
    private let locationManager: CLLocationManager = CLLocationManager()
    let locationResult: PassthroughSubject<LocationResult, Never> = .init()
    private var lastKnownLocation: CLLocationCoordinate2D?
    
    func start() {
        self.locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.allowsBackgroundLocationUpdates = false
        
        locationManager.requestWhenInUseAuthorization()
        self.lastKnownLocation = locationManager.location?.coordinate
    }
    
    func getLastKnownLocation() -> CLLocationCoordinate2D? {
        lastKnownLocation
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            locationManager.startMonitoringSignificantLocationChanges()
        default:
            self.locationResult.send(.failure(.locationDeniedAccess))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            Logger.viewCycle.error("Location not found")
            return
        }
        self.lastKnownLocation = location.coordinate
        self.locationResult.send(.success(location.coordinate))
    }
}
