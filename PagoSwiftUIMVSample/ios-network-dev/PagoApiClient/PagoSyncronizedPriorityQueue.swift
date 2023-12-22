//
//  SyncronizedPriorityQueue.swift
//  Pago
//
//  Created by Mihai Arosoaie on 08/12/16.
//  Copyright © 2016 timesafe. All rights reserved.
//


import Foundation
import CoreFoundation

public protocol Prioritizable {
    var priority: Int { get }
}


//a lower number has a higher priority
open class PagoSyncronizedPriorityQueue<Job: Prioritizable> {
    private var jobs: [Job] = []
    
    private var lock: NSLock = NSLock()
    
    open func enqueue(job: Job) {
        lock.lock()
        defer { lock.unlock() }
        jobs.append(job)
        sortJobs()
    }
    
    open func remove(matching: (Job) -> Bool) {
        lock.lock()
        defer { lock.unlock() }
        jobs = jobs.filter({!matching($0)})
    }
    
    private func sortJobs() {
        jobs.sort { (job1, job2) -> Bool in
            return job1.priority > job2.priority
        }
    }
    
    open func deque() -> Job? {
        lock.lock()
        defer { lock.unlock() }
        return jobs.popLast()
    }
    
    public init(_ jobs: [Job]) {
        self.jobs = jobs
        sortJobs()
    }
    
    public init() {
        
    }
    
    open func contents() -> String {
        return String(describing: jobs)
    }
}

//not finished
public class PagoDownloadQueue {
    
    public var ongoing = Set<PagoDownload>()
    
    public let priorityQueue: PagoSyncronizedPriorityQueue<PagoDownload>
    public let webservice: PagoWebservice
    
    public static let shared = PagoDownloadQueue(PagoApiClientManager.shared.webservice)
    
    public init(_ webservice: PagoWebservice) {
        priorityQueue = PagoSyncronizedPriorityQueue<PagoDownload>()
        self.webservice = webservice
    }
    
    public func enqueue(download: PagoDownload) {
        priorityQueue.enqueue(job: download)
        if ongoing.count == 0 {
            startNext()
        }
    }
    
    public func cancel(download: PagoDownload) {
        priorityQueue.remove { (d) -> Bool in
            d.resource.path == download.resource.path &&
            d.resource.method == download.resource.method
        }
    }
    
    public func startNext() {
        guard let download = priorityQueue.deque() else {
            //download queue empty
            return
        }
        ongoing.insert(download)

        webservice.load(download.resource) {[unowned self] result in
            self.ongoing.remove(download)

            switch result {
            case .success(let result):
                self.handleCompleted(download: download, data: result)
            case .failure(let error):
                self.handleFailed(download: download, error: error)
            }
            
            self.startNext()
        }
    }
    
    public let fileManager = FileManager.default
    
    public func handleCompleted(download: PagoDownload, data: Data) {
        //write to path
        fileManager.save(data: data, path: download.localPath)
        download.completionBlock(nil)
    }
    
    public func handleFailed(download: PagoDownload, error: Error?) {
        PagoLogManager.shared.log("Error downloading \(download): \(String(describing: error))")
        download.completionBlock(error)

//        priorityQueue.enqueue(job: download)

    }
    
}

extension FileManager {
    
    ///saves data at file with path by creating the missing directories
    public func save(data: Data, path: String) {
        let dirPath = (path as NSString).deletingLastPathComponent

        if !directoryExists(path: dirPath) {
            do {
                try createDirectory(atPath: dirPath, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                PagoLogManager.shared.log("Error while creating directory at path \(dirPath): \(error)")
            }
        }
        
        createFile(atPath: path, contents: data, attributes: nil)
    }
    
    public func directoryExists(path: String) -> Bool {
        var isDir : ObjCBool = false
        return fileExists(atPath: path, isDirectory: &isDir)
    }
    
    public func fileExists(at url: URL) -> Bool {
        return self.fileExists(atPath: url.path)
    }
}
