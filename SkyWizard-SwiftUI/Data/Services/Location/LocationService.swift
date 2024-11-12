//
//  LocationService.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 12/11/2024.
//

import Foundation
import CoreLocation
import OSLog

enum LocationServiceError: Error {
    case locationUnavailable
    case locationDeniedAccess(_ message: String)
}

final class LocationService: NSObject, CLLocationManagerDelegate {
    typealias LocationResult = Result<CLLocationCoordinate2D, LocationServiceError>
    let onLocationChanged: (LocationResult) -> Void
    let locationManager: CLLocationManager
    
    init(onLocationChanged: @escaping (LocationResult) -> Void) {
        self.onLocationChanged = onLocationChanged
        self.locationManager = CLLocationManager()
        
        super.init()
        self.start()
    }
    
    private func start() {
        self.locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.allowsBackgroundLocationUpdates = false
        
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            locationManager.startMonitoringSignificantLocationChanges()
        default:
            onLocationChanged(.failure(.locationDeniedAccess("Location access denied")))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            Logger.viewCycle.error("Location not found")
            return
        }
        onLocationChanged(.success(location.coordinate))
    }
}
