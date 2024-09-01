//
//  UpdateNumberValidationTest.swift
//  StylezUserTests
//
//  Created by MACBOOK on 3/3/24.
//

import XCTest
import StylesWebKit

@testable import StylezUser

final class UpdateNumberValidationTest: XCTestCase {
    
    func test_validateNumber_WithValidDetails_Return_Success()  {
        
        let number  =  "1233"
        let id = StylzAPIFacade.shared.session?.UserId ?? -1
        
        let request = UpdateNumberRequest(userID: id, number: number)
        
        let validation = UpdateNumberValidation()
        let validationResult = validation.validateNumber(request: request)
        
        XCTAssertTrue(validationResult.success)
        XCTAssertNil(validationResult.errorMessage)
    }
   
    
    
    func test_validateNumber_WithEmptyNumer_ReturnError()  {
        
        let number  =  ""
        let id = StylzAPIFacade.shared.session?.UserId ?? -1
        
        let request = UpdateNumberRequest(userID: id, number: number)
        
        let validation = UpdateNumberValidation()
        let validationResult = validation.validateNumber(request: request)
        
        XCTAssertFalse(validationResult.success)
        XCTAssertNotNil(validationResult.errorMessage)
        XCTAssertEqual(validationResult.errorMessage, LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_phone", comment: ""))
    }
    
    func test_validateNumber_WithInvalidID_ReturnError()  {
        
        let number  =  "123"
        let id =  0
        
        let request = UpdateNumberRequest(userID: id, number: number)
        
        let validation = UpdateNumberValidation()
        let validationResult = validation.validateNumber(request: request)
        
        XCTAssertFalse(validationResult.success)
        XCTAssertNotNil(validationResult.errorMessage)
        XCTAssertEqual(validationResult.errorMessage, K.Error.someThingWentWrong)
    }
    
}
