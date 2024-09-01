//
//  APIManager.swift
//  DoctorsAppForPatients
//
//  Created by test on 6/27/23.
//


import Foundation
import UIKit
//import SwiftyJSON

extension String: Error {}

enum DataError: Error{
    
    case invalidResponse
    case invalidURL
    case invalidData
    case unAuthorized(_ error: String)
   // case runtimeError(String)

    case network(_ error: Error?)
    
}

typealias Handler<T> = (Result<T,DataError>)  -> Void

final class APIManager{
    
    static let shared = APIManager()
    static var commonHeaders:[String:String]{
        return [
            "Content-Type": "application/json",
            "Accept": "application",
            "Authorization": "Bearer \(API.Key.authToken)"
        ]
    }
    
    //can't create its object
    private init(){}
    
    func getRequest<T: Codable>(
        modelType:T.Type,
        type:EndPointType,isFormData:Bool = false,
        completionHandler: @escaping Handler <T>)
    {
     
//        if K.Network.isConnected{
            guard let url =  type.url else {
                //print("url failed")
                completionHandler(.failure(DataError.unAuthorized(" \(K.Error.someThingWentWrong)")))
              return
            }
            
            var request = URLRequest(url: url)
            //print("~URL: \(url)")
            request.httpMethod = type.method.rawValue
            
            if type.body2 != nil {
                
                //print("data before encoding \(type.body2)")
                if let parameters = type.body2{
                    let encodedData = try? JSONEncoder().encode(parameters)
                    //print("encoded data \(encodedData)")
                    request.httpBody = encodedData
                }
            }
            else{
                //print("else block of parameter")
                if let parameters = type.body{
                    request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
                }
            }
    
        isFormData ?
            request.setValue("multipart/form-data", forHTTPHeaderField:"Content-Type")
        :
        request.setValue("application/json", forHTTPHeaderField:"Content-Type")
    
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(API.Key.authToken)", forHTTPHeaderField: "Authorization")
            
            
            //Background task
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data,error == nil else {
                    //print("Error: data, error ")
                    //print(error?.localizedDescription)
                    completionHandler(.failure(DataError.unAuthorized("\(error?.localizedDescription ?? "\(K.Error.someThingWentWrong)") ")))
                //completionHandler(.failure(DataError.invalidData))
                    return
                    
                }
                guard let response = response as? HTTPURLResponse, 200 ... 299 ~= response.statusCode else{
                    //print("Error: response code  \(response) ")
                    
                    if let response = response as? HTTPURLResponse, 401 == response.statusCode{
                       // let decodedErrorObj = try? JSONDecoder().decode(unAuthorizedModel.self, from: data)
                      
                        ////print("decodedError obj \(decodedErrorObj)")
                        
                        completionHandler(.failure(DataError.unAuthorized("Un Authorized Error !")))
                        return
                    }
                    
                    completionHandler(.failure(DataError.unAuthorized("\(K.Error.someThingWentWrong)")))
                    return
                }
                
                ////print("printing json \(url) ~* start.")
                
              //  self.printJson(responseData: data)
                
                ////print("printing json \(url) ~* end.")
                
                do {
                    //print("url: \(url), modalType: \(modelType), data: \(data)")
                    
                    if modelType == Data.self{
                        completionHandler(.success(data as! T))
                    }
                    
                    else{
                        let decodedObj = try JSONDecoder().decode(modelType, from: data)
                        completionHandler(.success(decodedObj))
                    }
                }
                catch let error {
                    //print(error.localizedDescription)
                    //print("did not decode, error in data type")
                    completionHandler(.failure(DataError.unAuthorized("\(K.Error.someThingWentWrong)")))
               }
            }.resume()
       
}

    func getErrorString(errors:[String]?) -> String{
       var errorMsg = ""
        if let errors{
            for i in errors{
                if errorMsg == ""{
                    errorMsg = ":\(i)"
                }
                else{
                    errorMsg = "\(errorMsg),\(i)"
                }
            }
        }
        
        return errorMsg
    }
    
func printJson(responseData:Data?){
    do{
        guard let jsonObject = try JSONSerialization.jsonObject(with: responseData!) as? [String: Any] else {
            //print("Error(//print): Cannot convert data to JSON object")
            return
        }
        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
            //print("Error(//print): Cannot convert JSON object to Pretty JSON data")
            return
        }
        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
            //print("Error(//print): Couldn't //print JSON in String")
            return
        }
        
        //print(prettyPrintedJson)
    }
    catch let error {
        //print("//print error: \(error.localizedDescription)")
    }
}


