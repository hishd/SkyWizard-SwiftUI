//
//  NetworkReachability.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 14/11/2024.
//

import Foundation
import Network
import Combine

class NetworkReachabilityService: Reachability {
    var isReachable: CurrentValueSubject<Bool, Never> = .init(false)
    private let monitor: NWPathMonitor
    private let queue: DispatchQueue
    
    init() {
        self.monitor = .init()
        self.queue = .global(qos: .background)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isReachable.send(path.status == .satisfied)
        }
        monitor.start(queue: queue)
    }
}
