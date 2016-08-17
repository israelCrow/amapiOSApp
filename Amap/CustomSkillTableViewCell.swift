//
//  CustomSkillTableViewCell.swift
//  Amap
//
//  Created by Mac on 8/16/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class CustomSkillTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
  
  private var scoreTextField: UITextField! = nil
  private var optionsOfScorePickerView: UIPickerView! = nil
  private var arrayOfOptions: [Int]! = nil
  
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
  
    self.createScoreTextField()
    self.createOptionsOfScorePickerView()
  
  }
  
  private func createScoreTextField() {
    
    let frameForScoreTextField = CGRect.init(x: 200.0 * UtilityManager.sharedInstance.conversionWidth,
                                             y: 20.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: 15.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 25.0 * UtilityManager.sharedInstance.conversionHeight)
    
    scoreTextField = UITextField.init(frame: frameForScoreTextField)
    
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
    
  }
  
  private func createOptionsOfScorePickerView() {
  
    optionsOfScorePickerView = UIPickerView()
    optionsOfScorePickerView.delegate = self
    scoreTextField.inputView = optionsOfScorePickerView
  
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
  
}
