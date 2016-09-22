//
//  CustomSkillTableViewCell.swift
//  Amap
//
//  Created by Mac on 8/16/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol CustomSkillTableViewCellDelegate {
  
  func changeValueOfCell(sender: CustomSkillTableViewCell)
  
}

class CustomSkillTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
  
  var scoreTextField: UITextField! = nil
//  private var optionsOfScorePickerView: UIPickerView! = nil
  private var arrayOfOptions: [Int]! = nil
  
  private var containerViewForPicker: UIView! = nil
  private var mainPickerView: UIPickerView! = nil

  var skillData: Skill! = nil
  var delegate: CustomSkillTableViewCellDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {

    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.initSomeValues()
    self.initInterface()

  }
  
  private func initSomeValues() {
    
    arrayOfOptions = [0, 1, 2, 3]
    
  }
  
  private func initInterface() {
  
    self.createContainerViewForPicker()
    self.createMainPickerView()
    self.createScoreTextField()
    self.createOptionsOfScorePickerView()
  
  }
  
  private func createContainerViewForPicker() {
    
    let frameForContainerView = CGRect.init(x: 0.0,
                                            y: 0.0,
                                            width: UIScreen.mainScreen().bounds.width,
                                            height: 150.0)
    
    containerViewForPicker = UIView.init(frame: frameForContainerView)
    containerViewForPicker.backgroundColor = UIColor.clearColor()
    
  }
  
  private func createMainPickerView() {
    
    let button = self.createGenericButton()
    containerViewForPicker.addSubview(button)
    
    let frameForPicker = CGRect.init(x: 0.0,
                                     y: button.frame.size.height + (5.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: UIScreen.mainScreen().bounds.width,
                                     height: 100.0 * UtilityManager.sharedInstance.conversionHeight)
    
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
    
    let frameForButton = CGRect.init(x: (containerViewForPicker.frame.size.width / 2.0) - (okButton.frame.size.width / 2.0),
                                     y: 8.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: okButton.frame.size.width,
                                     height: okButton.frame.size.height)
    
    okButton.frame = frameForButton
    okButton.layer.cornerRadius = 3.0
    
    return okButton
    
  }

  
  private func createScoreTextField() {
    
    let frameForScoreTextField = CGRect.init(x: 180.0 * UtilityManager.sharedInstance.conversionWidth,
                                             y: 15.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: 35.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 25.0 * UtilityManager.sharedInstance.conversionHeight)
    
    scoreTextField = UITextField.init(frame: frameForScoreTextField)
    scoreTextField.clearButtonMode = .WhileEditing
    scoreTextField.delegate = self
    scoreTextField.font = UIFont(name:"SFUIText-Regular",
                                 size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    
    self.addSubview(scoreTextField)
    
    let border = CALayer()
    let width = CGFloat(0.5)
    border.borderColor = UIColor.lightGrayColor().CGColor
    let frameForLine = CGRect(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                              y: scoreTextField.frame.size.height - (2.0 * UtilityManager.sharedInstance.conversionHeight),
                          width: scoreTextField.frame.size.width,
                         height: 0.5)
    border.borderWidth = width
    border.frame = frameForLine
    scoreTextField.layer.addSublayer(border)
    scoreTextField.inputView = containerViewForPicker
    
  }
  
  private func createOptionsOfScorePickerView() {

  
  }
  
  func textFieldDidBeginEditing(textField: UITextField) {
    
    self.delegate?.changeValueOfCell(self)
    
  }
  
  func setSkillData(newSkillData: Skill) {
    
    self.skillData = newSkillData
    
  }
  
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return arrayOfOptions.count
  }
  
  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return String(arrayOfOptions[row])
  }
  
  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    scoreTextField.text = String(arrayOfOptions[row])
  }
  
  @objc private func okButtonPressed() {

    self.endEditing(true)
    
  }
  
  
}
