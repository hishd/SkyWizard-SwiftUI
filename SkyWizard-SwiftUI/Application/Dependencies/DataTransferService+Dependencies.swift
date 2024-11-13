//
//  DataTransferService+Dependencies.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 07/11/2024.
//

import Foundation
import DependencyInjector
import NetworkingService

final class DataTransferServiceWeather: InjectableDependency {
    static var dependency: NetworkDataTransferService = {
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

final class DataTransferServiceGeocoding: InjectableDependency {
    static var dependency: NetworkDataTransferService = {
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

extension InjectableValues {
    var dataTransferServiceWeather: NetworkDataTransferService {
        get {
            Self[DataTransferServiceWeather.self]
        } set {
            Self[DataTransferServiceWeather.self] = newValue
        }
    }
    
    var dataTransferServiceGeocoding: NetworkDataTransferService {
        get {
            Self[DataTransferServiceGeocoding.self]
        } set {
            Self[DataTransferServiceGeocoding.self] = newValue
        }
    }
}
