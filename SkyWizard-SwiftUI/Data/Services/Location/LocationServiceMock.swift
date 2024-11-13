//
//  LocationServiceMock.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 13/11/2024.
//

import Foundation
import Combine

final class LocationServiceMock: LocationService {
    let locationResult: PassthroughSubject<LocationResult, Never> = .init()
    
    func start() {
        locationResult.send(.success(.init(latitude: 0, longitude: 0)))
    }
}
