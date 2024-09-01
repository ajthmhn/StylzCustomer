//
//  UpdateEmailValidationTest.swift
//  StylezUserTests
//
//  Created by MACBOOK on 3/3/24.
//

import XCTest
import StylesWebKit
@testable import StylezUser


final class UpdateEmailValidationTest: XCTestCase {

    func test_EmailValidation_WithEmptyEmail_ReturnsError(){
        let email  =  ""
        let id = StylzAPIFacade.shared.session?.UserId ?? -1
        
        let request = UpdateEmailRequest(userID: id, email: email)
        
        let validation = UpdateEmailValidation()
        let validationResult = validation.validateEmail(request: request)
        
        XCTAssertFalse(validationResult.success)
        XCTAssertNotNil(validationResult.errorMessage)
        XCTAssertEqual(validationResult.errorMessage, LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_email", comment: ""))
    }

    func test_EmailValidation_WithInValidEmail_ReturnsError(){
        let email  =  "sanam@gmaolcom"
        let id = StylzAPIFacade.shared.session?.UserId ?? -1
        
        let request = UpdateEmailRequest(userID: id, email: email)
        
        let validation = UpdateEmailValidation()
        let validationResult = validation.validateEmail(request: request)
        
        XCTAssertFalse(validationResult.success)
        XCTAssertNotNil(validationResult.errorMessage)
        XCTAssertEqual(validationResult.errorMessage, LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_valid", comment: ""))
    }

    func test_EmailValidation_WithInvalidID_ReturnsError(){
        let email  =  "dssd"
        let id =  -1
        
        let request = UpdateEmailRequest(userID: id, email: email)
        
        let validation = UpdateEmailValidation()
        let validationResult = validation.validateEmail(request: request)
        
        XCTAssertFalse(validationResult.success)
        XCTAssertNotNil(validationResult.errorMessage)
        XCTAssertEqual(validationResult.errorMessage, K.Error.someThingWentWrong)
    }

    func test_EmailValidation_WithValidDetails_Returns_Success(){
        let email  =  "sara@gmail.com"
        let id = StylzAPIFacade.shared.session?.UserId ?? -1
        
        let request = UpdateEmailRequest(userID: id, email: email)
        
        let validation = UpdateEmailValidation()
        let validationResult = validation.validateEmail(request: request)
        
        XCTAssertTrue(validationResult.success)
        XCTAssertNil(validationResult.errorMessage)
   
    }

    
}
