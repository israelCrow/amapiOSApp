//
//  WhenYouWillSignTheContractPitchSurveyView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/26/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol WhenYouWillSignTheContractPitchSurveyViewDelegate {
  
  func whenYouWillSignTheContractNextButtonPressed(dateSelected: String)
  
}

class WhenYouWillSignTheContractPitchSurveyView: UIView, UITextFieldDelegate {
  
  private var thumbsUpImageView: UIImageView! = nil
  private var whenYouWillSignTheContractView: CustomTextFieldWithTitleView! = nil
  private var titleLabel: UILabel! = nil
  private var nextButton: UIButton! = nil
  private var containerViewForPicker: UIView! = nil
  private var mainDatePicker: UIDatePicker! = nil
  private var finalDateForServer: String! = ""
  var regionPosition: PositionOfCardsAddResults! = nil
  
  var delegate: WhenYouWillSignTheContractPitchSurveyViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    
    self.initValues()
    self.initInterface()
    
  }
  
  private func initValues() {
    
    self.tag = 13
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    
    self.createThumbsUpImageView()
    self.createContainerViewForPicker()
    self.createMainDatePicker()
    self.createTitleLabel()
    self.createWriteDateOfCreationOfPitchView()
    self.createNextButton()
    
    
  }
  
  private func createThumbsUpImageView() {
    
    thumbsUpImageView = UIImageView.init(image: UIImage.init(named: "bigThumbsUp")!)
    let iconImageViewFrame = CGRect.init(x: 123.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: 30.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: thumbsUpImageView!.frame.size.width,
                                         height: thumbsUpImageView!.frame.size.height)
    
    thumbsUpImageView!.frame = iconImageViewFrame
    
    self.addSubview(thumbsUpImageView!)
    
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
  
  private func createTitleLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    titleLabel = UILabel.init(frame: frameForLabel)
    titleLabel.numberOfLines = 0
    titleLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 20.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "¿Sabes cuándo lo firmas?", //EditPitchesConstants.DidSignContactPitchSurveyView.titleLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(1.4),
        NSForegroundColorAttributeName: color
      ]
    )
    titleLabel.attributedText = stringWithFormat
    titleLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (titleLabel.frame.size.width / 2.0),
                               y: 128.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: titleLabel.frame.size.width,
                               height: titleLabel.frame.size.height)
    
    titleLabel.frame = newFrame
    
    self.addSubview(titleLabel)
    
  }
  
  private func createWriteDateOfCreationOfPitchView() {
    
    let frameForView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                   y: 164.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    whenYouWillSignTheContractView = CustomTextFieldWithTitleView.init(frame: frameForView,
                                                                 title: "", //"¿Sabes cuándo lo firmas?",
                                                                 image: "iconImputCalendar")
    
    whenYouWillSignTheContractView.mainTextField.placeholder = "dd/mm/aa"
    whenYouWillSignTheContractView.mainTextField.tag = 1
    whenYouWillSignTheContractView.mainTextField.inputView = containerViewForPicker
    whenYouWillSignTheContractView.mainTextField.delegate = self
    
    self.addSubview(whenYouWillSignTheContractView)
    
  }
  
  private func createNextButton() {
    
    nextButton = UIButton.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: EditPitchesConstants.DidSignContactPitchSurveyView.nextButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    nextButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    nextButton.backgroundColor = UIColor.grayColor()
    nextButton.addTarget(self,
                         action: #selector(nextButtonPressed),
                         forControlEvents: .TouchUpInside)
    nextButton.sizeToFit()
    
    let frameForButton = CGRect.init(x: 0.0,
                                     y: self.frame.size.height - (70.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: self.frame.size.width,
                                     height: 70.0 * UtilityManager.sharedInstance.conversionHeight)
    
    nextButton.frame = frameForButton
    nextButton.enabled = false
    nextButton.alpha = 1.0
    
    self.addSubview(nextButton)
    
  }
  
  @objc private func datePickerViewChanged(sender: UIDatePicker) {
    
    let dateFromPicker = mainDatePicker.date
    let calendar = NSCalendar.currentCalendar()
    let components = calendar.components([.Day, .Month, .Year], fromDate: dateFromPicker)
    
    finalDateForServer = "\(components.year)-\(components.month)-\(components.day)"
    let stringDate = "\(components.day)-\(components.month)-\(components.year)"
    
    whenYouWillSignTheContractView.mainTextField.text = stringDate
    
    self.changeNextButtonToEnabled()
    
  }
  
  @objc private func nextButtonPressed() {
    
    self.delegate?.whenYouWillSignTheContractNextButtonPressed(finalDateForServer)
    
  }
  
  @objc private func okButtonPressed(sender: UIButton) {
    
    let dateFromPicker = mainDatePicker.date
    let calendar = NSCalendar.currentCalendar()
    let components = calendar.components([.Day, .Month, .Year], fromDate: dateFromPicker)
    
    finalDateForServer = "\(components.year)-\(components.month)-\(components.day)"
    let stringDate = "\(components.day)-\(components.month)-\(components.year)"
    
    whenYouWillSignTheContractView.mainTextField.text = stringDate
    
    self.dismissKeyboard()
    
  }
  
  private func dismissKeyboard() {
    
    self.endEditing(true)
    
  }
  
  private func changeNextButtonToEnabled() {
    
    UIView.animateWithDuration(0.35,
                               animations: {
                                
                                self.nextButton.backgroundColor = UIColor.blackColor()
                                
    }) { (finished) in
      if finished == true {
        
        self.nextButton.enabled = true
        
      }
    }
    
  }
  
  
  //MARK: - UITextFieldDelegate
  
  func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
    
    self.changeNextButtonToEnabled()
    
    return true
  }
  
  
  func textFieldShouldClear(textField: UITextField) -> Bool {
    
    if textField.tag == 1 {
      
      finalDateForServer = ""
      
    }
    
    return true
    
  }
  
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    
    self.changeNextButtonToEnabled()
    
    return true
  }
  
  
}
