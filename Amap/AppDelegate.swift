 //
//  AppDelegate.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/2/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit
import GooglePlaces
import OneSignal

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    
    self.registerForPushNotifications(launchOptions)
    self.initGooglePlaces()
    self.loadController()
    self.adaptInterface()
    
    return true
  }
  
  private func initGooglePlaces() {
    
    GMSPlacesClient.provideAPIKey("AIzaSyDpb82IHdJA9y8xnsjWkSa44qlX1iAHJdM")
    
  }
  
  private func loadController() {
    let splashViewController = SplashViewController()
    let mainNavigationController = UINavigationController.init(rootViewController: splashViewController)
    
    window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
    window?.rootViewController = mainNavigationController
    window?.makeKeyAndVisible()
    
  }
  
  private func adaptInterface() {
    
    UINavigationBar.appearance().barTintColor = UIColor.blackColor()
    UINavigationBar.appearance().tintColor = UIColor.blackColor()
    
    UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    self.window?.backgroundColor = UIColor.blackColor()
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
  
  func application(application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: String) -> Bool {
//    if extensionPointIdentifier == UIApplicationKeyboardExtensionPointIdentifier {
//      return false
//    }
    return false
  }
  
  func switchRootViewController(rootViewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
    if animated {
      UIView.transitionWithView(window!, duration: 0.5, options: .TransitionCrossDissolve, animations: {
        let oldState: Bool = UIView.areAnimationsEnabled()
        UIView.setAnimationsEnabled(false)
        self.window!.rootViewController = rootViewController
        UIView.setAnimationsEnabled(oldState)
        }, completion: { (finished: Bool) -> () in
          if completion != nil && finished == true {
            completion!()
          }
      })
    } else {
      window!.rootViewController = rootViewController
    }
  }

  func registerForPushNotifications(launchOptions: [NSObject: AnyObject]?) {

    OneSignal.initWithLaunchOptions(launchOptions, appId: "ec4f3c30-1bf5-4db3-bb51-8c18631b3c36")
    OneSignal.IdsAvailable { (userId, pushToken) in
      
      UserSession.session.oneSignalUUID = userId
      //print("User ID from OneSignal: \(userId)")
      
    }
    
//    let notificationSettings = UIUserNotificationSettings(forTypes: [.Badge, .Sound, .Alert], categories: nil)
//    application.registerUserNotificationSettings(notificationSettings)
  
  }
  
//  func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
//    
//    if notificationSettings.types != .None {
//    
//      application.registerForRemoteNotifications()
//    
//    }
//    
//  }
//  
//  func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
//    
//    let tokenChars = UnsafePointer<CChar>(deviceToken.bytes)
//    var tokenString = ""
//    
//    for i in 0..<deviceToken.length {
//      
//      tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
//      
//    }
//    
//    print("Device Token:", tokenString)
//    
//  }
//  
//  func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
//    
//    print("Failed to register:", error)
//    
//  }
  

}

extension UIApplication {
  class func topViewController(base: UIViewController? = UIApplication.sharedApplication().keyWindow?.rootViewController) -> UIViewController? {
    
    if let nav = base as? UINavigationController {
      return topViewController(nav.visibleViewController)
    }
    
    if let tab = base as? UITabBarController {
      let moreNavigationController = tab.moreNavigationController
      
      if let top = moreNavigationController.topViewController where top.view.window != nil {
        return topViewController(top)
      } else if let selected = tab.selectedViewController {
        return topViewController(selected)
      }
    }
    
    if let presented = base?.presentedViewController {
      return topViewController(presented)
    }
    
    return base
  }
}

extension UIWindow {
  
  func visibleViewController() -> UIViewController? {
    if let rootViewController: UIViewController  = self.rootViewController {
      return UIWindow.getVisibleViewControllerFrom(rootViewController)
    }
    return nil
  }
  
  class func getVisibleViewControllerFrom(vc:UIViewController) -> UIViewController {
    
    if vc.isKindOfClass(UINavigationController.self) {
      
      let navigationController = vc as? UINavigationController
      return UIWindow.getVisibleViewControllerFrom( navigationController!.visibleViewController!)
      
    } else if vc.isKindOfClass(UITabBarController.self) {
      
      let tabBarController = vc as? UITabBarController
      return UIWindow.getVisibleViewControllerFrom(tabBarController!.selectedViewController!)
      
    } else {
      
      if let presentedViewController = vc.presentedViewController {
        
        return UIWindow.getVisibleViewControllerFrom(presentedViewController)
        
      } else {
        
        return vc;
      }
    }
  }
}

