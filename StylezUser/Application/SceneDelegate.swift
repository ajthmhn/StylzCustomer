//
//  SceneDelegate.swift
//  StylezUser
//
//  Created by Ajith Mohan on 10/08/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        
//        // Universial link Open
//        if let userActivity = connectionOptions.userActivities.first,
//           userActivity.activityType == NSUserActivityTypeBrowsingWeb,
//           let urlinfo = userActivity.webpageURL{
//            //print ("Universial Link Open at SceneDelegate on App Start ::::::: \(urlinfo)")
//        }
//        
//        //deeplink Open
//        if connectionOptions.urlContexts.first?.url != nil {
//            let urlinfo = connectionOptions.urlContexts.first?.url
//            //print ("Deeplink Open at SceneDelegate on App Start ::::::: \(String(describing: urlinfo))")
//        }
        
        
//        guard let _ = (scene as? UIWindowScene) else { return }
//        
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        
//        if checkIfNotFirst() == false{
//            if let windowScene = scene as? UIWindowScene {
//                moveTo(viewIdentifier: "WelcomeViewController_id", windowScene: windowScene)
//            }
//        }else{
//            if let windowScene = scene as? UIWindowScene {
//
//                moveTo(viewIdentifier: "root_vc", windowScene: windowScene)
//            }
//        }
        
        guard let _ = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
               
               if checkIfNotFirst() == false{
                       if let windowScene = scene as? UIWindowScene {
                           let window = UIWindow(windowScene: windowScene)
                       let storyboard = UIStoryboard(name: "Main", bundle: nil)
                       let initialViewController = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController_id")

                           window.rootViewController = initialViewController
                           self.window = window
                           window.makeKeyAndVisible()
                       }
               }else{
                   if let windowScene = scene as? UIWindowScene {
                       let window = UIWindow(windowScene: windowScene)
                   let storyboard = UIStoryboard(name: "Main", bundle: nil)
                   let initialViewController = storyboard.instantiateViewController(withIdentifier: "root_vc")
                   
                       window.rootViewController = initialViewController
                       self.window = window
                       window.makeKeyAndVisible()
                   }
               }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
    // Universial link Open when app is onPause
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb,
           let urlinfo = userActivity.webpageURL{
            
            //print ("Universial Link Open at SceneDelegate on App Pause  ::::::: \(urlinfo)")
            
          //  handleDeepLink(urlinfo,scene)
        }
    }
    
    // Deeplink Open when app in onPause
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        
        let urlinfo = URLContexts.first?.url
        //print ("Deeplink Open on SceneDelegate at App Pause :::::::: \(String(describing: urlinfo))")
        
        guard let url = URLContexts.first?.url else {
            return
        }
        
      //  handleDeepLink(url,scene)
    }
 
}

//
//
////MARK: - handling navigation andd deep link for opening shared salon
//
//extension SceneDelegate{
//    
//    func moveTo(viewIdentifier:String, windowScene:UIWindowScene){
//        let window = UIWindow(windowScene: windowScene)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let initialViewController = storyboard.instantiateViewController(withIdentifier: viewIdentifier)
//        
//        window.rootViewController = initialViewController
//        self.window = window
//        window.makeKeyAndVisible()
//    }
//    
//    
//    func handleDeepLink(_ url: URL,_ scene: UIScene) {
//        // Parse the deep link URL and extract relevant information
//        // Example: extract branchId from the URL query parameters
//       
//        if let branchId = url.queryParameters?["branchId"] {
//            // Navigate to the appropriate screen or perform actions based on the branchId
//            //print("~ Received deep link with branchId: \(branchId)")
//        
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.moveToSalonViewWith(branchId: branchId, url: url)
//        }
//        else{
//            scene.open(url, options: nil)
//        }
//    }
//}
//
//
//extension AppDelegate{
//    
//    
//    func navigationToSalonView(branchId: String, navigationController:UINavigationController){
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: stryBrdId.salons) as! SalonsViewController
//        
//        vc.branchId = Int(branchId) ?? 0
//        vc.isFromAppdelegate = true
//        
//        navigationController.pushViewController(vc, animated: true)
//    }
//    
//    
//    func moveToSalonViewWith(branchId:String,url:URL){
//        DispatchQueue.main.async { [self] in
//            
//            //print("in ddispaatch")
//         
//            //MARK: - if there's no app or path it should be redirected to website
//            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//               let rootViewController = windowScene.windows.first?.rootViewController as? UITabBarController {
//                
//                if let selectedViewController = rootViewController.selectedViewController {
//                    if let navigationController = selectedViewController as? UINavigationController {
//                        // The selected view controller of the tab bar is already a navigation controller
//                        // You can use 'navigationController' here
//                        //print("~Found navigation controller for the first tab ***")
//                        self.navigationToSalonView(branchId: branchId, navigationController: navigationController)
//                        
//                    } 
//                    else if let navigationController = selectedViewController.navigationController {
//                        // The selected view controller is not a navigation controller, but it's embedded in one
//                        // You can use 'navigationController' here
//                        //print("~Found navigation controller for the first tab")
//                        self.navigationToSalonView(branchId: branchId, navigationController: navigationController)
//                       
//                    } else {
//                        // The selected view controller is not a navigation controller
//                        //print("First tab is not embedded in a navigation controller")
//                        windowScene.open(url, options: nil)
//                    }
//                } else {
//                    // No tab is selected or no tabs are available
//                    //print("No tab is selected")
//                    windowScene.open(url,options: nil)
//                }
//            }
//            else {
//                // No UIWindowScene or UITabBarController found
//                //print("No UIWindowScene or UITabBarController found")
//            }
//        }
//    }
//}
//    
//
