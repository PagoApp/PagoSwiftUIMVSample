//
//  PagoWebPresenterTests.swift
//  PagoUITests
//
//  Created by LoredanaBenedic on 14.07.2023.
//

import XCTest
@testable import PagoUISDK

final class PagoWebViewTests: XCTestCase {
	
	func testOpenUrl() {
		
		let urlString = "urLString"
		let url = URL(string: urlString)
		var model = PagoWebModel(urlString: urlString)
		let presenter = PagoWebPresenter(model: model)
		presenter.loadData()
		
		XCTAssertTrue(model.type == PagoWebDisplayType.remote)
		XCTAssertTrue(model.urlRequest == URLRequest(url: url!))
	}
	
	func testLoadHtmlString() {
		
		let htmlString = "<!doctype html>\n<html class=\"no-js\" lang=\"ro\">\n\n<head>\n<meta charset=\"utf-8\">\n<meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n<title>\n</li>\n</ul>\n</p>\n</div>\n</div>\n<div class=\"col\">\n</div>\n</div>\n</div>\n</body>\n</html>"
		var model = PagoWebModel(htmlString: htmlString)
		let presenter = PagoWebPresenter(model: model)
		presenter.loadData()
		
		XCTAssertTrue(model.type == PagoWebDisplayType.remote)
		XCTAssertNil(model.urlRequest)
	}
	
	func testOpenLocalDoc() {
		
		let localStringUrl = "local/urL"
		let localUrl = URL(string: localStringUrl)
		var model = PagoWebModel(localUrl: localUrl!)
		let presenter = PagoWebPresenter(model: model)
		presenter.loadData()
		
		XCTAssertTrue(model.type == PagoWebDisplayType.local)
		XCTAssertNotNil(model.urlRequest)
	}
}
