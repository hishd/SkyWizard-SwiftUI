//
//  Application.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation
import NetworkingService

enum Application {
    enum Constants {
        static let openMetroBaseUrl = "https://api.open-meteo.com/v1"
        //Geocoding
        static let komootBaseUrl = "https://photon.komoot.io"
    }
    
    enum Networking {
        static let dataTransferServiceWeather: NetworkDataTransferService = {
            let networkConfig: ApiNetworkConfig = {
                guard let url = URL(string: Application.Constants.openMetroBaseUrl) else {
                    fatalError("Could not create URL from string: \(Application.Constants.openMetroBaseUrl)")
                }
                return .init(baseUrl: url)
            }()
            
            let networkService: NetworkService = {
                return DefaultNetworkService.init(networkConfig: networkConfig, sessionManagerType: .defaultType, loggerType: .defaultType)
            }()
            
            return DefaultNetworkDataTransferService(networkService: networkService, logger: DefaultNetworkDataTransferErrorLogger())
        }()
        
        static let dataTransferServiceGeocode: NetworkDataTransferService = {
            let networkConfig: ApiNetworkConfig = {
                guard let url = URL(string: Application.Constants.komootBaseUrl) else {
                    fatalError("Could not create URL from string: \(Application.Constants.komootBaseUrl)")
                }
                return .init(baseUrl: url)
            }()
            
            let networkService: NetworkService = {
                return DefaultNetworkService.init(networkConfig: networkConfig, sessionManagerType: .defaultType, loggerType: .defaultType)
            }()
            
            return DefaultNetworkDataTransferService(networkService: networkService, logger: DefaultNetworkDataTransferErrorLogger())
        }()
    }
}
