//
//  SlimLoggerConfig.swift
//  Pago
//
//  Created by Andrei Chirita on 13/05/2018.
//  Copyright © 2018 cleversoft. All rights reserved.
//

import Foundation

internal struct PagoSlimConfig {
    
    #if DEBUG
    internal static var enableConsoleLogging = false
    #else
    internal static var enableConsoleLogging = false
    #endif
    // Log level for console logging, can be set during runtime
    internal static var consoleLogLevel = PagoLogLevel.trace
    
    internal static let sourceFilesThatShouldLog: PagoSourceFilesThatShouldLog = .all
}
