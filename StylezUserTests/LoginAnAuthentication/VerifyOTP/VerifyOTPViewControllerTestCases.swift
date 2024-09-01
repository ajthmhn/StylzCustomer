//
//  VerifyOTPViewControllerTestCases.swift
//  StylezUserTests
//
//  Created by MACBOOK on 2/19/24.
//

import XCTest
import StylesWebKit

@testable import StylezUser

final class VerifyOTPViewControllerTestCases: XCTestCase {
    
    
    //Decomposed code
    //27631
    
    //MARK: - email verification
    func test_verifyLoginOtp2_withValidOTP_ReturnAPIResponse(){
        
        let deviceToken = ""
        let userID = 204
        let isEmail = true
        let otp = "20358"
        
        let request = verifyLoginOTPRequest(deviceToken: deviceToken, otp: otp, id: userID, isEmail: isEmail)
        
        let validation = VerifyLoginOTPValidation()
        let validationResult = validation.validate(request: request)
        
        let expectation = XCTestExpectation(description: "VerifyNumber")
        
        if validationResult.success{
            let resource = VerifyLoginOTPResource()
            resource.verifyLoginOtp(request: request) { errorMsg in
                DispatchQueue.main.async {
                    if errorMsg == nil{
                        expectation.fulfill()
                      }
                    else{
                        XCTFail("task should succeed but failed with error: \(errorMsg)")
                    }
                }
            }
        }
        else{
            XCTFail("task should fail with API error")
        }
        wait(for: [expectation], timeout: 20.0)
    }
  
    
    func test_verifyLoginOtp2_withInvalidOTP_ReturnAPIError(){
        
        let deviceToken = ""
        let userID = 204
        let isEmail = false
        let otp = "23345"
        
        let request = verifyLoginOTPRequest(deviceToken: deviceToken, otp: otp, id: userID, isEmail: isEmail)
        
        let validation = VerifyLoginOTPValidation()
        let validationResult = validation.validate(request: request)
        
        let expectation = XCTestExpectation(description: "VerifyNumber")
        
        if validationResult.success{
            let resource = VerifyLoginOTPResource()
            resource.verifyLoginOtp(request: request) { errorMsg in
                DispatchQueue.main.async {
                    if errorMsg == nil{
                        XCTFail("task should fail but succeeded with invalid otp")
                    }
                    else{
                        XCTAssertEqual(errorMsg,"User not matching", "task should fail with invalid credentials error")
                      expectation.fulfill()
                    }
                }
            }
        }
        else{
            XCTFail("task should fail with API error")
        }
        wait(for: [expectation], timeout: 20.0)
    }
  
    func test_verifyLoginOtp2_withEmptyOTP_ReturnAPIResponse(){
        
        let deviceToken = ""
        let userID = 204
        let isEmail = false
        let otp = ""
        
        let request = verifyLoginOTPRequest(deviceToken: deviceToken, otp: otp, id: userID, isEmail: isEmail)
        
        let validation = VerifyLoginOTPValidation()
        let validationResult = validation.validate(request: request)
        
        let expectation = XCTestExpectation(description: "VerifyNumber")
        
        if validationResult.success{
            let resource = VerifyLoginOTPResource()
            resource.verifyLoginOtp(request: request) { errorMsg in
                DispatchQueue.main.async {
                    if errorMsg == nil{
                        //    self.saveDetailsAndmoveToRootView()
                   //     expectation.fulfill()
                        XCTFail("task should fail but succeeded with invalid otp")
                }
                    else{
                        XCTFail("task should succeed but failed with error: \(errorMsg ?? "something went wrong")") }
                }
            }
        }
        else{
            XCTAssertEqual(validationResult.errorMessage,"InValid Details, please try again..", "task should fail with invalid credentials error")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20.0)
    }
    
    
    //MARK: - resend otp on email
   func test_resendLoginOtp2_withregisteredEmail_ReturnsAPIResponse(){
        //let phone = self.mobile
        let email = "ali@gmail.com"
        let id = 204
        
        let request = VerifyOTPRequest(phone: email, email: email, id: id, isEmail: true)
        let validation = OTPValidation()
        let validationResult = validation.validate(request: request)
        let expectation = XCTestExpectation(description: "resendOTPEmail")
        
        if validationResult.success{
            let resource = VerifyOTPResource()
            resource.sendOtpLogin(request: request) { result, otp, errorMsg  in
                DispatchQueue.main.async {
                    //print("got verify otp response")
                    if errorMsg == nil && otp != nil{
                        expectation.fulfill()
                        }
                    else{
                        XCTFail("task should succeeded, but failed with error:\(errorMsg)")
                    }
                }
            }
        }
        else{
            XCTFail("task should fail with error \(validationResult.errorMessage)")
         }
        
        wait(for: [expectation], timeout: 20.0)
    }
  
