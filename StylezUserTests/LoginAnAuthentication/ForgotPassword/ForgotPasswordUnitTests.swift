//
//  ForgotPasswordUnitTests.swift
//  StylezUserTests
//
//  Created by MACBOOK on 2/19/24.
//

import XCTest
import StylesWebKit

@testable import StylezUser

final class ForgotPasswordUnitTests: XCTestCase {
    //The email address you entered seems to be incorrect. Please verify the email address and try again
    
//MARK: - testing forgot password api with number
    func test_MainForgotPasswordHandler_WithValidData_ReturnsAPIResponse(){
        
        let emailOrNum = "123456789"
        let isEmail = false
        
        let request = ForgotpasswordRequest(phone: emailOrNum, isEmail: isEmail)
        let expectation = XCTestExpectation(description: "forgotPass")
       
        let viewModel = ForgotPasswordViewModel()
        viewModel.forgotPassword(request: request) { id, otp, errorMsg in
            
            DispatchQueue.main.async {
                if errorMsg == nil && otp != nil && id != nil{
                    XCTAssertNotNil(id)
                    XCTAssertNotNil(otp)
                    XCTAssertNil(errorMsg)
                  
                    //XCTAssertEqual(errorMsg, "The phone number you entered seems to be incorrect. Please verify the phone number and try again", "task should fail wtih error")
                    expectation.fulfill()
                }
                else{
                XCTFail("task should succeed, but failed with error: \(errorMsg)")
                }
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
        
    }
   
    func test_MainForgotPasswordHandler_WithInValidNumber_ReturnsAPIError(){
        
        let emailOrNum = "1236789"
        let isEmail = false
        
        let request = ForgotpasswordRequest(phone: emailOrNum, isEmail: isEmail)
        let expectation = XCTestExpectation(description: "forgotPass")
       
        let viewModel = ForgotPasswordViewModel()
        viewModel.forgotPassword(request: request) { id, otp, errorMsg in
            
            DispatchQueue.main.async {
                if errorMsg == nil && otp != nil && id != nil{
                    XCTAssertNotNil(id)
                    XCTAssertNotNil(otp)
                    XCTAssertNil(errorMsg)
                  
                    //XCTAssertEqual(errorMsg, "The phone number you entered seems to be incorrect. Please verify the phone number and try again", "task should fail wtih error")
                    expectation.fulfill()
                }
                else{
                    XCTAssertNil(id)
                    XCTAssertNil(otp)
                    XCTAssertNotNil(errorMsg)
                    XCTAssertEqual(errorMsg, "The phone number you entered seems to be incorrect. Please verify the phone number and try again", "task should fail wtih error")
                    expectation.fulfill()
             
                }
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
        
    }
   
    func test_MainForgotPasswordHandler_WithEmptyNumber_ReturnsError(){
        
        let emailOrNum = ""
        let isEmail = false
        
        let request = ForgotpasswordRequest(phone: emailOrNum, isEmail: isEmail)
        let expectation = XCTestExpectation(description: "forgotPass")
       
        let viewModel = ForgotPasswordViewModel()
        viewModel.forgotPassword(request: request) { id, otp, errorMsg in
            
            DispatchQueue.main.async {
                if errorMsg == nil && otp != nil && id != nil{
                    XCTAssertNotNil(id)
                    XCTAssertNotNil(otp)
                    XCTAssertNil(errorMsg)
                  
                    //XCTAssertEqual(errorMsg, "The phone number you entered seems to be incorrect. Please verify the phone number and try again", "task should fail wtih error")
                    expectation.fulfill()
                }
                else{
                    XCTAssertNil(id)
                    XCTAssertNil(otp)
                    XCTAssertNotNil(errorMsg)
                    XCTAssertEqual(errorMsg,LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_phone", comment: ""))
                    
                    expectation.fulfill()
                }
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
        
    }
  
    
  //MARK: - testing forgot password api with email
    
    
    func test_MainForgotPasswordHandler_WithValidEmail_ReturnsAPIResponse(){
        
        let emailOrNum = "sara@gmail.com"
        let isEmail = true
        
        let request = ForgotpasswordRequest(phone: emailOrNum, isEmail: isEmail)
        let expectation = XCTestExpectation(description: "forgotPass")
       
        let viewModel = ForgotPasswordViewModel()
        viewModel.forgotPassword(request: request) { id, otp, errorMsg in
            
            DispatchQueue.main.async {
                if errorMsg == nil && otp != nil && id != nil{
                    XCTAssertNotNil(id)
                    XCTAssertNotNil(otp)
                    XCTAssertNil(errorMsg)
                  
                    //XCTAssertEqual(errorMsg, "The phone number you entered seems to be incorrect. Please verify the phone number and try again", "task should fail wtih error")
                    expectation.fulfill()
                }
                else{
                XCTFail("task should succeed, but failed with error: \(errorMsg)")
                }
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
        
    }
   
    func test_MainForgotPasswordHandler_WithUnregisteredEmail_ReturnsAPIError(){
        
        let emailOrNum = "sara123@gmail.com"
        let isEmail = true
        
        let request = ForgotpasswordRequest(phone: emailOrNum, isEmail: isEmail)
        let expectation = XCTestExpectation(description: "forgotPass")
       
        let viewModel = ForgotPasswordViewModel()
        viewModel.forgotPassword(request: request) { id, otp, errorMsg in
            
            DispatchQueue.main.async {
                if errorMsg == nil && otp != nil && id != nil{
                    XCTAssertNotNil(id)
                    XCTAssertNotNil(otp)
                    XCTAssertNil(errorMsg)
                  
                    //XCTAssertEqual(errorMsg, "The phone number you entered seems to be incorrect. Please verify the phone number and try again", "task should fail wtih error")
                    expectation.fulfill()
                }
                else{
                    XCTAssertNil(id)
                    XCTAssertNil(otp)
                    XCTAssertNotNil(errorMsg)
                    XCTAssertEqual(errorMsg, "The email address you entered seems to be incorrect. Please verify the email address and try again")
                    expectation.fulfill()
             
                }
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
        
    }
   
    func test_MainForgotPasswordHandler_WithEmptyEmail_ReturnsError(){
        
        let emailOrNum = ""
        let isEmail = true
        
        let request = ForgotpasswordRequest(phone: emailOrNum, isEmail: isEmail)
        let expectation = XCTestExpectation(description: "forgotPass")
       
        let viewModel = ForgotPasswordViewModel()
        viewModel.forgotPassword(request: request) { id, otp, errorMsg in
            
            DispatchQueue.main.async {
                if errorMsg == nil && otp != nil && id != nil{
                    XCTAssertNotNil(id)
                    XCTAssertNotNil(otp)
                    XCTAssertNil(errorMsg)
                  
                    //XCTAssertEqual(errorMsg, "The phone number you entered seems to be incorrect. Please verify the phone number and try again", "task should fail wtih error")
                    expectation.fulfill()
                }
                else{
                    XCTAssertNil(id)
                    XCTAssertNil(otp)
                    XCTAssertNotNil(errorMsg)
                    XCTAssertEqual(errorMsg,LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_email", comment: ""))
                    
                    expectation.fulfill()
                }
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
        
    }
   
    func test_MainForgotPasswordHandler_WithInvalidEmail_ReturnsError(){
        
        let emailOrNum = "saraR.com"
        let isEmail = true
        
        let request = ForgotpasswordRequest(phone: emailOrNum, isEmail: isEmail)
        let expectation = XCTestExpectation(description: "forgotPass")
       
        let viewModel = ForgotPasswordViewModel()
        viewModel.forgotPassword(request: request) { id, otp, errorMsg in
            
            DispatchQueue.main.async {
                if errorMsg == nil && otp != nil && id != nil{
                    XCTAssertNotNil(id)
                    XCTAssertNotNil(otp)
                    XCTAssertNil(errorMsg)
                  
                    //XCTAssertEqual(errorMsg, "The phone number you entered seems to be incorrect. Please verify the phone number and try again", "task should fail wtih error")
                    expectation.fulfill()
                }
                else{
                    XCTAssertNil(id)
                    XCTAssertNil(otp)
                    XCTAssertNotNil(errorMsg)
                    XCTAssertEqual(errorMsg,LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_valid", comment: ""))
                    
                    expectation.fulfill()
                }
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
        
    }
  
    
    //MARK: - old
    
    //    func test_forgotPassword_withValidData_ReturnsAPIResponse(){
    //
    //        let isEmail = true
    //        var details = [String:Any]()
    //
    //        if isEmail == true{
    //            details["email"] = "sara@gmail.com"
    //        }else{
    //            details["phone"] = ""
    //        }
    //
    //        details["user_type"] = 3
    //
    //        let expectation = XCTestExpectation(description: "Forgot Password")
    //
    //        StylzAPIFacade.shared.forgotPassword(profDet: details) { (aRes) in
    //
    //            if aRes?.statusCode == 200{
    //                if aRes?.json?["status"].stringValue == "true"{
    //
    //                    if let data = aRes?.json?["data"].dictionary{
    //
    //                        //   {\"status\":true,\"message\":\"Success\",\"message_ar\":\"نجاح\",\"data\":{\"reset_code\":38952,\"user_id\":5}}"
    //
    //                        XCTAssertNotNil(aRes?.json?["reset_code"].intValue)
    //                        XCTAssertEqual(aRes?.json?["message"].stringValue, "Success", "should succeed with valid credentials")
    //
    //                        expectation.fulfill()
    //                    }
    //                }else{
    //                    if let error = aRes?.json?["error"].array{
    //                        if error.count > 0{
    //                            XCTFail("\(error[0].stringValue )")
    //                        }else{
    //                            XCTFail("\(aRes?.json?["error"].stringValue ?? "")")
    //                        }
    //                    }else{
    //                        if let error = aRes?.json?["error"].dictionary{
    //                            if isEmail == true{
    //                                XCTFail("\(error["email"]?.stringValue ?? "")")
    //                            }else{
    //                                XCTFail("\(error["phone"]?.stringValue ?? "")")
    //                            }
    //                        }
    //                    }
    //                }
    //            }else{
    //                if let error = aRes?.json?["error"].array{
    //                    if error.count > 0{
    //                        XCTFail("\(error[0].stringValue)")
    //                    }else{
    //                        XCTFail("\(aRes?.json?["error"].stringValue ?? "")")
    //                    }
    //                }else{
    //                    XCTFail("\(aRes?.json?["error"].stringValue ?? "")")
    //                }
    //            }
    //        }
    //        wait(for: [expectation], timeout: 20.0)
    //    }
    //
    //    //updatePAss
    //    func test_updatePassword_WithValidData(){
    //        var details = [String:Any]()
    //        details["reset_code"] = 46738
    //        details["user_id"] = 189
    //        details["password"] = "1"
    //
    //        let expectation = XCTestExpectation(description: "update pass")
    //
    //        StylzAPIFacade.shared.updatePassword(profDet: details) { (aRes) in
    //            if aRes?.statusCode == 200{
    //                if aRes?.json?["status"].stringValue == "true"{
    //
    //                    XCTAssertNotNil(aRes?.json?["reset_code"].intValue)
    //                    XCTAssertEqual(aRes?.json?["message"].stringValue, "Password updated successfully. Please login with new password to continue", "should succeed")
    //                    expectation.fulfill()
    //                }else{
    //                    if let error = aRes?.json?["error"].array{
    //                        if error.count > 0{
    //                            XCTFail("\(error[0].stringValue )")
    //                        }else{
    //                            XCTFail("\(aRes?.json?["error"].stringValue ?? "")")
    //                        }
    //                    }else{
    //                        if let error = aRes?.json?["error"].dictionary{
    //                            XCTFail("\(error["email"]?.stringValue ?? "")")
    //                        }
    //                    }
    //                }
    //            }else{
    //                if let error = aRes?.json?["error"].array{
    //                    if error.count > 0{
    //                        XCTFail("\(error[0].stringValue)")
    //                    }else{
    //                        XCTFail("\(aRes?.json?["error"].stringValue ?? "")")
    //                    }
    //                }else{
    //                    XCTFail("\(aRes?.json?["error"].stringValue ?? "")")
    //                }
    //            }
    //        }
    //        wait(for: [expectation], timeout: 30.0)
    //
    //    }
    //
    //    func test_updatePassword_WithInValidData(){
    //        var details = [String:Any]()
    //        details["reset_code"] = 46738
    //        details["user_id"] = 189
    //        details["password"] = 1
    //
    //        let expectation = XCTestExpectation(description: "update pass")
    //
    //        StylzAPIFacade.shared.updatePassword(profDet: details) { (aRes) in
    //            if aRes?.statusCode == 200{
    //                if aRes?.json?["status"].stringValue == "true"{
    //
    //                 //   XCTAssertNotNil(aRes?.json?["reset_code"].intValue)
    //                  //  XCTAssertEqual(aRes?.json?["message"].stringValue, "Password updated successfully. Please login with new password to continue", "should succeed")
    //
    //                   // expectation.fulfill()
    //
    //                    XCTFail("task should fail, but succeeded")
    //
    //                }else{
    //                    if let error = aRes?.json?["error"].array{
    //                        if error.count > 0{
    //                            XCTFail("\(error[0].stringValue )")
    //                            expectation.fulfill()
    //                          }else{
    //                           XCTFail("\(aRes?.json?["error"].stringValue ?? "")")
    //                            expectation.fulfill()
    //                        }
    //                    }
    //                    else{
    //                        if let error = aRes?.json?["error"].dictionary{
    //                            XCTFail("\(error["email"]?.stringValue ?? "")")
    //                            expectation.fulfill()
    //                        }
    //                        else{
    //                        //    XCTFail("\(aRes?.json?["error"].stringValue ?? "")")
    //                            XCTAssertEqual(aRes?.json?["error"].stringValue, "Time expired! Please try again.", "should succeed")
    //                          expectation.fulfill()
    //                       }
    //                    }
    //                }
    //            }else{
    //                if let error = aRes?.json?["error"].array{
    //                    if error.count > 0{
    //                        XCTFail("\(error[0].stringValue)")
    //                        expectation.fulfill()
    //                     }else{
    //                        XCTFail("\(aRes?.json?["error"].stringValue ?? "")")
    //                         expectation.fulfill()
    //                      }
    //                }else{
    //                    XCTFail("\(aRes?.json?["error"].stringValue ?? "")")
    //                    expectation.fulfill()
    //                }
    //            }
    //        }
    //        wait(for: [expectation], timeout: 10.0)
    //
    //    }
    
}
