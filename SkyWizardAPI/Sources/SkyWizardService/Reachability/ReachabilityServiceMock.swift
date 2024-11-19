//
//  ReachabilityServiceMock.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 14/11/2024.
//

import Foundation
import Combine

public final class ReachabilityServiceMock: ReachabilityService, @unchecked Sendable {
    public let isReachable: CurrentValueSubject<Bool, Never> = .init(true)
    
    public init() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 4) { [weak self] in
            self?.isReachable.send(true)
        }
    }
}
