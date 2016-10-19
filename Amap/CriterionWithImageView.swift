//
//  CriterionWithImageView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/18/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol CriterionWithImageViewDelegate {
  
  func theValueHasChangedFromCriterionWithImage(isValueChanged: Bool)
  
}

class CriterionWithImageView: UIView, CustomSwitchViewActionsDelegate {
  
  private var nameImageText: String! = nil
  private var imageView: UIImageView! = nil
  private var selectValueSwitch: CustomSwitchView! = nil
  private var initialValueFromSwitch: Bool = false
  var criterionId: String! = nil
  
  var delegate: CriterionWithImageViewDelegate?
  
  init(frame: CGRect, nameImage: String, valueOfSwitch: Bool){
    initialValueFromSwitch = valueOfSwitch
    nameImageText = nameImage
    
    super.init(frame: frame)
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.createImageView()
    self.createSelectValueSwitch()
    self.createBottomLine()
    
  }
  
  private func createImageView() {
    
    imageView = UIImageView.init(image: UIImage.init(named: nameImageText))
    let newFrameOfImageView = CGRect.init(x: 8.0 * UtilityManager.sharedInstance.conversionWidth,
                                               y: 17.0 * UtilityManager.sharedInstance.conversionHeight,
                                               width: 25.0 * UtilityManager.sharedInstance.conversionHeight,
                                               height: 24.1 * UtilityManager.sharedInstance.conversionHeight)
    imageView.frame = newFrameOfImageView
    self.addSubview(imageView)
    
  }
  
  private func createSelectValueSwitch() {
    let frameForSwitch = CGRect.init(x: 182.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 17.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 36.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 22.0 * UtilityManager.sharedInstance.conversionHeight)
    
    selectValueSwitch = CustomSwitchView.init(frame: frameForSwitch, valueOfSwitch: initialValueFromSwitch)
    selectValueSwitch.clipsToBounds = false
    selectValueSwitch.delegateForActions = self
    self.addSubview(selectValueSwitch)
    
  }
  
  private func createBottomLine() {

    let border = CALayer()
    let width = CGFloat(1)
    border.borderColor = UIColor.darkGrayColor().CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 0.0,
                               y: self.frame.size.height - (2.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: 220 * UtilityManager.sharedInstance.conversionWidth,
                               height: 1.0 * UtilityManager.sharedInstance.conversionHeight)
    self.layer.addSublayer(border)
    self.layer.masksToBounds = true
    
  }
  
  func getValueOfSwitch() -> Bool {
    
    return selectValueSwitch.isOn
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - CustomSwitchViewActionsDelegate
  
  func customSwitchChangedItsValue(valueSelected: Bool) {
    
    self.delegate?.theValueHasChangedFromCriterionWithImage(true)
    
  }
  
}