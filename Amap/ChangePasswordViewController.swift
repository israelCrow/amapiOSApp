//
//  ChangePasswordViewController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/4/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit
import Alamofire

class ChangePasswordViewController: UIViewController, ChangePasswordRequestViewDelegate, SuccessfullyAskForChangePasswordViewDelegate {
    
    let kCreateAccount = "Crea tu cuenta"
    
    private var flipCard:FlipCardView! = nil
    private var lastFramePosition: CGRect! = nil
    private var alreadyAppearedKeyboard: Bool = false
    private var changePasswordView: ChangePasswordRequestView! = nil
  
    var textToShowInEMailTextField: String = ""
  
    override func loadView() {
        
        self.addObserverToKeyboardNotification()
        self.editNavigationBar()
        
        self.view = UIView.init(frame: UIScreen.mainScreen().bounds)
        self.view.backgroundColor = UIColor.blackColor()
        
        self.view.addSubview(self.createGradientView())
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
    
    private func editNavigationBar() {
        
        self.navigationController?.navigationBarHidden = false
        
        self.changeBackButtonItem()
        self.changeNavigationBarTitle()
        
    }
    
    private func changeBackButtonItem() {
        
//        let imageBackButton = UIImage.init(named: "backButton")?.imageWithRenderingMode(.AlwaysOriginal)
//        
//        let backButton = UIBarButtonItem.init(image: imageBackButton,
//                                              style: .Plain,
//                                              target: self,
//                                              action: #selector(backButtonPressed)
//        )
//        
//        self.navigationItem.setLeftBarButtonItem(backButton, animated: false)
      
      let backButton = UIBarButtonItem(title: VisualizePitchesConstants.CreateAddNewPitchAndWriteBrandNameViewController.navigationLeftButtonText,
                                       style: UIBarButtonItemStyle.Plain,
                                       target: self,
                                       action: #selector(backButtonPressed))
      
      let fontForButtonItem =  UIFont(name: "SFUIText-Regular",
                                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
      
      let attributesDict: [String:AnyObject] = [NSFontAttributeName: fontForButtonItem!,
                                                NSForegroundColorAttributeName: UIColor.whiteColor()
      ]
      
      backButton.setTitleTextAttributes(attributesDict, forState: .Normal)
      
      self.navigationItem.leftBarButtonItem = backButton
      
    }
    
    private func changeNavigationBarTitle() {
        let titleLabel = UILabel.init(frame: CGRectZero)
        
        let font = UIFont(name: "SFUIText-Regular",
                          size: 17.0 * UtilityManager.sharedInstance.conversionWidth)
        let color = UIColor.whiteColor()
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.Center
        
        let stringWithFormat = NSMutableAttributedString(
            string: kCreateAccount,
            attributes:[NSFontAttributeName:font!,
                NSParagraphStyleAttributeName:style,
                NSForegroundColorAttributeName:color
            ]
        )
        titleLabel.attributedText = stringWithFormat
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
        
    }
    
    override func viewDidLoad() {
        
        self.createTapGestureForDismissKeyboard()
        self.createAndAddFlipCard()
        
    }
    
    private func createTapGestureForDismissKeyboard() {
        
        let tapForHideKeyboard = UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyboard))
        tapForHideKeyboard.numberOfTapsRequired = 1
        
        self.view.addGestureRecognizer(tapForHideKeyboard)
        
    }
    
    private func createAndAddFlipCard() {
        
        let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
        let heightOfCard = self.view.frame.size.height - (184.0 * UtilityManager.sharedInstance.conversionHeight)
        
        let frameForFlipCard = CGRect.init(x: (40.0 * UtilityManager.sharedInstance.conversionWidth),
                                           y: (100.0 * UtilityManager.sharedInstance.conversionHeight),
                                           width: widthOfCard,
                                           height: heightOfCard)
        
        let frameForViewsOfCard = CGRect.init(x: 0.0, y: 0.0, width: widthOfCard, height: heightOfCard)
        
        
        changePasswordView = ChangePasswordRequestView.init(frame: frameForViewsOfCard)
        changePasswordView.delegate = self
        changePasswordView.changeTextInEMailTextField(textToShowInEMailTextField)
        let blankView = UIView.init(frame:frameForViewsOfCard)
        
        flipCard = FlipCardView.init(frame: frameForFlipCard, viewOne: changePasswordView, viewTwo: blankView)
        
        self.view.addSubview(flipCard)
        
    }
    
    private func createGradientView() -> GradientView{
        
        let frameForView = CGRect.init(x: 0.0, y: 60.0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height - 60.0)
        
        let firstColorGradient = UIColor.init(red: 145.0/255.0, green: 255.0/255.0, blue: 171.0/255.0, alpha: 1.0)
        let secondColorGradient = UIColor.init(red: 117.0/255.0, green: 244.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        let colorsForBackground = [firstColorGradient,secondColorGradient]
        return GradientView.init(frame: frameForView, arrayOfcolors: colorsForBackground, typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
        
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    @objc private func backButtonPressed() {
        
        self.removeThisViewController()
        
    }
    
    @objc private func keyboardAppear(notification: NSNotification) {
        self.moveFlipCardWhenKeyboardAppear()
    }
    
    @objc private func keyboardDisappear(notification: NSNotification) {
        self.moveFlipCardWhenKeyboardDesappear()
    }
    
    private func moveFlipCardWhenKeyboardAppear() {
        if alreadyAppearedKeyboard != true {
            self.lastFramePosition = flipCard.frame
            alreadyAppearedKeyboard = true
            UIView.animateWithDuration(0.5){
                let newFrame = CGRect.init(x: self.flipCard.frame.origin.x,
                                           y: self.flipCard.frame.origin.y - (185.0 * UtilityManager.sharedInstance.conversionHeight) ,
                                           width: self.flipCard.frame.size.width,
                                           height: self.flipCard.frame.size.height)
                self.flipCard.frame = newFrame
            }
        }
    }
    
    private func moveFlipCardWhenKeyboardDesappear() {
        if alreadyAppearedKeyboard == true {
            alreadyAppearedKeyboard = false
            UIView.animateWithDuration(0.5){
                self.flipCard.frame = self.lastFramePosition
            }
        }
    }
    
    private func removeThisViewController() {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    //MARK - ChangePasswordRequestViewDelegate
    func changePasswordRequestViewWhenKeyboardDesappear(sender: AnyObject) {
        self.moveFlipCardWhenKeyboardDesappear()
    }
    
  func requestChangePassword(email: String, actionToMakeWhenFailed: () -> Void) {
    
        UtilityManager.sharedInstance.showLoader()
    
        let urlToRequest = "\(RequestToServerManager.sharedInstance.typeOfServer)/users/send_password_reset"
        
        let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
        requestConnection.HTTPMethod = "POST"
        requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requestConnection.setValue(UtilityManager.sharedInstance.apiToken, forHTTPHeaderField: "Authorization")
        
        let values = ["email" : email]
        
        requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(values, options: [])
        
        Alamofire.request(requestConnection)
            .validate(statusCode: 200..<300)
            //      .response{
            //        (request, response, data, error) -> Void in
            //        print(response)
            ////          let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
            ////            print (json)
            ////          }
            .responseJSON{ response in
              
              if response.data != nil {
                
                do {
                
                  let json = try NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
                
                  let answer = json["success"] as? String
                  //        let error = json["errors"] as? String
                  if answer == "Se ha enviado un correo con instrucciones para restablecer contraseña" {
                    
                    UtilityManager.sharedInstance.hideLoader()
                    self.flipCardToSuccess()
                    
                  } else {
                    
                    let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
                    let error = json["errors"] as? [String:AnyObject]
                    let stringError = error!["email"] as? [AnyObject]
                    let errorinString = stringError![0] as? String
                    
                    if errorinString == "No existe ningún usuario con ese email" {
                      self.changePasswordView.showErrorFromServerNotExistingUserLabel()
                    }
                    
                    actionToMakeWhenFailed()
                    UtilityManager.sharedInstance.hideLoader()
                    
                  }
                  
                }	catch(_) {
                  
                  UtilityManager.sharedInstance.hideLoader()
                  
                  let alertController = UIAlertController(title: "ERROR",
                    message: "Error de conexión con el servidor, favor de intentar más tarde",
                    preferredStyle: UIAlertControllerStyle.Alert)
                  
                  let cancelAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
                    
                    actionToMakeWhenFailed()
                    
                  }
                  
                  alertController.addAction(cancelAction)
                  self.presentViewController(alertController, animated: true, completion: nil)
                  
//                  actionToMakeWhenFailed()
//                  UtilityManager.sharedInstance.hideLoader()
                  
                }
                
              } else {
                
                actionToMakeWhenFailed()
                UtilityManager.sharedInstance.hideLoader()
                
              }
              
//                let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
//
//                let answer = json["success"] as? String
//                //        let error = json["errors"] as? String
//                if answer == "Se ha enviado un correo con instrucciones para restablecer contraseña" {
//                
//                    UtilityManager.sharedInstance.hideLoader()
//                    self.flipCardToSuccess()
//                  
//                } else {
//                  
//                    let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
//                    let error = json["errors"] as? [String:AnyObject]
//                    let stringError = error!["email"] as? [AnyObject]
//                    let errorinString = stringError![0] as? String
//                  
//                    if errorinString == "No existe ningún usuario con ese email" {
//                        self.changePasswordView.showErrorFromServerNotExistingUserLabel()
//                    }
//                  
//                    actionToMakeWhenFailed()
//                    UtilityManager.sharedInstance.hideLoader()
//                  
//                }
              
        }
     }
    
    private func flipCardToSuccess() {
        let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
        let heightOfCard = self.view.frame.size.height - (184.0 * UtilityManager.sharedInstance.conversionHeight)
        let frameForViewsOfCard = CGRect.init(x: 0.0, y: 0.0, width: widthOfCard, height: heightOfCard)
        
        let successRequestChangePassword = SuccessfullyAskForChangePasswordView.init(frame: frameForViewsOfCard)
        successRequestChangePassword.hidden = true
        successRequestChangePassword.delegate = self
        
        flipCard.setSecondView(successRequestChangePassword)
        flipCard.flip()
    }
    
    @objc private func dismissKeyboard() {
        
        changePasswordView.dismissKeyboard(self)
        
    }
    
    //MARK - SuccessfullyAskForChangePasswordViewDelegate
    func nextButtonPressedSuccessfullyRequestForChangePasswordView() {
        self.removeThisViewController()
    }
    
    
}