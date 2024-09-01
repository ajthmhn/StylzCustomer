//
//  ForgotPasswordViewModelUnitTests.swift
//  StylezUserTests
//
//  Created by MACBOOK on 2/27/24.
//

import XCTest
@testable import StylezUser

final class ForgotPasswordViewModelUnitTests: XCTestCase {
    
    //MARK: - test forgot password api with number
    func  test_ForgotPasswordHandler_WithValidNumber_ReturnsAPIResponse(){
        //ARRANGE
        let emailOrNum =  "123456789"
        let isEmail = false
        let request = ForgotpasswordRequest(phone: emailOrNum, isEmail: isEmail)
        let validation = ForgotPasswordValidation()
        let expectation = XCTestExpectation(description: "forgotPass")
        
        //ACT
        let validationResult = validation.validate(request: request)
        
        if validationResult.success{
            
            let resource = ForgotPasswordResource()
            resource.forgotPassword(request: request){id, otp, errorMsg in
                
                //ASSERT
                //print("got verify otp response otp: \(otp), \(errorMsg)")
                XCTAssertNotNil(id)
                XCTAssertNotNil(otp)
                XCTAssertNil(errorMsg)
                
                expectation.fulfill()
            }
        }
        else{
            //ASSERT
            XCTFail("test should succeed but failed with validation error: \(validationResult.errorMessage)")
        }
        wait(for: [expectation], timeout: 20.0)
        
    }
    
