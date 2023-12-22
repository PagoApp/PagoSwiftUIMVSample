//
//  SlimLogglyDestinationConfig.swift
//  Pago
//
//  Created by Andrei Chirita on 13/05/2018.
//  Copyright © 2018 cleversoft. All rights reserved.
//

import Foundation

internal struct PagoSlimLogglyConfig {
    
    internal static var applicationIdentifier : String = Bundle.main.bundleIdentifier ?? "nil"
    
    internal static var logglyToken: String = ""
    // Replace your-loggly-api-key below with a "Customer Token" (you can create a customer token in the Loggly UI)
    // Replace your-app-name below with a short name for your app (no spaces or crazy characters). You can use this
    // tag in the Loggly UI to create Source Group for each app you have in Loggly.
    internal static let logglyUrlString = "https://logs-01.loggly.com/bulk/\(logglyToken)/tag/\(applicationIdentifier)/"
    
    // Number of log entries in buffer before posting entries to Loggly. Entries will also be posted when the user
    // exits the app.
    internal static let maxEntriesInBuffer = 30
    
    // Loglevel for the Loggly destination. Can be set to another level during runtime
    internal static var logglyLogLevel = PagoLogLevel.debug
    
}
