//
//  GoldenPitchLoginView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/2/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class GoldenPitchLoginView: UIView {
  
  private var goldenPitchStarImageView: UIImageView! = nil
  
  private var goldenPitchLabel: UILabel! = nil
  private var amapLabel: UILabel! = nil
  private var writeNameDescriptionLabel: UILabel! = nil
  private var nameLabel: UILabel! = nil
  private var writeEMailDescriptionLabel: UILabel! = nil
  private var eMailLabel: UILabel! = nil
  private var forgotPasswordLabel: UILabel! = nil
  private var invalidUser:UILabel! = nil
  private var errorEMailLabel: UILabel! = nil
  private var errorNameLabel: UILabel! = nil
  private var errorBothTextFieldLabel: UILabel! = nil
  
  private var nameTextField: UITextField! = nil
  private var eMailTextField: UITextField! = nil
  
  private var cancelButtonForNameTextField: UIButton! = nil
  private var cancelButtonForEMailTextField: UIButton! = nil
  
  private var nextButton: UIButton! = nil
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.initInterface()
  }
  
  private func initInterface() {

    self.backgroundColor = UIColor.whiteColor()
    self.addActions()
    self.adaptMyself()
    self.createGoldenPitchStar()
    self.createGoldenPitchTitleLabel()
    self.createAmapLabel()
    self.createWriteNameDescriptionLabel()
    self.createNameLabel()
    self.createNameTextField()
    self.createWriteEMailDescriptionLabel()
    self.createEMailLabel()
    self.createEMailTextField()
    self.createForgotPasswordLabel()
    self.createInvalidUserLabel()
    self.createNextButton()
    self.createErrorEMailLabel()
    self.createErrorNameLabel()
    self.createErrorBothTextFieldLabel()

  }
  
  private func addActions() {
    
    let tapToDismissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                              action: #selector(dismissKeyboard))
    tapToDismissKeyboard.numberOfTapsRequired = 1
    self.addGestureRecognizer(tapToDismissKeyboard)
    
  }
  
  private func adaptMyself() {
    self.layer.shadowColor = UIColor.blackColor().CGColor
    self.layer.shadowOpacity = 1
    self.layer.shadowOffset = CGSizeZero
    self.layer.shadowRadius = 5
  }
  
  private func createGoldenPitchStar() {
    goldenPitchStarImageView = UIImageView.init(image: UIImage.init(named: "goldenPitch_star"))
    let goldenPitchStarFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (goldenPitchStarImageView.frame.size.width / 2.0),
                                           y: 30.0 * UtilityManager.sharedInstance.conversionHeight,
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
      string: GoldenPitchConstants.goldenPitchTitleText,
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
      string: GoldenPitchConstants.amapText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(4.0),
        NSForegroundColorAttributeName: color
      ]
    )
    amapLabel.attributedText = stringWithFormat
    amapLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (amapLabel.frame.size.width / 2.0),
                               y: goldenPitchLabel.frame.origin.y + goldenPitchLabel.frame.size.height,
                               width: amapLabel.frame.size.width,
                               height: amapLabel.frame.size.height)
    
    amapLabel.frame = newFrame
    
    self.addSubview(amapLabel)
  }
  
  private func createWriteNameDescriptionLabel() {
    writeNameDescriptionLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Medium",
                      size: 12.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.24)
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: GoldenPitchConstants.writeNameDescriptionText,
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    writeNameDescriptionLabel.attributedText = stringWithFormat
    writeNameDescriptionLabel.sizeToFit()
    let newFrame = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: (210 * UtilityManager.sharedInstance.conversionHeight),
                               width: writeNameDescriptionLabel.frame.size.width,
                               height: writeNameDescriptionLabel.frame.size.height)
    
    writeNameDescriptionLabel.frame = newFrame
    
    self.addSubview(writeNameDescriptionLabel)
  }
  
  private func createNameLabel() {
    
    nameLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: GoldenPitchConstants.nameText,
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    nameLabel.attributedText = stringWithFormat
    nameLabel.sizeToFit()
    let newFrame = CGRect.init(x: 48.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: writeNameDescriptionLabel.frame.origin.y + writeNameDescriptionLabel.frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: nameLabel.frame.size.width,
                               height: nameLabel.frame.size.height)
    
    nameLabel.frame = newFrame
    
    self.addSubview(nameLabel)
    
  }
  
  private func createNameTextField() {
    let frameForTextField = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                        y: nameLabel.frame.origin.y + nameLabel.frame.size.height + (5.0 * UtilityManager.sharedInstance.conversionHeight),
                                    width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 25.0 * UtilityManager.sharedInstance.conversionHeight)
    
    nameTextField = UITextField.init(frame: frameForTextField)
    
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
    
    let font = UIFont(name: "SFUIText-Medium",
                      size: 12.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.24)
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: GoldenPitchConstants.writeEMailDescriptioText,
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    writeEMailDescriptionLabel.attributedText = stringWithFormat
    writeEMailDescriptionLabel.sizeToFit()
    let newFrame = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: nameLabel.frame.origin.y + nameLabel.frame.size.height + (51.0 * UtilityManager.sharedInstance.conversionHeight),
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
      string: GoldenPitchConstants.emailText,
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    eMailLabel.attributedText = stringWithFormat
    eMailLabel.sizeToFit()
    let newFrame = CGRect.init(x: 48.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: writeEMailDescriptionLabel.frame.origin.y + writeEMailDescriptionLabel.frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: eMailLabel.frame.size.width,
                               height: eMailLabel.frame.size.height)
    
    eMailLabel.frame = newFrame
    
    self.addSubview(eMailLabel)
  
  }
  
  private func createEMailTextField() {
    let frameForTextField = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                        y: eMailLabel.frame.origin.y + eMailLabel.frame.size.height + (5.0 * UtilityManager.sharedInstance.conversionHeight),
                                    width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: (25.0 * UtilityManager.sharedInstance.conversionHeight))
    
    eMailTextField = UITextField.init(frame: frameForTextField)
    
    let border = CALayer()
    let width = CGFloat(0.5)
    border.borderColor = UIColor.darkGrayColor().CGColor
    border.frame = CGRect(x: 0, y: eMailTextField.frame.size.height - width, width:  eMailTextField.frame.size.width, height: eMailTextField.frame.size.height)
    
    border.borderWidth = width
    eMailTextField.layer.addSublayer(border)
    eMailTextField.layer.masksToBounds = true
    
    
    self.addSubview(eMailTextField)
  }
  
  private func createForgotPasswordLabel() {
    
    forgotPasswordLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 11.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: GoldenPitchConstants.forgotPasswordText,
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    forgotPasswordLabel.attributedText = stringWithFormat
    forgotPasswordLabel.sizeToFit()
    let newFrame = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: eMailTextField.frame.origin.y + eMailTextField.frame.size.height + (10.0 * UtilityManager.sharedInstance.conversionHeight),
                           width: forgotPasswordLabel.frame.size.width,
                          height: forgotPasswordLabel.frame.size.height)
    
    forgotPasswordLabel.frame = newFrame
    
    self.addSubview(forgotPasswordLabel)
    
  }
  
  private func createInvalidUserLabel() {
    
    invalidUser = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.redColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: GoldenPitchConstants.invalidUserText,
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    invalidUser.attributedText = stringWithFormat
    invalidUser.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (invalidUser.frame.size.width / 2.0),
                               y: forgotPasswordLabel.frame.origin.y + forgotPasswordLabel.frame.size.height + (5.0 * UtilityManager.sharedInstance.conversionHeight),
                           width: invalidUser.frame.size.width,
                          height: invalidUser.frame.size.height)
    
    invalidUser.frame = newFrame
    invalidUser.alpha = 0.0
    
    self.addSubview(invalidUser)
    
  }
  
  private func createNextButton() {
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let colorWhenPressed = UIColor.greenColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: GoldenPitchConstants.nextButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    let stringWithFormatWhenpressed = NSMutableAttributedString(
      string: GoldenPitchConstants.nextButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: colorWhenPressed
      ]
    )
    
    let frameForButton = CGRect.init(x: 0.0, y: self.frame.size.height - (70.0 * UtilityManager.sharedInstance.conversionHeight), width: self.frame.size.width, height: (70.0 * UtilityManager.sharedInstance.conversionHeight))
    nextButton = UIButton.init(frame: frameForButton)
    nextButton.addTarget(self,
                                action: #selector(requestLogin),
                                forControlEvents: .TouchUpInside)
    nextButton.backgroundColor = UIColor.blackColor()
    nextButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    nextButton.setAttributedTitle(stringWithFormatWhenpressed, forState: .Highlighted)
    
    self.addSubview(nextButton)
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
                               y: forgotPasswordLabel.frame.origin.y + forgotPasswordLabel.frame.size.height + (5.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: errorEMailLabel.frame.size.width,
                               height: errorEMailLabel.frame.size.height)
    
    errorEMailLabel.frame = newFrame
    errorEMailLabel.alpha = 0.0
    self.addSubview(errorEMailLabel)
    
  }
  
  private func createErrorNameLabel() {
    
    errorNameLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 11.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.redColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Ingrese un nombre",
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    
    errorNameLabel.attributedText = stringWithFormat
    errorNameLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (errorNameLabel.frame.size.width / 2.0),
                               y: forgotPasswordLabel.frame.origin.y + forgotPasswordLabel.frame.size.height + (5.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: errorNameLabel.frame.size.width,
                               height: errorNameLabel.frame.size.height)
    
    errorNameLabel.frame = newFrame
    errorNameLabel.alpha = 0.0
    self.addSubview(errorNameLabel)
    
  }
  
  private func createErrorBothTextFieldLabel() {
    
    errorBothTextFieldLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 11.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.redColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Revisa nombre y formato de mail",
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    
    errorBothTextFieldLabel.attributedText = stringWithFormat
    errorBothTextFieldLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (errorBothTextFieldLabel.frame.size.width / 2.0),
                               y: forgotPasswordLabel.frame.origin.y + forgotPasswordLabel.frame.size.height + (5.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: errorBothTextFieldLabel.frame.size.width,
                               height: errorBothTextFieldLabel.frame.size.height)
    
    errorBothTextFieldLabel.frame = newFrame
    errorBothTextFieldLabel.alpha = 0.0
    self.addSubview(errorBothTextFieldLabel)
    
  }
  
  @objc private func requestLogin() {
    
    nextButton.userInteractionEnabled = false
    
    let mailValid = UtilityManager.sharedInstance.isValidEmail(eMailTextField.text!)
    let nameValid = UtilityManager.sharedInstance.isValidText(nameTextField.text!)
    
    if mailValid == true && nameValid == true {
//      do request login
    } else
      if mailValid == false && nameValid == true {
        self.showValidMailError()
      } else
        if nameValid == false && mailValid == true {
          self.showValidNameError()
        }else
          if nameValid == false && mailValid == false {
            self.showBothTextErrorLabel()
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
  
  private func showValidNameError() {
    
    self.nextButton.userInteractionEnabled = false
    UIView.animateWithDuration(0.4,
                               animations: {
                                self.errorNameLabel.alpha = 1.0
    }) { (finished) in
      if finished {
        self.hideErrorNameLabel()
      }
    }
    
  }
  
  @objc private func hideErrorNameLabel() {
    
    UIView.animateWithDuration(1.0, animations: {
      self.errorNameLabel.alpha = 0.0
    }) { (finished) in
      if finished {
        self.nextButton.userInteractionEnabled = true
      }
    }
    
  }
  
  
  private func showBothTextErrorLabel() {
    self.nextButton.userInteractionEnabled = false
    UIView.animateWithDuration(0.4,
                               animations: {
                                self.errorBothTextFieldLabel.alpha = 1.0
    }) { (finished) in
      if finished {
        self.hideErrorBothTextFieldLabel()
      }
    }
  }
  
  @objc private func hideErrorBothTextFieldLabel() {
    
    UIView.animateWithDuration(1.0, animations: {
      self.errorBothTextFieldLabel.alpha = 0.0
    }) { (finished) in
      if finished {
        self.nextButton.userInteractionEnabled = true
      }
    }
    
  }
  
  @objc private func showErrorMessage() {
    UIView.animateWithDuration(0.35){
      self.invalidUser.alpha = 1.0
    }
  }
  
  @objc private func dismissKeyboard(sender:AnyObject) {
    self.endEditing(true)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}