    func test_resendLoginOtp2_withUnregisteredEmail_ReturnsAPIError(){
        //let phone = self.mobile
        let email = "ali12242@gmail.com"
        let id = 234
        
        let request = VerifyOTPRequest(phone: email, email: email, id: id, isEmail: true)
        let validation = OTPValidation()
        let validationResult = validation.validate(request: request)
        let expectation = XCTestExpectation(description: "resendOTPEmail")
        
        if validationResult.success{
            let resource = VerifyOTPResource()
            resource.sendOtpLogin(request: request) { result, otp, errorMsg  in
                DispatchQueue.main.async {
                    //print("got verify otp response")
                    if errorMsg == nil && otp != nil{
                        XCTFail("task should fail, but succeeded")
                        }
                    else{
                        XCTAssertEqual(errorMsg,"This credential is not registered with us.", "task should fail with invalid credentials error")
                        
                        expectation.fulfill()
                    }
                }
            }
        }
        else{
            XCTFail("task should fail with error \(validationResult.errorMessage)")
         }
        
        wait(for: [expectation], timeout: 20.0)
    }
  
    func test_resendLoginOtp2_withInvalidEmail_ReturnsError(){
        //let phone = self.mobile
        let email = "ssarakskk"
        let id = 234
        
        let request = VerifyOTPRequest(phone: email, email: email, id: id, isEmail: true)
        let validation = OTPValidation()
        let validationResult = validation.validate(request: request)
        let expectation = XCTestExpectation(description: "resendOTPEmail")
        
        if validationResult.success{
            let resource = VerifyOTPResource()
            resource.sendOtpLogin(request: request) { result, otp, errorMsg  in
                DispatchQueue.main.async {
                    //print("got verify otp response")
                    if errorMsg == nil && otp != nil{
                        XCTFail("task should fail, but succeeded")
                        }
                    else{
                        XCTFail("task should fail with error \(errorMsg)")
                    }
                }
            }
        }
        else{
            XCTAssertEqual(validationResult.errorMessage,LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_valid", comment: ""), "task should fail with invalid credentials error")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 20.0)
    }
  
    func test_resendLoginOtp2_withEmptyEmail_ReturnsError(){
        //let phone = self.mobile
        let email = ""
        let id = 0
        
        let request = VerifyOTPRequest(phone: email, email: email, id: id, isEmail: true)
        let validation = OTPValidation()
        let validationResult = validation.validate(request: request)
        let expectation = XCTestExpectation(description: "resendOTPEmail")
        
        if validationResult.success{
            let resource = VerifyOTPResource()
            resource.sendOtpLogin(request: request) { result, otp, errorMsg  in
                DispatchQueue.main.async {
                    //print("got verify otp response")
                    if errorMsg == nil && otp != nil{
                        XCTFail("task should fail, but succeeded")
                        }
                    else{
                        XCTFail("task should fail with error \(errorMsg)")
                    }
                }
            }
        }
        else{
            XCTAssertEqual(validationResult.errorMessage,"Invalid details, please try again...", "task should fail with invalid credentials error")
            
            expectation.fulfill()
       
        }
        
        wait(for: [expectation], timeout: 20.0)
    }
  
    
    
    //MARK: - resend otp on number
    
    func test_resendOtp2_WithValidNumber_ReturnAPIResponse(){
         let phone = "987654321"
         
         let request = LoginRequestWithNumber(number: phone)
         let validation = LoginValidation()
         let validationResult = validation.validateNumber(request: request)
         
         let expectation = XCTestExpectation(description: "resendOTPNum")
      
         if validationResult.success{
             let resource = LoginResourceNumber()
             resource.authenticateUserWithNumber(request: request) { result, errorMsg in
                 DispatchQueue.main.async {
                     if errorMsg != nil{
                         XCTFail("task should fail with error \(errorMsg)")
                    }
                     else{
                      //print("\(result?.data.otp ?? 0)")
                         expectation.fulfill()
                     }
                 }
             }
         }
         else{
             XCTFail("task should succeded but failed with error: \(validationResult.errorMessage)")
     }
         wait(for: [expectation], timeout: 20.0)
     }
  
    func test_resendOtp2_WithUnregisteredNumber_ReturnAPIError(){
         let phone = "98765422"
         
         let request = LoginRequestWithNumber(number: phone)
         let validation = LoginValidation()
         let validationResult = validation.validateNumber(request: request)
         
         let expectation = XCTestExpectation(description: "resendOTPNum")
      
         if validationResult.success{
             let resource = LoginResourceNumber()
             resource.authenticateUserWithNumber(request: request) { result, errorMsg in
                DispatchQueue.main.async {
                     if errorMsg != nil{
                         XCTAssertEqual(errorMsg, "This credential is not registered with us.", "task should fail with invalid credentials error")
                         expectation.fulfill()
                    }
                     else{
                      //   self.otp = "\(result?.data.otp ?? 0)"
                         XCTFail("task should fail but succeded with invalid number")
                      }
                 }
             }
         }
         else{
             XCTFail("task should succeeded but failed with error: \(validationResult.errorMessage)")
        }
         wait(for: [expectation], timeout: 20.0)
   }
   
    
   func test_resendOtp2_WithEmptyNumber_ReturnError(){
        let phone = ""
        
        let request = LoginRequestWithNumber(number: phone)
        let validation = LoginValidation()
        let validationResult = validation.validateNumber(request: request)
        
        let expectation = XCTestExpectation(description: "resendOTPNum")
     
        if validationResult.success{
            let resource = LoginResourceNumber()
            resource.authenticateUserWithNumber(request: request) { result, errorMsg in
                DispatchQueue.main.async {
                    if errorMsg != nil{
                        XCTFail("task should fail with error \(errorMsg)")
                   }
                    else{
                     //   self.otp = "\(result?.data.otp ?? 0)"
                        XCTFail("task should fail but succeded with invalid number")
                     }
                }
            }
        }
        else{
            XCTAssertEqual(validationResult.errorMessage, LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_phone", comment: ""), "task should fail with invalid credentials error")
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20.0)
  
    }
    
  //Time expired! Please try again.
    //MARK: - number verification
    func test_verifyOtp2_WithValidOTP_ReturnsAPIError(){
        let deviceToken = ""
        let userID = 204
      //  let isEmail = false
        let otp = "60726"
        
        let request = VerifyOTPForPhoneRequest(otp: otp, id: userID, device: deviceToken)
        let validation = OTPForPhoneValidation()
        let validationResult = validation.validate(request: request)
        
        let expectation = XCTestExpectation(description: "VerifyEmail")
     
        if validationResult.success{
            let resource = VerifyOTPForPhoneResource()
            resource.verifyOTP(request: request) { errorMsg in
                DispatchQueue.main.async {
                    if errorMsg != nil{
                        XCTFail("task should succeeded but failed with api error: \(errorMsg)")
                        }
                    else{
                        expectation.fulfill()
                     }
                }
            }
        }
        else{
            //InValid Details, please try again..
            XCTFail("task should fail with invalid data error: \(validationResult.errorMessage)")
            }
        wait(for: [expectation], timeout: 20.0)
  }
   
    
    func test_verifyOtp2_WithInvalidOTP_ReturnsAPIError(){
        let deviceToken = ""
        let userID = 204
      //  let isEmail = false
        let otp = "234556"
        
        let request = VerifyOTPForPhoneRequest(otp: otp, id: userID, device: deviceToken)
        let validation = OTPForPhoneValidation()
        let validationResult = validation.validate(request: request)
        
        let expectation = XCTestExpectation(description: "VerifyEmail")
     
        if validationResult.success{
            let resource = VerifyOTPForPhoneResource()
            resource.verifyOTP(request: request) { errorMsg in
                DispatchQueue.main.async {
                    if errorMsg != nil{
                        expectation.fulfill()
                     }
                    else{
                        XCTFail("task should fail but succeded with invalid otp")
                   }
                }
            }
        }
        else{
            //InValid Details, please try again..
            XCTFail("task should fail with invalid data error:\(validationResult.errorMessage)")
            
            }
        wait(for: [expectation], timeout: 20.0)
  }

    func test_verifyOtp2_WithInvalidData_ReturnsError(){
        let deviceToken = ""
        let userID = 204
      //  let isEmail = false
        let otp = ""
        
        let request = VerifyOTPForPhoneRequest(otp: otp, id: userID, device: deviceToken)
        let validation = OTPForPhoneValidation()
        let validationResult = validation.validate(request: request)
        
        let expectation = XCTestExpectation(description: "VerifyEmail")
     
        if validationResult.success{
            let resource = VerifyOTPForPhoneResource()
            resource.verifyOTP(request: request) { errorMsg in
                DispatchQueue.main.async {
                    if errorMsg != nil{
                        XCTFail("task should succeed but failed with error: \(errorMsg ?? "something went wrong")")
                       }
                    else{
                        XCTFail("task should fail but succeded with invalid data")
                   }
                }
            }
        }
        else{
            //InValid Details, please try again..
            XCTAssertEqual(validationResult.errorMessage, "InValid Details, please try again..", "Login should fail with invalid credentials error")
            
            expectation.fulfill()
            }
        wait(for: [expectation], timeout: 20.0)
  }

    
  //MARK: - old code unit tests
    //Email field is required
    //User not matching
    
    
    //    func test_verifyOtp_WithInValidData_ReturnsError(){
    //        var  details = [String:Any]()
    //        details["otp"] = 36782 //36783
    //        details["user_id"] = 189 // registered user 189
    //        details["fcm_id"] = ""
    //
    //        let expectation = XCTestExpectation(description: "VerifyOtpAPi")
    //
    //        StylzAPIFacade.shared.verifyOtp(profDet: details) { (aRes) in
    //
    //            //print(aRes?.json)
    //            if aRes?.statusCode == 200{
    //                if aRes?.json?["status"].stringValue == "true"{
    //                    //move to root vc
    //                    XCTFail("task should succeed but failed with error")
    //                 //   XCTAssertEqual(aRes?.json?["message"].stringValue, "Success", "should succeed with valid otp")
    //                  //  expectation.fulfill()
    //
    //                }
    //                else{
    //                    if let error = aRes?.json?["error"].array{
    //                        if error.count > 0{
    //                            XCTAssertEqual(error[0].stringValue, "Email field is required ", "Login should fail with invalid credentials error")
    //                            expectation.fulfill()
    //                        }else{
    //                            XCTAssertEqual(aRes?.json?["error"].stringValue, "Email field is required ", "Login should fail with invalid credentials error")
    //                            expectation.fulfill()
    //
    //                        }
    //                    }
    //                    else{
    //                        XCTAssertEqual(aRes?.json?["error"].stringValue, "User not matching", "Login should fail with invalid credentials error")
    //                        expectation.fulfill()
    //                    }
    //                }
    //            }else{
    //                if let error = aRes?.json?["error"].array{
    //                    if error.count > 0{
    //                        XCTAssertEqual(error[0].stringValue, "Email field is required ", "Login should fail with invalid credentials error")
    //                        expectation.fulfill()
    //                     }else{
    //                         XCTAssertEqual(aRes?.json?["error"].stringValue, "Email field is required ", "Login should fail with invalid credentials error")
    //                           expectation.fulfill()
    //                     }
    //                }else{
    //                    XCTAssertEqual(aRes?.json?["error"].stringValue, "Email field is required ", "Login should fail with invalid credentials error")
    //                    expectation.fulfill()
    //                }
    //            }
    //        }
    //        wait(for: [expectation], timeout: 20.0)
    //    }
    //
    //
    //
    //    func test_verifyOtp_WithTimeExpired_ReturnsError(){
    //        var  details = [String:Any]()
    //        details["otp"] = 36783
    //        details["user_id"] = 189 // registered user 189
    //        details["fcm_id"] = ""
    //
    //        let expectation = XCTestExpectation(description: "VerifyOtpAPi")
    //
    //        StylzAPIFacade.shared.verifyOtp(profDet: details) { (aRes) in
    //
    //            //print(aRes?.json)
    //            if aRes?.statusCode == 200{
    //                if aRes?.json?["status"].stringValue == "true"{
    //                    //move to root vc
    //                    XCTFail("task should succeed but failed with error")
    //                  //  XCTAssertEqual(aRes?.json?["message"].stringValue, "Success", "should succeed with valid otp")
    //                   // expectation.fulfill()
    //
    //                }
    //                else{
    //                    if let error = aRes?.json?["error"].array{
    //                        if error.count > 0{
    //                            XCTAssertEqual(error[0].stringValue, "Email field is required ", "Login should fail with invalid credentials error")
    //                            expectation.fulfill()
    //                           }else{
    //                            XCTAssertEqual(aRes?.json?["error"].stringValue, "Email field is required ", "Login should fail with invalid credentials error")
    //                               expectation.fulfill()
    //
    //                        }
    //                    }else{
    //                     //   XCTAssertEqual(aRes?.json?["error"].stringValue, "User not matching", "Login should fail with invalid credentials error")
    //                        XCTAssertEqual(aRes?.json?["error"].stringValue, "Time expired! Please try again.", "Login should fail with invalid credentials error")
    //
    //                        //Time expired! Please try again
    //                        expectation.fulfill()
    //
    //                    }
    //                }
    //            }else{
    //                if let error = aRes?.json?["error"].array{
    //                    if error.count > 0{
    //                        //XCTFail("task should succeed but failed with error: \(error[0].stringValue)")
    //                       // XCTAssertEqual(aRes?.json?["error"].stringValue, "Email field is required ", "Login should fail with invalid credentials error")
    //                       expectation.fulfill()
    //                     }else{
    //                       // XCTFail("task should succeed but failed with error: \(aRes?.json?["error"].stringValue ?? "")")
    //                       //  XCTAssertEqual(aRes?.json?["error"].stringValue, "Email field is required ", "Login should fail with invalid credentials error")
    //                       expectation.fulfill()
    //                     }
    //                }else{
    //                    XCTAssertEqual(aRes?.json?["error"].stringValue, "Email field is required ", "Login should fail with invalid credentials error")
    //                    expectation.fulfill()
    //                 }
    //            }
    //        }
    //        wait(for: [expectation], timeout: 20.0)
    //    }
    //
    //    func test_verifyOtp_WithValidData_ReturnsAPIResponse(){
    //        var  details = [String:Any]()
    //        details["otp"] = 36783
    //        details["user_id"] = 189 // registered user 189
    //        details["fcm_id"] = ""
    //
    //        let expectation = XCTestExpectation(description: "VerifyOtpAPi")
    //
    //        StylzAPIFacade.shared.verifyOtp(profDet: details) { (aRes) in
    //
    //            if aRes?.statusCode == 200{
    //                if aRes?.json?["status"].stringValue == "true"{
    //                    //move to root vc
    //               //     XCTFail("task should succeed but failed with error")
    //                    XCTAssertEqual(aRes?.json?["message"].stringValue, "Success", "should succeed with valid otp")
    //                    expectation.fulfill()}
    //                else{
    //                    if let error = aRes?.json?["error"].array{
    //                        if error.count > 0{
    //                            XCTAssertEqual(error[0].stringValue, "Email field is required ", "Login should fail with invalid credentials error")
    //                           }else{
    //                            XCTAssertEqual(aRes?.json?["error"].stringValue, "Email field is required ", "Login should fail with invalid credentials error")}
    //                    }else{
    //                     //   XCTAssertEqual(aRes?.json?["error"].stringValue, "User not matching", "Login should fail with invalid credentials error")
    //                        XCTAssertEqual(aRes?.json?["error"].stringValue, "Time expired! Please try again.", "Login should fail with invalid credentials error")
    //
    //                        //Time expired! Please try again
    //                    //    expectation.fulfill()
    //
    //                    }
    //                }
    //            }else{
    //                if let error = aRes?.json?["error"].array{
    //                    if error.count > 0{
    //                        XCTFail("task should succeed but failed with error: \(error[0].stringValue)")
    //                    }else{
    //                        XCTFail("task should succeed but failed with error: \(aRes?.json?["error"].stringValue ?? "")")
    //                    }
    //                }else{
    //                    XCTAssertEqual(aRes?.json?["error"].stringValue, "Email field is required ", "Login should fail with invalid credentials error")
    //                 }
    //            }
    //        }
    //        wait(for: [expectation], timeout: 20.0)
    //    }
    
}
