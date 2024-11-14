//
//  NetworkReachability.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 14/11/2024.
//

import Foundation
import Network

class NetworkReachabilityService: Reachability {
    private let monitor: NWPathMonitor
    private let queue: DispatchQueue
    private var isNetworkReachable: Bool = false
    
    init() {
        self.monitor = .init()
        self.queue = .global(qos: .background)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isNetworkReachable = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
    
    func isReachable() -> Bool {
        isNetworkReachable
    }
}
