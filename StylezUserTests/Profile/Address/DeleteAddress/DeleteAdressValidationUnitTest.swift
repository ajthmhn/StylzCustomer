//
//  DeleteAdressValidationUnitTest.swift
//  StylezUserTests
//
//  Created by MACBOOK on 3/5/24.
//

import XCTest

@testable import StylezUser

final class DeleteAdressValidationUnitTest: XCTestCase {

    func test_deleteAddressRequestValdiation_withEmptyID_returnError(){
        let id = 0
        
        let request = DeleteAddressRequest(id: id)
        
        let validation = DeleteAddressRequestValidation()
        
        let validationResult = validation.validateId(request: request)
       
        XCTAssertFalse(validationResult.success)
        XCTAssertNotNil(validationResult.errorMessage)
        
    }
    
    func test_deleteAddressRequestValdiation_withinvalidID_returnError(){
        let id = -1
        
        let request = DeleteAddressRequest(id: id)
        
        let validation = DeleteAddressRequestValidation()
        
        let validationResult = validation.validateId(request: request)
       
        XCTAssertFalse(validationResult.success)
        XCTAssertNotNil(validationResult.errorMessage)
        
    }
    
    func test_deleteAddressRequestValdiation_withvalidID_return_Success(){
        let id = 233
        
        let request = DeleteAddressRequest(id: id)
        
        let validation = DeleteAddressRequestValidation()
        
        let validationResult = validation.validateId(request: request)
       
        XCTAssertTrue(validationResult.success)
        XCTAssertNil(validationResult.errorMessage)
        
    }
   
}
