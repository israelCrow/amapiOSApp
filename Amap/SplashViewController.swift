//
//  SplashViewController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/2/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit
import Alamofire

class SplashViewController: UIViewController {
  
  private var mainTabBarController: MainTabBarController! = nil
  
  override func loadView() {
    self.view = UIView.init(frame: UIScreen.mainScreen().bounds)
    self.view.backgroundColor = UIColor.blackColor()
  }
  
  override func viewDidLoad() {
    self.navigationController?.navigationBarHidden = true
    self.navigationController?.navigationBar.barStyle = .Black
    
    //Check whether there has already been a coonection
    
    //If there's not info show tutorial
    
    let lastValidEmail = NSUserDefaults.standardUserDefaults().objectForKey(UtilityManager.sharedInstance.kLastValidUserEmail) as? String
    let lastValidPassword = NSUserDefaults.standardUserDefaults().objectForKey(UtilityManager.sharedInstance.kLastValidUserPassword) as? String
    
    if lastValidEmail != nil && lastValidPassword != nil {
      
      self.makeLogin(lastValidEmail!, password: lastValidPassword!)
      
    }else{
    
      self.showLogin()
      
    }
  }
  
  private func showLogin() {
    
    let loginViewController = LoginViewController()
    self.navigationController?.pushViewController(loginViewController, animated: true)

  }
  
  func makeLogin(email: String, password: String) {
    
    UtilityManager.sharedInstance.showLoader()
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/sessions"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
    
    let values = [
      "user_session" :
        [ "email" : email,
          "password" : password
      ]
    ]
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(values, options: [])
    
    Alamofire.request(requestConnection)
      .validate(statusCode: 200..<500)
      //                  .response{
      //                    (request, response, data, error) -> Void in
      //                    print(response)
      //            //          let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
      //            //            print (json)
      //            //          }
      
      .responseJSON{ response in
        if response.response?.statusCode == 200 {
          
          
          NSUserDefaults.standardUserDefaults().setObject(email, forKey: UtilityManager.sharedInstance.kLastValidUserEmail)
          NSUserDefaults.standardUserDefaults().setObject(password, forKey: UtilityManager.sharedInstance.kLastValidUserPassword)
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          //print(json)
          
          
          let agency_id = json["agency_id"] as? Int
          let brand_id = json["brand_id"] as? Int
          let auth_token = json["auth_token"] as? String
          let email = json["email"] as? String
          let first_name = json["first_name"] as? String
          let id_user_int = json["id"] as? Int
          let id_user_string = String(id_user_int!)
          let is_member_amap = json["is_member_amap"] as? String
          
          var is_member_amap_bool: Bool
          if is_member_amap == "0" {
            is_member_amap_bool = false
          }else{
            is_member_amap_bool = true
          }
          
          let last_name = json["last_name"] as? String
          let role_int = json["role"] as? Int
          let role_string = String(role_int)
          
          if agency_id != nil && agency_id != -1 {
            
            UserSession.session.agency_id = String(agency_id!)
            AgencyModel.Data.id = UserSession.session.agency_id!
            
          } else
            if brand_id != nil && brand_id != -1 {
              
              UserSession.session.brand_id = String(brand_id!)
              
          }
          
          UserSession.session.auth_token = auth_token!
          UserSession.session.email = email!
          UserSession.session.first_name = first_name!
          UserSession.session.id = id_user_string
          UserSession.session.is_member_amap = is_member_amap_bool
          UserSession.session.last_name = last_name!
          UserSession.session.role = role_string
          
          RequestToServerManager.sharedInstance.requestForAgencyData(){
            
            UtilityManager.sharedInstance.hideLoader()
            
            self.initAndChangeRootToMainTabBarController()

          }
          
        } else {
          
          UtilityManager.sharedInstance.hideLoader()
          self.showLogin()
 
        }
        
        
        
        //        let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
        //        print (json)
        //
        //        print("\(response.response) \n\n\(response.response?.statusCode)")
    }
  }
  
