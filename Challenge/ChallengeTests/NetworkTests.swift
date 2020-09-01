//
//  NetworkTests.swift
//  ChallengeTests
//
//  Created by Estelle Paus on 8/27/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import XCTest
@testable import Challenge

class NetworkTests: XCTestCase {
    
    var sut: Network!
    var mockURLSession : MockURLSession!
    
    override func setUpWithError() throws {
        sut = Network()
        mockURLSession = MockURLSession()
        sut.session = mockURLSession
    }

    override func tearDownWithError() throws {
        sut = nil
        mockURLSession = nil
    }

    func test_NetworkUsesExpectedHost() {
        let imageURL = "http://dev.tapptic.com/test/json.php"
        sut.makeRequest(urlString: imageURL, completion: {results in
            
        })
        guard let url = sut.theURL else { XCTFail(); return }
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL:  true)
        XCTAssertEqual(urlComponents?.host, "dev.tapptic.com")
    }
    
    func testNetworkUsesExpectedPath() {
        let imageURL = "http://dev.tapptic.com/test/json.php"
        sut.makeRequest(urlString: imageURL, completion: {results in
            
        })
        guard let url = sut.theURL else { XCTFail(); return }
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL:  true)
        XCTAssertEqual(urlComponents?.path, "/test/json.php")
    }
    
    func testNetworkUsesGetMethod()  throws {
         let nm = Network()
         let method = nm.method
         XCTAssertEqual(method, .get)
     }
     
     func testNetworkTimeoutIs30() throws {
         let nm = Network()
         let timeout = nm.timeoutInterval
         XCTAssertEqual(timeout, 30)
     }
     
     func testParseJsonCreatesModelArray() throws {
         
         if let path = Bundle.main.path(forResource: "response", ofType: "json") {
             do {
                 if let data = NSData(contentsOfFile: path) {
                     let nm = Network()
                     if let results = nm.parseResponse(data: data as Data) {
                         let array = results as [DTOModel]
                         XCTAssertEqual(array.count, 4)
                     }
                 }
             }
         } else {
            XCTFail()
        }
     }
     
     func testParseJsonSuccessfulDespiteMissingField() throws {
            
            if let path = Bundle.main.path(forResource: "responseWithMissingField", ofType: "json") {
                do {
                    if let data = NSData(contentsOfFile: path) {
                        let nm = Network()
                        if let results = nm.parseResponse(data: data as Data) {
                            let array = results as [DTOModel]
                            XCTAssertEqual(array.count, 4)
                            let model = array[0]
                            let emptyField = model.name
                            XCTAssertNil(emptyField)
                        }
                    }
                }
            } else {
                XCTFail()
            }
        }

}

extension NetworkTests {
    class MockURLSession: SessionProtocol {
        
        var url: URL?
        
        func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = request.url
            return URLSession.shared.dataTask(with: self.url!)
        }
    }
}

