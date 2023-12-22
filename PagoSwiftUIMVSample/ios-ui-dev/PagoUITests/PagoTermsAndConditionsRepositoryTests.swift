//
//  PagoTermsAndConditionsRepositoryTests.swift
//  PagoUITests
//
//  Created by Alex Udrea on 15.11.2023.
//

import XCTest
import PagoUISDK

final class PagoTermsAndConditionsRepositoryTests: XCTestCase {
    
    var repository: PagoTermsAndConditionsRepository!
        
    override func setUpWithError() throws {
        
        repository = PagoTermsAndConditionsRepository()
    }
    
    override func tearDownWithError() throws {
        
        repository = nil
    }
    
    func testContainsHTMLTagReturnsTrueWhenInputIsHtml() throws {
        
        let htmlString = "<!doctype html>\n<html class=\"no-js\" lang=\"ro\">\n\n<head>\n<meta charset=\"utf-8\">\n<meta http-equiv=\"x-ua-compatible\" content=\"ie=edge\">\n<title>\n</li>\n</ul>\n</p>\n</div>\n</div>\n<div class=\"col\">\n</div>\n</div>\n</div>\n</body>\n</html>"
        
        let result = repository.containsHTMLTag(htmlString)
        
        XCTAssertTrue(result, "Method should have returned true as the input text is a html structure.")
        XCTAssertTrue(repository.containsHTMLTag("<script type=\"text/javascript\">\ndocument.write(\"JavaScript\");\n</script>"))

    }
    
    func testContainsHTMLTagReturnsFalseWhenInputIsURL() throws {
        
        let result = repository.containsHTMLTag("https://www.example.com/")
        
        XCTAssertFalse(result, "Method should have returned false as there was no tag in the input text.")

    }
    
    func testContainsHTMLTagReturnsFalseWhenInputIsWrongHtml() throws {
        
        XCTAssertFalse(repository.containsHTMLTag("This is a plain text without HTML tags"))
        XCTAssertFalse(repository.containsHTMLTag("<div class=\"invalid\" "))
        XCTAssertFalse(repository.containsHTMLTag("<a href='wrong'"))
        XCTAssertFalse(repository.containsHTMLTag("<span>"))
        XCTAssertFalse(repository.containsHTMLTag("<div>Incomplete div"))
        XCTAssertFalse(repository.containsHTMLTag("document.write(\"JavaScript\");"));
        
    }
}
