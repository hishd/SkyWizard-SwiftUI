//
//  ReachabilityServiceMock.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 14/11/2024.
//

import Foundation
import Combine

final class ReachabilityServiceMock: ReachabilityService {
    let isReachable: CurrentValueSubject<Bool, Never> = .init(true)
    
    init() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 4) { [weak self] in
            self?.isReachable.send(true)
        }
    }
}
