//
//  CustomTextFieldWithTitleAndPickerForDashboardView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 11/17/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol CustomTextFieldWithTitleAndPickerForDashboardViewDelegate {
  
  func userSelected(numberOfElementInArrayOfUsers: Int)
  
}

class CustomTextFieldWithTitleAndPickerForDashboardView: UIView, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
  
  private var titleLabel: UILabel! = nil
  private var imageOfArrow: UIImageView! = nil
  private var mainPickerView: UIPickerView! = nil
  private var containerViewForPicker: UIView! = nil
  
  var mainTextField: UITextField! = nil
  
  private var textOfTitleString: String! = nil
  private var nameOfImageString: String?
  private var optionsOfPicker = [String]()
  
  var delegate: CustomTextFieldWithTitleAndPickerForDashboardViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, textLabel: String!?, nameOfImage: String?, newOptionsOfPicker: [String]!) {
    
    if nameOfImage != nil {
      
      nameOfImageString = nameOfImage!
      
    }
    
    if textLabel != nil {
      
      textOfTitleString = textLabel!
      
    }
    
    optionsOfPicker = newOptionsOfPicker
    
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.createContainerViewForPicker()
    self.createMainPickerView()
    self.createTitleLabel()
    self.createIconImageView()
    self.createMainTextField()
    
  }
  
  private func createContainerViewForPicker() {
    
    let frameForContainerView = CGRect.init(x: 0.0,
                                            y: 0.0,
                                            width: UIScreen.mainScreen().bounds.width,
                                            height: 250.0)
    
    containerViewForPicker = UIView.init(frame: frameForContainerView)
    containerViewForPicker.backgroundColor = UIColor.clearColor()
    
  }
  
  private func createMainPickerView() {
    
    let button = self.createGenericButton()
    containerViewForPicker.addSubview(button)
    
    let frameForPicker = CGRect.init(x: 0.0,
                                     y: button.frame.size.height + (5.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: UIScreen.mainScreen().bounds.width,
                                     height: 250.0 * UtilityManager.sharedInstance.conversionHeight)
    
    mainPickerView = UIPickerView.init(frame: frameForPicker)
    mainPickerView.delegate = self
    mainPickerView.dataSource = self
    containerViewForPicker.addSubview(mainPickerView)
    
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
    
    if textOfTitleString != nil {
      
      titleLabel = UILabel.init(frame: CGRectZero)
      
      let font = UIFont(name: "SFUIText-Medium",
                        size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
      let color = UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.25)
      let style = NSMutableParagraphStyle()
      style.alignment = NSTextAlignment.Center
      
      let stringWithFormat = NSMutableAttributedString(
        string: textOfTitleString!,
        attributes:[NSFontAttributeName:font!,
          NSParagraphStyleAttributeName:style,
          NSForegroundColorAttributeName:color
        ]
      )
      titleLabel!.attributedText = stringWithFormat
      titleLabel!.sizeToFit()
      
      let newFrame = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                 y: 0.0 * UtilityManager.sharedInstance.conversionHeight,
                                 width: titleLabel!.frame.size.width,
                                 height: titleLabel!.frame.size.height)
      
      titleLabel!.frame = newFrame
      self.addSubview(titleLabel!)
    }
    
  }
  
  private func createIconImageView() {
    
    let positionY: CGFloat
    
    if titleLabel != nil {
      
      positionY = titleLabel!.frame.origin.y + titleLabel!.frame.size.height + (36.0 * UtilityManager.sharedInstance.conversionHeight) //When has title but not icon
      
    } else {
      
      positionY = 24.0 * UtilityManager.sharedInstance.conversionHeight //When doesn't have an title but icon
      
    }
    
    
    if nameOfImageString != nil {
      
      imageOfArrow = UIImageView.init(image: UIImage.init(named: nameOfImageString!))
      let iconImageViewFrame = CGRect.init(x: 198.0 * UtilityManager.sharedInstance.conversionWidth,
                                           y: positionY,
                                           width: imageOfArrow!.frame.size.width,
                                           height: imageOfArrow!.frame.size.height)
      
      imageOfArrow!.frame = iconImageViewFrame
      
      let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(makeFirstResponderTheMainTextField))
      tapGesture.numberOfTapsRequired = 1
      
      imageOfArrow!.userInteractionEnabled = true
      imageOfArrow!.addGestureRecognizer(tapGesture)
      
      self.addSubview(imageOfArrow!)
      
    }
    
  }
  
  @objc private func makeFirstResponderTheMainTextField() {
    
    self.mainTextField.becomeFirstResponder()
    
  }
  
  private func createMainTextField() {
    
    var newPositionX: CGFloat
    var newPositionY: CGFloat
    var newWidth: CGFloat
    
    if imageOfArrow != nil {
      
      newPositionX = 10.0 * UtilityManager.sharedInstance.conversionWidth
      
      newWidth = (220.0 * UtilityManager.sharedInstance.conversionWidth) - (imageOfArrow!.frame.size.width + (20.0 * UtilityManager.sharedInstance.conversionWidth))
      
    } else {
      
      newPositionX = 10.0 * UtilityManager.sharedInstance.conversionWidth
      
      newWidth = 220.0 * UtilityManager.sharedInstance.conversionWidth
      
    }
    
    if titleLabel != nil {
      
      newPositionY = titleLabel!.frame.origin.y + titleLabel!.frame.size.height + (15.0 * UtilityManager.sharedInstance.conversionHeight)
      
    } else {
      
      newPositionY = 18.0 * UtilityManager.sharedInstance.conversionHeight
      
    }
    
    let frameForTextField = CGRect.init(x: newPositionX,
                                        y: newPositionY,
                                        width: newWidth,
                                        height: 50.0 * UtilityManager.sharedInstance.conversionHeight)
    
    mainTextField = UITextField.init(frame: frameForTextField)
    
    let border = CALayer()
    let width = CGFloat(0.5)
    border.borderColor = UIColor.darkGrayColor().CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: -10.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: mainTextField.frame.size.height + (1.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                               height: 0.5)
    mainTextField.layer.masksToBounds = false
    mainTextField.backgroundColor = UIColor.clearColor()
    mainTextField.layer.addSublayer(border)
    mainTextField.clearButtonMode = UITextFieldViewMode.WhileEditing
    mainTextField.inputView = containerViewForPicker
    mainTextField.font = UIFont(name:"SFUIText-Regular",
                                size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    mainTextField.delegate = self
    self.addSubview(mainTextField)
    
  }
  
  @objc private func okButtonPressed() {
    
    mainTextField.text = optionsOfPicker[mainPickerView.selectedRowInComponent(0)]
    
    self.endEditing(true)
    
    self.delegate?.userSelected(mainPickerView.selectedRowInComponent(0))
    
  }
  
  //MARK: - PickerViewDelegate - DataSource
  
  func numberOfComponentsInPickerView(picker: UIPickerView) -> Int {
    
    return 1
    
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
    return optionsOfPicker.count
    
  }
  
  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
    return optionsOfPicker[row]
    
  }
  
  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
    mainTextField.text = optionsOfPicker[row]
    
  }
  
  //MARK: - TextFieldDelegate
  
  func textFieldDidBeginEditing(textField: UITextField) {
    
    //self.delegate?.customTextFieldWithTitleAndPickerViewDidBeginEditing(self)
    
  }
  
}
