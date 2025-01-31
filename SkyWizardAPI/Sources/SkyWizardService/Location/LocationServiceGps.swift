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
import SkyWizardLogger

public enum LocationServiceError: LocalizedError {
    case locationUnavailable
    case locationDeniedAccess
}

extension LocationServiceError {
    public var errorDescription: String? {
        switch self {
        case .locationUnavailable:
            return "Location is unavailable"
        case .locationDeniedAccess:
            return "Please allow location access."
        }
    }
}

public final class LocationServiceGps: NSObject, LocationService, CLLocationManagerDelegate {
    private let locationManager: CLLocationManager = CLLocationManager()
    public let locationResult: PassthroughSubject<LocationResult, Never> = .init()
    private var lastKnownLocation: CLLocationCoordinate2D?
    
    public func start() {
        self.locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.allowsBackgroundLocationUpdates = false
        
        locationManager.requestWhenInUseAuthorization()
        
        guard let lastCoordinate = locationManager.location?.coordinate else {
            return
        }
        self.lastKnownLocation = lastCoordinate
        
        self.locationResult.send(.success(lastCoordinate))
    }
    
    public func getLastKnownLocation() -> CLLocationCoordinate2D? {
        lastKnownLocation
    }
    
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            locationManager.startMonitoringSignificantLocationChanges()
        default:
            self.locationResult.send(.failure(.locationDeniedAccess))
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            Logger.viewCycle.error("Location not found")
            return
        }
        self.lastKnownLocation = location.coordinate
        self.locationResult.send(.success(location.coordinate))
    }
}
