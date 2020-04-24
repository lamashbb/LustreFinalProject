//
//  AppDelegate.swift
//  lustreProj
//
//  Created by lam  on 1/25/20.
//  Copyright © 2020 lam . All rights reserved.
//

import UIKit
import Firebase
import Foundation
import GoogleMaps
import GooglePlaces
import UserNotifications
import Messages

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate ,UNUserNotificationCenterDelegate ,UIWindowSceneDelegate, MessagingDelegate{

//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        print("token :\(deviceToken)")
//    }

   var window: UIWindow?

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])


    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        UNUserNotificationCenter.current().delegate = self
        if response.notification.request.identifier == "test"{
             print("inside notification 111")
            

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let secondViewController = storyboard.instantiateViewController(withIdentifier: "GoToSignIn") as UIViewController
           
        }
        if response.notification.request.identifier == "open"{
                    print("inside open action 111")
            
                  
               }
        
         completionHandler()
    }
    
    static func action (in vc :UIViewController, title:String, completion :@escaping() ->Void){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: title, style: .default){(_) in
            completion()
            
        }
        alert.addAction(action)
        vc.present(alert,animated: true)
    }

    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
      print("Firebase registration token: \(fcmToken)")

      let dataDict:[String: String] = ["token": fcmToken]
      NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }




    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
         FirebaseApp.configure()
        Messaging.messaging().delegate = self

       GMSServices.provideAPIKey("AIzaSyD1387RQbod1LCGdD0pKY3l5IQMc3LN-Yk")
       GMSPlacesClient.provideAPIKey("AIzaSyD1387RQbod1LCGdD0pKY3l5IQMc3LN-Yk")

       UNUserNotificationCenter.current().delegate = self
       UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
             print("granted: (\(granted)")
       }
        print("in appliaction")

        UIApplication.shared.registerForRemoteNotifications()

        Messaging.messaging().fcmToken
        print("device token" ,  Messaging.messaging().fcmToken)

               return true
           }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {


        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


//import UIKit
//import UserNotifications
//
//import Firebase
//
//
//@UIApplicationMain
//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//  var window: UIWindow?
//  let gcmMessageIDKey = "gcm.message_id"
//
////    func application(_ application: UIApplication,
////      didFinishLaunchingWithOptions launchOptions:
////        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
////      FirebaseApp.configure()
////      return true
////    }
//
//  func application(_ application: UIApplication,
//                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//
//    FirebaseApp.configure()
//
//    // [START set_messaging_delegate]
//    Messaging.messaging().delegate = self
//    // [END set_messaging_delegate]
//    // Register for remote notifications. This shows a permission dialog on first run, to
//    // show the dialog at a more appropriate time move this registration accordingly.
//    // [START register_for_notifications]
//    if #available(iOS 10.0, *) {
//      // For iOS 10 display notification (sent via APNS)
//      UNUserNotificationCenter.current().delegate = self
//
//      let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//      UNUserNotificationCenter.current().requestAuthorization(
//        options: authOptions,
//        completionHandler: {_, _ in })
//    } else {
//      let settings: UIUserNotificationSettings =
//      UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//      application.registerUserNotificationSettings(settings)
//    }
//
//    application.registerForRemoteNotifications()
//
//    // [END register_for_notifications]
//    return true
//  }
//
//  // [START receive_message]
//  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
//    // If you are receiving a notification message while your app is in the background,
//    // this callback will not be fired till the user taps on the notification launching the application.
//    // TODO: Handle data of notification
//    // With swizzling disabled you must let Messaging know about the message, for Analytics
//    // Messaging.messaging().appDidReceiveMessage(userInfo)
//    // Print message ID.
//    if let messageID = userInfo[gcmMessageIDKey] {
//      print("Message ID: \(messageID)")
//    }
//
//    // Print full message.
//    print(userInfo)
//  }
//
//  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
//                   fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//    // If you are receiving a notification message while your app is in the background,
//    // this callback will not be fired till the user taps on the notification launching the application.
//    // TODO: Handle data of notification
//    // With swizzling disabled you must let Messaging know about the message, for Analytics
//    // Messaging.messaging().appDidReceiveMessage(userInfo)
//    // Print message ID.
//    if let messageID = userInfo[gcmMessageIDKey] {
//      print("Message ID: \(messageID)")
//    }
//
//    // Print full message.
//    print(userInfo)
//
//    completionHandler(UIBackgroundFetchResult.newData)
//  }
//  // [END receive_message]
//  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//    print("Unable to register for remote notifications: \(error.localizedDescription)")
//  }
//
//  // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
//  // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
//  // the FCM registration token.
//  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//    print("APNs token retrieved: \(deviceToken)")
//
//    // With swizzling disabled you must set the APNs token here.
//    // Messaging.messaging().apnsToken = deviceToken
//    print("the token issss")
//    print(Messaging.messaging().fcmToken)
//  }
//}
//
//// [START ios_10_message_handling]
//@available(iOS 10, *)
//extension AppDelegate : UNUserNotificationCenterDelegate {
//
//  // Receive displayed notifications for iOS 10 devices.
//  func userNotificationCenter(_ center: UNUserNotificationCenter,
//                              willPresent notification: UNNotification,
//    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//    let userInfo = notification.request.content.userInfo
//
//    // With swizzling disabled you must let Messaging know about the message, for Analytics
//    // Messaging.messaging().appDidReceiveMessage(userInfo)
//    // Print message ID.
//    if let messageID = userInfo[gcmMessageIDKey] {
//      print("Message ID: \(messageID)")
//    }
//
//    // Print full message.
//    print(userInfo)
//
//    // Change this to your preferred presentation option
//    completionHandler([])
//  }
//
//  func userNotificationCenter(_ center: UNUserNotificationCenter,
//                              didReceive response: UNNotificationResponse,
//                              withCompletionHandler completionHandler: @escaping () -> Void) {
//    let userInfo = response.notification.request.content.userInfo
//    // Print message ID.
//    if let messageID = userInfo[gcmMessageIDKey] {
//      print("Message ID: \(messageID)")
//    }
//
//    // Print full message.
//    print(userInfo)
//
//    completionHandler()
//  }
//}
//// [END ios_10_message_handling]
//
//extension AppDelegate : MessagingDelegate {
//  // [START refresh_token]
//  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
//    print("Firebase registration token: \(fcmToken)")
//
//    let dataDict:[String: String] = ["token": fcmToken]
//    NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
//    // TODO: If necessary send token to application server.
//    // Note: This callback is fired at each app startup and whenever a new token is generated.
//  }
//  // [END refresh_token]
//  // [START ios_10_data_message]
//  // Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
//  // To enable direct data messages, you can set Messaging.messaging().shouldEstablishDirectChannel to true.
//  func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
//    print("Received data message: \(remoteMessage.appData)")
//  }
//  // [END ios_10_data_message]
//}
