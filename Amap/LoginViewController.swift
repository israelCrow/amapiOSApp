//
//  LoginViewController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/2/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController, GoldenPitchLoginViewDelegate {
    
  let kCreateAccountText = "No estás registrado? Crea Cuenta"
    
  private var flipCard:FlipCardView! = nil
  private var createAccountLabel: UILabel! = nil
  private var lastFramePosition: CGRect! = nil
  private var alreadyAppearedKeyboard: Bool = false
  private var loginGoldenPitchView: GoldenPitchLoginView! = nil
  private var isSecondOrMoreTimeToAppear: Bool = false
  private var mainTabBarController: MainTabBarController! = nil
  
  override func loadView() {
    self.view = self.createGradientView()
    self.view.userInteractionEnabled = true
  }
    
  override func viewDidLoad() {
      
    self.createTapGestureForDismissKeyboard()
    self.addObserverToKeyboardNotification()
    self.createFlipCardView()
    self.addCreateAccountLabel()
      
  }
    
    private func createTapGestureForDismissKeyboard() {
        
        let tapForHideKeyboard = UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyboard))
        tapForHideKeyboard.numberOfTapsRequired = 1
        
        self.view.addGestureRecognizer(tapForHideKeyboard)
        
        
    }
    
    private func addObserverToKeyboardNotification() {
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(keyboardAppear),
                                                         name: UIKeyboardDidShowNotification,
                                                         object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(keyboardDisappear),
                                                         name: UIKeyboardDidHideNotification,
                                                         object: nil)
        
        
    }
    
    private func createFlipCardView() {
        
        let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
        let heightOfCard = self.view.frame.size.height - (136.0 * UtilityManager.sharedInstance.conversionHeight)
        let frameForCard = CGRect.init(x: (40.0 * UtilityManager.sharedInstance.conversionWidth),
                                       y: (60.0 * UtilityManager.sharedInstance.conversionHeight),
                                       width: widthOfCard,
                                       height: heightOfCard)
        
        loginGoldenPitchView = GoldenPitchLoginView.init(frame: frameForCard)
        self.loginGoldenPitchView.delegate = self
        self.view.addSubview(loginGoldenPitchView)
        
    }
    
    private func addCreateAccountLabel() {
        createAccountLabel = UILabel.init(frame: CGRectZero)
        
        let font = UIFont(name: "SFUIDisplay-Semibold",
                          size: 11.0 * UtilityManager.sharedInstance.conversionWidth)
        let color = UIColor.init(red: 0.0/255.0, green: 64.0/255.0, blue: 89.0/255.0, alpha: 1.0)
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.Center
        
        let stringWithFormat = NSMutableAttributedString(
            string: kCreateAccountText,
            attributes:[NSFontAttributeName: font!,
                NSParagraphStyleAttributeName: style,
                NSForegroundColorAttributeName: color,
            ]
        )
        stringWithFormat.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: NSMakeRange(21, 11))
        createAccountLabel.attributedText = stringWithFormat
        createAccountLabel.sizeToFit()
        let newFrame = CGRect.init(x: (self.view.frame.size.width / 2.0) - (createAccountLabel.frame.size.width / 2.0),
                                   y: self.loginGoldenPitchView.frame.origin.y + self.loginGoldenPitchView.frame.size.height + (17.0  * UtilityManager.sharedInstance.conversionHeight),
                                   width: createAccountLabel.frame.size.width,
                                   height: createAccountLabel.frame.size.height + (22.0 * UtilityManager.sharedInstance.conversionHeight))
        
        createAccountLabel.frame = newFrame
        let tapToCreateAccount = UITapGestureRecognizer.init(target: self, action: #selector(pushCreateAccount))
        tapToCreateAccount.numberOfTapsRequired = 1
        createAccountLabel.userInteractionEnabled = true
        createAccountLabel.addGestureRecognizer(tapToCreateAccount)
        
        self.view.addSubview(createAccountLabel)
    }
    
    @objc private func pushCreateAccount() {
        
        //    ///////PRUEBA ELIMINAR////
        //
        //    let changePassController = ChangePasswordViewController()
        //    self.navigationController?.pushViewController(changePassController, animated: true)
        //
        //    //////PRUEBA ELIMINAR////
        
        let createAccountViewController = CreateAccountViewController()
        self.navigationController?.pushViewController(createAccountViewController, animated: true)
    }
    
    private func createGradientView() -> GradientView{
        
        let firstColorGradient = UIColor.init(red: 145.0/255.0, green: 255.0/255.0, blue: 171.0/255.0, alpha: 1.0)
        let secondColorGradient = UIColor.init(red: 117.0/255.0, green: 244.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        let colorsForBackground = [firstColorGradient,secondColorGradient]
        return GradientView.init(frame: UIScreen.mainScreen().bounds, arrayOfcolors: colorsForBackground, typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
        
    }
    
    override func didReceiveMemoryWarning() {
    }
    
    override func viewWillAppear(animated: Bool) {
      self.navigationController?.setNavigationBarHidden(true, animated: true)
      
      if isSecondOrMoreTimeToAppear == false {
        
        isSecondOrMoreTimeToAppear = true
        
      } else {
        
        loginGoldenPitchView.resetActionsAndAppearance()
        
      }
    }
    
    override func viewWillDisappear(animated: Bool) {
      
      super.viewWillDisappear(animated)
      NSNotificationCenter.defaultCenter().removeObserver(self)
      
    }
    
    @objc private func keyboardAppear(notification: NSNotification) {
        self.moveLoginGoldenPitchViewWhenKeyboardAppear()
    }
    
    @objc private func keyboardDisappear(notification: NSNotification) {
        self.moveLoginGoldenPitchViewWhenKeyboardDesappear()
    }
    
    private func moveLoginGoldenPitchViewWhenKeyboardAppear() {
        if alreadyAppearedKeyboard != true {
            self.lastFramePosition = loginGoldenPitchView.frame
            alreadyAppearedKeyboard = true
            UIView.animateWithDuration(0.5){
                let newFrame = CGRect.init(x: self.loginGoldenPitchView.frame.origin.x,
                                           y: self.loginGoldenPitchView.frame.origin.y - (185.0 * UtilityManager.sharedInstance.conversionHeight) ,
                                           width: self.loginGoldenPitchView.frame.size.width,
                                           height: self.loginGoldenPitchView.frame.size.height)
                self.loginGoldenPitchView.frame = newFrame
            }
        }
    }
    
    private func moveLoginGoldenPitchViewWhenKeyboardDesappear() {
        if alreadyAppearedKeyboard == true {
            alreadyAppearedKeyboard = false
            UIView.animateWithDuration(0.5){
                self.loginGoldenPitchView.frame = self.lastFramePosition
            }
        }
    }
    
    //MARK - GoldenPitchLoginViewDelegate
    func nextButtonPressedGoldenPitchLoginView(name: String, email: String) {
        
        let urlToRequest = "https://amap-dev.herokuapp.com/api/sessions"
        
        let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
        requestConnection.HTTPMethod = "POST"
        requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
        
        let values = [
            "user_session" :
                [ "email" : name,
                    "password" : email
            ]
        ]
        
        requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(values, options: [])
        
        Alamofire.request(requestConnection)
            .validate(statusCode: 200..<500)
            //      .response{
            //        (request, response, data, error) -> Void in
            //        print(response)
            ////          let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
            ////            print (json)
            ////          }
            
            .responseJSON{ response in
                if response.response?.statusCode == 200 {
                    
                  let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
                  
                  //print(json)
                  
                  let info_user_session = json["user"] as? [String: AnyObject]

                  if info_user_session != nil {
                    
                    let agency_id = info_user_session!["agency_id"] as? Int
                    let auth_token = info_user_session!["auth_token"] as? String
                    let email = info_user_session!["email"] as? String
                    let first_name = info_user_session!["first_name"] as? String
                    let id_user_int = info_user_session!["id"] as? Int
                    let id_user_string = String(id_user_int!)
                    let is_member_amap = info_user_session!["is_member_amap"] as? String
                    
                    var is_member_amap_bool: Bool
                    if is_member_amap == "0" {
                      is_member_amap_bool = false
                    }else{
                      is_member_amap_bool = true
                    }
                    
                    let last_name = info_user_session!["last_name"] as? String
                    let role_int = info_user_session!["role"] as? Int
                    let role_string = String(role_int)
                    
                    UserSession.session.agency_id = String(agency_id!)
                    UserSession.session.auth_token = auth_token!
                    UserSession.session.email = email!
                    UserSession.session.first_name = first_name!
                    UserSession.session.id = id_user_string
                    UserSession.session.is_member_amap = is_member_amap_bool
                    UserSession.session.last_name = last_name!
                    UserSession.session.role = role_string
                    
                    AgencyModel.Data.id = UserSession.session.agency_id!
                    RequestToServerManager.sharedInstance.requestForAgencyData(){
                      
                      self.initAndChangeRootToMainTabBarController()
                      
//                      let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//                      let rootMainTabScreen = MainTabBarController()
//                      
//                      appDelegate.window?.rootViewController = rootMainTabScreen
//                      appDelegate.window?.makeKeyAndVisible()
                      
//                      self.navigationController?.pushViewController(mainTabScreen, animated: true)

//                      let visualizeAgencyProfile = VisualizeAgencyProfileViewController()
//                      self.navigationController?.pushViewController(visualizeAgencyProfile, animated: true)
                      
//                      let editStuffAgency = EditAgencyProfileViewController()
//                      self.navigationController?.pushViewController(editStuffAgency, animated: true)
                    
                    }

                  } else {
                    
                    print("ERROR")
                    
                  }

                  
                  
                    
//                  let frameLabel = CGRect.init(x: 0.0,
//                                               y: 0.0,
//                                           width: self.view.frame.size.width,
//                                          height: self.view.frame.size.height / 2.0)
//                    
//                    let infoOfUser = UILabel.init(frame: frameLabel)
//                    infoOfUser.text = "Email: \(email!)"
//                    infoOfUser.numberOfLines = 10
//                    
//                    let blankVC = BlankViewController()
//                    blankVC.view.addSubview(infoOfUser)
                  
//                    self.navigationController?.pushViewController(blankVC, animated: true)
//                    self.loginGoldenPitchView.activateInteractionEnabledOfNextButton()
                  


                  
                } else {
                  
                        self.loginGoldenPitchView.activateInteractionEnabledOfNextButton()
                        if response.response?.statusCode == 422 {
                          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
                            let error = json["errors"] as? [String:AnyObject]
                            let stringError = error!["email"] as? [AnyObject]
                            let errorinString = stringError![0] as? String
                          if errorinString == "Email o password incorrecto" {
                            self.loginGoldenPitchView.showErrorFromLoginControllerLabel()
                          }
                          //print(json)
                        } else
                        if response.response?.statusCode == 500 { //error de servidor
                            self.loginGoldenPitchView.showErrorFromLoginControllerLabel()
                        }
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
  
    @objc private func dismissKeyboard() {
      
        self.loginGoldenPitchView.dismissKeyboard(self)
        
    }
    
    func textFieldSelected(sender: AnyObject) {
        self.moveLoginGoldenPitchViewWhenKeyboardAppear()
    }
    
    func goldenPitchLoginRequestWhenKeyboardDesappear(sender: AnyObject) {
        self.moveLoginGoldenPitchViewWhenKeyboardDesappear()
    }
    
    func forgotPasswordLabelInGoldenPtichLoginViewPressed(sender: AnyObject) {
        let changePasswordVC = ChangePasswordViewController()
        self.navigationController?.pushViewController(changePasswordVC, animated: true)
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
  
}
