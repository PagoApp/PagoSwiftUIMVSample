//
//  PagoUIOperationPreload.swift
//  PagoCoreSDK
//
//  Created by Bogdan on 16.06.2023.
//

import Foundation

class PagoUIOperationPreload: Operation, PagoOperationPreload {
    
    var version: String
    var download: (String)->(Data?)
    
    var downloadedData: Data? = nil
    
    init(version: String, download: @escaping (String)->(Data?)) {

        self.version = version
        self.download = download
    }
    
    override func main() {

        guard !isCancelled else { return }
    
        guard let data = download(version) else { return }
        
        guard !isCancelled else { return }
        
        downloadedData = data
    }
}
