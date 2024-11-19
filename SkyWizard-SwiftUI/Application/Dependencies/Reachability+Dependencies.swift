//
//  Reachability+Dependencies.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 14/11/2024.
//

import Foundation
import DependencyInjector
import SkyWizardService

fileprivate final class NetworkReachabilityServiceDependency: InjectableDependency {
    static var dependency: NetworkReachabilityService = .init()
}

fileprivate final class ReachabilityServiceMockDependency: InjectableDependency {
    static var dependency: ReachabilityServiceMock = .init()
}

extension InjectableValues {
    var networkReachabilityService: ReachabilityService {
        get {
            Self[NetworkReachabilityServiceDependency.self]
        }
    }
    
    var reachabilityServiceMock: ReachabilityService {
        get {
            Self[ReachabilityServiceMockDependency.self]
        }
    }
}
