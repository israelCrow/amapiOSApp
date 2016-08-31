//
//  CriterionView.swift
//  Amap
//
//  Created by Mac on 8/12/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class CriterionView: UIView {
  
  private var descriptionLabel: UILabel! = nil
  private var descriptionText: String! = nil
  private var selectValueSwitch: CustomSwitchView! = nil
  private var initialValueFromSwitch: Bool = false
  
  init(frame: CGRect, textLabel: String, valueOfSwitch: Bool){
    initialValueFromSwitch = valueOfSwitch
    descriptionText = textLabel
    
    super.init(frame: frame)
    self.initInterface()
    
  }
  
  private func initInterface() {
  
    self.createDescriptionLabel()
    self.createSelectValueSwitch()
  
  }
  
  private func createDescriptionLabel() {
    
    descriptionLabel = UILabel.init(frame: CGRectZero)
    descriptionLabel.numberOfLines = 2
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: self.descriptionText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    descriptionLabel.attributedText = stringWithFormat
    let newFrame = CGRect.init(x: 14.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 0.0,
                               width: 155.0 * UtilityManager.sharedInstance.conversionWidth,
                               height: 32.0 * UtilityManager.sharedInstance.conversionHeight)
    
    descriptionLabel.frame = newFrame
    descriptionLabel.sizeToFit()
    
    self.addSubview(descriptionLabel)
    
  }
  
  private func createSelectValueSwitch() {
    let frameForSwitch = CGRect.init(x: 184.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 0.0,
                                 width: 36.0 * UtilityManager.sharedInstance.conversionWidth,
                                height: 22.0 * UtilityManager.sharedInstance.conversionHeight)
    
    selectValueSwitch = CustomSwitchView.init(frame: frameForSwitch, valueOfSwitch: initialValueFromSwitch)
    selectValueSwitch.clipsToBounds = false
    self.addSubview(selectValueSwitch)
    
  }
  
  func adaptSize() {
    
    let newFrame = CGRect.init(x: self.frame.origin.x,
                               y: self.frame.origin.y,
                           width: self.frame.size.width,
                          height: descriptionLabel.frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight))
    self.frame = newFrame
    
    let border = CALayer()
    let width = CGFloat(1)
    border.borderColor = UIColor.darkGrayColor().CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 0.0,
                               y: self.frame.size.height - (2.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: 220 * UtilityManager.sharedInstance.conversionWidth,
                               height: 1.0)
    self.layer.addSublayer(border)
    self.layer.masksToBounds = true

  }
  
  func getValueOfSwitch() -> Bool {
  
    return selectValueSwitch.isOn
  
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
}
