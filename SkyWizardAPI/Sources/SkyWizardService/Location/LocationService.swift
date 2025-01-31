//
//  LocationService.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 13/11/2024.
//

import Foundation
import Combine
import CoreLocation

public protocol LocationService {
    typealias LocationResult = Result<CLLocationCoordinate2D, LocationServiceError>
    var locationResult: PassthroughSubject<LocationResult, Never> { get }
    
    func start()
    func getLastKnownLocation() -> CLLocationCoordinate2D?
}
