//
//  CreateAccountViewController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/3/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit
import Alamofire

class CreateAccountViewController: UIViewController, CreateAccountViewDelegate, SuccessfullyAskForAccountViewDelegate, ExistingAccountViewDelegate, CreateAccountProcessAlreadyBegunViewDelegate {
  
  let kCreateAccount = "Crear Cuenta"
  
  private var flipCard:FlipCardView! = nil
  private var lastFramePosition: CGRect! = nil
  private var alreadyAppearKeyboard: Bool = false
  
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
    
 //   self.changeBackButtonItem()
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
    
    let createAccountView = CreateAccountView.init(frame: frameForViewsOfCard)
    createAccountView.delegate = self
    let blankView = UIView.init(frame:frameForViewsOfCard)
    
    flipCard = FlipCardView.init(frame: frameForFlipCard, viewOne: createAccountView, viewTwo: blankView)
    
    //PRUEBAS
    //let alreadyBegun = CreateAccountProcessAlreadyBegunView.init(frame: frameForFlipCard)

    
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
    
    self.popThisViewController()
    
  }
  
  private func popThisViewController() {
    
    self.navigationController?.popViewControllerAnimated(true)
    
  }
  
  @objc private func keyboardAppear(notification: NSNotification) {
    if alreadyAppearKeyboard != true {
      self.lastFramePosition = self.flipCard.frame
      alreadyAppearKeyboard = true
      UIView.animateWithDuration(0.5){
        let newFrame = CGRect.init(x: self.flipCard.frame.origin.x,
                                   y: self.flipCard.frame.origin.y - (200.0 * UtilityManager.sharedInstance.conversionHeight) ,
                               width: self.flipCard.frame.size.width,
                              height: self.flipCard.frame.size.height)
        self.flipCard.frame = newFrame
      }
    }
  }
  
  @objc private func keyboardDisappear(notification: NSNotification) {
    if alreadyAppearKeyboard == true {
      alreadyAppearKeyboard = false
      UIView.animateWithDuration(0.5){
        self.flipCard.frame = self.lastFramePosition
      }
    }
  }
  
  private func flipCardToSuccess() {
    let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
    let heightOfCard = self.view.frame.size.height - (184.0 * UtilityManager.sharedInstance.conversionHeight)
    let frameForViewsOfCard = CGRect.init(x: 0.0, y: 0.0, width: widthOfCard, height: heightOfCard)
    let successView = SuccessfullyAskForAccountView.init(frame: frameForViewsOfCard)
    successView.hidden = true
    successView.delegate = self
    
    flipCard.setSecondView(successView)
    flipCard.flip()
  }
  
  private func flipCardToFailedExistingAccount() {
    
    let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
    let heightOfCard = self.view.frame.size.height - (184.0 * UtilityManager.sharedInstance.conversionHeight)
    let frameForViewsOfCard = CGRect.init(x: 0.0, y: 0.0, width: widthOfCard, height: heightOfCard)
    let existingAccView = ExistingAccountView.init(frame: frameForViewsOfCard)
    existingAccView.hidden = true
    existingAccView.delegate = self
    
    flipCard.setSecondView(existingAccView)
    flipCard.flip()
    
  }
  
  private func flipCardFailedCreateAccountProcessAlreadyBegun() {
    
    let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
    let heightOfCard = self.view.frame.size.height - (184.0 * UtilityManager.sharedInstance.conversionHeight)
    let frameForViewsOfCard = CGRect.init(x: 0.0, y: 0.0, width: widthOfCard, height: heightOfCard)
    let createAccountAlreadyBegun = CreateAccountProcessAlreadyBegunView.init(frame: frameForViewsOfCard)
    createAccountAlreadyBegun.hidden = true
    createAccountAlreadyBegun.delegate = self
    
    flipCard.setSecondView(createAccountAlreadyBegun)
    flipCard.flip()
    
  }
  
  //MARK: - CreateAccountViewDelegate
  func requestCreateAccount(email: String, agency: String) {
    let urlToRequest2 = "https://amap-dev.herokuapp.com/api/new_user_requests"
    
    let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest2)!)
    requestConnection.HTTPMethod = "POST"
    requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
    requestConnection.setValue("Token 40e97aa81c2be2de4b99f1c243bec9c4", forHTTPHeaderField: "Authorization")
    
    let values = [
      "new_user_request" :
        [ "email" : email,
          "agency" : agency
      ]
    ]
    
    requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(values, options: [])
    
    Alamofire.request(requestConnection)
      .responseJSON{ response in
        if response.response?.statusCode >= 200 && response.response?.statusCode <= 300 {
          print("SUCCESS")

          self.flipCardToSuccess()

        }else if response.response?.statusCode == 422 {
          
          let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
          
          
          if let errors = json["errors"] as? [String: AnyObject] {
            
            if let emailError = errors["email"] as? String{
              
              if emailError == "Ya existe una cuenta con ese email" {
                self.flipCardToFailedExistingAccount()
              }else
                if emailError == "Ya existe una solicitud con ese email" {
                  self.flipCardFailedCreateAccountProcessAlreadyBegun()
              }
              
            }
            print(json)
          }

          
          
          
          
          
        }
    }
  }
  
  //MARK: - SuccessfullyAskForAccountViewDelegate
  func nextButtonPressedSuccessfullyAskForAccountView() {
    self.popThisViewController()
  }
  
  //MARK: - ExistingAccountViewDelegate
  func nextButtonPressedExistingAccountView() {
    self.popThisViewController()
  }
  
  //MARK: - CreateAccountProcessAlreadyBegunViewDelegate
  func nextButtonPressedCreateAccountProcessAlreadyBegun() {
    self.popThisViewController()
  }
  
}
