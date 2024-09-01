//
//  DeleteAddress_UnitTest.swift
//  StylezUserTests
//
//  Created by MACBOOK on 3/5/24.
//

import XCTest

@testable import StylezUser

//"{\"detail\":\"Invalid token.\",\"status\":false}"
//"{\"detail\":\"Authentication credentials were not provided.\",\"status\":false}"

//141 valid address id
final class DeleteAddress_UnitTest: XCTestCase {

 
    func test_DeleteAddress_withEmptyID_returnsError(){
    
    let id = 0
    
    let expectation = XCTestExpectation(description: "delete address")
    let request = DeleteAddressRequest(id: id)
    
    let viewModel = DeleteAddressViewModel()
        viewModel.deleteAddress(request: request) { err in
            
            XCTAssertNotNil(err)
            XCTAssertEqual(err, K.Error.someThingWentWrong)
            expectation.fulfill()
            
        }
    
    wait(for: [expectation], timeout: 20.0)
}
    
    
    func test_DeleteAddress_withInvalidID_returnsAPIError(){    let id = 123
    
    let expectation = XCTestExpectation(description: "delete address")
    let request = DeleteAddressRequest(id: id)
    
    let viewModel = DeleteAddressViewModel()
        viewModel.deleteAddress(request: request) { err in
            
            XCTAssertNotNil(err)
            XCTAssertEqual(err, K.Error.someThingWentWrong)
            expectation.fulfill()
            
        }
    
    wait(for: [expectation], timeout: 20.0)
}
    
    func test_DeleteAddress_withValidID_returnsAPIResponse(){    let id = 141
    
    let expectation = XCTestExpectation(description: "delete address")
    let request = DeleteAddressRequest(id: id)
    
    let viewModel = DeleteAddressViewModel()
        viewModel.deleteAddress(request: request) { err in
            
            XCTAssertNil(err)
            //XCTAssertEqual(err, K.Error.someThingWentWrong)
            expectation.fulfill()
        }
    wait(for: [expectation], timeout: 20.0)
}
}
