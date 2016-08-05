//
//  CreateAccountView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/3/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol CreateAccountViewDelegate{
  func requestCreateAccount(email:String, agency:String)
}

class CreateAccountView: UIView {
  
  private var createAccountLabel: UILabel! = nil
  private var agencyButton: UIButton! = nil
  private var brandButton: UIButton! = nil
  private var writeNameDescriptionLabel: UILabel! = nil
  private var nameLabel: UILabel! = nil
  private var writeEMailDescriptionLabel: UILabel! = nil
  private var eMailLabel: UILabel! = nil
  
  private var nameTextField: UITextField! = nil
  private var eMailTextField: UITextField! = nil
  
  private var cancelButtonForNameTextField: UIButton! = nil
  private var cancelButtonForEMailTextField: UIButton! = nil
  
  private var askPasswordButton: UIButton! = nil
  var delegate: CreateAccountViewDelegate?
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.initInterface()
  }
  
  private func initInterface() {
    self.backgroundColor = UIColor.whiteColor()
    
    self.addActions()
    self.createCreateAccountLabel()
    self.createWriteNameDescriptionLabel()
    self.createNameLabel()
    //self.createButton1
    self.createNameTextField()
    self.createWriteEMailDescriptionLabel()
    self.createEMailLabel()
    //self.createButton2
    self.createEMailTextField()
    self.createAskPasswordButton()
    
    //DELETE
//    self.testConnection()
    //DELETE
  }
  
  private func addActions() {
    
    let tapToDismissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                              action: #selector(dismissKeyboard))
    tapToDismissKeyboard.numberOfTapsRequired = 1
    self.addGestureRecognizer(tapToDismissKeyboard)
    
  }
  
  private func createCreateAccountLabel() {
    
    createAccountLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Ultralight", size: 30.0)
    let color = UIColor.init(red: 0.0/255.0, green: 64.0/255.0, blue: 89.0/255.0, alpha: 1.0)
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: CreateAccountConstants.CreateAccountView.createAccountText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    createAccountLabel.attributedText = stringWithFormat
    createAccountLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (createAccountLabel.frame.size.width / 2.0),
                               y: 30.0,
                               width: createAccountLabel.frame.size.width,
                               height: createAccountLabel.frame.size.height)
    
    createAccountLabel.frame = newFrame
    
    self.addSubview(createAccountLabel)
    
  }
  
  private func createWriteNameDescriptionLabel() {
    writeNameDescriptionLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Medium", size: 10.0)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: CreateAccountConstants.CreateAccountView.writeNameDescriptionText,
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    writeNameDescriptionLabel.attributedText = stringWithFormat
    writeNameDescriptionLabel.sizeToFit()
    let newFrame = CGRect.init(x: 38.0,
                               y: 210.0,
                               width: writeNameDescriptionLabel.frame.size.width,
                               height: writeNameDescriptionLabel.frame.size.height)
    
    writeNameDescriptionLabel.frame = newFrame
    
    self.addSubview(writeNameDescriptionLabel)
  }
  
  private func createNameLabel() {
    
    nameLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Regular", size: 14.0)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: CreateAccountConstants.CreateAccountView.nameText,
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    nameLabel.attributedText = stringWithFormat
    nameLabel.sizeToFit()
    let newFrame = CGRect.init(x: 48.0,
                               y: writeNameDescriptionLabel.frame.origin.y + writeNameDescriptionLabel.frame.size.height + 20.0,
                               width: nameLabel.frame.size.width,
                               height: nameLabel.frame.size.height)
    
    nameLabel.frame = newFrame
    
    self.addSubview(nameLabel)
    
  }
  
  private func createNameTextField() {
    let frameForTextField = CGRect.init(x: 38.0, y: nameLabel.frame.origin.y + nameLabel.frame.size.height + 5.0, width: 220.0, height: 25.0)
    
    nameTextField = UITextField.init(frame: frameForTextField)
    nameTextField.tag = 1
    
    let border = CALayer()
    let width = CGFloat(0.5)
    border.borderColor = UIColor.darkGrayColor().CGColor
    border.frame = CGRect(x: 0, y: nameTextField.frame.size.height - width, width:  nameTextField.frame.size.width, height: nameTextField.frame.size.height)
    
    border.borderWidth = width
    nameTextField.layer.addSublayer(border)
    nameTextField.layer.masksToBounds = true
    
    self.addSubview(nameTextField)
  }
  
  private func createWriteEMailDescriptionLabel() {
    
    writeEMailDescriptionLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Medium", size: 10.0)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: CreateAccountConstants.CreateAccountView.writeEMailDescriptioText,
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    writeEMailDescriptionLabel.attributedText = stringWithFormat
    writeEMailDescriptionLabel.sizeToFit()
    let newFrame = CGRect.init(x: 38.0,
                               y: nameLabel.frame.origin.y + nameLabel.frame.size.height + 51.0,
                               width: writeEMailDescriptionLabel.frame.size.width,
                               height: writeEMailDescriptionLabel.frame.size.height)
    
    writeEMailDescriptionLabel.frame = newFrame
    
    self.addSubview(writeEMailDescriptionLabel)
    
  }
  
  private func createEMailLabel() {
    
    eMailLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Regular", size: 14.0)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: CreateAccountConstants.CreateAccountView.emailText,
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    eMailLabel.attributedText = stringWithFormat
    eMailLabel.sizeToFit()
    let newFrame = CGRect.init(x: 48.0,
                               y: writeEMailDescriptionLabel.frame.origin.y + writeEMailDescriptionLabel.frame.size.height + 20.0,
                               width: eMailLabel.frame.size.width,
                               height: eMailLabel.frame.size.height)
    
    eMailLabel.frame = newFrame
    
    self.addSubview(eMailLabel)
    
  }
  
  private func createEMailTextField() {
    let frameForTextField = CGRect.init(x: 38.0, y: eMailLabel.frame.origin.y + eMailLabel.frame.size.height + 5.0, width: 220.0, height: 25.0)
    
    eMailTextField = UITextField.init(frame: frameForTextField)
    eMailTextField.tag = 2
    
    let border = CALayer()
    let width = CGFloat(0.5)
    border.borderColor = UIColor.darkGrayColor().CGColor
    border.frame = CGRect(x: 0, y: eMailTextField.frame.size.height - width, width:  eMailTextField.frame.size.width, height: eMailTextField.frame.size.height)
    
    border.borderWidth = width
    eMailTextField.layer.addSublayer(border)
    eMailTextField.layer.masksToBounds = true
    
    
    self.addSubview(eMailTextField)
  }
  
  private func createAskPasswordButton() {
    
    let font = UIFont(name: "SFUIDisplay-Light", size: 22.0)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center

    let stringWithFormat = NSMutableAttributedString(
      string: CreateAccountConstants.CreateAccountView.nextButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    let frameForButton = CGRect.init(x: 0.0, y: self.frame.size.height - 70.0, width: self.frame.size.width, height: 70.0)
    askPasswordButton = UIButton.init(frame: frameForButton)
    askPasswordButton.addTarget(self,
                                action: #selector(createAccount),
                      forControlEvents: .TouchUpInside)
    askPasswordButton.backgroundColor = UIColor.blackColor()
    askPasswordButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    
    self.addSubview(askPasswordButton)
    
  }
  
  //DELETE
  @objc private func createAccount() {
    self.delegate?.requestCreateAccount(eMailTextField.text!, agency: nameTextField.text!)
  }
  //DELETE
  
  @objc private func dismissKeyboard(sender:AnyObject) {
    self.endEditing(true)
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
  
  
  
}