  private func initAndChangeRootToMainTabBarController() {
    
    mainTabBarController = MainTabBarController()
    mainTabBarController.tabBar.barTintColor = UIColor.blackColor()
    mainTabBarController.tabBar.tintColor = UIColor.whiteColor()
    
    var arrayOfViewControllers = [UINavigationController]()
    
    //    mainTabBarController.viewControllers = [UIViewController]()
    
    arrayOfViewControllers.append(self.createFirstBarItem())
    arrayOfViewControllers.append(self.createSecondBarItem())
    arrayOfViewControllers.append(self.createThirdBarItem())
    
    mainTabBarController.viewControllers = arrayOfViewControllers
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    UIView.transitionWithView(appDelegate.window!,
                              duration: 0.25,
                              options: UIViewAnimationOptions.TransitionCrossDissolve,
                              animations: {
                                self.view.alpha = 0.0
                                appDelegate.window?.rootViewController = self.mainTabBarController
                                appDelegate.window?.makeKeyAndVisible()
                                
      },
                              completion: nil)
    
  }

  private func createFirstBarItem() -> UINavigationController {
    
    let imageDashboardNonSelected = UIImage.init(named: "iconDashboardMedium")
    let imageDashboardSelected = UIImage.init(named: "iconDashboardWhite")
    
    let blankController1 = BlankViewController()
    
    let tabOneBarItem = UITabBarItem.init(title: AgencyProfileVisualizeConstants.TabBarView.dashBoardButtonText,
                                          image: imageDashboardNonSelected,
                                          selectedImage: imageDashboardSelected)
    
    let newNavController = UINavigationController.init(rootViewController: blankController1)
    
    tabOneBarItem.tag = 1
    newNavController.tabBarItem = tabOneBarItem
    newNavController.navigationBar.barStyle = .Black
    
    return newNavController
    
  }
  
  private func createSecondBarItem() -> UINavigationController {
    
    let imagePitchesNonSelected = UIImage.init(named: "iconPitchesMedium")
    let imagePitchesSelected = UIImage.init(named: "iconPitchesWhite")
    
    let visualizeAllPitches = VisualizeAllPitchesViewController()
    visualizeAllPitches.delegateForShowAndHideTabBar = mainTabBarController
    let tabTwoBarItem = UITabBarItem.init(title: AgencyProfileVisualizeConstants.TabBarView.pitchesButtonText,
                                          image: imagePitchesNonSelected,
                                          selectedImage: imagePitchesSelected)
    
    let newNavController = UINavigationController.init(rootViewController: visualizeAllPitches)
    
    tabTwoBarItem.tag = 2
    newNavController.tabBarItem = tabTwoBarItem
    newNavController.navigationBar.barStyle = .Black
    
    return newNavController
    
  }
  
  private func createThirdBarItem() -> UINavigationController  {
    
    let imageAgencyProfileNonSelected = UIImage.init(named: "iconAgencyMedium")
    let imageAgencyProfileSelected = UIImage.init(named: "iconAgencyWhite")
    
    let visualizeAgencyProfileController = VisualizeAgencyProfileViewController()
    visualizeAgencyProfileController.delegate = mainTabBarController
    let tabThreeBarItem = UITabBarItem.init(title: AgencyProfileVisualizeConstants.TabBarView.agencyProfileButtonText,
                                            image: imageAgencyProfileNonSelected,
                                            selectedImage: imageAgencyProfileSelected)
    
    let newNavController = UINavigationController.init(rootViewController: visualizeAgencyProfileController)
    
    tabThreeBarItem.tag = 3
    newNavController.tabBarItem = tabThreeBarItem
    newNavController.navigationBar.barStyle = .Black
    
    return newNavController
    
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }
  
  override func didReceiveMemoryWarning() {
    
  }
  
}