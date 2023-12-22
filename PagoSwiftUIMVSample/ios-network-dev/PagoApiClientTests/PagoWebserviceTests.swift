//
//  PagoWebserviceTests.swift
//  PagoApiClientTests
//
//  Created by Alex Udrea on 14.12.2023.
//

import XCTest
@testable import PagoApiClient

final class PagoWebserviceTests: XCTestCase {

    var webService: PagoWebservice!
    override func setUpWithError() throws {
        webService = PagoWebservice(authorizationKey: "", delegate: nil)
    }

    override func tearDownWithError() throws {
        webService = nil
    }

    func testIsRequestStaticDataReturnsTrueWhenStaticModelsIsCalled() {
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration)
            
            let urlString = "rca/static/models"
            if let url = URL(string: urlString) {
                let request = URLRequest(url: url)
                let task = session.dataTask(with: request)
                
                // Use a PagoRequest object here
                let pagoRequest = PagoRequest(session: session, requestTask: .data(nil, task))
                
                XCTAssertTrue(webService.isRequestStaticData(pagoRequest), "Should have returned true because URL contains static")
            } else {
                XCTFail("Invalid URL")
            }
        }
    
    func testIsRequestStaticDataReturnsTrueWhenStaticIsCalled() {
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration)
            
            let urlString = "rca/static"
            if let url = URL(string: urlString) {
                let request = URLRequest(url: url)
                let task = session.dataTask(with: request)
                
                // Use a PagoRequest object here
                let pagoRequest = PagoRequest(session: session, requestTask: .data(nil, task))
                
                XCTAssertTrue(webService.isRequestStaticData(pagoRequest), "Should have returned true because URL contains static")
            } else {
                XCTFail("Invalid URL")
            }
        }
    
    func testIsRequestStaticDataReturnsTrueWhenStaticCountiesIsCalled() {
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration)
            
            let urlString = "rca/static/counties"
            if let url = URL(string: urlString) {
                let request = URLRequest(url: url)
                let task = session.dataTask(with: request)
                
                // Use a PagoRequest object here
                let pagoRequest = PagoRequest(session: session, requestTask: .data(nil, task))
                
                XCTAssertTrue(webService.isRequestStaticData(pagoRequest), "Should have returned true because URL contains static")
            } else {
                XCTFail("Invalid URL")
            }
        }
    
    func testIsRequestStaticDataReturnsFalseWhenNoStaticDataApiIsCalled() {
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration)
            
            let urlString = "random/api"
            if let url = URL(string: urlString) {
                let request = URLRequest(url: url)
                let task = session.dataTask(with: request)
                
                // Use a PagoRequest object here
                let pagoRequest = PagoRequest(session: session, requestTask: .data(nil, task))
                
                XCTAssertFalse(webService.isRequestStaticData(pagoRequest), "Should have returned false because URL does not contain static")
            } else {
                XCTFail("Invalid URL")
            }
        }
    
    func testIsRequestStaticDataReturnsFalseWhenNoCorrectStaticDataApiIsCalled() {
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration)
            
            let urlString = "wrong/staticapi"
            if let url = URL(string: urlString) {
                let request = URLRequest(url: url)
                let task = session.dataTask(with: request)
                
                // Use a PagoRequest object here
                let pagoRequest = PagoRequest(session: session, requestTask: .data(nil, task))
                
                XCTAssertFalse(webService.isRequestStaticData(pagoRequest), "Should have returned false because URL does not contain static element")
            } else {
                XCTFail("Invalid URL")
            }
        }

    

}
