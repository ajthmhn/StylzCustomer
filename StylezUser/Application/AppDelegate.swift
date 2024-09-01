//
//  AppDelegate.swift
//  StylezUser
//
//  Created by Ajith Mohan on 10/08/23.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleMaps
import GooglePlaces
import FirebaseMessaging
import FirebaseCore
import StylesWebKit

//import FirebaseCoreInternal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let googleApiKey = "AIzaSyANGQ1CPazPTtTo9IwDvwm_ESG09EKi7Vk"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared.enable = true
       
        config_GoogleMaps()
        
        configFireBase()
       
        configNotification(application: application)
        
        localizeUI()
        
//        // Check if the app was launched with a deep link URL
//        if let url = launchOptions?[.url] as? URL {
//            //print("~ redirection to view from app ddeelafre \(url)")
//            handleDeepLink(url, app: application)
//        }
        
        return true
    }
    
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    
  
    //MARK: -  register APNs Token
    
    private func application(application: UIApplication,
                             didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        Messaging.messaging().apnsToken = deviceToken as Data
    }
    
    
    //MARK: - did recieve notification
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // handler for Push Notifications

        
        if let messageID = userInfo[K.Notification.gcmMessageIDKey] {
            //print("Message ID: \(messageID)")
        }
        
        // //print full message.
        //print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    
    //  MARK: - universal and deep links handling
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // Handle deep link URL when the app is already running
        
        //print("~ App delegate link: \(url)")
    
       // handleDeepLink(url, app: app)
        
        return true
        
    }
    
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
    
        //print("~ restoration handle")
        
//        if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
//            
//            if let url = userActivity.webpageURL {
//                
//                // Extract query parameters
//                handleDeepLink(url, app: application) // it's handled in scene delegate
//                
//            }
//        }
        
        return true
    }
}


//MARK: - UI , config google maps
extension AppDelegate{
    
    func localizeUI(){
        UIView.appearance().semanticContentAttribute =   LocalizationSystem.sharedInstance.getLanguage() == "ar" ? .forceRightToLeft : .forceLeftToRight
    }
    
    func config_GoogleMaps(){
        GMSServices.provideAPIKey(googleApiKey)
        GMSPlacesClient.provideAPIKey(googleApiKey)
    }
    
}


//MARK: - notification delegate - for recieving the notification

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        
        if let messageID = userInfo[K.Notification.gcmMessageIDKey] {
            //print("Message ID: \(messageID)")
        }
        
        // //print full message.
        //print(userInfo)
        
        // Change this to your preferred presentation option
        //    completionHandler([.alert, .badge, .sound])
        completionHandler([.banner, .badge, .sound])
    }
    
    
    //check point ::::
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        
        // //print message ID.
        if let messageID = userInfo[K.Notification.gcmMessageIDKey] {
            //print("Message ID: \(messageID)")
        }
        
        let appointmentID = userInfo["appointment_id"] as? String
        
        let actionIdentifier = response.actionIdentifier
        
      //  handleNotificationActionBtn(identifier: actionIdentifier, appointmentID: appointmentID)
        
        completionHandler()
        
    }
}



//MARK: - messaging delegate method
extension AppDelegate: MessagingDelegate{
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        //print("Firebase registration token: \(String(describing: fcmToken))")
        
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )
    }
}



//MARK: Config Notification and action button

extension AppDelegate{
    
    func configFireBase(){
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
    }
    
    func configNotification(application: UIApplication){
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
//        addActionButtonInNotification()
        application.registerForRemoteNotifications()
    }
    
}

//
////MARK: - add and handle notification action button
//
//extension AppDelegate{
//    //MARK: - action button in notification
//    
//    
//    func addActionButtonInNotification(){
//        
//        // Define action buttons
//        let acceptAction = UNNotificationAction(identifier: K.Notification.actionAccept, title: K.Notification.acceptTitle, options: [])
//        
//        let rejectAction = UNNotificationAction(identifier: K.Notification.actionReject, title: K.Notification.rejectTitle, options: [])
//        
//        // Define notification category
//        let notificationCategory = UNNotificationCategory(identifier: K.Notification.appointmentConfirmation_Identifier, actions: [acceptAction, rejectAction], intentIdentifiers: [], options: [])
//        
//        // Register the notification category
//        UNUserNotificationCenter.current().setNotificationCategories([notificationCategory])
//    }
//    
//    
//    //MARK: - handling notification action button
//    func handleNotificationActionBtn(identifier:String, appointmentID:String?){
//        switch identifier {
//        case K.Notification.actionAccept:
//            // Handle accept action
//            //print("User accepted the notification")
//            sendNotification(msg: K.Notification.ConfirmationSentMsg)
//            
//        case K.Notification.actionReject:
//            // Handle reject action
//            //print("User rejected the notification")
//            
//            if let appointmentID{
//                cancelAppointment(appointmentID: Int(appointmentID ?? "0") ?? 0)
//            }
//            
//        default:
//            break
//        }
//    }
//    
//}
//
////MARK: - send local notifcation for confirming the appointment
//extension AppDelegate{
//    
//    func sendNotification(msg:String){
//        DispatchQueue.main.async {
//            let notificationContent = UNMutableNotificationContent()
//            notificationContent.title = K.App.name
//            notificationContent.body = msg
//            let notificationRequest = UNNotificationRequest(identifier: K.Notification.localNotificationIdentifier, content: notificationContent, trigger: nil)
//            UNUserNotificationCenter.current().add(notificationRequest, withCompletionHandler: nil)
//        }
//    }
//    
//}
//
//
//
////MARK: - CancelAppointmentApi
//extension AppDelegate{
//    
//    func cancelAppointment(appointmentID:Int){
//        //print("appointe id", appointmentID)
//        
//        StylzAPIFacade.shared.cancelAppointment(id: appointmentID) { (aRes) in
//            if aRes?.statusCode == 200{
//                if aRes?.json?["status"].intValue == 200{
//                    //     self.sendNotification(msg: "Appointment cancelled successfully.")
//                }else{
//                    //print("error occurred in cancelling the appointment: \(aRes?.json)")
//                }
//            }
//        }
//    }
//}
//
//
////MARK: - scocial sharing - deep linking
//extension AppDelegate{
//    
//    func handleDeepLink(_ url: URL,app:UIApplication) {
//        
//        //print("~opened app with url \(url)")
//        // Parse the deep link URL and extract product ID
//        if let branchId = url.queryParameters?["branchId"]{
//            // Navigate to the product details screen with productId
//            //print("~Navigating to product with ID: \(branchId)")
//            moveToSalonViewWith(branchId: branchId, url: url)
//        }
//        else{
//            app.open(url)
//        }
//    }
//}
//
//
//
