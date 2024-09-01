//
//  Constants.swift
//  StylezUser
//
//  Created by MACBOOK on 2/29/24.
//

import Foundation
import UIKit


struct K{
    
    struct App{
    static let name = "Stylz"
    }
    
    struct LocationView{
        static var isLocationViewVisivble = false
   static var enableLocationViewIsPresented = false
    }
    
    
    struct User {
        
        static var isSubscribed = false
        static var userID = 0
        static var deviceToken = ""
        static var customerID = 0
        static var dicountValue = 0.0
        
    }
    
    
    struct Notification{
      static let actionAccept = "ACCEPT_ACTION"
        static let actionReject = "REJECT_ACTION"
        static let acceptTitle = "Confrim"
        static let rejectTitle = "Cancel"
        static let appointmentConfirmation_Identifier = "Appointment_Confirmation"
    static  let gcmMessageIDKey = "gcm.message_id"
        static let ConfirmationSentMsg = "Confirmation sent successfully."
    static let localNotificationIdentifier = "Local_RESPONSE_NOTIFICATION"
    }
    
    
    struct SearchTypes{
        
        static let shop = "shop"
        static let employee = "employee"
        
    }
    
    struct Color{
        static let AccentColor = UIColor(named:"AccentColor")
        static let gray = UIColor.systemGray6
        static let lightGray = UIColor(named: "lightGray")
        static let green = UIColor(named: "green")
        static let orange = UIColor(named: "orange")
        static let yellow = UIColor(named: "yellow")
        static let grayStar = UIColor(named: "starGray")
      
        static let star = UIColor(named: "Star")
        static let star5 = UIColor(named: "Star5")
        static let star3 = UIColor(named: "Star3")
        static let star2 = UIColor(named: "Star2")
        static let cart = UIColor(named: "Cart")
        }
    
    struct DateFormats{
    
        static let dateLocale = "d/MMM/yyyy"
        static let _dateLocale = "dd-MM-yyyy"
        static let timeLocale = "hh:mm a"
        static let defaultFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    }
    
    struct placeHolderImage{
        static let employee = "" //test_7 //test_7" //book_stylie
        static let user = "user"
        static let service = "test_2"
        static let scissor = "test_5"
    }
    
    struct UserDefaultsKeys{
        static let isSubscribed = "isSuscribed"
        static let userID = "userID"
        static let user_details = "user_details"
    }
    
    struct Error{
        static let someThingWentWrong = "Something went wrong try again..."
        static let netWorkError = "network Error"
        static let noLocation = "No location found. Please select any location first"
        static let enterValidNum = "Please enter a valid number"
        static let verifyYourEmaiil = "Verify your email address"
        
        
        //
        static let passwordError = "Password must be at least 8 characters long"
       static let timingError = "Please select a time"
    }
    
    struct MYStrings{
        
        static let weAreSorry = "We are sorry to see you go :("
        static let cancelSubscriptionText = "Your current subscription will remain active until Mars 12, 2024. We'll automatically downgrade you to free account after that date, but you'll always be able to access your account.\n\nif you need to reactivate your subscription, you can click below"
        static let areYouSure = "Are you sure"
        static let cancelSubscriptionAlertText = "if you cancel the subscription, you will lose access to the premium features."
        static let yes = "Yes"
        static let staySubscribed = "Stay Subscribed"
        static let youAreAllSet = "You’re all set"
        static let purchaseSuccesful = "Your purchase was successful."
        
        static let orderID = "Order ID:"
        
        static let SevendayFreeCancelAnytime = "Free for 7 days, then 49.99 SAR/month.\nCancel Aanytime"
        
        static let  getPremium  = "Get Premium"
        static let  getPremiumPlan = "Get Premium Plan"
        static let  getSevenDaysForFree = "Get 7 days for free"
        static let  Subscription = "Subscription"
        static let  upgradeTopRemium = "Upgrade to Premium"
        static let  subscripitonHistory = "Subscription History"
        static let  cancelPremium = "Cancel"
        static let  viewPlanFeature = "View Plan"
        static let  stylPremium = "Stylz Premium"
        static let  premiumPlan = "Premium Plan"
        static let  monthly = "Monthly"
        static let  myPlan = "My Plan"
        
        //static let     =   "Subscription";
        
        static let  backToHomePage = "Back to homepage"
        static let  reactivateSubscription = "Reactivate my premium plan"
        
        static let  subscriptionWillAutomaticallyRenewOn = "your subscription will automaticlly renew on"
        
        static let sarPErMOnthCANcelANytime = "Then 49.99 SAR/month. Cancel anytime."
        
        static let wantToLogOut = "Are you sure you want to signout?"
        //   static let logout = "Are you sure you want to logout?"
        static let imageUploaded = "Image updated"
        static let verified  = "Verified"
        static let unVerified  = "Unverified"
        static let chooseLoc = "Please choose location"
        static let enterPromoCode = "Please enter promo code"
        
        static let Upload = "Upload"
        
        //unlocaliizee
        
        static let updateYourEmail = "Update your email"
        static let updateYourNumber = "Update your mobile number"
        
        static let updateYourNumberSubHead = "We will send a code to your new mobile number to verify your account"
        
        static let updateYourEmailSubHead = "We will send a code to your new email to verify your account"
        
        static let email = "Email"
        static let phone = "Phone"
        static let discount  = "discount"
        
        //
        
        static let  notesplaceholder = "Describe your experience (Optional)"
        
        static let howWas = "How was"
        static let feedbackSubmitted = "Feedback Submitted"
        static let Thankyou = "Thank you"
        static let submitReview = "Submit your review Now"
        
        static let ratingMsg = "Let us know about your last experience with"
        static let ratingMsg2 = "Barbershop and his staff"
        static let rate = "Rate"
        static let staff = "staff"
        static let rateEach = "Rate each"
        static let staffsBehaivior = "staff’s behavior"
        
        
        //
        
        static let fogotPAssMsg = "Enter the email address or phone number with your account and we'll send an email with confirmation to rest your password"
        //  static mobile
        
        static let continueBtn = "Continue"
        static let notNowBtn = "Not now"
        
        static let submitBtn = "Submit"
        static let shopRatingMsg = "Your feedback will help us to improve\nservice quality"
        
        static let staffRatingMSg = "this will help us to improve service quality"
        
        //27 may
        
        
        static let shareLocation = "Share Location"
        static let enableLocation = "Enable your current location"
        static let enableLocationMsg = "Please activate location sharing in your device settings. This will allow the app to fetch your location to show nearby services."
        static let goToSettings = "Go to settings"
        
        
        
    static let couponCode = "Coupon Code"
        
    }
    
}