//

func postDataWithAuthorization<T:Decodable>(requestUrl: URL,slugId:String,selectedFileData:Data,fileType:String, resultType: T.Type, completionHandler:@escaping(_ result: T?)-> Void){
    var urlRequest = URLRequest(url: requestUrl)
    
    urlRequest.addValue("Bearer \(API.Key.authToken)", forHTTPHeaderField: "Authorization")
    urlRequest.setValue("\(slugId)", forHTTPHeaderField: "slug")
    urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
    urlRequest.httpMethod = "POST" // POST
    
    //        if fileType == K.FileType.IMG{
    //            urlRequest.setValue("image/jpeg", forHTTPHeaderField: "Content-Type")
    //        }else if fileType == K.FileType.PDF {
    //            urlRequest.setValue("application/pdf", forHTTPHeaderField: "Content-Type")
    //        }
    
    URLSession.shared.uploadTask(with: urlRequest, from: selectedFileData, completionHandler: { responseData, response, error in
        DispatchQueue.main.async {
            //print(response as Any)
            
            do{
                guard let jsonObject = try JSONSerialization.jsonObject(with: responseData!) as? [String: Any] else {
                    //print("Error: Cannot convert data to JSON object")
                    _=completionHandler(nil)
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    //print("Error: Cannot convert JSON object to Pretty JSON data")
                    _=completionHandler(nil)
                    return
                }
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    //print("Error: Couldn't //print JSON in String")
                    _=completionHandler(nil)
                    return
                }
                
                //print(prettyPrintedJson)
                let result = try JSONDecoder().decode(T.self, from: responseData!)
                _=completionHandler(result)
            }
            catch let error {
                //print(error.localizedDescription)
                _=completionHandler(nil)
            }
            // do your work
        }
    }).resume()
}


func postApiWithServerKeyAuthorization<T:Decodable>(requestUrl: URL, requestBody: Data, resultType: T.Type, completionHandler:@escaping(_ result: T?)-> Void)
{
    //do anything here
    var urlRequest = URLRequest(url: requestUrl)
    
    urlRequest.addValue("Bearer \(API.Key.authToken)", forHTTPHeaderField: "Authorization")
    urlRequest.httpMethod = "POST"
    urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
    urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
    
    urlRequest.httpBody = requestBody
    
    URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
        if(error == nil && data != nil && data?.count != 0)
        {
            do {
                guard error == nil else {
                    //print("Error: error calling POST")
                    //print(error!)
                    _=completionHandler(nil)
                    return
                }
                guard let data = data else {
                    //print("Error: Did not receive data")
                    _=completionHandler(nil)
                    return
                }
                guard let response = httpUrlResponse as? HTTPURLResponse, (200 ..< 799) ~= response.statusCode else {
                    //print("Error: HTTP request failed")
                    _=completionHandler(nil)
                    return
                }
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    //print("Error: Cannot convert data to JSON object")
                    _=completionHandler(nil)
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    //print("Error: Cannot convert JSON object to Pretty JSON data")
                    _=completionHandler(nil)
                    return
                }
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    //print("Error: Couldn't //print JSON in String")
                    _=completionHandler(nil)
                    return
                }
                
                //print("no error printing json")
                //print(prettyPrintedJson)
                
                let result = try JSONDecoder().decode(T.self, from: data)
                _=completionHandler(result)
            }
            catch let decodingError {
                debugPrint(decodingError)
                _=completionHandler(nil)
            }
        }
        
    }.resume()
}
  
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                //    //print("cinvert string to json \(json)")
                return json
            } catch {
                //print("Something went wrong in converting string to dictionary")
            }
        }
        return nil
    }
    


}


//MARK: - String extension
extension String {
    func getCleanedURL() -> URL? {
        guard self.isEmpty == false else {
            return nil
        }
        if let url = URL(string: self) {
            return url
        } else {
            if let urlEscapedString = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) , let escapedURL = URL(string: urlEscapedString){
                return escapedURL
            }
        }
        return nil
    }
    
    
}

// MARK:  - DAta extension
extension Data {
    var prettyPrintedJSONString: NSString? {
        guard let jsonObject = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: jsonObject,
                                                     options: [.prettyPrinted]),
              let prettyJSON = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {
            return nil
        }
        return prettyJSON
    }
}

//protocol MyEncodable: Encodable {
//    func toJSONData() -> Data?
//}
//

extension Encodable {
    func toJSONData() -> Data? { try? JSONEncoder().encode(self) }
}
