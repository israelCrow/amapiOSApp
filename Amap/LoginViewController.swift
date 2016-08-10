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
    
    override func loadView() {
        self.view = self.createGradientView()
    }
    
    override func viewDidLoad() {
        
        self.addObserverToKeyboardNotification()
        self.createFlipCardView()
        self.addCreateAccountLabel()
        
        //DELETE
        //self.testConnection()
        //DELETE
        
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
                NSForegroundColorAttributeName: color
            ]
        )
        createAccountLabel.attributedText = stringWithFormat
        createAccountLabel.sizeToFit()
        let newFrame = CGRect.init(x: (self.view.frame.size.width / 2.0) - (createAccountLabel.frame.size.width / 2.0),
                                   y: self.loginGoldenPitchView.frame.origin.y + self.loginGoldenPitchView.frame.size.height + (17.0  * UtilityManager.sharedInstance.conversionHeight),
                                   width: createAccountLabel.frame.size.width,
                                   height: createAccountLabel.frame.size.height)
        
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
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //DELETE
    @objc private func testConnection(){
        //GET TEST
        //let urlToRequest = "http://amap-dev.herokuapp.com/api/users"
        
        //POST TEST
        let urlToRequest2 = "https://amap-dev.herokuapp.com/api/new_user_requests"
        
        let requestConnection = NSMutableURLRequest(URL: NSURL.init(string: urlToRequest2)!)
        requestConnection.HTTPMethod = "POST"
        requestConnection.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requestConnection.setValue("Token 40e97aa81c2be2de4b99f1c243bec9c4", forHTTPHeaderField: "Authorization")
        
        let rawValues = [
            "new_user_request" :
                [
                    "email" : "isrel",
                    "agency" : "Pequeño Cuervo"
            ]
        ]
        
        requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(rawValues, options: [])
        
        Alamofire.request(requestConnection)
            .validate(statusCode: 200..<300)
            //      .response{
            //        (request, response, data, error) -> Void in
            //
            //        let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
            //        print (json)
            //      }
            .responseJSON{ response in
                //      if response.response?.statusCode == 200 {
                //        print("SUCCESS")
                //      }
                let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
                print (json)
                
                print("\(response.response) \n\n\(response.response?.statusCode)")
                
        }
    }
    //DELETE
    
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
        requestConnection.setValue("Token 40e97aa81c2be2de4b99f1c243bec9c4", forHTTPHeaderField: "Authorization")
        
        let values = [
            "user_session" :
                [ "email" : name,
                    "password" : email
            ]
        ]
        
        requestConnection.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(values, options: [])
        
        Alamofire.request(requestConnection)
            .validate(statusCode: 200..<450)
            //      .response{
            //        (request, response, data, error) -> Void in
            //        print(response)
            ////          let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
            ////            print (json)
            ////          }
            
            .responseJSON{ response in
                if response.response?.statusCode == 200 {
                    
                    let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
                    let info = json["user"] as? [String: AnyObject]
                    let name = info!["first_name"] as? String
                    let lastName = info!["last_name"] as? String
                    let email = info!["email"] as? String
                    
                    let frameLabel = CGRect.init(x: 0.0,
                        y: 0.0,
                        width: self.view.frame.size.width,
                        height: self.view.frame.size.height / 2.0)
                    
                    let infoOfUser = UILabel.init(frame: frameLabel)
                    infoOfUser.text = "Nombre: \(name!)\nApellido: \(lastName!)\nEmail: \(email!)"
                    infoOfUser.numberOfLines = 10
                    
                    
                    let blankVC = BlankViewController()
                    blankVC.view.addSubview(infoOfUser)
                    
                    self.navigationController?.pushViewController(blankVC, animated: true)
                } else
                    if response.response?.statusCode == 422 {
                        let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
                        let stringError = json["errors"] as? String
                        if stringError == "Email o password incorrecto" {
                            self.loginGoldenPitchView.showErrorFromLoginControllerLabel()
                        }
                        //print(json)
                }
                
                
                
                //        let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
                //        print (json)
                //        
                //        print("\(response.response) \n\n\(response.response?.statusCode)")
        }
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
    
}
