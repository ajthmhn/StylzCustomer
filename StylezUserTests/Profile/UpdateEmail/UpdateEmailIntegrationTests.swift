//
//  UpdateEmailViewModelTests.swift
//  StylezUserTests
//
//  Created by MACBOOK on 3/3/24.
//

import XCTest
import StylesWebKit

@testable import StylezUser

final class UpdateEmailViewModelTests: XCTestCase {
    //Given email and old email are same
    
    func test_updateEmail_WithValidDetails_ReturnsAPIResponse(){
        
        let email  =  "Sara123@gmail.com"
        let id = StylzAPIFacade.shared.session?.UserId ?? -1
        
        let request = UpdateEmailRequest(userID: id, email: email)
        
        let expectation = XCTestExpectation(description: "updateEmail")
        
        let viewModel = UpdateEmailViewModel()
        viewModel.updateEmail(request: request) { otp, userID, errorMsg in
            
            XCTAssertNotNil(otp)
            XCTAssertNotNil(userID)
            XCTAssertNil(errorMsg)
            expectation.fulfill()
        }
     
        wait(for: [expectation], timeout: 10.0)
    }

    func test_updateEmail_WithAlreadyExistedEmail_ReturnsAPIError(){
        
        let email  =  "Ali@gmail.com"
        let id = StylzAPIFacade.shared.session?.UserId ?? -1
        
        let request = UpdateEmailRequest(userID: id, email: email)
        
        let expectation = XCTestExpectation(description: "updateEmail")
        
        let viewModel = UpdateEmailViewModel()
        viewModel.updateEmail(request: request) { otp, userID, errorMsg in
          
            XCTAssertNil(otp)
            XCTAssertNil(userID)
            XCTAssertNotNil(errorMsg)
            XCTAssertEqual(errorMsg, "Email already exists")
            expectation.fulfill()
        }
     
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_updateEmail_WithInvalidEmail_ReturnsError(){
        
        let email  =  "12@gamidpcm"
        let id = StylzAPIFacade.shared.session?.UserId ?? -1
        
        let request = UpdateEmailRequest(userID: id, email: email)
        
        let expectation = XCTestExpectation(description: "updateEmail")
        
        let viewModel = UpdateEmailViewModel()
        viewModel.updateEmail(request: request) { otp, userID, errorMsg in
          
            XCTAssertNil(otp)
            XCTAssertNil(userID)
            XCTAssertNotNil(errorMsg)
            XCTAssertEqual(errorMsg, LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_valid", comment: ""))
            expectation.fulfill()
        }
     
        wait(for: [expectation], timeout: 10.0)
    }

    func test_updateEmail_WithEmptyEmail_ReturnsError(){
        
        let email  =  ""
        let id = StylzAPIFacade.shared.session?.UserId ?? -1
        
        let request = UpdateEmailRequest(userID: id, email: email)
        
        let expectation = XCTestExpectation(description: "updateEmail")
       
        let viewModel = UpdateEmailViewModel()
        viewModel.updateEmail(request: request) { otp, userID, errorMsg in
          
            XCTAssertNil(otp)
            XCTAssertNil(userID)
            XCTAssertNotNil(errorMsg)
            XCTAssertEqual(errorMsg, LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_email", comment: ""))
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
