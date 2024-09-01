//
//  UploadProfileImageRequest.swift
//  StylezUser
//
//  Created by abcd on 25/03/2024.
//

import Foundation
import UIKit

struct UploadProfileImageRequest {
    
    let image: UIImage
    
    func getRequestBody() -> [String:Any]{
        
        var profDic = [String:Any]()
        
        profDic["image"] = getImageData()
        
        return profDic
    }
    
    
    func getImageData() -> Data?{
       
        let resize = resizeImage(image: image, targetSize: CGSize(width: 640, height: 480))
        
        let fixedImage = resize.fixOrientation()
        
        if let imgData:Data = fixedImage.pngData() {
            return imgData
        }
        
        return nil
    }
    
}
