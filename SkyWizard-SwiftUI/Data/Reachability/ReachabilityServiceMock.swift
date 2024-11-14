//
//  ReachabilityServiceMock.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 14/11/2024.
//

import Foundation
import Combine

final class ReachabilityServiceMock: Reachability {
    let isReachable: CurrentValueSubject<Bool, Never> = .init(false)
    
    init() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.isReachable.send(true)
        }
    }
}
