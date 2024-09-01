//
//  ChangePasswordControllerTests.swift
//  StylezUserTests
//
//  Created by MACBOOK on 2/27/24.
//

import XCTest
@testable import StylezUser
final class ChangePasswordControllerTests: XCTestCase {

    // "{\"detail\":\"Authentication credentials were not provided.\",\"status\":false}"
   // "{\"detail\":\"Invalid token.\",\"status\":false}"
    
    //Old  password is wrong.
    //first hit login api
    func test_changePasswordAPI_WithValidData_ReturnsError(){
        
        let oldPass =  "3"
        let newPass =  "1"
        let confirmPass =  "1"
        
        let expectation = XCTestExpectation(description: "changePass")
        
        let request = ChangePasswordRequest(password: newPass, confirmPass: confirmPass, oldPassword: oldPass)
        
        let viewModel = ChangePassViewModel()
        viewModel.changePassword(request: request) { errorMsg in
         
                XCTAssertNil(errorMsg)
              //  XCTAssertEqual(errorMsg, "The email address you entered seems to be incorrect. Please verify the email address and try again")
                expectation.fulfill()
                
            }
            wait(for: [expectation], timeout: 20)
            
        }
    
    
    func test_changePasswordAPI_WithMismatchedPass_ReturnsError(){
        
        let oldPass =  "3"
        let newPass =  "12"
        let confirmPass =  "2"
        
        let expectation = XCTestExpectation(description: "changePass")
        
        let request = ChangePasswordRequest(password: newPass, confirmPass: confirmPass, oldPassword: oldPass)
        
        let viewModel = ChangePassViewModel()
        viewModel.changePassword(request: request) { errorMsg in
      
                XCTAssertNotNil(errorMsg)
                XCTAssertEqual(errorMsg, LocalizationSystem.sharedInstance.localizedStringForKey(key: "password_missmatch", comment: ""))
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 20)
            
        }

 
    func test_changePasswordAPI_WithIncorrectOlDPass_ReturnsAPIError(){
        
        let oldPass =  "5"
        let newPass =  "12"
        let confirmPass =  "12"
        
        let expectation = XCTestExpectation(description: "changePass")
        
        let request = ChangePasswordRequest(password: newPass, confirmPass: confirmPass, oldPassword: oldPass)
        
        let viewModel = ChangePassViewModel()
        viewModel.changePassword(request: request) { errorMsg in
      
                XCTAssertNotNil(errorMsg)
                XCTAssertEqual(errorMsg, "Old  password is wrong.")
                expectation.fulfill()
            }
            
           
        wait(for: [expectation], timeout: 20)
            
        
    }
    
    
    func test_changePasswordAPI_WithEmptyConfirmPass_ReturnsError(){
        
        let oldPass =  "33"
        let newPass =  "223"
        let confirmPass =  ""
        
        let expectation = XCTestExpectation(description: "changePass")
        
        let request = ChangePasswordRequest(password: newPass, confirmPass: confirmPass, oldPassword: oldPass)
      
        let viewModel = ChangePassViewModel()
        viewModel.changePassword(request: request) { errorMsg in
      
                XCTAssertNotNil(errorMsg)
                XCTAssertEqual(errorMsg, LocalizationSystem.sharedInstance.localizedStringForKey(key: "retype_pass", comment: ""))
                expectation.fulfill()
                
            }
            
            wait(for: [expectation], timeout: 20)
    }
       
        func test_changePasswordAPI_WithEmptyOldPass_ReturnsError(){
            
            let oldPass =  ""
            let newPass =  "223"
            let confirmPass =  "22"
            
            let expectation = XCTestExpectation(description: "changePass")
            
            let request = ChangePasswordRequest(password: newPass, confirmPass: confirmPass, oldPassword: oldPass)
            
            let viewModel = ChangePassViewModel()
            viewModel.changePassword(request: request) { errorMsg in
          
                    XCTAssertNotNil(errorMsg)
                    XCTAssertEqual(errorMsg, LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_current", comment: ""))
                    expectation.fulfill()
                    
                }
                
                wait(for: [expectation], timeout: 20)
            }
            
        
        func test_changePasswordAPI_WithEmptyNewPass_ReturnsError(){
            
            let oldPass =  "33"
            let newPass =  ""
            let confirmPass =  "33"
            
            let expectation = XCTestExpectation(description: "changePass")
            
            let request = ChangePasswordRequest(password: newPass, confirmPass: confirmPass, oldPassword: oldPass)
            
            let viewModel = ChangePassViewModel()
            viewModel.changePassword(request: request) { errorMsg in
                   XCTAssertNotNil(errorMsg)
                    XCTAssertEqual(errorMsg, LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_pass", comment: ""))
                    expectation.fulfill()
                    
                }
                
                wait(for: [expectation], timeout: 20)
                
            }
            
    }
