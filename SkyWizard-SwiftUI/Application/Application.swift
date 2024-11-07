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
        static let geoCodingBaseUrl = "https://"
    }
    
    enum Networking {
        static let dataTransferService: NetworkDataTransferService = {
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
    }
}
