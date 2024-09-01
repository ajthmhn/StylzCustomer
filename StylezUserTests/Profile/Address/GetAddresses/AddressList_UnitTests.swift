//
//  GetAddressListAPI_Tests.swift
//  StylesWebKitTests
//
//  Created by MACBOOK on 3/5/24.
//

import XCTest
import StylesWebKit

@testable import StylezUser


final class AddressListUnitTests: XCTestCase {
  
  
    
    func test_getAddressData_ReturnsAPIResponse(){
        let expectation = XCTestExpectation(description: "updateProfile")
        
       
        StylzAPIFacade.shared.addressList{ (aRes) in
            
            if aRes?.statusCode == 200{
                var addressList = [Addresss]()
                if let data = aRes?.json?["data"].array{
                    XCTAssertNotNil(data)
                }
            }
            else{
                XCTFail(" erorr:")
            }
            
            expectation.fulfill()
        }
        wait(for: [expectation],timeout: 5)
    }
    

    
    func test_getAddressData2_ReturnsAPIResponse(){
        let expectation = XCTestExpectation(description: "updateProfile")
        
       
        StylzAPIFacade.shared.addressList{ (aRes) in
            
            if aRes?.statusCode == 200{
                var addressList = [Addresss]()
                if let data = aRes?.json?["data"].array{
                    XCTAssertNotNil(data)
                }
            }
            else{
                XCTFail(" erorr:")
            }
            
            expectation.fulfill()
        }
        wait(for: [expectation],timeout: 5)
    }
    

}
