//
//  RegisterUnitTestCases.swift
//  StylezUserTests
//
//  Created by MACBOOK on 2/18/24.
//

import XCTest
import StylesWebKit

@testable import StylezUser
final class RegisterUnitTestCases: XCTestCase {
    
    //Email field is required
    //Phone field is required
    //Email already exists. Please choose a different email.
    //Phone number already exists . Please choose a different phone.
   
    func test_registerUser_WithNoNationality_ReturnsAPIError(){
        let  password = "7"
        let email = "sara@gmail.com"
        let firstName = "sanam"
        let phone =  "123"
     
        let request = RegisterRequest(phone:phone , email: email , password:password , firstName: firstName, age: "", occupation: "", countryID:  -1, ispolicyAccepted: true  )
        
        let validation = RegisterValidations()
        let validationResult = validation.validate(request: request)
        
        let expectation = XCTestExpectation(description: "Register")
        
        if validationResult.success{
            let resource = RegistrationResource()
            resource.registerUser(request: request) { result, err in
                DispatchQueue.main.async {
                    if err != nil{
                       
                   }
                    else{
                        XCTFail("Login should fail, but succeeded with invalid data")
                    }
                }
            }
        }
        else{
            XCTAssertEqual(validationResult.errorMessage, LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_coutry", comment: "")
                           , "Login should fail with error")
            expectation.fulfill()
     
        }
        wait(for: [expectation], timeout: 20.0)
    }
  
