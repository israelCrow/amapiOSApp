//
//  CreateAccountView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/3/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol CreateAccountViewDelegate{
  func requestCreateAccount(email:String, agency:String, actionToMakeWhenFinished: ()->Void)
}

class CreateAccountView: UIView, UITextFieldDelegate {
    
    private var createAccountLabel: UILabel! = nil
    private var agencyButton: UIButton! = nil
    private var brandButton: UIButton! = nil
    private var writeNameDescriptionLabel: UILabel! = nil
    private var nameLabel: UILabel! = nil
    private var writeEMailDescriptionLabel: UILabel! = nil
    private var eMailLabel: UILabel! = nil
    private var errorEMailLabel: UILabel! = nil
    private var errorNameLabel: UILabel! = nil
    private var errorBothTextFieldLabel: UILabel! = nil
    
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
        self.createAgencyButton()
        self.createBrandButton()
        self.createWriteNameDescriptionLabel()
        //    self.createNameLabel()
        self.createNameTextField()
        self.createCancelButtonForNameTextField()
        self.createWriteEMailDescriptionLabel()
        //    self.createEMailLabel()
        //self.createButton2
        self.createEMailTextField()
        self.createCancelButtonForEMailTextField()
        self.createAskPasswordButton()
        self.createErrorEMailLabel()
        self.createErrorNameLabel()
        self.createErrorBothTextFieldLabel()
        
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
        
        let font = UIFont(name: "SFUIDisplay-Ultralight",
                          size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
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
                                   y: 30.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: createAccountLabel.frame.size.width,
                                   height: createAccountLabel.frame.size.height)
        
        createAccountLabel.frame = newFrame
        
