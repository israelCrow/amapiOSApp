//
//  AppDelegate.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/2/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    
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


}

