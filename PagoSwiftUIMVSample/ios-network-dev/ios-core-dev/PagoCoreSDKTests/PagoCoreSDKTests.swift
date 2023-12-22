//
//  PagoCoreSDKTests.swift
//  PagoCoreSDKTests
//
//  Created by Gabi on 24.05.2022.
//

import XCTest
@testable import PagoCoreSDK

class PagoCoreSDKTests: XCTestCase {

    var dataSource: PagoTokenDataSource!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        dataSource = IntegratorDataSource() as PagoTokenDataSource

    }

    func testCorrectConfigFile() throws {

        let jsonObject: [String:Any] = [
                "hostUrl": "www.cloud.pago.ro",
                "appId": "7cfdccff-acea-4334-b824-450095c215d3",
                "authHeader": "authHeader",
                "requiredDataSourceProvider": true,
                "defaultOcrFlag": false
        ]
        
        let data: Data = (try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted))!

        let config = IntegratorPagoConfig(config: data) as PagoJSONConfig
         XCTAssertNoThrow(try PagoConfigurator(config: config, tokenDataSource: dataSource), "JSON is missing smth.")
    }
    
    func testMissingBaseUrlConfigFile() throws {

        let jsonObject: [String:Any] = [
                "appId": "7cfdccff-acea-4334-b824-450095c215d3",
                "authHeader": "authHeader",
                "requiredDataSourceProvider": true,
                "defaultOcrFlag": false
        ]
        
        let data: Data = (try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted))!
        

        let config = IntegratorPagoConfig(config: data) as PagoJSONConfig
         XCTAssertThrowsError(try PagoConfigurator(config: config, tokenDataSource: dataSource), "JSON is missing smth.") {
             error in
             
             switch error as! PagoException {
             case .missing(_):
                 break
             default:
                 XCTAssert(true)
             }
         }
    }
    
    func testMissingAuthHeaderConfigFile() throws {

        let jsonObject: [String:Any] = [
                "appId": "7cfdccff-acea-4334-b824-450095c215d3",
                "hostUrl": "www.cloud.pago.ro",
                "requiredDataSourceProvider": true,
                "defaultOcrFlag": false
        ]
        
        let data: Data = (try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted))!
        

        let config = IntegratorPagoConfig(config: data) as PagoJSONConfig
         XCTAssertThrowsError(try PagoConfigurator(config: config, tokenDataSource: dataSource), "JSON is missing smth.") {
             error in
             
             switch error as! PagoException {
             case .missing(_):
                 break
             default:
                 XCTAssert(true)
             }
         }
        
    }
    
    func testMissingAppIdUrlConfigFile() throws {

        let jsonObject: [String:Any] = [
                "hostUrl": "www.cloud.pago.ro",
                "authHeader": "authHeader",
                "requiredDataSourceProvider": true,
                "defaultOcrFlag": false
        ]
        
        let data: Data = (try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted))!

        let config = IntegratorPagoConfig(config: data) as PagoJSONConfig
         XCTAssertThrowsError(try PagoConfigurator(config: config, tokenDataSource: dataSource), "JSON is missing smth.") {
             error in
             
             switch error as! PagoException {
             case .missing(_):
                 break
             default:
                 XCTAssert(true)
             }
         }
        
    }
    
    func testCorruptConfigFile() throws {

        let data: Data = Data()

        let config = IntegratorPagoConfig(config: data) as PagoJSONConfig
         XCTAssertThrowsError(try PagoConfigurator(config: config, tokenDataSource: dataSource), "JSON is missing smth.") {
             error in
             
             switch error as! PagoException {
             case .invalid(_):
                 break
             default:
                 XCTAssert(true)
             }
         }
        
    }

}