    func test_registerUser_WithRegisteredUserEmail_ReturnsAPIError(){
        let  password = "7"
        let email = "sara@gmail.com"
        let firstName = "sanam"
        let phone =  "123"
     
        let request = RegisterRequest(phone:phone , email: email , password:password , firstName: firstName, age: "", occupation: "", countryID:  0, ispolicyAccepted: true  )
        
        let validation = RegisterValidations()
        let validationResult = validation.validate(request: request)
        
        let expectation = XCTestExpectation(description: "Register")
        
        if validationResult.success{
            let resource = RegistrationResource()
            resource.registerUser(request: request) { result, err in
                DispatchQueue.main.async {
                    if err != nil{
                    //    XCTFail("\(err ?? "")")
                        XCTAssertEqual(err, "Email already exists. Please choose a different email.", "Login should fail with empty name error")
                     
                        expectation.fulfill()
                   }
                    else{
                        XCTFail("Login should fail, but succeeded with invalid data")
                    }
                }
            }
        }
        else{
            XCTFail("Login should fail with server error")
       }
        wait(for: [expectation], timeout: 20.0)
    }
   
    
    func test_registerUser_WithEmptyPhone_ReturnsError(){
        let  password = "7"
        let email = "11612@gmail.com"
        let firstName = "sanam"
        let phone =  ""
     
        let request = RegisterRequest(phone:phone , email: email , password:password , firstName: firstName, age: "", occupation: "", countryID:  0, ispolicyAccepted: true )
        
        let validation = RegisterValidations()
        let validationResult = validation.validate(request: request)
        
        let expectation = XCTestExpectation(description: "Register")
        
        if validationResult.success{
            let resource = RegistrationResource()
            resource.registerUser(request: request) { result, err in
                DispatchQueue.main.async {
                    if err != nil{
                        XCTFail("\(err ?? "")")
                    }
                    else{
                        XCTFail("Login should fail, but succeeded with invalid data")
                    }
                }
            }
        }
        else{
            XCTAssertEqual(validationResult.errorMessage, LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_phone", comment: ""), "Login should fail with empty error")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20.0)
    }
   
    func test_registerUser_WithEmptyName_ReturnsError(){
        let  password = "tt"
        let email = "11612@gmail.com"
        let firstName = ""
        let phone =  "11612"
     
        let request = RegisterRequest(phone:phone , email: email , password:password , firstName: firstName, age: "", occupation: "", countryID:  0, ispolicyAccepted: true )
        
        let validation = RegisterValidations()
        let validationResult = validation.validate(request: request)
        
        let expectation = XCTestExpectation(description: "Register")
        
        if validationResult.success{
            let resource = RegistrationResource()
            resource.registerUser(request: request) { result, err in
                DispatchQueue.main.async {
                    if err != nil{
                        XCTFail("\(err ?? "")")
                    }
                    else{
                        XCTFail("Login should fail, but succeeded with invalid data")
                    }
                }
            }
        }
        else{
            XCTAssertEqual(validationResult.errorMessage, LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_name", comment: ""), "Login should fail with empty name error")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20.0)
    }
   
    
    func test_registerUser_WithEmptyPassword_ReturnsError(){
        let  password = ""
        let email = "11612@gmail.com"
        let firstName = "sanam"
        let phone =  "11612"
     
        let request = RegisterRequest(phone:phone , email: email , password:password , firstName: firstName, age: "", occupation: "", countryID:  0, ispolicyAccepted: true )
        
        let validation = RegisterValidations()
        let validationResult = validation.validate(request: request)
        
        let expectation = XCTestExpectation(description: "Register")
        
        if validationResult.success{
            let resource = RegistrationResource()
            resource.registerUser(request: request) { result, err in
                DispatchQueue.main.async {
                    if err != nil{
                        XCTFail("\(err ?? "")")
                    }
                    else{
                            XCTFail("Login should fail, but succeeded with invalid data")}
                }
            }
        }
        else{
            //enter_password
            //enter_email
            XCTAssertEqual(validationResult.errorMessage, LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_password", comment: ""), "Login should fail with no password error")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20.0)
    }
    
    
    func test_registerUser_WithEmptyEmail_ReturnsError(){
        let  password = "ss"
        let email = ""
        let firstName = "sanam"
        let phone =  "11612"
     
        let request = RegisterRequest(phone:phone , email: email , password:password , firstName: firstName, age: "", occupation: "", countryID:  0, ispolicyAccepted: true)
        
        let validation = RegisterValidations()
        let validationResult = validation.validate(request: request)
        
        let expectation = XCTestExpectation(description: "Register")
        
        if validationResult.success{
            let resource = RegistrationResource()
            resource.registerUser(request: request) { result, err in
                DispatchQueue.main.async {
                    if err != nil{
                        XCTFail("\(err ?? "")")
                    }
                    else{
                        XCTFail("Login should fail, but succeeded with invalid data")
                    }
                }
            }
        }
        else{
            XCTAssertEqual(validationResult.errorMessage, LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_email", comment: ""), "Login should fail with no email error")
          
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20.0)
    }
    
    
    func test_registerUser_WithInValidEmail_ReturnsError(){
        let  password = "ss"
        let email = "sara@hill"
        let firstName = "sanam"
        let phone =  "11612"
     
        let request = RegisterRequest(phone:phone , email: email , password:password , firstName: firstName, age: "", occupation: "", countryID:  0, ispolicyAccepted: true )
        
        let validation = RegisterValidations()
        let validationResult = validation.validate(request: request)
        
        let expectation = XCTestExpectation(description: "Register")
        
        if validationResult.success{
            let resource = RegistrationResource()
            resource.registerUser(request: request) { result, err in
                DispatchQueue.main.async {
                    if err != nil{
                        XCTFail("\(err ?? "")")
                    }
                    else{
                        XCTFail("Login should fail, but succeeded with invalid data") }
                }
            }
        }
        else{
            XCTAssertEqual(validationResult.errorMessage, LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_valid", comment: ""), "Login should fail with invalid email error")
          
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20.0)
    }
    
   
    
    func test_registerUser_WithValidCredentials_ReturnsAPIResponse(){
        let password = "1"
        let email = "ali@gmail.com"
        let firstName = "ali"
        let phone =  "987654321"
        
        let request = RegisterRequest(phone:phone , email: email , password:password , firstName: firstName, age: "", occupation: "", countryID:  1, ispolicyAccepted: true )
        let validation = RegisterValidations()
        let validationResult = validation.validate(request: request)
        
        let expectation = XCTestExpectation(description: "Register")
        
        if validationResult.success{
            let resource = RegistrationResource()
            resource.registerUser(request: request) { result, err in
                DispatchQueue.main.async {
                    if err != nil{
                       //print(err)
                       XCTAssertEqual(err, "", "Login should fail, with invalid data error")
                       XCTFail("\(err ?? "")")
                    }
                    else{
                        //   self.moveToOTPView(otp:"\(result?.phoneOtp ?? 0)", id: result?.userID ?? 0)
                        XCTAssertEqual(result?.message, "Registration completed successfully", "Login should succeed with valid credentials error")
                        expectation.fulfill()
                    }
                }
            }
        }
        else{
            XCTFail("\(validationResult.errorMessage ?? "")")
        }
        wait(for: [expectation], timeout: 20.0)
    }
    
    
    //MARK: old code - unit tests
    
    //
    //    func test_registerUser_withValidData_Returns_APIResponse(){
    //
    //        var  details = [String:Any]()
    //        details["password"] = ""
    //        details["email"] = "11612@gmail.com"
    //        details["first_name"] = ""
    //        details["phone"] =  "11612"
    //
    //
    //        if checkIfNotMale() == true{
    //            details["gender"] = 2
    //        }else{
    //            details["gender"] = 1
    //        }
    //
    //        details["country_id"] = ""
    //        //  details["age"] = ""
    //        // details["occupation"] = ""
    //
    //        let expectation = XCTestExpectation(description: "Register")
    //
    //        StylzAPIFacade.shared.signUp(profDet: details) { (aRes) in
    //            //print(aRes?.json)
    //            if aRes?.statusCode == 200{
    //                if aRes?.json?["status"].stringValue == "true"{
    //
    //                    //move to otp view controller
    //                    //  XCTAssertEqual(name, "Sara", "Login should succeed with valid credentials error")
    //
    //                    XCTAssertEqual(aRes?.json?["message"].stringValue, "Registration completed successfully", "Login should succeed with valid credentials error")
    //                    //print("status is true")
    //
    //                    expectation.fulfill()
    //                }
    //                else{
    //                    if let error = aRes?.json?["error"].array{
    //                        if error.count > 0{
    //                            XCTFail("\(error[0].stringValue)")
    //                        }else{
    //                            XCTFail("\(aRes?.json?["error"].stringValue ?? "")")
    //                        }
    //                    }else{
    //                        XCTFail("\(aRes?.json?["error"].stringValue ?? "")")
    //
    //                    }
    //                }
    //            }
    //            else{
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
    //
    //    func test_registerUser_witInhValidEmailData_Returns_Error(){
    //
    //        var  details = [String:Any]()
    //        details["password"] = ""
    //        details["email"] = ""
    //        details["first_name"] = ""
    //        details["phone"] =  "123"
    //
    //        if checkIfNotMale() == true{
    //            details["gender"] = 2
    //        }else{
    //            details["gender"] = 1
    //        }
    //
    //        details["country_id"] = ""
    //        //  details["age"] = ""
    //        // details["occupation"] = ""
    //
    //        let expectation = XCTestExpectation(description: "Register")
    //
    //        StylzAPIFacade.shared.signUp(profDet: details) { (aRes) in
    //            if aRes?.statusCode == 200{
    //                if aRes?.json?["status"].stringValue == "true"{
    //
    //                    //move to otp view controller
    //                    XCTFail("Login should fail, but succeeded with invalid data")
    //                }
    //                else{
    //                    if let error = aRes?.json?["error"].array{
    //                        if error.count > 0{
    //                            XCTFail("\(error[0].stringValue)")
    //                        }else{
    //                            XCTFail("\(aRes?.json?["error"].stringValue ?? "")")
    //                        }
    //                    }else{
    //                        XCTAssertEqual(aRes?.json?["error"].stringValue, "Email field is required ", "Login should fail with invalid credentials error")
    //
    //                        //print("status is true")
    //
    //                        expectation.fulfill()
    //                    }
    //                }
    //            }
    //            else{
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
    //        wait(for: [expectation], timeout: 10.0)
    //    }
    //
    //
    //    func test_registerUser_witInhValidData_Returns_Error(){
    //
    //        var  details = [String:Any]()
    //        details["password"] = ""
    //        details["email"] = "sara@g"
    //        details["first_name"] = ""
    //        details["phone"] =  ""
    //
    //
    //        if checkIfNotMale() == true{
    //            details["gender"] = 2
    //        }else{
    //            details["gender"] = 1
    //        }
    //
    //        details["country_id"] = ""
    //        //  details["age"] = ""
    //        // details["occupation"] = ""
    //
    //        let expectation = XCTestExpectation(description: "Register")
    //
    //        StylzAPIFacade.shared.signUp(profDet: details) { (aRes) in
    //            if aRes?.statusCode == 200{
    //                if aRes?.json?["status"].stringValue == "true"{
    //
    //                    //move to otp view controller
    //                    //  XCTAssertEqual(name, "Sara", "Login should succeed with valid credentials error")
    //                    XCTFail("Login should fail, but succeeded with invalid data")
    //                }
    //                else{
    //                    if let error = aRes?.json?["error"].array{
    //                        if error.count > 0{
    //                            XCTFail("\(error[0].stringValue)")
    //                        }else{
    //                            XCTFail("\(aRes?.json?["error"].stringValue ?? "")")
    //                        }
    //                    }
    //                    else{
    //                        XCTAssertNotNil(aRes?.json?["error"].stringValue)
    //                        //print("status is true")
    //                        expectation.fulfill()
    //                    }
    //                }
    //            }
    //            else{
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
    //        wait(for: [expectation], timeout: 10.0)
    //    }
    //
    //
    //
    //    //MARK: - get country api test cases
    //
    //    func test_getCountryAPI_ReturnsAPIResponse(){
    //
    //        //ARRANGE
    //        var countries = [Countrys]()
    //        countries.removeAll()
    //
    //
    //        let expectation = XCTestExpectation(description: "getCountryApi")
    //
    //        StylzAPIFacade.shared.getCountry { (aRes) in
    //
    //            if aRes?.statusCode == 200{
    //                if aRes?.json?["status"].boolValue == true{
    //                    if let data = aRes?.json?["data"].array{
    //
    //                        XCTAssertNotNil(data)
    //
    //                        for m in data{
    //                            //let booking = Countrys(json: m)
    //                            //countries.append(booking)
    //                        }
    //                        expectation.fulfill()
    //                    }
    //                }
    //                else{
    //                   XCTFail("task should succeed but failed with error: \(aRes?.json?["message"].stringValue ?? "")")
    //               }
    //            }
    //        }
    //        wait(for: [expectation], timeout: 10.0)
    //    }
    //
    //
    //    //
    //    func test_getCountryAPI_ReturnsError(){
    //
    //        //ARRANGE
    //        var countries = [Countrys]()
    //        countries.removeAll()
    //
    //        let expectation = XCTestExpectation(description: "getCountryApi")
    //
    //        StylzAPIFacade.shared.getCountry { (aRes) in
    //            if aRes?.statusCode == 200{
    //                if aRes?.json?["status"].boolValue == true{
    //                    if let data = aRes?.json?["data"].array{
    //                        XCTAssertNil(data)
    //                        XCTFail("task should fail with error: \(aRes?.json?["message"].stringValue ?? "")")
    //                     }
    //                }
    //                else{
    //                    XCTFail("task should succeed but failed with error: \(aRes?.json?["message"].stringValue ?? "")")}
    //            }
    //        }
    //        wait(for: [expectation], timeout: 10.0)
    //
    //    }
    
}