        self.addSubview(createAccountLabel)
        
    }
    
    private func createAgencyButton() {
        let frameForButton = CGRect.init(x: 45.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: createAccountLabel.frame.origin.y + createAccountLabel.frame.size.height + (1.0 * UtilityManager.sharedInstance.conversionHeight),
                                         width: 100.0,
                                         height: 100.0)
        agencyButton = UIButton.init(frame: frameForButton)
        let image = UIImage(named: "iconAgencyBlack") as UIImage?
        agencyButton.setImage(image, forState: .Normal)
        self.addSubview(agencyButton)
        
    }
    
    private func createBrandButton() {
        let frameForButton = CGRect.init(x: 135.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: createAccountLabel.frame.origin.y + createAccountLabel.frame.size.height + (1.0 * UtilityManager.sharedInstance.conversionHeight),
                                         width: 100.0,
                                         height: 100.0)
        agencyButton = UIButton.init(frame: frameForButton)
        let image = UIImage(named: "iconBrandBlack") as UIImage?
        agencyButton.setImage(image, forState: .Normal)
        self.addSubview(agencyButton)
        
    }
    
    private func createWriteNameDescriptionLabel() {
        writeNameDescriptionLabel = UILabel.init(frame: CGRectZero)
        
        let font = UIFont(name: "SFUIText-Medium",
                          size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
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
        let newFrame = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                   y: 184.0 * UtilityManager.sharedInstance.conversionHeight,
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
            string: CreateAccountConstants.CreateAccountView.nameText,
            attributes:[NSFontAttributeName:font!,
                NSParagraphStyleAttributeName:style,
                NSForegroundColorAttributeName:color
            ]
        )
        nameLabel.attributedText = stringWithFormat
        nameLabel.sizeToFit()
        let newFrame = CGRect.init(x: 48.0,
                                   y: writeNameDescriptionLabel.frame.origin.y + writeNameDescriptionLabel.frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight),
                                   width: nameLabel.frame.size.width,
                                   height: nameLabel.frame.size.height)
        
        nameLabel.frame = newFrame
        
        self.addSubview(nameLabel)
        
    }
    
    private func createNameTextField() {
        let frameForTextField = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                            y: writeNameDescriptionLabel.frame.origin.y + writeNameDescriptionLabel.frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight),
                                            width: 200.0 * UtilityManager.sharedInstance.conversionWidth,
                                            height: 25.0 * UtilityManager.sharedInstance.conversionHeight)
        
        nameTextField = UITextField.init(frame: frameForTextField)
        nameTextField.tag = 1
        nameTextField.delegate = self
        nameTextField.placeholder = "Agencia/Marca"
        nameTextField.addTarget(self, action: #selector(animateCancelButton), forControlEvents: .EditingChanged)
        
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor.darkGrayColor().CGColor
        let frameForLine = CGRect(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                  y: nameTextField.frame.origin.y + nameTextField.frame.size.height,
                                  width: 220 * UtilityManager.sharedInstance.conversionWidth,
                                  height: 0.5)
        let viewForLine = UIView.init(frame: frameForLine)
        viewForLine.backgroundColor = UIColor.clearColor()
        border.borderWidth = width
        border.frame = CGRect.init(x: 0.0,
                                   y: 0.0,
                                   width: 220 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 0.5)
        viewForLine.layer.addSublayer(border)
        viewForLine.layer.masksToBounds = true
        
        self.addSubview(viewForLine)
        
        self.addSubview(nameTextField)
    }
    
    private func createCancelButtonForNameTextField() {
        let frameForButton = CGRect.init(x:nameTextField.frame.origin.x + nameTextField.frame.size.width,
                                         y: nameTextField.frame.origin.y,
                                         width: 20.0,
                                         height: 20.0)
        cancelButtonForNameTextField = UIButton.init(frame: frameForButton)
        cancelButtonForNameTextField.tag = 1
        cancelButtonForNameTextField.alpha = 0.0
        let image = UIImage(named: "deleteButton") as UIImage?
        cancelButtonForNameTextField.setImage(image, forState: .Normal)
        cancelButtonForNameTextField.addTarget(self, action: #selector(deleteNameTextField), forControlEvents:.TouchUpInside)
        self.addSubview(cancelButtonForNameTextField)
    }
    
    private func createWriteEMailDescriptionLabel() {
        
        writeEMailDescriptionLabel = UILabel.init(frame: CGRectZero)
        
        let font = UIFont(name: "SFUIText-Medium",
                          size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
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
        let newFrame = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                   y: nameTextField.frame.origin.y + nameTextField.frame.size.height + (35.0 * UtilityManager.sharedInstance.conversionHeight),
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
            string: CreateAccountConstants.CreateAccountView.emailText,
            attributes:[NSFontAttributeName:font!,
                NSParagraphStyleAttributeName:style,
                NSForegroundColorAttributeName:color
            ]
        )
        eMailLabel.attributedText = stringWithFormat
        eMailLabel.sizeToFit()
        let newFrame = CGRect.init(x: 48.0,
                                   y: writeEMailDescriptionLabel.frame.origin.y + writeEMailDescriptionLabel.frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight),
                                   width: eMailLabel.frame.size.width,
                                   height: eMailLabel.frame.size.height)
        
        eMailLabel.frame = newFrame
        
        self.addSubview(eMailLabel)
        
    }
    
    private func createEMailTextField() {
        let frameForTextField = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                            y: writeEMailDescriptionLabel.frame.origin.y + writeEMailDescriptionLabel.frame.size.height + 5.0,
                                            width: 200.0 * UtilityManager.sharedInstance.conversionWidth,
                                            height: 25.0 * UtilityManager.sharedInstance.conversionHeight)
        
        eMailTextField = UITextField.init(frame: frameForTextField)
        eMailTextField.tag = 2
        eMailTextField.placeholder = "jen@ejemplo.com"
        eMailTextField.delegate = self
        eMailTextField.addTarget(self, action: #selector(animateCancelButton), forControlEvents: .EditingChanged)
        
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor.darkGrayColor().CGColor
        let frameForLine = CGRect(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                  y: eMailTextField.frame.origin.y + eMailTextField.frame.size.height,
                                  width: 220 * UtilityManager.sharedInstance.conversionWidth,
                                  height: 0.5)
        let viewForLine = UIView.init(frame: frameForLine)
        viewForLine.backgroundColor = UIColor.clearColor()
        border.borderWidth = width
        border.frame = CGRect.init(x: 0.0,
                                   y: 0.0,
                                   width: 220 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 0.5)
        viewForLine.layer.addSublayer(border)
        viewForLine.layer.masksToBounds = true
        
        self.addSubview(viewForLine)
        self.addSubview(eMailTextField)
    }
    
    private func createCancelButtonForEMailTextField() {
        let frameForButton = CGRect.init(x:eMailTextField.frame.origin.x + eMailTextField.frame.size.width,
                                         y: eMailTextField.frame.origin.y,
                                         width: 20.0,
                                         height: 20.0)
        cancelButtonForEMailTextField = UIButton.init(frame: frameForButton)
        cancelButtonForEMailTextField.alpha = 0.0
        cancelButtonForEMailTextField.tag = 2
        let image = UIImage(named: "deleteButton") as UIImage?
        cancelButtonForEMailTextField.setImage(image, forState: .Normal)
        cancelButtonForEMailTextField.addTarget(self, action: #selector(deleteEMailTextField), forControlEvents:.TouchUpInside)
        
        self.addSubview(cancelButtonForEMailTextField)
    }
    
    private func createAskPasswordButton() {
        
        let font = UIFont(name: "SFUIDisplay-Light",
                          size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
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
        
        let frameForButton = CGRect.init(x: 0.0,
                                         y: self.frame.size.height - (70.0 * UtilityManager.sharedInstance.conversionHeight),
                                         width: self.frame.size.width,
                                         height: (70.0 * UtilityManager.sharedInstance.conversionHeight))
        askPasswordButton = UIButton.init(frame: frameForButton)
        askPasswordButton.addTarget(self,
                                    action: #selector(createAccount),
                                    forControlEvents: .TouchUpInside)
        askPasswordButton.backgroundColor = UIColor.blackColor()
        askPasswordButton.setAttributedTitle(stringWithFormat, forState: .Normal)
        
        self.addSubview(askPasswordButton)
        
    }
    
    private func createErrorEMailLabel() {
        
        errorEMailLabel = UILabel.init(frame: CGRectZero)
        
        let font = UIFont(name: "SFUIText-Regular",
                          size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
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
                                   y: eMailTextField.frame.origin.y + eMailTextField.frame.size.height + (5.0 * UtilityManager.sharedInstance.conversionHeight),
                                   width: errorEMailLabel.frame.size.width,
                                   height: errorEMailLabel.frame.size.height)
        
        errorEMailLabel.frame = newFrame
        errorEMailLabel.alpha = 0.0
        self.addSubview(errorEMailLabel)
        
    }
    
    private func createErrorNameLabel() {
        
        errorNameLabel = UILabel.init(frame: CGRectZero)
        
        let font = UIFont(name: "SFUIText-Regular",
                          size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
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
                                   y: eMailTextField.frame.origin.y + eMailTextField.frame.size.height + (5.0 * UtilityManager.sharedInstance.conversionHeight),
                                   width: errorNameLabel.frame.size.width,
                                   height: errorNameLabel.frame.size.height)
        
        errorNameLabel.frame = newFrame
        errorNameLabel.alpha = 0.0
        self.addSubview(errorNameLabel)
        
    }
    
    private func createErrorBothTextFieldLabel() {
        
        errorBothTextFieldLabel = UILabel.init(frame: CGRectZero)
        
        let font = UIFont(name: "SFUIText-Regular",
                          size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
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
                                   y: eMailTextField.frame.origin.y + eMailTextField.frame.size.height + (5.0 * UtilityManager.sharedInstance.conversionHeight),
                                   width: errorBothTextFieldLabel.frame.size.width,
                                   height: errorBothTextFieldLabel.frame.size.height)
        
        errorBothTextFieldLabel.frame = newFrame
        errorBothTextFieldLabel.alpha = 0.0
        self.addSubview(errorBothTextFieldLabel)
        
    }
    
    @objc private func createAccount() {
        
        askPasswordButton.userInteractionEnabled = false
        
        let mailValid = UtilityManager.sharedInstance.isValidEmail(eMailTextField.text!)
        let nameValid = UtilityManager.sharedInstance.isValidText(nameTextField.text!)
        
        if mailValid == true && nameValid == true {
          
          
          self.delegate?.requestCreateAccount(eMailTextField.text!.lowercaseString, agency: nameTextField.text!){
            
            UtilityManager.sharedInstance.hideLoader()
            
          }
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
        
        self.removeAllErrorLabels()
        self.askPasswordButton.userInteractionEnabled = false
        UIView.animateWithDuration(1.0,
                                   animations: {
                                    self.errorEMailLabel.alpha = 1.0
        }) { (finished) in
            if finished == true{
                self.askPasswordButton.userInteractionEnabled = true
//                self.hideErrorMailLabel()
            }
        }
    }
    
    @objc private func hideErrorMailLabel() {
        
        UIView.animateWithDuration(0.3, animations: {
            self.errorEMailLabel.alpha = 0.0
        }) { (finished) in
            if finished {
//                self.askPasswordButton.userInteractionEnabled = true
            }
        }
        
    }
    
    private func showValidNameError() {
        
        self.removeAllErrorLabels()
        self.askPasswordButton.userInteractionEnabled = false
        UIView.animateWithDuration(1.0,
                                   animations: {
                                    self.errorNameLabel.alpha = 1.0
        }) { (finished) in
            if finished {
                self.askPasswordButton.userInteractionEnabled = true
//                self.hideErrorNameLabel()
            }
        }
        
    }
    
    @objc private func hideErrorNameLabel() {
        
        UIView.animateWithDuration(0.3, animations: {
            self.errorNameLabel.alpha = 0.0
        }) { (finished) in
            if finished {
                self.askPasswordButton.userInteractionEnabled = true
            }
        }
        
    }
    
    private func showBothTextErrorLabel() {
        
        self.removeAllErrorLabels()
        self.askPasswordButton.userInteractionEnabled = false
        UIView.animateWithDuration(1.0,
                                   animations: {
                                    self.errorBothTextFieldLabel.alpha = 1.0
        }) { (finished) in
            if finished {
                self.askPasswordButton.userInteractionEnabled = true
//                self.hideErrorBothTextFieldLabel()
            }
        }
    }
    
    @objc private func hideErrorBothTextFieldLabel() {
        
        UIView.animateWithDuration(0.3, animations: {
            self.errorBothTextFieldLabel.alpha = 0.0
        }) { (finished) in
            if finished {
                self.askPasswordButton.userInteractionEnabled = true
            }
        }
    }
    
    @objc private func deleteNameTextField(){
        self.nameTextField.text = ""
        self.hideButtonCancelForNameTextField()
        self.removeAllErrorLabels()
    }
    
    @objc private func deleteEMailTextField(){
        self.eMailTextField.text = ""
        self.hideButtonCancelForEMailTextField()
        self.removeAllErrorLabels()
    }
    
    @objc func dismissKeyboard(sender:AnyObject) {
        self.endEditing(true)
    }
    
    @objc private func animateCancelButton(textField: UITextField) {
        
        self.removeAllErrorLabels()
        
        if textField.tag == 1 { //NameTextField
            if textField.text!.characters.count != 0 {
                self.showButtonCancelForNameTextField()
            }else{
                self.hideButtonCancelForNameTextField()
            }
        }else
            if textField.tag == 2 { //EMailTextField
                if textField.text!.characters.count != 0 {
                    self.showButtonCancelForEMailTextField()
                }else{
                    self.hideButtonCancelForEMailTextField()
                }
        }
    }
    
    private func showButtonCancelForNameTextField() {
        
        UIView.animateWithDuration(0.35) {
            self.cancelButtonForNameTextField.alpha = 1.0
        }
        
    }
    
    private func hideButtonCancelForNameTextField() {
        
        UIView.animateWithDuration(0.35) {
            self.cancelButtonForNameTextField.alpha = 0.0
        }
        
    }
    
    private func showButtonCancelForEMailTextField() {
        
        UIView.animateWithDuration(0.35) {
            self.cancelButtonForEMailTextField.alpha = 1.0
        }
        
    }
    
    private func hideButtonCancelForEMailTextField() {
        
        UIView.animateWithDuration(0.35) {
            self.cancelButtonForEMailTextField.alpha = 0.0
        }
        
    }
    
    private func removeAllErrorLabels() {
        
        self.hideErrorNameLabel()
        self.hideErrorMailLabel()
        self.hideErrorBothTextFieldLabel()
        
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        self.removeAllErrorLabels()
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
