//
//  PitchCategoryTableViewCell.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/12/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class PitchCategoryTableViewCell: UITableViewCell {
  
  private var pitchCategoryData: PitchCategory! = nil
  var customSwitch: CustomSwitchView! = nil
  

  func changePitchCategoryData(newPitchCategoryData: PitchCategory){
    
    pitchCategoryData = newPitchCategoryData
    self.changeNameLabel()
    self.changeCustomSwitch()
    
  }
  
  private func changeNameLabel() {
    
    if textLabel != nil {
      
      textLabel?.text = nil
      textLabel?.attributedText = nil
      
    }
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.init(red: 143.0/255.0, green: 142.0/255.0, blue: 148.0/255.0, alpha: 1.0)
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: pitchCategoryData.pitchCategoryName,
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    
    textLabel?.attributedText = stringWithFormat
    
  }
  
  private func changeCustomSwitch() {
    
    if customSwitch != nil {
      
      customSwitch.removeFromSuperview()
      customSwitch = nil
      
    }
    
    let frameForSwitch = CGRect.init(x: 196.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 17.0 * UtilityManager.sharedInstance.conversionHeight,
                                 width: 36.0 * UtilityManager.sharedInstance.conversionWidth,
                                height: 22.0 * UtilityManager.sharedInstance.conversionHeight)
    
    customSwitch = CustomSwitchView.init(frame: frameForSwitch, valueOfSwitch:pitchCategoryData.isThisCategory)
    
    self.addSubview(customSwitch)
    
  }
  
  
  
}
