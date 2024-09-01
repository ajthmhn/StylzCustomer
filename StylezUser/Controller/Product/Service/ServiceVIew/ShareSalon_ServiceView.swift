//
//  ShareSalon_ServiceView.swift
//  StylezUser
//
//  Created by abcd on 15/05/2024.
//

import Foundation
import UIKit
import StylesWebKit

extension ServiceViewController{
    
    func shareLinkToOtherApps() {
     
        // The URL you want to share
        guard let url = URL(string: "\(StylzAPIConfig.BaseUrl.baseServerpath)/salon?branchId=\(salon?.id ?? 0)")
        else{return}
        
        // Title and message
        let title = "Check out this salon!"
        let message = "I found a great salon: \(salon?.name_en ?? ""). \nCheck it out here:"
        
        // Create the share items array
        let shareItems: [Any] = [title, message, url]
        
        //    let shareItems: [Any] = [title, message]
        
        // Create an activity view controller
        let activityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        
        // Exclude certain activities if needed
        //                activityViewController.excludedActivityTypes = [
        //                    .airDrop, .postToFacebook, .postToTwitter, .postToWeibo, .message, .mail
        //                ]
        //
        
        // Present the activity view controller
        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        present(activityViewController, animated: true, completion: nil)
    }
    
    
    
    
//    func shareToInstagram() {
//        // Construct the URL with the appropriate scheme and parameters
//        guard let instagramURL = URL(string: "instagram://app") else {
//            // Instagram app not installed, handle gracefully
//            return
//        }
//        // Check if Instagram app is installed
//        if UIApplication.shared.canOpenURL(instagramURL) {
//            // Instagram app is installed, open the URL
//            UIApplication.shared.open(instagramURL, options: [:], completionHandler: nil)
//        } else {
//            // Instagram app is not installed, handle gracefully
//            //print("Instagram app not installed")
//        }
//    }
    
}

