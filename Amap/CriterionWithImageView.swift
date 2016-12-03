//
//  CriterionWithImageView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/18/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol CriterionWithImageViewDelegate {
  
  func theValueHasChangedFromCriterionWithImage(valueChangedTo: Bool, sender: CriterionWithImageView)
  
}

class CriterionWithImageView: UIView, CustomSwitchViewActionsDelegate {
  
  private var nameImageText: String! = nil
  private var imageView: UIImageView! = nil
  private var textAfterImageLabel: UILabel! = nil
  private var textAfterImageString: String = ""
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
  
  init(frame: CGRect, nameImage: String, valueOfSwitch: Bool, newTextAfterImage: String){
    initialValueFromSwitch = valueOfSwitch
    nameImageText = nameImage
    textAfterImageString = newTextAfterImage
    
    super.init(frame: frame)
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.createImageView()
    
    if textAfterImageString != "" {
      
      self.createTextAfterImageLabel()
      
    }
    
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
  
  private func createTextAfterImageLabel() {
  
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 80.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    textAfterImageLabel = UILabel.init(frame: frameForLabel)
    textAfterImageLabel.numberOfLines = 0
    textAfterImageLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: textAfterImageString,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    textAfterImageLabel.attributedText = stringWithFormat
    textAfterImageLabel.sizeToFit()
    let newFrame = CGRect.init(x: 46.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 20.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: textAfterImageLabel.frame.size.width,
                               height: textAfterImageLabel.frame.size.height)
    
    textAfterImageLabel.frame = newFrame
    
    self.addSubview(textAfterImageLabel)
  
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
    
    self.delegate?.theValueHasChangedFromCriterionWithImage(valueSelected, sender: self)
    
  }
  
}