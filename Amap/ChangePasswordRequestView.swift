//
//  ChangePasswordRequestView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/4/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol  ChangePasswordRequestViewDelegate {
  func requestChangePassword(email: String)
  func changePasswordRequestViewWhenKeyboardDesappear(sender: AnyObject)
}

class ChangePasswordRequestView: UIView {
  
  private var goldenPitchStarImageView: UIImageView! = nil
  
  private var goldenPitchLabel: UILabel! = nil
  private var amapLabel: UILabel! = nil
  private var messageLabel: UILabel! = nil
  private var writeEMailDescriptionLabel: UILabel! = nil
  private var eMailLabel: UILabel! = nil
  private var errorEMailLabel: UILabel! = nil
  private var nextButton: UIButton! = nil
  
  private var eMailTextField: UITextField! = nil
  
  var delegate: ChangePasswordRequestViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.initInterface()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    self.addActions()
    self.createGoldenPitchStar()
    self.createGoldenPitchTitleLabel()
    self.createAmapLabel()
    self.createMessageLabel()
    self.createWriteEMailDescriptionLabel()
//    self.createEMailLabel()
    self.createEMailTextField()
    self.createErrorEMailLabel()
//    self.createButton1
    self.createNextButton()
    
  }
  
  private func addActions() {
    
    let tapToDismissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                              action: #selector(dismissKeyboard))
    tapToDismissKeyboard.numberOfTapsRequired = 1
    self.addGestureRecognizer(tapToDismissKeyboard)
    
  }
  
  private func createGoldenPitchStar() {
    goldenPitchStarImageView = UIImageView.init(image: UIImage.init(named: "goldenPitch_star"))
    let goldenPitchStarFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (goldenPitchStarImageView.frame.size.width / 2.0),
                                           y: (30.0 * UtilityManager.sharedInstance.conversionHeight),
                                       width: goldenPitchStarImageView.frame.size.width,
                                      height: goldenPitchStarImageView.frame.size.height)
    goldenPitchStarImageView.frame = goldenPitchStarFrame
    
    self.addSubview(goldenPitchStarImageView)
  }
  
  private func createGoldenPitchTitleLabel() {
    goldenPitchLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Semibold",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.init(red: 0.0/255.0, green: 64.0/255.0, blue: 89.0/255.0, alpha: 1.0)
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: ChangePasswordRequestConstants.ChangePasswordRequestView.goldenPitchTitleText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(4.0),
        NSForegroundColorAttributeName: color
      ]
    )
    goldenPitchLabel.attributedText = stringWithFormat
    goldenPitchLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (goldenPitchLabel.frame.size.width / 2.0),
                               y: goldenPitchStarImageView.frame.origin.y + goldenPitchStarImageView.frame.size.height + (10.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: goldenPitchLabel.frame.size.width,
                               height: goldenPitchLabel.frame.size.height)
    
    goldenPitchLabel.frame = newFrame
    
    self.addSubview(goldenPitchLabel)
  }
  
  private func createAmapLabel() {
    amapLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Regular",
                      size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.init(red: 0.0/255.0, green: 64.0/255.0, blue: 89.0/255.0, alpha: 1.0)
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: ChangePasswordRequestConstants.ChangePasswordRequestView.amapText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(4.0),
        NSForegroundColorAttributeName: color
      ]
    )
    amapLabel.attributedText = stringWithFormat
    amapLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (amapLabel.frame.size.width / 2.0),
                               y: goldenPitchStarImageView.frame.origin.y + goldenPitchStarImageView.frame.size.height + (31.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: amapLabel.frame.size.width,
                               height: amapLabel.frame.size.height)
    
    amapLabel.frame = newFrame
    
    self.addSubview(amapLabel)
  }
  
  private func createMessageLabel() {
    messageLabel = UILabel.init(frame: CGRect.init(x: 0.0, y: 0.0, width: self.frame.size.width - (63.0 * UtilityManager.sharedInstance.conversionWidth), height: 0.0))
    messageLabel.adjustsFontSizeToFitWidth = true
    messageLabel.numberOfLines = 5
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: ChangePasswordRequestConstants.ChangePasswordRequestView.messageText ,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(1.0),
        NSForegroundColorAttributeName: color
      ]
    )
    messageLabel.attributedText = stringWithFormat
    messageLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (messageLabel.frame.size.width / 2.0),
                               y: amapLabel.frame.origin.y + amapLabel.frame.size.height + (31.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: messageLabel.frame.size.width,
                               height: messageLabel.frame.size.height)
    
    messageLabel.frame = newFrame
    
    self.addSubview(messageLabel)
  }
  
  private func createWriteEMailDescriptionLabel() {
    
    writeEMailDescriptionLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Medium",
                      size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: ChangePasswordRequestConstants.ChangePasswordRequestView.writeEMailDescriptioText,
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    writeEMailDescriptionLabel.attributedText = stringWithFormat
    writeEMailDescriptionLabel.sizeToFit()
    let newFrame = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: messageLabel.frame.origin.y + messageLabel.frame.size.height + (29.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: writeEMailDescriptionLabel.frame.size.width,
                               height: writeEMailDescriptionLabel.frame.size.height)
    
    writeEMailDescriptionLabel.frame = newFrame
    
    self.addSubview(writeEMailDescriptionLabel)
    
  }
  
  private func createEMailLabel() {
    
    eMailLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: ChangePasswordRequestConstants.ChangePasswordRequestView.emailText,
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    eMailLabel.attributedText = stringWithFormat
    eMailLabel.sizeToFit()
    let newFrame = CGRect.init(x: 48.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: writeEMailDescriptionLabel.frame.origin.y + writeEMailDescriptionLabel.frame.size.height + (10.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: eMailLabel.frame.size.width,
                               height: eMailLabel.frame.size.height)
    
    eMailLabel.frame = newFrame
    
    self.addSubview(eMailLabel)
    
  }
  
  private func createEMailTextField() {
    let frameForTextField = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                        y: writeEMailDescriptionLabel.frame.origin.y + writeEMailDescriptionLabel.frame.size.height + (5.0 * UtilityManager.sharedInstance.conversionHeight),
                                    width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 25.0 * UtilityManager.sharedInstance.conversionHeight)
    
    eMailTextField = UITextField.init(frame: frameForTextField)
    eMailTextField.placeholder = "jen@ejemplo.com"
    
    let border = CALayer()
    let width = CGFloat(0.5)
    border.borderColor = UIColor.darkGrayColor().CGColor
    border.frame = CGRect(x: 0,
                          y: eMailTextField.frame.size.height - width,
                      width: eMailTextField.frame.size.width,
                     height: eMailTextField.frame.size.height)
    
    border.borderWidth = width
    eMailTextField.layer.addSublayer(border)
    eMailTextField.layer.masksToBounds = true
    
    
    self.addSubview(eMailTextField)
  }
  
  private func createErrorEMailLabel() {
    
    errorEMailLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 11.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.redColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Formato de mail incorrecto",
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    
    errorEMailLabel.attributedText = stringWithFormat
    errorEMailLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (errorEMailLabel.frame.size.width / 2.0),
                               y: eMailTextField.frame.origin.y + eMailTextField.frame.size.height + (3.0 * UtilityManager.sharedInstance.conversionHeight),
                           width: errorEMailLabel.frame.size.width,
                          height: errorEMailLabel.frame.size.height)
    
    errorEMailLabel.frame = newFrame
    errorEMailLabel.alpha = 0.0
    self.addSubview(errorEMailLabel)
    
  }
  
  private func createNextButton() {
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let colorWhenPressed = UIColor.greenColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: ChangePasswordRequestConstants.ChangePasswordRequestView.nextButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    let stringWithFormatWhenpressed = NSMutableAttributedString(
      string: ChangePasswordRequestConstants.ChangePasswordRequestView.nextButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: colorWhenPressed
      ]
    )
    
    let frameForButton = CGRect.init(x: 0.0,
                                     y: self.frame.size.height - (70.0 * UtilityManager.sharedInstance.conversionHeight),
                                 width: self.frame.size.width,
                                height: (70.0 * UtilityManager.sharedInstance.conversionHeight))
    nextButton = UIButton.init(frame: frameForButton)
    nextButton.addTarget(self,
                         action: #selector(requestChangePasswordButtonPressed),
                         forControlEvents: .TouchUpInside)
    nextButton.backgroundColor = UIColor.blackColor()
    nextButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    nextButton.setAttributedTitle(stringWithFormatWhenpressed, forState: .Highlighted)
    
    self.addSubview(nextButton)
    
  }
  
  @objc private func dismissKeyboard(sender:AnyObject) {
    self.endEditing(true)
  }
  
  @objc private func requestChangePasswordButtonPressed() {
    
    let validEMail = UtilityManager.sharedInstance.isValidEmail(eMailTextField.text!)
    let validText = UtilityManager.sharedInstance.isValidText(eMailTextField.text!)
    
    if validEMail == true && validText == true {
      self.delegate?.requestChangePassword(eMailTextField.text!)
      self.dismissKeyboard(eMailTextField)
      self.delegate?.changePasswordRequestViewWhenKeyboardDesappear(self)
    }else{
      self.showValidMailError()
    }
  }
  
  private func showValidMailError() {
    
    nextButton.userInteractionEnabled = false
    UIView.animateWithDuration(0.4,
                               animations: {
                                self.errorEMailLabel.alpha = 1.0
    }) { (finished) in
      if finished {
        self.hideErrorMailLabel()
      }
    }
    
  }
  
  @objc private func hideErrorMailLabel() {
    
    UIView.animateWithDuration(1.0, animations: {
      self.errorEMailLabel.alpha = 0.0
    }) { (finished) in
      if finished {
        self.nextButton.userInteractionEnabled = true
      }
    }
  }
  
}