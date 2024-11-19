//
//  NetworkReachability.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 14/11/2024.
//

import Foundation
import Network
import Combine

public final class NetworkReachabilityService: ReachabilityService, @unchecked Sendable {
    public let isReachable: CurrentValueSubject<Bool, Never> = .init(false)
    private let monitor: NWPathMonitor
    private let queue: DispatchQueue
    
    public init() {
        self.monitor = .init()
        self.queue = .global(qos: .background)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isReachable.send(path.status == .satisfied)
        }
        monitor.start(queue: queue)
    }
}