    func  test_ForgotPasswordHandler_WithInValidNumber_ReturnsAPIError(){
        //ARRANGE
        let emailOrNum =  "1234"
        let isEmail = false
        let request = ForgotpasswordRequest(phone: emailOrNum, isEmail: isEmail)
        let validation = ForgotPasswordValidation()
        let expectation = XCTestExpectation(description: "forgotPass")
        
        //ACT
        let validationResult = validation.validate(request: request)
        
        if validationResult.success{
            
            let resource = ForgotPasswordResource()
            resource.forgotPassword(request: request){id, otp, errorMsg in
                
                //ASSERT
                //print("got verify otp response otp: \(otp), \(errorMsg)")
                XCTAssertNil(id)
                XCTAssertNil(otp)
                XCTAssertNotNil(errorMsg)
                XCTAssertEqual(errorMsg, "The phone number you entered seems to be incorrect. Please verify the phone number and try again", "task should fail wtih error")
                expectation.fulfill()
            }
        }
        else{
            //ASSERT
            XCTFail("test should failed with API error but faild with: \(validationResult.errorMessage)")
        }
        wait(for: [expectation], timeout: 20.0)
   
    }
    func  test_ForgotPasswordHandler_WithEmptyNumber_ReturnsError(){
        //ARRANGE
        let emailOrNum =  ""
        let isEmail = false
        let request = ForgotpasswordRequest(phone: emailOrNum, isEmail: isEmail)
        let validation = ForgotPasswordValidation()
        let expectation = XCTestExpectation(description: "forgotPass")
        
        //ACT
        let validationResult = validation.validate(request: request)
        
        if validationResult.success{
            
            let resource = ForgotPasswordResource()
            resource.forgotPassword(request: request){id, otp, errorMsg in
                
                //ASSERT
                //print("got verify otp response otp: \(otp), \(errorMsg)")
                XCTAssertNil(id)
                XCTAssertNil(otp)
                XCTAssertNil(errorMsg)
                XCTFail("task should fail with validation error")
            }
        }
        else{
            //ASSERT
            XCTAssertEqual(validationResult.errorMessage,LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_phone", comment: ""))
           
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20.0)
    }


    //MARK: - test forgot password api with mail
    
    func  test_ForgotPasswordHandler_WithUnregisteredEmail_ReturnsAPIError(){
        //ARRANGE
        let emailOrNum =  "sra@gmail.com"
        let isEmail = true
        let request = ForgotpasswordRequest(phone: emailOrNum, isEmail: isEmail)
        let validation = ForgotPasswordValidation()
        let expectation = XCTestExpectation(description: "forgotPAss")
        
        //ACT
        let validationResult = validation.validate(request: request)
        
        if validationResult.success{
            
            let resource = ForgotPasswordResource()
            resource.forgotPassword(request: request){id, otp, errorMsg in
                
                //ASSERT
                //print("got verify otp response otp: \(otp), \(errorMsg)")
                XCTAssertNil(id)
                XCTAssertNil(otp)
                XCTAssertNotNil(errorMsg)
                XCTAssertEqual(errorMsg, "The email address you entered seems to be incorrect. Please verify the email address and try again")
                
                expectation.fulfill()
            }
        }
        else{
            //ASSERT
            XCTFail("test should succeed but failed with validation error: \(validationResult.errorMessage)")
        }
        wait(for: [expectation], timeout: 20.0)
    }
    
    func  test_ForgotPasswordHandler_WithValidEmail_ReturnsAPIResponse(){
        //ARRANGE
        let emailOrNum =  "sara@gmail.com"
        let isEmail = true
        let request = ForgotpasswordRequest(phone: emailOrNum, isEmail: isEmail)
        let validation = ForgotPasswordValidation()
        let expectation = XCTestExpectation(description: "forgotPAss")
        
        //ACT
        let validationResult = validation.validate(request: request)
        
        if validationResult.success{
            
            let resource = ForgotPasswordResource()
            resource.forgotPassword(request: request){id, otp, errorMsg in
                
                //ASSERT
                //print("got verify otp response otp: \(otp), \(errorMsg)")
                XCTAssertNotNil(id)
                XCTAssertNotNil(otp)
                XCTAssertNil(errorMsg)
                
                expectation.fulfill()
            }
        }
        else{
            //ASSERT
            XCTFail("test should succeed but failed with validation error: \(validationResult.errorMessage)")
        }
        wait(for: [expectation], timeout: 20.0)
    }
    
    func  test_ForgotPasswordHandler_WithInValidEmail_ReturnsError(){
        //ARRANGE
        let emailOrNum =  "saras"
        let isEmail = true
        let request = ForgotpasswordRequest(phone: emailOrNum, isEmail: isEmail)
        let validation = ForgotPasswordValidation()
        let expectation = XCTestExpectation(description: "forgotPass")
        
        //ACT
        let validationResult = validation.validate(request: request)
        
        if validationResult.success{
            
            let resource = ForgotPasswordResource()
            resource.forgotPassword(request: request){id, otp, errorMsg in
                
                //ASSERT
                //print("got verify otp response otp: \(otp), \(errorMsg)")
                XCTAssertNil(id)
                XCTAssertNil(otp)
                XCTAssertNil(errorMsg)
                XCTFail("task should fail with validation error")
            }
        }
        else{
            //ASSERT
            XCTAssertEqual(validationResult.errorMessage,LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_valid", comment: ""))
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20.0)
   
    }
   
    func  test_ForgotPasswordHandler_WithEmptyEmail_ReturnsError(){
        //ARRANGE
        let emailOrNum =  ""
        let isEmail = true
        let request = ForgotpasswordRequest(phone: emailOrNum, isEmail: isEmail)
        let validation = ForgotPasswordValidation()
        let expectation = XCTestExpectation(description: "forgotPass")
        
        //ACT
        let validationResult = validation.validate(request: request)
        
        if validationResult.success{
            
            let resource = ForgotPasswordResource()
            resource.forgotPassword(request: request){id, otp, errorMsg in
                
                //ASSERT
                //print("got verify otp response otp: \(otp), \(errorMsg)")
                XCTAssertNil(id)
                XCTAssertNil(otp)
                XCTAssertNil(errorMsg)
                XCTFail("task should fail with validation error")
            }
        }
        else{
            //ASSERT
            XCTAssertEqual(validationResult.errorMessage,LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_email", comment: ""))
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20.0)
    }
}
