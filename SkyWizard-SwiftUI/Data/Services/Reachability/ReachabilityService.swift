//
//  Reachability.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 14/11/2024.
//

import Foundation
import Combine

protocol ReachabilityService {
    var isReachable: CurrentValueSubject<Bool, Never> { get }
}
