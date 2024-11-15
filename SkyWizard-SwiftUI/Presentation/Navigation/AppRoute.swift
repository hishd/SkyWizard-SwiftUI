//
//  AppRoutes.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 15/11/2024.
//

import Foundation
import SwiftUI

enum AppRoute {
    case about
}

extension AppRoute: Hashable {
    var content: some View {
        switch self {
        case .about: Text("This is About View")
        }
    }
}
