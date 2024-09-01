//
//  AddAddressViewIntegration_UnitTests.swift
//  StylezUserTests
//
//  Created by MACBOOK on 3/5/24.
//

import XCTest
@testable import StylezUser



final class AddAddressViewIntegration_UnitTests: XCTestCase {
    
    func test_addAddressModel_withInvalidDetails_ReturnsError(){
        
        let nickName =  "sdd"
        let latitude:Double? = nil
        let longitude:Double? = nil
        
        let expectation = XCTestExpectation(description: "Add new address")
        let request = AddAddressRequest(_latitude: latitude, _longitude: longitude, nickName: nickName)
        
        let viewModel = AddAddressViewModel()
        viewModel.createAddress(request: request) { err in
            XCTAssertNotNil(err)
            XCTAssertEqual(err, "Please choose location")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    func test_addAddressModel_withEmptyNickName_ReturnsError(){
     
    let nickName =  ""
    let latitude:Double? = nil
    let longitude:Double? = nil
    
        let expectation = XCTestExpectation(description: "Add new address")
    let request = AddAddressRequest(_latitude: latitude, _longitude: longitude, nickName: nickName)
    
    let viewModel = AddAddressViewModel()
        viewModel.createAddress(request: request) { err in
            XCTAssertNotNil(err)
            XCTAssertEqual(err, LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_nick", comment: ""))
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    // run login api first
    func test_addAddressModel_withValidDetails_ReturnsAPIResponse(){
     
    let nickName =  "home"
        let latitude:Double? = 2.2
    let longitude:Double? = 45
    
        let expectation = XCTestExpectation(description: "Add new address")
    let request = AddAddressRequest(_latitude: latitude, _longitude: longitude, nickName: nickName)
    
    let viewModel = AddAddressViewModel()
        viewModel.createAddress(request: request) { err in
            XCTAssertNil(err)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    
}

