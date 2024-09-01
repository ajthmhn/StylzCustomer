//
//  AddAddressRequestValidation_UnitTests.swift
//  StylezUserTests
//
//  Created by MACBOOK on 3/5/24.
//

import XCTest

@testable import StylezUser

final class AddAddressRequestValidation_UnitTests: XCTestCase {
    
    func test_addAddressRequest_withEmptyName_returnError(){
        
        let name = ""
        let lat:Double? = nil
        let long:Double? = nil
        
        let request = AddAddressRequest(_latitude: lat, _longitude: long, nickName: name)
        
        let validation = AddAddressRequestValidation()
        let validationResult = validation.validateAddress(request: request)
        
        XCTAssertFalse(validationResult.success)
        XCTAssertNotNil(validationResult.errorMessage)
        XCTAssertEqual(validationResult.errorMessage,LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_nick", comment: ""))
        }
    

  func test_addAddressRequest_withEmptyLocationDetails_returnError(){
    
    let name = "home"
    let lat:Double? = nil
    let long:Double? = nil
    
    let request = AddAddressRequest(_latitude: lat, _longitude: long, nickName: name)
    
    let validation = AddAddressRequestValidation()
    let validationResult = validation.validateAddress(request: request)
    
    XCTAssertFalse(validationResult.success)
    XCTAssertNotNil(validationResult.errorMessage)
    XCTAssertEqual(validationResult.errorMessage,  "Please choose location")
    }

    func test_addAddressRequest_withValidDetails_return_Success(){
      
        let name = "home"
        let lat:Double? = 3.3
        let long:Double? = 4.4
      
      let request = AddAddressRequest(_latitude: lat, _longitude: long, nickName: name)
      
      let validation = AddAddressRequestValidation()
      let validationResult = validation.validateAddress(request: request)
      
      XCTAssertTrue(validationResult.success)
      XCTAssertNil(validationResult.errorMessage)
     
    }

    
}
