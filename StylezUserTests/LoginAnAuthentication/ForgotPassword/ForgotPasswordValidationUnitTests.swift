//
//  ForgotPasswordValidationUnitTests.swift
//  StylezUserTests
//
//  Created by MACBOOK on 2/27/24.
//

import XCTest
@testable import StylezUser

final class ForgotPasswordValidationUnitTests: XCTestCase {
    
    func test_ForgotPasswordValidation_WithEmptyEmail_returnsError(){
        //Arrange
        let emailOrNum =  ""
        let isEmail = true
        let request = ForgotpasswordRequest(phone: emailOrNum, isEmail: isEmail)
        let validation = ForgotPasswordValidation()
   
        //ACT
        let validationResult = validation.validate(request: request)
        
        //Assert
        XCTAssertFalse(validationResult.success)
        XCTAssertNotNil(validationResult.errorMessage)
        XCTAssertEqual(validationResult.errorMessage, LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_email", comment: ""))
    }
 
    
    func test_ForgotPassValidation_WithEmptyNum_returnsError(){
        //Arrange
        let emailOrNum =  ""
        let isEmail = false
        let request = ForgotpasswordRequest(phone: emailOrNum, isEmail: isEmail)
        let validation = ForgotPasswordValidation()
   
        //ACT
        let validationResult = validation.validate(request: request)
        
        //Assert
        XCTAssertFalse(validationResult.success)
        XCTAssertNotNil(validationResult.errorMessage)
        XCTAssertEqual(validationResult.errorMessage, LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_phone", comment: ""))
    }
   
    
    func test_forGotPassValidation_WithInvalidEmail_returnsError(){
        //Arrange
        let emailOrNum =  "sara@gamsil"
        let isEmail = true
        let request = ForgotpasswordRequest(phone: emailOrNum, isEmail: isEmail)
        let validation = ForgotPasswordValidation()
   
        //ACT
        let validationResult = validation.validate(request: request)
        
        //Assert
        XCTAssertFalse(validationResult.success)
        XCTAssertNotNil(validationResult.errorMessage)
        XCTAssertEqual(validationResult.errorMessage, LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_valid", comment: ""))
    }
   
    
    func test_forgotPassValidation_WithValidEmail_returns_Succeess(){
        //Arrange
        let emailOrNum =  "sara@gmail.com"
        let isEmail = true
        let request = ForgotpasswordRequest(phone: emailOrNum, isEmail: isEmail)
        let validation = ForgotPasswordValidation()
        
        //ACT
        let validationResult = validation.validate(request: request)
        
        //Assert
        XCTAssertTrue(validationResult.success)
        XCTAssertNil(validationResult.errorMessage)
        
    }
   
    func test_forgotPassValidation_WithValidNumber_returns_Succeess(){
        //Arrange
        let emailOrNum =  "1234"
        let isEmail = false
        let request = ForgotpasswordRequest(phone: emailOrNum, isEmail: isEmail)
        let validation = ForgotPasswordValidation()
        
        //ACT
        let validationResult = validation.validate(request: request)
        
        //Assert
        XCTAssertTrue(validationResult.success)
        XCTAssertNil(validationResult.errorMessage)
        
    }
   
    
}
