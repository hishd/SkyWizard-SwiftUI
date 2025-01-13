//
//  DataTransferService+Dependencies.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation
import NetworkingService
import Factory

extension Container {
    private var networkConfigWeather: Factory<ApiNetworkConfig> {
        Factory(self) {
            guard let url = URL(string: "https://api.open-meteo.com/v1") else {
                fatalError("Could not create URL from string: https://api.open-meteo.com/v1")
            }
            return .init(baseUrl: url)
        }
    }
    
    private var networkConfigGeocoding: Factory<ApiNetworkConfig> {
        Factory(self) {
            guard let url = URL(string: "https://api.open-meteo.com/v1") else {
                fatalError("Could not create URL from string: https://api.open-meteo.com/v1")
            }
            return .init(baseUrl: url)
        }
    }
    
    var dataTransferServiceWeather: Factory<NetworkDataTransferService> {
        Factory(self) {
            let networkService: NetworkService = {
                return DefaultNetworkService.init(networkConfig: self.networkConfigWeather(), sessionManagerType: .defaultType, loggerType: .defaultType)
            }()
            
            return DefaultNetworkDataTransferService(networkService: networkService, logger: DefaultNetworkDataTransferErrorLogger())
        }
    }
    
    var dataTransferServiceGeocoding: Factory<NetworkDataTransferService> {
        Factory(self) {
            let networkService: NetworkService = {
                return DefaultNetworkService.init(networkConfig: self.networkConfigGeocoding(), sessionManagerType: .defaultType, loggerType: .defaultType)
            }()
            
            return DefaultNetworkDataTransferService(networkService: networkService, logger: DefaultNetworkDataTransferErrorLogger())
        }
    }
}
