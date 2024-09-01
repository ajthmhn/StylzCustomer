
import Foundation
import UIKit

struct API{
    
    struct Key{
        static var authToken = ""
        static var thisMonth = "thisMonth"
    }
    
    struct slug{
    }
    
    // static let baseURL = ""//prd
    static let Base = "https://test.demo.bilz.app/"//dev
    static let Server = "delivery_app/"
    
    //MAPs
  
    //Login
    static let login = "login"
    static let changePassword = "changePassword"
    static let logout = "logout"
    
   
}


enum CustomereEndpoint{
    case login(loginBody: [String:AnyHashable])
    
}

extension CustomereEndpoint:EndPointType{
    
    var path: String {
        switch self {
            
            //Login
              case .login:
            return "\(API.login)"
        }
    }
    
    var serverURL: String {
        return API.Server
    }
    
    var baseURL: String {
        return API.Base
    }
    
    var url: URL? {
        switch self{
     //   case .getRoute:
       //     return "\(path)".getCleanedURL()
            
        default:
            return "\(baseURL)\(serverURL)\(path)".getCleanedURL()
        }
    }
    
    var method: HTTPMethods {
        switch self {
            
            // login apis
        case .login:
            return .post
        }
    }
    
    var headers: [String : String]? {
        return APIManager.commonHeaders
    }
    
    var body2: Encodable? {
        switch self{
//case .uploadPOD(let orderID,let driverID,let signatureImg, let idImg, let prodImg):
  //          return uploadPODBody(orderID: orderID, driverID: driverID, signatureImg: signatureImg, productImg: prodImg, idCardImg: idImg)
            
        default:
            return nil
        }
    }
    
    var body: AnyHashable? {
        switch self {
            
            // login apis
        case .login(let username):
            return username
        //    return loginBody(username: username, password: password)
      
        }
    }
}

extension CustomereEndpoint{
    
    func getCompressedImageData(image:UIImage) -> Data{
        let data = image.jpegData(compressionQuality: CGFloat(0.5))!
        return data
    }
    
//    func uploadPODBody(orderID:Int, driverID:Int, signatureImg:UIImage, productImg:UIImage, idCardImg:UIImage) -> Encodable{
//        let signatureImgdata = getCompressedImageData(image: signatureImg)
//        let productImgdata = getCompressedImageData(image: productImg)
//        let idImgdata = getCompressedImageData(image: idCardImg)
//        
//        let podEncodedDataBody = PODModelEncodable(orderID: orderID, driverID: driverID, signatureImage: signatureImgdata, productImage: productImgdata, idcardImage: idImgdata)
//        print(podEncodedDataBody)
//        return podEncodedDataBody
//        //        return [
//        //            "order_id":orderID,
//        //            "driver_id":driverID,
//        //            "signature_image":signatureImgdata,
//        //            "product_image":productImgdata,
//        //            "idcard_image":idImgdata
//        //        ]
//    }
}

