//
//  SlimLogger.swift
//  Pago
//
//  Created by Andrei Chirita on 13/05/2018.
//  Copyright © 2018 cleversoft. All rights reserved.
//

import Foundation


internal enum PagoSourceFilesThatShouldLog {
    case all
    case none
    case enabledSourceFiles([String])
}

internal enum PagoLogLevel: Int {
    case trace  = 100
    case debug  = 200
    case info   = 300
    case warn   = 400
    case error  = 500
    case fatal  = 600
    
    var string:String {
        switch self {
        case .trace:
            return "TRACE"
        case .debug:
            return "DEBUG"
        case .info:
            return "INFO "
        case .warn:
            return "WARN "
        case .error:
            return "ERROR"
        case .fatal:
            return "FATAL"
        }
    }
    
}

internal protocol PagoLogDestination {
    func log<T>( _ message: @autoclosure () -> T, level: PagoLogLevel,
                 filename: String, line: Int)
}

private let slim = PagoSlim()

internal class PagoSlim {
    
    internal var logDestinations: [PagoLogDestination] = []
    internal var cleanedFilenamesCache:NSCache<AnyObject, AnyObject> = NSCache<AnyObject, AnyObject>()
    
    init() {
        if PagoSlimConfig.enableConsoleLogging {
            logDestinations.append(PagoConsoleDestination())
        }
    }
    
    internal class func addLogDestination(_ destination: PagoLogDestination) {
        slim.logDestinations.append(destination)
    }
    
    internal class func setUserId(_ name: String) {
        if let logDestination = slim.logDestinations.last as? PagoSlimLogglyDestination {
            logDestination.userid = name
            slim.logDestinations[slim.logDestinations.count - 1] = logDestination
        }
    }
    
    internal class func trace<T>( _ message: @autoclosure () -> T,
                              filename: String, line: Int) {
        slim.logInternal(message, level: PagoLogLevel.trace, filename: filename, line: line)
    }
    
    internal class func debug<T>( _ message: @autoclosure () -> T,
                              filename: String, line: Int) {
        slim.logInternal(message, level: PagoLogLevel.debug, filename: filename, line: line)
    }
    
    internal class func info<T>( _ message: @autoclosure () -> T,
                             filename: String, line: Int) {
        slim.logInternal(message, level: PagoLogLevel.info, filename: filename, line: line)
    }
    
    internal class func warn<T>( _ message: @autoclosure () -> T,
                             filename: String, line: Int) {
        slim.logInternal(message, level: PagoLogLevel.warn, filename: filename, line: line)
    }
    
    internal class func error<T>( _ message: @autoclosure () -> T,
                              filename: String, line: Int) {
        slim.logInternal(message, level: PagoLogLevel.error, filename: filename, line: line)
    }
    
    internal class func fatal<T>( _ message: @autoclosure () -> T,
                              filename: String, line: Int) {
        slim.logInternal(message, level: PagoLogLevel.fatal, filename: filename, line: line)
    }
    
    fileprivate func logInternal<T>( _ message: @autoclosure () -> T, level: PagoLogLevel,
                                     filename: String, line: Int) {
        let cleanedfile = cleanedFilename(filename)
        if isSourceFileEnabled(cleanedfile) {
            for dest in logDestinations {
                dest.log(message, level: level, filename: cleanedfile, line: line)
            }
        }
    }
    
    fileprivate func cleanedFilename(_ filename:String) -> String {
        if let cleanedfile:String = cleanedFilenamesCache.object(forKey:filename as AnyObject) as? String {
            return cleanedfile
        } else {
            var retval = ""
            let items = filename.split{ $0 == "/"}.map(String.init)
            
            
            if items.count > 0 {
                retval = items.last!
            }
            cleanedFilenamesCache.setObject(retval as AnyObject, forKey:filename as AnyObject)
            return retval
        }
    }
    
    fileprivate func isSourceFileEnabled(_ cleanedFile:String) -> Bool {
        switch PagoSlimConfig.sourceFilesThatShouldLog {
        case .all:
            return true
        case .none:
            return false
        case .enabledSourceFiles(let enabledFiles):
            if enabledFiles.contains(cleanedFile) {
                return true
            } else {
                return false
            }
        }
    }
}

internal class PagoConsoleDestination: PagoLogDestination {
    
    internal let dateFormatter = DateFormatter()
    internal let serialLogQueue: DispatchQueue = DispatchQueue(label: "PagoConsoleDestinationQueue")
    
    init() {
        dateFormatter.dateFormat = "HH:mm:ss:SSS"
    }
    
    
    internal func log<T>( _ message: @autoclosure () -> T, level: PagoLogLevel,
                 filename: String, line: Int) {
        if level.rawValue >= PagoSlimConfig.consoleLogLevel.rawValue {
            let msg = message()
            self.serialLogQueue.async {
                print("\(self.dateFormatter.string(from: Date() as Date)):\(level.string):\(filename):\(line) - \(msg)")
            }
        }
    }
}
