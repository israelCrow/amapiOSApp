//
//  CollapsibleTableViewHeader.swift
//  Amap
//
//  Created by Mac on 8/15/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class CollapsibleTableViewHeader: UITableViewCell {
  
  private var skillImageView: UIImageView! = nil
  var nameOfSkillLabel: UILabel! = nil
  var toggleButton: UIButton! = nil
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.initInterface()
  }
  
  private func initInterface() {
    
    self.contentView.backgroundColor = UIColor.whiteColor()
    
    self.createSkillImageView()
    self.createToggleButton()
    
  }
  
  private func createSkillImageView() {
    
    skillImageView = UIImageView.init(image: UIImage.init(named: "starCopy"))
    let newFrameOfSkillImageView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                               y: 17.0 * UtilityManager.sharedInstance.conversionHeight,
                                               width: skillImageView.frame.size.width,
                                               height: skillImageView.frame.size.height)
    skillImageView.frame = newFrameOfSkillImageView
    self.contentView.addSubview(skillImageView)
    
  }
  
  private func createToggleButton() {
    
    let newFrameNameOfToggleButton = CGRect.init(x: 201.0 * UtilityManager.sharedInstance.conversionWidth,
                                                 y: 17.0 * UtilityManager.sharedInstance.conversionHeight,
                                                 width: 22.0 * UtilityManager.sharedInstance.conversionWidth,
                                                 height: 22.0 * UtilityManager.sharedInstance.conversionHeight)
    
    
    toggleButton = UIButton.init(frame: newFrameNameOfToggleButton)
//    toggleButton.backgroundColor = UIColor.redColor()
    let imageToggleButton = UIImage.init(named: "dropdown")
    toggleButton.setImage(imageToggleButton, forState: .Normal)
    toggleButton.frame = newFrameNameOfToggleButton
    
    self.contentView.addSubview(toggleButton)
    
  }
  
  func setMutableAttributedStringOfNameOfSkillLabel(nameSkill: String) {
    
    nameOfSkillLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: nameSkill,
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    nameOfSkillLabel.attributedText = stringWithFormat
    nameOfSkillLabel.sizeToFit()
    let newFrame = CGRect.init(x: 22.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 18.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: nameOfSkillLabel.frame.size.width,
                               height: nameOfSkillLabel.frame.size.height)
    
    nameOfSkillLabel.frame = newFrame
    
    self.contentView.addSubview(nameOfSkillLabel)
    
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
