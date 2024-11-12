//
//  OSLog+Extensions.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 12/11/2024.
//

import Foundation
import OSLog

import OSLog

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    static let viewCycle = Logger(subsystem: subsystem, category: "viewcycle")
//    Logger.viewCycle.notice("Notice example")
//    Logger.viewCycle.info("Info example")
//    Logger.viewCycle.debug("Debug example")
//    Logger.viewCycle.trace("Trace example")
//    Logger.viewCycle.warning("Warning example")
//    Logger.viewCycle.error("Error example")
//    Logger.viewCycle.fault("Fault example")
//    Logger.viewCycle.critical("Critical example")
    static let statistics = Logger(subsystem: subsystem, category: "statistics")
//    Logger.statistics.debug("Statistics example")
}
