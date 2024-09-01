//
//  UpdateProfileUnitTests.swift
//  StylezUserTests
//
//  Created by MACBOOK on 3/3/24.
//

import XCTest
import StylesWebKit

@testable import StylezUser

final class UpdateProfileUnitTests: XCTestCase {
    
    //number: "212121212", name: "Sara2", email: "sara@gmail.com", countryID: 3, age: "26", occupation: "", imageSelected: false, image: Optional(<UIImage:0x600003005f80 named(main: User-icon) {981, 981} renderingMode=automatic(original)>))
    
    //   "error" : "The database backend does not accept 0 as a value for AutoField.",
    
    //This QueryDict instance is immutable
    func test_UpdateProfileResource_WithInvalidDetails_ReturnsError(){
        let number = "212121212"
        let email = "sara@gmail.com"
        let countryID = 0
        let age = "34"
        let job = ""
        let name = "sara2"
        
        let request = UpdateProfileRequest(number: number, name: name, email: email, countryID: countryID, age: age , occupation: job, imageSelected: false, image:nil)
        
        let expectation = XCTestExpectation(description: "updateProfile")
        
        let resource = UpdateProfileResource()
        resource.updateProfile(request: request) { errorMsg in
            
            XCTAssertNotNil(errorMsg)
            //  XCTAssertEqual(errorMsg,"This QueryDict instance is immutable")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 20.0)
    }
    
    func test_UpdateProfileResource_WithValidDetails_ReturnsAPIResponse(){
        let number = "212121212"
        let email = "sara@gmail.com"
        let countryID = 3
        let age = "34"
        let job = ""
        let name = "sara2"
        
        let request = UpdateProfileRequest(number: number, name: name, email: email, countryID: countryID, age: age , occupation: job, imageSelected: false, image:nil)
        
        let expectation = XCTestExpectation(description: "updateProfile")
        
        let resource = UpdateProfileResource()
        resource.updateProfile(request: request) { errorMsg in
            
            XCTAssertNil(errorMsg)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 20.0)
    }
    
}
