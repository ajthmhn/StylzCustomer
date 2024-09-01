//
//  LoginUnitTestCases.swift
//  StylezUserTests
//
//  Created by MACBOOK on 2/15/24.
//

import XCTest
import StylesWebKit

@testable import StylezUser

final class LoginUnitTestCases: XCTestCase {
    
    //decomposed code unit tests
    
    //MARK: - login with email
    func test_loginUser2_UnregisteredUser_ReturnsAPIError(){
        let email = "sara123fg3@gmail.com"
        let pass = "1"
        let deviceToken = ""
        
        let expectation = XCTestExpectation(description: "Login2")
        
        let request = LoginRequestWithEmail(userEmail: email, userPassword: pass, deviceToken: deviceToken)
        
        let validation = LoginValidation()
        let validationResult = validation.validateEmail(request: request)
        
        if validationResult.success{
            
            let resource = LoginResourceEmail()
            resource.authenticateUserWithEmail(request: request) { result,otp, errorMsg  in
                DispatchQueue.main.async {
                    //get json
                    if  errorMsg != nil{
                        let userID = result?.data?.userID ?? 0
                        //print("hanlde login error \(errorMsg)")
                        //     XCTFail("Login should fail with api error \(errorMsg)")
                        expectation.fulfill()
                    }
                    else{
                        //print("error is nil")
                        if result?.data?.emailVerificationStatus == false, let userID = result?.data?.userID{
                            //print("verify email")
                        }
                        else{
                            //print("move to root")
                        }
                        
                        XCTAssertEqual(email, "sara@gmail.com", "Login should fail with invalid credentials error")
                    }
                }
            }
        }
        else{
            XCTFail("Login should fail with invalid credentials \(validationResult.errorMessage ?? "")")
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_loginUser2_withValidCredentials_ReturnsAPIResponse(){
        let email = "sara@gmail.com"
        let pass = "1"
        let deviceToken = ""
        
        let expectation = XCTestExpectation(description: "Login2")
        
        let request = LoginRequestWithEmail(userEmail: email, userPassword: pass, deviceToken: deviceToken)
        
        let validation = LoginValidation()
        let validationResult = validation.validateEmail(request: request)
        
        if validationResult.success{
            
            let resource = LoginResourceEmail()
            resource.authenticateUserWithEmail(request: request) { result,otp, errorMsg  in
                DispatchQueue.main.async {
                    //get json
                    if  errorMsg != nil{
                        let userID = result?.data?.userID ?? 0
                        XCTFail("Login should succeed but failed with error \(errorMsg)")
                    }
                    else{
                        if result?.data?.emailVerificationStatus == false, let userID = result?.data?.userID{
                            //print("verify email")
                        }
                        else{
                            //print("move to root")
                        }
                        
                        XCTAssertEqual(email, "sara@gmail.com", "Login should succeed")
                        expectation.fulfill()
                    }
                }
            }
        }
        else{
            XCTFail("Login should fail with invalid credentials error: \(validationResult.errorMessage ?? "")")
        }
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    func test_loginUser2_withEmptyEmail_returnError(){
        //ARRANGE
        
        let email = ""
        let pass = "ass"
        let deviceToken = ""
        
        let expectation = XCTestExpectation(description: "Login2")
        
        let request = LoginRequestWithEmail(userEmail: email, userPassword: pass, deviceToken: deviceToken)
        let validation = LoginValidation()
        let validationResult = validation.validateEmail(request: request)
        
        if validationResult.success{
            let resource = LoginResourceEmail()
            resource.authenticateUserWithEmail(request: request) { result,int, errorMsg in
                
                if let errorMsg{
                    XCTFail("Login should fail with invalid credentials error \(errorMsg)")
                }
                else{
                    //print(result)
                    XCTFail("Login should fail with invalid credentials error")
                }
            }
        }
        else{
            XCTAssertEqual(validationResult.errorMessage, LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_email", comment: ""), "Login should fail with invalid credentials error")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_loginUser2_withEmptyPassword_returnError(){
        //ARRANGE
        
        let email = "sss"
        let pass = ""
        let deviceToken = ""
        
        let expectation = XCTestExpectation(description: "Login2")
        
        let request = LoginRequestWithEmail(userEmail: email, userPassword: pass, deviceToken: deviceToken)
        let validation = LoginValidation()
        let validationResult = validation.validateEmail(request: request)
        
        if validationResult.success{
            let resource = LoginResourceEmail()
            resource.authenticateUserWithEmail(request: request) { result,int, errorMsg in
                
                if let errorMsg{
                    XCTFail("Login should fail with invalid credentials")
                }
                else{
                    XCTFail("Login should fail with invalid credentials")
                }
            }
        }
        else{
            XCTAssertEqual(validationResult.errorMessage, LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_passwrd", comment: ""), "Login should fail with invalid credentials")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    
    func test_loginUser2_withInValidEmail_returnError(){
        //ARRANGE
        
        let email = "sara@gmailcm"
        let pass = "1"
        let deviceToken = ""
        
        let expectation = XCTestExpectation(description: "Login2")
        
        let request = LoginRequestWithEmail(userEmail: email, userPassword: pass, deviceToken: deviceToken)
        let validation = LoginValidation()
        let validationResult = validation.validateEmail(request: request)
        
        if validationResult.success{
            let resource = LoginResourceEmail()
            resource.authenticateUserWithEmail(request: request) { result,int, errorMsg in
                
                if let errorMsg{
                    XCTFail("Login should fail with invalid credentials")
                }
                else{
                    //print("printing result")
                    //print(result)
                    XCTFail("Login should fail with invalid credentials")
                }
            }
        }
        else{
            XCTAssertEqual(validationResult.errorMessage,LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_valid", comment: ""), "Login should fail with invalid credentials")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    
    //    func test_loginUser2_withValidCredentials_returnAPIResponse(){
    //        //ARRANGE
    //
    //        let email = "sara@gmail.com"
    //        let pass = "1"
    //        let deviceToken = ""
    //
    //        let expectation = XCTestExpectation(description: "Login2")
    //
    //        let request = LoginRequest(userEmail: email, userPassword: pass, deviceToken: deviceToken)
    //        let validation = LoginValidation()
    //        let validationResult = validation.validate(request: request)
    //
    //        if validationResult.success{
    //            let resource = LoginResource()
    //          resource.authenticateUser(request: request) { result, errorMsg in
    //
    //                if let errorMsg{
    //                    XCTFail("Login should fail with invalid credentials")
    //               }
    //                else{
    //                    XCTAssertEqual(email, "sara@gmail.com", "Login should succeed with valid credentials error")
    //                    expectation.fulfill()
    //             }
    //            }
    //        }
    //        else{
    //           XCTFail("Login should fail with invalid credentials")
    //      }
    //        wait(for: [expectation], timeout: 10.0)
    //    }
    
    
    
    //MARK: - login With number
    
    
    func test_loginPhone_withValidDetails_ReturnsAPIResponse(){
        
        let number = "123456789"
        let request = LoginRequestWithNumber(number: number)
        
        let expectation = XCTestExpectation(description: "Login2")
        
        let viewModel = LoginViewModel()
        viewModel.loginPhone(request: request) { result, errorMsg in
            XCTAssertNil(errorMsg)
            XCTAssertNotNil(result?.data)
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_loginPhone_withUnregisteredNumber_ReturnsAPIError(){
        
        let number = "1246"
        let request = LoginRequestWithNumber(number: number)
        
        let expectation = XCTestExpectation(description: "Login2")
        
        let viewModel = LoginViewModel()
        viewModel.loginPhone(request: request) { result, errorMsg in
            XCTAssertNotNil(errorMsg)
            XCTAssertEqual(errorMsg,"This credential is not registered with us.")
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    func test_loginPhone_withEmptyNumber_ReturnsError(){
        
        let number = ""
        let request = LoginRequestWithNumber(number: number)
        
        let expectation = XCTestExpectation(description: "Login2")
        
        let viewModel = LoginViewModel()
        viewModel.loginPhone(request: request) { result, errorMsg in
            XCTAssertNotNil(errorMsg)
            XCTAssertEqual(errorMsg,LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_phone", comment: "") , "Login should succeed with valid credentials error")
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    
    
    //MARK: - decomposed verify otp
    
    func test_verifyOtpLogin_withValidDetails(){
        let phone = ""
        let email = "ali@gmail.com"
        let isEmail = true
        let id = 204
        let expectation = XCTestExpectation(description: "verifyOTp2")
        
        let request = VerifyOTPRequest(phone: phone, email: email, id: id, isEmail: isEmail)
        
        //print("request: \(request)")
        let validation = OTPValidation()
        let validationResult = validation.validate(request: request)
        
        if validationResult.success{
            let resource = VerifyOTPResource()
            resource.sendOtpLogin(request: request) { result, otp, errorMsg  in
                DispatchQueue.main.async {
                    //print("got verify otp response \(result)")
                    if errorMsg == nil && otp != nil{
                        //isEmail ? self.moveToVerifyOtp(otp: otp! , userId: result?.data.userID ?? 0, isphoneLogin: false, isEmail: true)
                        //  : self.moveToVerifyOtp(otp: otp! , userId: result?.data.userID ?? 0, isphoneLogin: true, isEmail: false)
                        
                        //print("move to verify otp view")
                        expectation.fulfill()
                    }
                    else{
                        XCTFail("Login should fail with invalid credentials \(otp) \(errorMsg ?? "")")
                    }
                }
            }
        }
        else{
            XCTFail("Login should fail with invalid credentials \(validationResult.errorMessage ?? "")")
        }
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    
    //Unexpected response data format or content
    
    //MARK: - old
    //    //MARK: - login with email
    
    
    //    func test_LoginApiResource_With_ValidRequest_Returns_LoginResponse(){
    //
    //        //ARRANGE
    //        var  details = [String:Any]()
    //        details["email"] = "sara@gmail.com"
    //        details["password"] = "1"
    //        details["user_type"] = 3
    //        details["fcm_id"] = ""
    //        let expectation = XCTestExpectation(description: "Login")
    //
    //        //ACT
    //        StylzAPIFacade.shared.login(profDet: details) { (aRes) in
    //
    //            if aRes?.statusCode == 200{
    //                //print("status 200")
    //                //print(aRes?.json)
    //                if aRes?.json?["status"].stringValue == "true"{
    //
    //                    XCTAssertNotNil(aRes, "Data shouls not be nil")
    //                    if let data = aRes?.json?["user_details"].dictionary{
    //                        let email = data["email"]?.stringValue
    //                        let name = data["first_name"]?.stringValue
    //
    //                        XCTAssertEqual(name, "Sara", "Login should succeed with valid credentials error")
    //
    //                        XCTAssertEqual(email, "sara@gmail.com", "Login should succeed with valid credentials error")
    //                    }
    //                    expectation.fulfill()
    //                }
    //                else{
    //                    //print("error 4")
    //                    XCTFail("Login should fail with invalid credentials")
    //                }
    //            }
    //            else{
    //                if let error = aRes?.json?["error"].array{
    //                    if error.count > 0{
    //                        //print("error 1")
    //                        XCTFail("Login should fail with SERVER ERROR")
    //                    }else{
    //                        //print("error 2")
    //                        XCTFail("Login should fail with SERVER ERROR")
    //                    }
    //                }else{
    //                    //print("error 3")
    //                    XCTFail("Login should fail with SERVER ERROR")
    //                }
    //            }
    //        }
    //        // Wait for the expectation to be fulfilled
    //        wait(for: [expectation], timeout: 10.0)
    //    }
    //
    //
    //    func test_LoginApiResource_With_InValidEmail_Returns_Error(){
    //
    //        //ARRANGE
    //        var  details = [String:Any]()
    //        details["email"] = "sara@gmailcom"
    //        details["password"] = "1"
    //        details["user_type"] = 3
    //        details["fcm_id"] = ""
    //        let expectation = XCTestExpectation(description: "Login")
    //
    //        //ACT
    //        StylzAPIFacade.shared.login(profDet: details) { (aRes) in
    //
    //            if aRes?.statusCode == 200{
    //                //print("status 200")
    //
    //                if aRes?.json?["status"].stringValue == "true"{
    //                    XCTFail("Login should fail with invalid credentials")
    //                }
    //                else{
    //                    //print("error 4")
    //                    XCTAssertEqual(aRes?.json?["error"].stringValue, "Invalid Email or Password.", "Login should fail with invalid credentials error")
    //                    expectation.fulfill()
    //                }
    //            }
    //            else{
    //                if let error = aRes?.json?["error"].array{
    //                    if error.count > 0{
    //                        //print("error 1")
    //                        XCTFail("Login should fail with SERVER ERROR")
    //                    }else{
    //                        //print("error 2")
    //                        XCTFail("Login should fail with SERVER ERROR")
    //                    }
    //                }else{
    //                    //print("error 3")
    //                    XCTFail("Login should fail with SERVER ERROR")
    //                }
    //            }
    //        }
    //        // Wait for the expectation to be fulfilled
    //        wait(for: [expectation], timeout: 10.0)
    //
    //    }
    //
    //    func test_LoginApiResource_With_INValidRequest_Returns_Error(){
    //
    //        //ARRANGE
    //        var  details = [String:Any]()
    //        details["email"] = "sara@gmail.com"
    //        details["password"] = "12344"
    //        details["user_type"] = 3
    //        details["fcm_id"] = ""
    //
    //        let expectation = XCTestExpectation(description: "Login")
    //
    //        //ACT
    //        StylzAPIFacade.shared.login(profDet: details) { (aRes) in
    //
    //            if aRes?.statusCode == 200{
    //                //print("status 200")
    //
    //                XCTAssertNotNil(aRes)
    //                if aRes?.json?["status"].stringValue == "true"{
    //                    XCTFail("Login should fail with InVALID credentials")
    //                }
    //                else{
    //                    //print("error 4")
    //                    XCTAssertEqual(aRes?.json?["error"].stringValue, "Invalid Email or Password.", "Login should fail with invalid credentials error")
    //                    expectation.fulfill()
    //                }
    //            }
    //            else{
    //                if let error = aRes?.json?["error"].array{
    //                    if error.count > 0{
    //                        //print("error 1")
    //                        XCTFail("Login should fail with SERVER ERROR")
    //                    }else{
    //                        //print("error 2")
    //                        XCTFail("Login should fail with SERVER ERROR")
    //                    }
    //                }else{
    //                    //print("error 3")
    //                    XCTFail("Login should fail with SERVER ERROR")
    //                }
    //            }
    //        }
    //        // Wait for the expectation to be fulfilled
    //        wait(for: [expectation], timeout: 10.0)
    //    }
    //
    //
    //
    //    //MARK: - check login with phone num api
    //
    //    // This credential is not registered with us.
    //    //This phone field is required
    //    func test_LoginApiResource_With_EmptyPhoneNumberString_Returns_Error(){
    //
    //        var  details = [String:Any]()
    //        details["phone"] = ""
    //
    //        let expectation = XCTestExpectation(description: "Login")
    //
    //        StylzAPIFacade.shared.loginPhone(profDet: details) { (aRes) in
    //
    //            if aRes?.statusCode == 200{
    //                if aRes?.json?["status"].stringValue == "true"{
    //                    XCTFail("Login should fail with invalid num")
    //                }
    //                else{
    //                    if let error = aRes?.json?["error"].array{
    //                        if error.count > 0{
    //                            XCTAssertEqual(error[0].stringValue, "This phone field is required", "Login failed with empty num1")
    //                            expectation.fulfill()
    //                        }
    //                        else{
    //                            XCTAssertEqual(aRes?.json?["error"].stringValue, "This phone field is required", "Login failed with empty num2")
    //                            expectation.fulfill()
    //                        }
    //                    }else{
    //                        if let error = aRes?.json?["error"].dictionary{
    //                            XCTAssertEqual(error["phone"]?.stringValue, "This phone field is required", "Login failed with empty num3")
    //                            expectation.fulfill()
    //                        }
    //                    }
    //                }
    //            }
    //            else{
    //                if let error = aRes?.json?["error"].array{
    //                    if error.count > 0{
    //                        XCTFail("Login should fail with SERVER ERROR")
    //                        expectation.fulfill()
    //                      }else{
    //                        XCTFail("Login should fail with SERVER ERROR")
    //                          expectation.fulfill()
    //                      }
    //                }else{
    //                    XCTFail("Login should fail with SERVER ERROR")
    //                    expectation.fulfill()
    //                }
    //            }
    //        }
    //
    //        wait(for: [expectation], timeout: 10.0)
    //
    //    }
    //
    //
    //    func test_LoginApiResource_With_NotRegisteredPhoneNumber_Returns_Error(){
    //
    //        var  details = [String:Any]()
    //        details["phone"] = "123456"
    //
    //        let expectation = XCTestExpectation(description: "Login")
    //
    //        StylzAPIFacade.shared.loginPhone(profDet: details) { (aRes) in
    //
    //            if aRes?.statusCode == 200{
    //                if aRes?.json?["status"].stringValue == "true"{
    //                    XCTFail("Login should fail, but succeed")
    //                }
    //                else{
    //                    if let error = aRes?.json?["error"].array{
    //                        if error.count > 0{
    //                            XCTAssertEqual(error[0].stringValue, "This credential is not registered with us.", "Login failed with invalid num1")
    //                            expectation.fulfill()
    //                        }
    //                        else{
    //                            XCTAssertEqual(aRes?.json?["error"].stringValue, "This credential is not registered with us.", "Login failed with invalid num2")
    //                            expectation.fulfill()
    //                        }
    //                    }else{
    //                        if let error = aRes?.json?["error"].dictionary{
    //                            XCTAssertEqual(error["phone"]?.stringValue, "This credential is not registered with us.", "Login failed with invalid num3")
    //                            expectation.fulfill()
    //                        }
    //                    }
    //                }
    //            }
    //            else{
    //                if let error = aRes?.json?["error"].array{
    //                    if error.count > 0{
    //                        XCTFail("Login should fail with SERVER ERROR")
    //                    }else{
    //                        XCTFail("Login should fail with SERVER ERROR")
    //                    }
    //                }else{
    //                    XCTFail("Login should fail with SERVER ERROR")
    //                }
    //            }
    //        }
    //
    //        wait(for: [expectation], timeout: 10.0)
    //    }
    //
    //
    //
    //    func test_LoginApiResource_With_RegisteredPhoneNumber_Returns_APIResponse(){
    //
    //        var  details = [String:Any]()
    //        details["phone"] = "123456789"
    //
    //        let expectation = XCTestExpectation(description: "Login")
    //
    //        StylzAPIFacade.shared.loginPhone(profDet: details) { (aRes) in
    //            //print(aRes?.json)
    //            if aRes?.statusCode == 200{
    //                if aRes?.json?["status"].stringValue == "true"{
    //                    XCTAssertEqual(aRes?.json?["message"].stringValue, "Success", "Login should succeed with valid credentials")
    //
    //                    expectation.fulfill()
    //                }
    //                else{
    //                    if let error = aRes?.json?["error"].array{
    //                        if error.count > 0{
    //                            XCTFail("Login should succeed, but failed with error: \(error[0])")
    //                        }
    //                        else{
    //                            XCTFail("Login should succeed, but failed with error: \(error)")
    //                        }
    //                    }else{
    //                        if let error = aRes?.json?["error"].dictionary{
    //                            XCTFail("Login should succeed, but failed with error: \(error)")
    //                        }
    //                    }
    //                }
    //            }
    //            else{
    //                if let error = aRes?.json?["error"].array{
    //                    if error.count > 0{
    //                        XCTFail("Login should fail with SERVER ERROR")
    //                    }else{
    //                        XCTFail("Login should fail with SERVER ERROR")
    //                    }
    //                }else{
    //                    XCTFail("Login should fail with SERVER ERROR")
    //                }
    //            }
    //        }
    //
    //        wait(for: [expectation], timeout: 10.0)
    //
    //    }
    //
    //    //  //This credential is not registered with us.\"},\"error_ar\":{\"email\":\"البيانات المدخلة غير مسجلة مسبقا.\"}}"
    //
    //
    //    //MARK: otp login
    //
    //    func test_verifyOtpLogin_With_RegisteredEmail_Returns_APIResponse(){
    //
    //        var  details = [String:Any]()
    //        var isEmail = true
    //
    //        if isEmail == true{
    //            details["email"] = "sara@gmail.com"
    //        }else{
    //            details["phone"] = ""
    //        }
    //
    //        details["user_id"] = 189 //189
    //
    //        let expectation = XCTestExpectation(description: "verifyOtpLogin")
    //
    //        StylzAPIFacade.shared.sendOtpLogin(profDet: details) { (aRes) in
    //            //print(aRes?.json)
    //            if aRes?.statusCode == 200{
    //                if aRes?.json?["status"].stringValue == "true"{
    //                    if let data = aRes?.json?["data"].dictionary{
    //                        XCTAssertEqual(aRes?.json?["message"].stringValue, "Success", "Login should succeed with valid credentials")
    //
    //                        XCTAssertEqual(data["user_id"]?.intValue, 189,"Login should succeed with valid credentials")
    //                        XCTAssertNotNil(data["email_otp"]?.intValue)
    //                        expectation.fulfill()
    //                    }
    //                }
    //                else{
    //                    if let error = aRes?.json?["error"].array{
    //                        if error.count > 0{
    //                            XCTFail("Login should fail with SERVER ERROR: \(error[0].stringValue)")
    //                        }
    //                        else{
    //                            XCTFail("Login should fail with SERVER ERROR : \(aRes?.json?["error"].stringValue ?? "")")
    //                        }}
    //                    else{
    //                        if let error = aRes?.json?["error"].dictionary{
    //                            XCTFail("Login should fail with SERVER ERROR: \(error["phone"]?.stringValue ?? "")")
    //                        }
    //                    }
    //                }
    //            }
    //            else{
    //                if let error = aRes?.json?["error"].array{
    //                    if error.count > 0{
    //                        XCTFail("Login should fail with SERVER ERROR: \(error[0].stringValue)")
    //                    }else{
    //                        XCTFail("Login should fail with SERVER ERROR: \(aRes?.json?["error"].stringValue ?? "")")
    //                    }
    //                }
    //                else{
    //                    //its nt avserver error - give empty stringg error
    //
    //                    XCTFail("Login should fail with SERVER ERROR: \(aRes?.json?["error"].stringValue ?? "")")
    //                }
    //            }
    //        }
    //
    //        wait(for: [expectation], timeout: 10.0)
    //    }
    //
    //    func test_verifyOtpLogin_With_RegisteredPhoneNumber_Returns_APIResponse(){
    //
    //        var  details = [String:Any]()
    //        var isEmail = false
    //
    //        if isEmail == true{
    //            details["email"] = ""
    //        }else{
    //            details["phone"] = "123456789"
    //        }
    //
    //        details["user_id"] = 189 //189
    //
    //        let expectation = XCTestExpectation(description: "verifyOtpLogin")
    //
    //        StylzAPIFacade.shared.sendOtpLogin(profDet: details) { (aRes) in
    //            if aRes?.statusCode == 200{
    //                if aRes?.json?["status"].stringValue == "true"{
    //                    if let data = aRes?.json?["data"].dictionary{
    //
    //                        XCTAssertEqual(aRes?.json?["message"].stringValue, "Success", "Login should succeed with valid credentials")
    //                        XCTAssertEqual(data["user_id"]?.intValue, 189,"Login should succeed with valid credentials")
    //                        XCTAssertNotNil(data["email_otp"]?.intValue)
    //
    //                        expectation.fulfill()
    //                    }
    //                }
    //                else{
    //                    if let error = aRes?.json?["error"].array{
    //                        if error.count > 0{
    //                            XCTFail("Login should fail with SERVER ERROR: \(error[0].stringValue)")
    //                        }
    //                        else{
    //                            XCTFail("Login should fail with SERVER ERROR : \(aRes?.json?["error"].stringValue ?? "")")
    //                        }}
    //                    else{
    //                        if let error = aRes?.json?["error"].dictionary{
    //                            XCTFail("Login should fail with SERVER ERROR: \(error["phone"]?.stringValue ?? "")")
    //                        }
    //                    }
    //                }
    //            }
    //            else{
    //                if let error = aRes?.json?["error"].array{
    //                    if error.count > 0{
    //                        XCTFail("Login should fail with SERVER ERROR: \(error[0].stringValue)")
    //                    }else{
    //                        XCTFail("Login should fail with SERVER ERROR: \(aRes?.json?["error"].stringValue ?? "")")
    //                    }
    //                }
    //                else{
    //                    //its nt avserver error - give empty stringg error
    //                    XCTFail("Login should fail with SERVER ERROR: \(aRes?.json?["error"].stringValue ?? "")")
    //                }
    //            }
    //        }
    //
    //        wait(for: [expectation], timeout: 10.0)
    //    }
    //
    //    func test_verifyOtpLogin_With_UnRegisteredPhoneNumber_Returns_APIResponse(){
    //
    //        var  details = [String:Any]()
    //        var isEmail = false
    //
    //        if isEmail == true{
    //            details["email"] = ""
    //        }else{
    //            details["phone"] = "1234567"
    //        }
    //
    //        details["user_id"] = 189 //189
    //
    //        let expectation = XCTestExpectation(description: "verifyOtpLogin")
    //
    //        StylzAPIFacade.shared.sendOtpLogin(profDet: details) { (aRes) in
    //            if aRes?.statusCode == 200{
    //                if aRes?.json?["status"].stringValue == "true"{
    //                    if let data = aRes?.json?["data"].dictionary{
    //                        XCTFail("Login should fail with invalid credentials but succeeded")
    //
    //                    }
    //                }
    //                else{
    //                    if let error = aRes?.json?["error"].array{
    //                        if error.count > 0{
    //                            XCTFail("Login should fail with SERVER ERROR: \(error[0].stringValue)")
    //                        }
    //                        else{
    //                            XCTFail("Login should fail with SERVER ERROR : \(aRes?.json?["error"].stringValue ?? "")")
    //                        }}
    //                    else{
    //                        if let error = aRes?.json?["error"].dictionary{
    //
    //                            XCTAssertEqual(error["phone"]?.stringValue ,"This credential is not registered with us.", "Login should fail with invalid credentials")
    //
    //                            expectation.fulfill()
    //                        }
    //                    }
    //                }
    //            }
    //            else{
    //                if let error = aRes?.json?["error"].array{
    //                    if error.count > 0{
    //                        XCTFail("Login should fail with SERVER ERROR: \(error[0].stringValue)")
    //                    }else{
    //                        XCTFail("Login should fail with SERVER ERROR: \(aRes?.json?["error"].stringValue ?? "")")
    //                    }
    //                }
    //                else{
    //                    //its nt avserver error - give empty stringg error
    //                    XCTFail("Login should fail with SERVER ERROR: \(aRes?.json?["error"].stringValue ?? "")")
    //                }
    //            }
    //        }
    //        wait(for: [expectation], timeout: 10.0)
    //    }
    //
    //
    //    func test_verifyOtpLogin_With_UnRegisteredEmail_Returns_APIResponse(){
    //
    //        var  details = [String:Any]()
    //        var isEmail = true
    //
    //        if isEmail == true{
    //            details["email"] = "sara@gmail.cpm"
    //        }else{
    //            details["phone"] = ""
    //        }
    //
    //        details["user_id"] = 189 //189
    //
    //        let expectation = XCTestExpectation(description: "verifyOtpLogin")
    //
    //        StylzAPIFacade.shared.sendOtpLogin(profDet: details) { (aRes) in
    //            if aRes?.statusCode == 200{
    //                if aRes?.json?["status"].stringValue == "true"{
    //                    if let data = aRes?.json?["data"].dictionary{
    //                        XCTFail("Login should fail with invalid credentials but succeeded")
    //                    }
    //                }
    //                else{
    //                    if let error = aRes?.json?["error"].array{
    //                        if error.count > 0{
    //                            XCTFail("Login should fail with SERVER ERROR: \(error[0].stringValue)")
    //                        }
    //                        else{
    //                            XCTFail("Login should fail with SERVER ERROR : \(aRes?.json?["error"].stringValue ?? "")")
    //                        }}
    //                    else{
    //                        if let error = aRes?.json?["error"].dictionary{
    //
    //                            //XCTAssertEqual(error["phone"]?.stringValue ,"This credential is not registered with us.", "Login should fail with invalid credentials")
    //
    //                            // this email error is not handled in the code
    //                            XCTAssertEqual(error["email"]?.stringValue ,"This credential is not registered with us.", "Login should fail with invalid credentials")
    //
    //                            //                                "{\"status\":false,\"error\":{\"email\":\"This credential is not registered with us.\"},\"error_ar\":{\"email\":\"البيانات المدخلة غير مسجلة مسبقا.\"}}"
    //
    //                            expectation.fulfill()
    //                        }
    //                    }
    //                }
    //            }
    //            else{
    //                if let error = aRes?.json?["error"].array{
    //                    if error.count > 0{
    //                        XCTFail("Login should fail with SERVER ERROR: \(error[0].stringValue)")
    //                    }else{
    //                        XCTFail("Login should fail with SERVER ERROR: \(aRes?.json?["error"].stringValue ?? "")")
    //                    }
    //                }
    //                else{
    //                    //its nt avserver error - give empty stringg error
    //                    XCTFail("Login should fail with SERVER ERROR: \(aRes?.json?["error"].stringValue ?? "")")
    //                }
    //            }
    //        }
    //        wait(for: [expectation], timeout: 10.0)
    //    }
    //
    //
    //    //
    //    func test_loginUser(){
    //
    //        var  details = [String:Any]()
    //        details["email"] = "sara@gmail.com"
    //        details["password"] = "1"
    //        details["user_type"] = 3
    //        details["fcm_id"] = ""
    //
    //        let expectation = XCTestExpectation(description: "verifyOtpLogin")
    //
    //        StylzAPIFacade.shared.login(profDet: details) { (aRes) in
    //
    //            if aRes?.statusCode == 200{
    //                if aRes?.json?["status"].stringValue == "true"{
    //                    if let data = aRes?.json?["data"].dictionary{
    //                        let emailVerified = data["email_verification_status"]?.boolValue
    //                        if emailVerified == false{
    //                            if  let userDetails = data["user_details"]?.dictionary{
    //                                let userID = data["user_id"]?.intValue
    //
    //                                //   //print(".~ verify otp ")
    //                                //   self.verifyOtpLogin(phone: "", email: self.txtEmail.text ?? "", id: userID ?? 0, isEmail: true)
    //
    //                                XCTAssertEqual(userDetails["email"]?.stringValue ,"sara@gmail.com", "Login should succeed with valid credentials")
    //
    //                                expectation.fulfill()
    //
    //                            }
    //                        }
    //                        else{
    //                            //  //print(".~ save user details, move to root vc")
    //
    //                            XCTAssertEqual(data["email"]?.stringValue ,"sara@gmail.com", "Login should succeed with valid credentials")
    //                            expectation.fulfill()
    //                        }
    //                    }
    //                }else{
    //                    if let error = aRes?.json?["error"].array{
    //                        if error.count > 0{
    //                            //   showAlert(title: "", subTitle:  error[0].stringValue , sender: self)
    //                            XCTFail("Login should fail with SERVER ERROR: \(error[0].stringValue)")
    //                        }else{
    //                            //    showAlert(title: "", subTitle:  aRes?.json?["error"].stringValue ?? "" , sender: self)
    //                            XCTFail("Login should fail with SERVER ERROR: \(aRes?.json?["error"].stringValue ?? "")")
    //                        }
    //                    }else{
    //                        let eror = aRes?.json?["error"].stringValue
    //                        if eror?.range(of:"verify your email address") != nil {
    //
    //                            // aRes?.json?["error"].stringValue
    //                            //      //print("show alert with error msg, then on click on ok button call account verify api.")
    //                            XCTFail("Login should fail with SERVER ERROR: \(aRes?.json?["error"].stringValue ?? "")")
    //                        }
    //                        else{
    //                            //Invalid Email or Password.
    //                            XCTFail("Login should fail with SERVER ERROR: \(aRes?.json?["error"].stringValue ?? "")")
    //                        }
    //                    }
    //                }
    //            }else{
    //                if let error = aRes?.json?["error"].array{
    //                    if error.count > 0{
    //                        //    showAlert(title: "", subTitle:  error[0].stringValue , sender: self)
    //                        XCTFail("Login should fail with SERVER ERROR: \(error[0].stringValue ?? "")")
    //                    }else{
    //                        //      showAlert(title: "", subTitle:  aRes?.json?["error"].stringValue ?? "" , sender: self)
    //                        XCTFail("Login should fail with SERVER ERROR: \(aRes?.json?["error"].stringValue ?? "")")
    //                    }
    //                }else{
    //                    //    showAlert(title: "", subTitle:  aRes?.json?["error"].stringValue ?? "" , sender: self)
    //                    XCTFail("Login should fail with SERVER ERROR: \(aRes?.json?["error"].stringValue ?? "")")
    //                }
    //            }
    //        }
    //
    //        wait(for: [expectation], timeout: 10.0)
    //
    //    }
    //
    //
    
}


//
