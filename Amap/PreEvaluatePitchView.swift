//
//  PreEvaluatePitchView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/13/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol PreEvaluatePitchViewDelegate {
  
  func savePitchAndFlipCard(briefEmailContact: String!, briefDate: String!)
  
}

class PreEvaluatePitchView: UIView, UITextFieldDelegate {
  
  private var writeNameAgencyOrBrandView: CustomTextFieldWithTitleView! = nil
  private var writeDateOfCreationOfPitchView: CustomTextFieldWithTitleView! = nil
  private var nextButton: UIButton! = nil
  private var containerViewForPicker: UIView! = nil
  private var mainDatePicker: UIDatePicker! = nil

  private var finalDateForServer: String! = ""
  private var errorEMailLabel: UILabel! = nil
  private var sameEmailErrorLabel: UILabel! = nil
  
  var delegate: PreEvaluatePitchViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    
    self.createContainerViewForPicker()
    self.createMainDatePicker()
    self.createWriteNameAgencyBrandView()
    self.createWriteDateOfCreationOfPitchView()
    self.createNextButton()
    
    self.createErrorEMailLabel()
    self.createSameEmailErrorLabel()
    
  }
  
  private func createContainerViewForPicker() {
    
    let frameForContainerView = CGRect.init(x: 0.0,
                                            y: 0.0,
                                            width: UIScreen.mainScreen().bounds.width,
                                            height: 175.0)
    
    containerViewForPicker = UIView.init(frame: frameForContainerView)
    containerViewForPicker.backgroundColor = UIColor.clearColor()
    
  }
  
  private func createMainDatePicker() {
    
    let button = self.createGenericButton()
    containerViewForPicker.addSubview(button)
    
    let frameForPicker = CGRect.init(x: 0.0,
                                     y: button.frame.size.height + (5.0 * UtilityManager.sharedInstance.conversionHeight),
                                 width: UIScreen.mainScreen().bounds.width,
                                height: 150.0 * UtilityManager.sharedInstance.conversionHeight)
    
    mainDatePicker = UIDatePicker.init(frame: frameForPicker)
    mainDatePicker.datePickerMode = .Date
    mainDatePicker.addTarget(self, action: #selector(datePickerViewChanged), forControlEvents: UIControlEvents.ValueChanged)
    containerViewForPicker.addSubview(mainDatePicker)
    
  }
  
  private func createGenericButton() -> UIButton {
    
    let okButton = UIButton.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 15.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Ok",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    okButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    okButton.backgroundColor = UIColor.grayColor()
    okButton.addTarget(self,
                        action: #selector(okButtonPressed),
                        forControlEvents: .TouchUpInside)
    okButton.sizeToFit()
    
    let frameForButton = CGRect.init(x: (UIScreen.mainScreen().bounds.width / 2.0) - (okButton.frame.size.width / 2.0),
                                     y: 8.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: okButton.frame.size.width,
                                     height: okButton.frame.size.height)
    
    okButton.frame = frameForButton
    okButton.layer.cornerRadius = 3.0
    
    return okButton
    
  }
  
  private func createWriteNameAgencyBrandView() {
    
    let frameForView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                   y: 68.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                              height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    writeNameAgencyOrBrandView = CustomTextFieldWithTitleView.init(frame: frameForView,
                                                                   title: VisualizePitchesConstants.PreEvaluatePitchView.descriptionWriteNameLabel,
                                                                   image: nil)
    
    writeNameAgencyOrBrandView.mainTextField.placeholder = "e-mail"
    writeNameAgencyOrBrandView.mainTextField.autocapitalizationType = .None
    writeNameAgencyOrBrandView.mainTextField.delegate = self
    
    self.addSubview(writeNameAgencyOrBrandView)
    
  }
  
  private func createWriteDateOfCreationOfPitchView() {
    
    let frameForView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                   y: 167.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    writeDateOfCreationOfPitchView = CustomTextFieldWithTitleView.init(frame: frameForView,
                                                                   title: VisualizePitchesConstants.PreEvaluatePitchView.descriptionWriteDateLabel,
                                                                   image: "iconImputCalendar")
    
    writeDateOfCreationOfPitchView.mainTextField.placeholder = "dd/mm/aa"
    writeDateOfCreationOfPitchView.mainTextField.inputView = containerViewForPicker
    writeDateOfCreationOfPitchView.mainTextField.autocapitalizationType = .None
    writeDateOfCreationOfPitchView.mainTextField.delegate = self
    writeDateOfCreationOfPitchView.mainTextField.tag == 2
    
    self.addSubview(writeDateOfCreationOfPitchView)
    
  }
  
  private func createNextButton() {
    
    nextButton = UIButton.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.AddPitchAndWriteBrandNameView.addButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    nextButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    nextButton.backgroundColor = UIColor.blackColor()
    nextButton.addTarget(self,
                        action: #selector(nextButtonPressed),
                        forControlEvents: .TouchUpInside)
    nextButton.sizeToFit()
    
    let frameForButton = CGRect.init(x: 0.0,
                                     y: self.frame.size.height - (70.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: self.frame.size.width,
                                     height: 70.0 * UtilityManager.sharedInstance.conversionHeight)
    
    nextButton.frame = frameForButton
    nextButton.alpha = 1.0
    
    self.addSubview(nextButton)
    
  }
  
  private func createErrorEMailLabel() {
    
    errorEMailLabel = UILabel.init(frame: CGRectZero)
    errorEMailLabel.numberOfLines = 2
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 13.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.redColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Mail o fecha incorrecta",
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    
    errorEMailLabel.attributedText = stringWithFormat
    errorEMailLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (errorEMailLabel.frame.size.width / 2.0),
                               y: writeDateOfCreationOfPitchView.frame.origin.y + writeDateOfCreationOfPitchView.frame.size.height + (10.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: errorEMailLabel.frame.size.width,
                               height: errorEMailLabel.frame.size.height)
    
    errorEMailLabel.frame = newFrame
    errorEMailLabel.alpha = 0.0
    self.addSubview(errorEMailLabel)
    
  }
  
  private func createSameEmailErrorLabel() {
    
    sameEmailErrorLabel = UILabel.init(frame: CGRectZero)
    sameEmailErrorLabel.numberOfLines = 2
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 13.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.redColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "No puedes ingresar tu propio mail",
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    
    sameEmailErrorLabel.attributedText = stringWithFormat
    sameEmailErrorLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (sameEmailErrorLabel.frame.size.width / 2.0),
                               y: writeDateOfCreationOfPitchView.frame.origin.y + writeDateOfCreationOfPitchView.frame.size.height + (10.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: sameEmailErrorLabel.frame.size.width,
                               height: sameEmailErrorLabel.frame.size.height)
    
    sameEmailErrorLabel.frame = newFrame
    sameEmailErrorLabel.alpha = 0.0
    self.addSubview(sameEmailErrorLabel)
    
  }
  
  @objc private func datePickerViewChanged(sender: UIDatePicker) {
    
    let dateFromPicker = mainDatePicker.date
    let calendar = NSCalendar.currentCalendar()
    let components = calendar.components([.Day, .Month, .Year], fromDate: dateFromPicker)
    
    finalDateForServer = "\(components.year)-\(components.month)-\(components.day)"
    let stringDate = "\(components.day)-\(components.month)-\(components.year)"
    
    writeDateOfCreationOfPitchView.mainTextField.text = stringDate
    
  }
  
  @objc private func nextButtonPressed() {
    
    let isValidEmail = UtilityManager.sharedInstance.isValidEmail(writeNameAgencyOrBrandView.mainTextField.text!)
    let isValidDate = UtilityManager.sharedInstance.isValidText(finalDateForServer)
    
    if writeNameAgencyOrBrandView.mainTextField.text!.lowercaseString != UserSession.session.email.lowercaseString {
      
      if isValidEmail == true && isValidDate == true{
        
        self.delegate?.savePitchAndFlipCard(writeNameAgencyOrBrandView.mainTextField.text!,
                                            briefDate: finalDateForServer)
        
      } else {
        
        self.showValidMailError()
        
      }
      
    } else {
      
      self.showSameMailError()
      
    }
    

    
  }
  
  @objc private func okButtonPressed(sender: UIButton) {
    
    let dateFromPicker = mainDatePicker.date
    let calendar = NSCalendar.currentCalendar()
    let components = calendar.components([.Day, .Month, .Year], fromDate: dateFromPicker)
    
    finalDateForServer = "\(components.year)-\(components.month)-\(components.day)"
    let stringDate = "\(components.day)-\(components.month)-\(components.year)"
    
    writeDateOfCreationOfPitchView.mainTextField.text = stringDate
    
    self.dismissKeyboard()
    
  }
  
  private func showValidMailError() {
    
//    self.removeAllErrorLabels()
    nextButton.userInteractionEnabled = false
    UIView.animateWithDuration(1.0,
                               animations: {
                                self.errorEMailLabel.alpha = 1.0
    }) { (finished) in
      if finished {
        //                self.hideErrorMailLabel()
        self.nextButton.userInteractionEnabled = true
      }
    }
  }
  
  @objc private func hideErrorMailLabel() {
    
    UIView.animateWithDuration(0.3, animations: {
      self.errorEMailLabel.alpha = 0.0
    }) { (finished) in
      if finished {
        //                self.nextButton.userInteractionEnabled = true
      }
    }
    
  }
  
  private func showSameMailError() {
    
    //    self.removeAllErrorLabels()
    nextButton.userInteractionEnabled = false
    UIView.animateWithDuration(1.0,
                               animations: {
                                self.sameEmailErrorLabel.alpha = 1.0
    }) { (finished) in
      if finished {
        //                self.hideErrorMailLabel()
        self.nextButton.userInteractionEnabled = true
      }
    }
  }
  
  @objc private func hideSameMailLabel() {
    
    UIView.animateWithDuration(0.3, animations: {
      self.sameEmailErrorLabel.alpha = 0.0
    }) { (finished) in
      if finished {
        //                self.nextButton.userInteractionEnabled = true
      }
    }
    
  }
  
  private func dismissKeyboard() {
    
    self.endEditing(true)
    
  }
  
  //MARK: - UITextFieldDelegate 
  
  func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
    
    self.hideErrorMailLabel()
    self.hideSameMailLabel()
    
    return true
  }
  
  
  func textFieldShouldClear(textField: UITextField) -> Bool {
    
    if textField.tag == 2 {
      
      finalDateForServer = ""
      
    }
    
    self.hideErrorMailLabel()
    self.hideSameMailLabel()
    
    return true
  }
  
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    
    self.hideErrorMailLabel()
    self.hideSameMailLabel()
    
    return true
  }

  
}
