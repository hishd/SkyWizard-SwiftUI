//
//  Reachability+Dependencies.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 14/11/2024.
//

import Foundation
import DependencyInjector

fileprivate final class NetworkReachabilityServiceDependency: InjectableDependency {
    static var dependency: NetworkReachabilityService = .init()
}

fileprivate final class ReachabilityServiceMockDependency: InjectableDependency {
    static var dependency: ReachabilityServiceMock = .init()
}

extension InjectableValues {
    var networkReachabilityService: NetworkReachabilityService {
        get {
            Self[NetworkReachabilityServiceDependency.self]
        }
    }
    
    var reachabilityServiceMock: ReachabilityServiceMock {
        get {
            Self[ReachabilityServiceMockDependency.self]
        }
    }
}
