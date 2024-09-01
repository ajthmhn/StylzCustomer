//
//  UpdatePasswordControllerTest.swift
//  StylezUserTests
//
//  Created by MACBOOK on 3/3/24.
//

import XCTest
import StylesWebKit

@testable import StylezUser

final class UpdateNumberIntegrationTest: XCTestCase {
    
    //Given phone number  and old phone number are same
    func test_updatePhone_WithValidDetails_Return_APIResponse()  {
        
        let number  =  "1111111111" //before testing change num
        let id = StylzAPIFacade.shared.session?.UserId ?? -1
        
        let request = UpdateNumberRequest(userID: id, number: number)
        
        
        let expectation = XCTestExpectation(description: "updateNumber")
        
        let viewModel = updateNumberViewModel()
        viewModel.updatePhone(request: request) { otp, userID, errorMsg in
            
            XCTAssertNil(errorMsg)
            XCTAssertNotNil(otp)
            XCTAssertNotNil(userID)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_updatePhone_WithAlreadyResgisteredNumber_Return_APIError()  {
        
        let number  =  "123456789"
        let id = StylzAPIFacade.shared.session?.UserId ?? -1
        
        let request = UpdateNumberRequest(userID: id, number: number)
        
        
        let expectation = XCTestExpectation(description: "updateNumber")
        
        let viewModel = updateNumberViewModel()
        viewModel.updatePhone(request: request) { otp, userID, errorMsg in
            XCTAssertNil(otp)
            XCTAssertNil(userID)
            XCTAssertNotNil(errorMsg)
            XCTAssertEqual(errorMsg, "Phone already exists")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    
    func test_updatePhone_WithEmptyNumber_ReturnError()  {
        //7846488 valid num
        let number  =  ""
        let id = StylzAPIFacade.shared.session?.UserId ?? -1
        
        let request = UpdateNumberRequest(userID: id, number: number)
        
        let expectation = XCTestExpectation(description: "updateNumber")
        
        let viewModel = updateNumberViewModel()
        viewModel.updatePhone(request: request) { otp, userID, errorMsg in
            
            XCTAssertNil(otp)
            XCTAssertNil(userID)
            
            XCTAssertNotNil(errorMsg)
            XCTAssertEqual(errorMsg,LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_phone", comment: ""))
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
}
