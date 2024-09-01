//
//  ChangePasswordValidationTests.swift
//  StylezUserTests
//
//  Created by MACBOOK on 2/27/24.
//

import XCTest
@testable import StylezUser

final class ChangePasswordValidationTests: XCTestCase {
    
    func test_ChangePasswordValidation_WithEmptyPassword_returnsError(){
        //Arrange
        let pass =  ""
        let confirmPass = "233"
        let oldPass = "233"
        
        let request = ChangePasswordRequest(password: pass, confirmPass: confirmPass, oldPassword: oldPass)
        let validation = ChangePasswordValidation()
   
        //ACT
        let validationResult = validation.validate(request: request)
        
        //Assert
        XCTAssertFalse(validationResult.success)
        XCTAssertNotNil(validationResult.errorMessage)
        XCTAssertEqual(validationResult.errorMessage, LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_pass", comment: ""))
    }
   
    func test_ChangePasswordValidation_WithEmptyConfirmPassword_returnsError(){
        //Arrange
        let pass =  "12"
        let confirmPass = ""
        let oldPass = "23"
        
        let request = ChangePasswordRequest(password: pass, confirmPass: confirmPass, oldPassword: oldPass)
        let validation = ChangePasswordValidation()
   
        //ACT
        let validationResult = validation.validate(request: request)
        
        //Assert
        XCTAssertFalse(validationResult.success)
        XCTAssertNotNil(validationResult.errorMessage)
        XCTAssertEqual(validationResult.errorMessage, LocalizationSystem.sharedInstance.localizedStringForKey(key: "retype_pass", comment: ""))
    }
 
    func test_ChangePasswordValidation_WithEmptyOLDPassword_returnsError(){
        //Arrange
        let pass =  "12"
        let confirmPass = "33"
        let oldPass = ""
        
        let request = ChangePasswordRequest(password: pass, confirmPass: confirmPass, oldPassword: oldPass)
        let validation = ChangePasswordValidation()
   
        //ACT
        let validationResult = validation.validate(request: request)
        
        //Assert
        XCTAssertFalse(validationResult.success)
        XCTAssertNotNil(validationResult.errorMessage)
        XCTAssertEqual(validationResult.errorMessage, LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_current", comment: ""))
    }
 
    func test_ChangePasswordValidation_WithMismatchedPass_returnsError(){
        //Arrange
        let pass =  "12"
        let confirmPass = "33"
        let oldPass = "23"
        
        let request = ChangePasswordRequest(password: pass, confirmPass: confirmPass, oldPassword: oldPass)
        let validation = ChangePasswordValidation()
   
        //ACT
        let validationResult = validation.validate(request: request)
        
        //Assert
        XCTAssertFalse(validationResult.success)
        XCTAssertNotNil(validationResult.errorMessage)
        XCTAssertEqual(validationResult.errorMessage, LocalizationSystem.sharedInstance.localizedStringForKey(key: "password_missmatch", comment: ""))
    }
 
    
    func test_ChangePasswordValidation_WithValidData_returns_Success(){
        //Arrange
        let pass =  "12"
        let confirmPass = "12"
        let oldPass = "344"
        
        let request = ChangePasswordRequest(password: pass, confirmPass: confirmPass, oldPassword: oldPass)
        let validation = ChangePasswordValidation()
   
        //ACT
        let validationResult = validation.validate(request: request)
        
        //Assert
        XCTAssertTrue(validationResult.success)
        XCTAssertNil(validationResult.errorMessage)
      }
 
}
