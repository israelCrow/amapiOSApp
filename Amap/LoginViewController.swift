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
    
  let kCreateAccountText = "¿Cómo? ¿No estás registrado? Crea una cuenta ahora"
    
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
        stringWithFormat.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: NSMakeRange(29, 21))
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
      
      UIView.setAnimationsEnabled(true)
      
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
      
      UtilityManager.sharedInstance.showLoader()
        
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
//                  .response{
//                    (request, response, data, error) -> Void in
//                    print(response)
//            //          let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
//            //            print (json)
//            //          }
          
            .responseJSON{ response in
                if response.response?.statusCode == 200 {
                  
                  
                  NSUserDefaults.standardUserDefaults().setObject(name, forKey: UtilityManager.sharedInstance.kLastValidUserEmail)
                  NSUserDefaults.standardUserDefaults().setObject(email, forKey: UtilityManager.sharedInstance.kLastValidUserPassword)

                  let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
                  
                  //print(json)
                    
                  let agency_id = (json["agency_id"] as? Int != nil ? json["agency_id"] as! Int : -1)
                  let company_id = (json["company_id"] as? Int != nil ? json["company_id"] as! Int : -1)
                  let auth_token = (json["auth_token"] as? String != nil ? json["auth_token"] as! String : "")
                  let email = (json["email"] as? String != nil ? json["email"] as! String : "")
                  let first_name = (json["first_name"] as? String != nil ? json["first_name"] as! String : "")
                  let id_user_int = (json["id"] as? Int != nil ? json["id"] as! Int : -1)
                  let id_user_string = String(id_user_int)
                  let is_member_amap = (json["is_member_amap"] as? String != nil ? json["is_member_amap"] as! String : "0")
                  
                  var is_member_amap_bool: Bool
                  if is_member_amap == "0" {
                    is_member_amap_bool = false
                  }else{
                    is_member_amap_bool = true
                  }
                    
                  let last_name = (json["last_name"] as? String != nil ? json["last_name"] as! String : "")
                  let role_int = (json["role"] as? Int != nil ? json["role"] as! Int : -1)
                  let role_string = String(role_int)
                  
                  if agency_id != -1 {
                      
                    UserSession.session.agency_id = String(agency_id)
                    AgencyModel.Data.id = UserSession.session.agency_id!
                      
                  } else
                    if company_id != -1 {
                        
                      UserSession.session.company_id = String(company_id)
                      MyCompanyModelData.Data.id = String(company_id)
                      
                  }

                  UserSession.session.auth_token = auth_token
                  UserSession.session.email = email
                  UserSession.session.first_name = first_name
                  UserSession.session.id = id_user_string
                  UserSession.session.is_member_amap = is_member_amap_bool
                  UserSession.session.last_name = last_name
                  UserSession.session.role = role_string
                  
                  if UserSession.session.role == "2" {
                    
                    RequestToServerManager.sharedInstance.requestForAgencyData(){
                      
                      UtilityManager.sharedInstance.hideLoader()
                      
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
                    
                  }else
                    if UserSession.session.role == "4" {
                      
                      RequestToServerManager.sharedInstance.requestForCompanyData({
                        
                        UtilityManager.sharedInstance.hideLoader()
                        
                        self.initAndChangeRootToMainTabBarController()
                        
                      })
                      
                    }
                  

                  
                } else {
                  
                        UtilityManager.sharedInstance.hideLoader()
                        self.loginGoldenPitchView.activateInteractionEnabledOfNextButton()
                        if response.response?.statusCode == 422 {
                          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
                            let error = json["errors"] as? [String:AnyObject]
                            let stringError = error!["email"] as? [AnyObject]
                            let errorinString = stringError![0] as? String
                          if errorinString == "Email o password incorrecto" {
                            self.loginGoldenPitchView.showErrorFromLoginControllerLabel()
                          } else {
                            print("SERVER ERROR -- \(json)")
                          }
                        } else
                        if response.response?.statusCode == 500 { //error de servidor
                            self.loginGoldenPitchView.showErrorFromLoginControllerLabel()
                          print("SERVER ERROR: 500 -- \(response)")
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
    
    if UserSession.session.role == "2" {
      
      arrayOfViewControllers.append(self.createFirstBarItem())
      arrayOfViewControllers.append(self.createSecondBarItem())
      arrayOfViewControllers.append(self.createThirdBarItem())
      
      mainTabBarController.viewControllers = arrayOfViewControllers
      let notToShowPitchesTutorial = NSUserDefaults.standardUserDefaults().boolForKey(UtilityManager.sharedInstance.kNotToShowProfileTutorial + UserSession.session.email)
      
      if notToShowPitchesTutorial == false {
        
        mainTabBarController.selectedIndex = 2
        
      } else {
        
        mainTabBarController.selectedIndex = 1
        
      }
      
      UtilityManager.sharedInstance.mainTabBarController = mainTabBarController
      
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
      
    } else
    
      if UserSession.session.role == "4" {
        
        arrayOfViewControllers.append(self.createSecondBarItemForNormalUser())
        arrayOfViewControllers.append(self.createFourthBarItemForNormalUser())
        
        mainTabBarController.viewControllers = arrayOfViewControllers
//        let notToShowPitchesTutorial = NSUserDefaults.standardUserDefaults().boolForKey(UtilityManager.sharedInstance.kNotToShowProfileTutorial + UserSession.session.email)
//        
//        if notToShowPitchesTutorial == false {
//          
//          mainTabBarController.selectedIndex = 2
//          
//        } else {
//          
//          mainTabBarController.selectedIndex = 1
//          
//        }
        
        UtilityManager.sharedInstance.mainTabBarController = mainTabBarController
        
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
    
    let dashBoard = VisualizeMainCardsDashboardViewController()
    
    let tabOneBarItem = UITabBarItem.init(title: AgencyProfileVisualizeConstants.TabBarView.dashBoardButtonText,
                                          image: imageDashboardNonSelected,
                                          selectedImage: imageDashboardSelected)
    
    let newNavController = UINavigationController.init(rootViewController: dashBoard)
    
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
  
  private func createSecondBarItemForNormalUser() -> UINavigationController  { //CHECAR AQUI
    
    let imagePitchesNonSelected = UIImage.init(named: "iconPitchesMedium")
    let imagePitchesSelected = UIImage.init(named: "iconPitchesWhite")
    
    let visualizeAllPitchesForNormalClient = VisualizeAllPitchesForNormalClientViewController()
    //    visualizeAllPitchesForNormalClient.delegateForShowAndHideTabBar = mainTabBarController
    let tabTwoBarItem = UITabBarItem.init(title: AgencyProfileVisualizeConstants.TabBarView.pitchesButtonText,
                                          image: imagePitchesNonSelected,
                                          selectedImage: imagePitchesSelected)
    
    let newNavController = UINavigationController.init(rootViewController: visualizeAllPitchesForNormalClient)
    
    tabTwoBarItem.tag = 2
    newNavController.tabBarItem = tabTwoBarItem
    newNavController.navigationBar.barStyle = .Black
    
    return newNavController
    
  }
  
  private func createFourthBarItemForNormalUser() -> UINavigationController  { //CHECAR AQUI
    
    let imageAgencyProfileNonSelected = UIImage.init(named: "iconAgencyMedium")
    let imageAgencyProfileSelected = UIImage.init(named: "iconAgencyWhite")
    
    let visualizeCompanyProfileController = VisualizeCompanyProfileViewController()
    visualizeCompanyProfileController.delegate = mainTabBarController
    let tabFourthBarItem = UITabBarItem.init(title: "Perfil Marca",
                                             image: imageAgencyProfileNonSelected,
                                             selectedImage: imageAgencyProfileSelected)
    
    let newNavController = UINavigationController.init(rootViewController: visualizeCompanyProfileController)
    
    tabFourthBarItem.tag = 4
    newNavController.tabBarItem = tabFourthBarItem
    newNavController.navigationBar.barStyle = .Black
    
    return newNavController
    
  }

  
}
