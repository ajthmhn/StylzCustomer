//
//  TESTCASE SAMPLE.swift
//  StylezUserTests
//
//  Created by MACBOOK on 2/15/24.
//

import Foundation

import Foundation

class APIClient {
    func fetchData(completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: "https://api.example.com/data")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "DataErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
    }
}
import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
    }
    
    func fetchData() {
        let apiClient = APIClient()
        apiClient.fetchData { result in
            switch result {
            case .success(let data):
                // Handle successful data fetching
                print("Data fetched successfully: \(data)")
            case .failure(let error):
                // Handle error
                print("Failed to fetch data with error: \(error)")
            }
        }
    }
}

import XCTest

class APIClientTests: XCTestCase {
    
    // MARK: - Test Cases
    func testFetchData_Successful() {
        // Arrange
        let apiClient = APIClient()
        let expectation = XCTestExpectation(description: "Fetch data")
        
        // Act
        apiClient.fetchData { result in
            // Assert
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "Data should not be nil")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Data fetching should succeed, but failed with error: \(error)")
            }
        }
        
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchData_NetworkError() {
        // Arrange
        let apiClient = APIClient()
        let expectation = XCTestExpectation(description: "Fetch data")
        
        // Act
        apiClient.fetchData { result in
            // Assert
            switch result {
            case .success:
                XCTFail("Data fetching should fail with network error")
            case .failure(let error as NSError):
                XCTAssertEqual(error.domain, NSURLErrorDomain, "Error domain should be NSURLErrorDomain")
                expectation.fulfill()
            }
        }
        
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchData_EmptyResponseData() {
        // Arrange
        let apiClient = APIClient()
        let expectation = XCTestExpectation(description: "Fetch data")
        
        // Act
        apiClient.fetchData { result in
            // Assert
            switch result {
            case .success(let data):
                XCTAssertTrue(data.isEmpty, "Response data should be empty")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Data fetching should succeed with empty response data, but failed with error: \(error)")
            }
        }
        
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)
    }
}
