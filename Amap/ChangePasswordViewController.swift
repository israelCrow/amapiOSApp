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
  
  let kCreateAccount = "Crear Cuenta"
  
  private var flipCard:FlipCardView! = nil
  private var lastFramePosition: CGRect! = nil
  private var alreadyAppearedKeyboard: Bool = false
  
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
    let imageBackButton = UIImage.init(named: "backButton")
    let backButton = UIBarButtonItem.init(image: imageBackButton,
                                          style: .Plain,
                                          target: self,
                                          action: #selector(backButtonPressed)
    )
    self.navigationItem.setLeftBarButtonItem(backButton, animated: false)
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
    
    let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
    let heightOfCard = self.view.frame.size.height - (184.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let frameForFlipCard = CGRect.init(x: (40.0 * UtilityManager.sharedInstance.conversionWidth),
                                       y: (100.0 * UtilityManager.sharedInstance.conversionHeight),
                                       width: widthOfCard,
                                       height: heightOfCard)
    
    let frameForViewsOfCard = CGRect.init(x: 0.0, y: 0.0, width: widthOfCard, height: heightOfCard)
    
    
    let changePasswordView = ChangePasswordRequestView.init(frame: frameForViewsOfCard)
    changePasswordView.delegate = self
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
    
    self.navigationController?.popViewControllerAnimated(true)
    
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
  
  //MARK - ChangePasswordRequestViewDelegate
  func changePasswordRequestViewWhenKeyboardDesappear(sender: AnyObject) {
    self.moveFlipCardWhenKeyboardDesappear()
  }
  
  func requestChangePassword(email: String) {
    
    let urlToRequest = "https://amap-dev.herokuapp.com/api/users/send_password_reset"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue("Token 40e97aa81c2be2de4b99f1c243bec9c4", forHTTPHeaderField: "Authorization")
    
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
        let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
        print (json)
        let answer = json["success"] as? String
//        let error = json["errors"] as? String
        if answer == "Se ha enviado un correo con instrucciones para restablecer contraseña" {
          print(answer)
          self.flipCardToSuccess()
        }
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
  
  //MARK - SuccessfullyAskForChangePasswordViewDelegate
  func nextButtonPressedSuccessfullyRequestForChangePasswordView() {
    self.flipCardToSuccess()
  }
  
  
}