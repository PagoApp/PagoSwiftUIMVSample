//
//  SlimLogglyDestination.swift
//  Pago
//
//  Created by Andrei Chirita on 13/05/2018.
//  Copyright © 2018 cleversoft. All rights reserved.
//

import UIKit

private let logglyQueue: DispatchQueue = DispatchQueue(label: "pago.slimlogger.loggly")

internal class PagoSlimLogglyDestination: PagoLogDestination {
    
    internal var userid:String?
    fileprivate let dateFormatterInternal = DateFormatter()
    fileprivate let dateFormatter = DateFormatter()
    fileprivate var buffer:[String] = [String]()
    fileprivate var backgroundTaskIdentifier: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
    fileprivate lazy var standardFields:NSDictionary = {
        let dict = NSMutableDictionary()
        dict["lang"] = Locale.preferredLanguages[0]
        if let infodict = Bundle.main.infoDictionary {
            if let versionCode = infodict["CFBundleVersion"] as? String {
                dict["versionCode"] = versionCode
            }
        }
        return dict
    }()
    
    fileprivate var observer: NSObjectProtocol?
    
    init() {
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatterInternal.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        observer = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "UIApplicationWillResignActiveNotification"), object: nil, queue: nil, using: { [unowned self] note in
                let tmpbuffer = self.buffer
                self.buffer = [String]()
                self.backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(withName: "saveLogRecords",
                                                                                         expirationHandler: {
                                                                                            self.endBackgroundTask()
                })
                self.sendLogsInBuffer(stringbuffer: tmpbuffer)
            }
        )
    }
    
    deinit {
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    private func toJson(dictionary: NSDictionary) -> NSData? {
        
        var err: NSError?
        do {
            let json = try JSONSerialization.data(withJSONObject: dictionary, options: JSONSerialization.WritingOptions(rawValue: 0))
            return json as NSData?
        } catch let error1 as NSError {
            err = error1
            let error = err?.description ?? "nil"
            NSLog("ERROR: Unable to serialize json, error: %@", error)
            return nil
        }
    }
    
    private func toJsonString(data: NSData) -> String {
        if let jsonstring = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue) {
            return jsonstring as String
        } else {
            return ""
        }
    }
    
    internal func log<T>( _ message:@autoclosure () -> T, level: PagoLogLevel, filename:String, line:Int) {
        if level.rawValue < PagoSlimLogglyConfig.logglyLogLevel.rawValue {
            // don't log
            return
        }
        
        var jsonstr = ""
        let mutableDict:NSMutableDictionary = NSMutableDictionary()
        var messageIsaDictionary = false
        if let msgdict = message() as? NSDictionary {
            let nsmsgdict = msgdict as [NSObject : AnyObject]
            mutableDict.addEntries(from: nsmsgdict)
            messageIsaDictionary = true
        }
        if !messageIsaDictionary {
            mutableDict.setObject("\(message())", forKey: "rawmsg" as NSCopying)
        }
        mutableDict.addEntries(from: standardFields as [NSObject : AnyObject])
        if let user = self.userid {
            mutableDict.setObject(user, forKey: "email" as NSCopying)
        }
        
        if let jsondata = toJson(dictionary: mutableDict) {
            jsonstr = toJsonString(data: jsondata)
        }
        addLogMsgToBuffer(msg: jsonstr)
    }
    
    private func addLogMsgToBuffer(msg:String) {
        logglyQueue.async {
            self.buffer.append(msg)
            if self.buffer.count > PagoSlimLogglyConfig.maxEntriesInBuffer {
                let tmpbuffer = self.buffer
                self.buffer = [String]()
                self.sendLogsInBuffer(stringbuffer: tmpbuffer)
            }
        }
    }
    
    private func sendLogsInBuffer(stringbuffer:[String]) {
        let allMessagesString = stringbuffer.joined(separator: "\n")
        self.traceMessage(msg: "LOGGLY: will try to post \(allMessagesString)")
        if let allMessagesData = (allMessagesString as NSString).data(using: String.Encoding.utf8.rawValue) {
            let urlRequest = NSMutableURLRequest(url: NSURL(string: PagoSlimLogglyConfig.logglyUrlString)! as URL)
            urlRequest.httpMethod = "POST"
            urlRequest.httpBody = allMessagesData
            let session = URLSession.shared
            let task = session.dataTask(with: urlRequest as URLRequest, completionHandler: {(responsedata, response, error) in
                if let anError = error {
                    self.traceMessage(msg: "Error from Loggly: \(anError)")
                } else if let data = responsedata {
                    self.traceMessage(msg: "Posted to Loggly, status = \(NSString(data: data, encoding:String.Encoding.utf8.rawValue) ?? "**nil**")")
                } else {
                    self.traceMessage(msg: "Neither error nor responsedata, something's wrong")
                }
                if self.backgroundTaskIdentifier != UIBackgroundTaskIdentifier.invalid {
                    self.endBackgroundTask()
                }
            })
            task.resume()
        }
    }
    
    private func endBackgroundTask() {
        if self.backgroundTaskIdentifier != UIBackgroundTaskIdentifier.invalid {
            UIApplication.shared.endBackgroundTask(self.backgroundTaskIdentifier)
            self.backgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
            print("Ending background task")
        }
    }
    
    private func traceMessage(msg:String) {
        if PagoSlimConfig.enableConsoleLogging && PagoSlimLogglyConfig.logglyLogLevel == PagoLogLevel.trace {
            print(msg)
        }
    }
}
