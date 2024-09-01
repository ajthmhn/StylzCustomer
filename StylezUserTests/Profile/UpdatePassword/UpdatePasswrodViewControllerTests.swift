//
//  UpdatePasswrodViewControllerTests.swift
//  StylezUserTests
//
//  Created by MACBOOK on 2/26/24.
//

import XCTest

@testable import StylezUser

final class UpdatePasswrodViewControllerTests: XCTestCase {
    
    
    func test_updatePassword_WithEmptyPassword_ReturnsError(){
        
        let otp = "2234"
        let id = 0
        let password = "345"
        let confirmPass = ""
        
        let request = UpdatePasswordRequest(otp: otp, userID: id, password: password, retypedPass: confirmPass)
        
        let expectation = XCTestExpectation(description: "ChangePass")
        
        let viewModel = UpdatePassViewModel()
        viewModel.updatePassword(request: request) { errorMsg in
            DispatchQueue.main.async {
                if errorMsg != nil{
                    //alert
                    XCTAssertEqual(errorMsg, LocalizationSystem.sharedInstance.localizedStringForKey(key: "retype_pass", comment: ""), "should fail with empty Password error")
                 
                    expectation.fulfill()
                }
                else{
                    //moveToLoginView
                    XCTFail("should fail with error, but succeeded")
                }
            }
        }
        wait(for: [expectation], timeout: 10)
    }
   
    func test_updatePassword_WithEmptyRetypedPassword_ReturnsError(){
        
        let otp = "2234"
        let id = 0
        let password = "123"
        let confirmPass = ""
        
        let request = UpdatePasswordRequest(otp: otp, userID: id, password: password, retypedPass: confirmPass)
        
        let expectation = XCTestExpectation(description: "ChangePass")
        
        let viewModel = UpdatePassViewModel()
        viewModel.updatePassword(request: request) { errorMsg in
            DispatchQueue.main.async {
                if errorMsg != nil{
                    //alert
                    XCTAssertEqual(errorMsg, LocalizationSystem.sharedInstance.localizedStringForKey(key: "retype_pass", comment: ""), "should fail with empty Password error")
                 
                    expectation.fulfill()
                }
                else{
                    //moveToLoginView
                    XCTFail("should fail with error, but succeeded")
                }
            }
        }
        wait(for: [expectation], timeout: 10)
    }
   
    func test_updatePassword_WithMismatchedPassword_ReturnsError(){
        
        let otp = "2234"
        let id = 12
        let password = "123"
        let confirmPass = "2345"
        
        let request = UpdatePasswordRequest(otp: otp, userID: id, password: password, retypedPass: confirmPass)
        
        let expectation = XCTestExpectation(description: "ChangePass")
        
        let viewModel = UpdatePassViewModel()
        viewModel.updatePassword(request: request) { errorMsg in
            DispatchQueue.main.async {
                if errorMsg != nil{
                    //alert
                    XCTAssertEqual(errorMsg, LocalizationSystem.sharedInstance.localizedStringForKey(key: "password_missmatch", comment: ""))
                    expectation.fulfill()
                }
                else{
                    //moveToLoginView
                    XCTFail("should fail with error, but succeeded")
                }
            }
        }
        wait(for: [expectation], timeout: 10)
    }
   
    
    
    func test_updatePassword_WithInvalidOTPorID_ReturnsError(){
        
        let otp = ""
        let id = 34
        let password = "123"
        let confirmPass = "344"
        
        let request = UpdatePasswordRequest(otp: otp, userID: id, password: password, retypedPass: confirmPass)
        
        let expectation = XCTestExpectation(description: "ChangePass")
        
        let viewModel = UpdatePassViewModel()
        viewModel.updatePassword(request: request) { errorMsg in
            DispatchQueue.main.async {
                if errorMsg != nil{
                    //alert
                    XCTAssertEqual(errorMsg,
                                   "Invalid details, please try again...", "should fail with invalid details error")
                 
                    expectation.fulfill()
                }
                else{
                    //moveToLoginView
                    XCTFail("should fail with error, but succeeded")
                }
            }
        }
        wait(for: [expectation], timeout: 10)
    }
   
    func test_updatePassword_WithInValidOTP_ReturnsAPIError(){
        
        let otp = "7580"
        let id = 189
        let password = "3"
        let confirmPass = "3"
        
        let request = UpdatePasswordRequest(otp: otp, userID: id, password: password, retypedPass: confirmPass)
        
        let expectation = XCTestExpectation(description: "ChangePass")
        
        let viewModel = UpdatePassViewModel()
        viewModel.updatePassword(request: request) { err in
            DispatchQueue.main.async {
                if err != nil{
                    //alert
                 XCTAssertEqual(err, "User not matching")
                expectation.fulfill()
                }
                else{
                    //moveToLoginView
                    XCTFail("should fail with server error, but succeeded")
                  }
            }
        }
        wait(for: [expectation], timeout: 10)
    }
   
    
    func test_updatePassword_WithValidDetails_ReturnsAPIResponse(){
        
        let otp = "71580"
        let id = 189
        let password = "3"
        let confirmPass = "3"
        
        let request = UpdatePasswordRequest(otp: otp, userID: id, password: password, retypedPass: confirmPass)
        
        let expectation = XCTestExpectation(description: "ChangePass")
        
        let viewModel = UpdatePassViewModel()
        viewModel.updatePassword(request: request) { err in
            DispatchQueue.main.async {
                if err != nil{
                    //alert
                 
                    XCTFail("should succeed but failed with error: \(err)")
                }
                else{
                    //moveToLoginView
                    expectation.fulfill()
                }
            }
        }
        wait(for: [expectation], timeout: 10)
    }
   
    
//    func test_changePassword_emptyOldPass_ReturnsError(){
//        let oldPass =  ""
//        let newPass =  ""
//        let confirmPass =  ""
//        let request = ChangePasswordRequest(password: newPass, confirmPass: confirmPass, oldPassword: oldPass)
//      
//        let expectation = XCTestExpectation(description: "ChangePass")
//      
//        let viewModel = ChangePassViewModel()
//        
//        viewModel.changePassword(request: request) { errorMsg in
//            DispatchQueue.main.async {
//                if errorMsg != nil{
//               //alert
//                    XCTAssertEqual(errorMsg, "", "should fail with emptyOldPass error")
//                    expectation.fulfill()
//                }
//                else{
//                    //popback
//                 XCTFail("should fail with error, but succeeded")
//                }
//            }
//        }
//        wait(for: [expectation], timeout: 10)
//    }
//
//    
}
