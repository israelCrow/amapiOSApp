//
//  CustomTextFieldWithTitleView.swift
//  Amap
//
//  Created by Mac on 8/16/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class CustomTextFieldWithTitleView: UIView {
  
  private var textOfTitleString: String?
  private var nameOfImageString: String?
  private var iconImageView: UIImageView?
  private var titleLabel: UILabel?
  var mainTextField: UITextField! = nil
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, title: String?, image: String?) {
    
    textOfTitleString = title
    nameOfImageString = image
    
    super.init(frame: frame)
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.createTitleLabel()
    self.createIconImageView()
    self.createMainTextField()
    
  }
  
  private func createTitleLabel() {
    
    if textOfTitleString != nil {
    
      titleLabel = UILabel.init(frame: CGRectZero)
    
      let font = UIFont(name: "SFUIText-Medium",
                        size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
      let color = UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
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
      
      positionY = titleLabel!.frame.origin.y + titleLabel!.frame.size.height + (29.0 * UtilityManager.sharedInstance.conversionHeight) //When has title but not icon
      
    } else {
      
      positionY = 29.0 * UtilityManager.sharedInstance.conversionHeight //When doesn't have an title but icon
      
    }
    
    
    if nameOfImageString != nil {
      
      iconImageView = UIImageView.init(image: UIImage.init(named: nameOfImageString!))
      let iconImageViewFrame = CGRect.init(x: 2.0 * UtilityManager.sharedInstance.conversionWidth,
                                           y: positionY,
                                       width: iconImageView!.frame.size.width,
                                      height: iconImageView!.frame.size.height)
      
      iconImageView!.frame = iconImageViewFrame
      
      self.addSubview(iconImageView!)
      
    }
    
    
  }
  
  private func createMainTextField() {

    var newPositionX: CGFloat
    var newPositionXForLine: CGFloat
    var newPositionY: CGFloat
    var newWidth: CGFloat
    var newWidthForLine: CGFloat
    
    if iconImageView != nil {
      
      newPositionX = iconImageView!.frame.origin.x + iconImageView!.frame.size.width + (20.0 * UtilityManager.sharedInstance.conversionWidth)
      
      newWidth = (220.0 * UtilityManager.sharedInstance.conversionWidth) - (iconImageView!.frame.origin.x + iconImageView!.frame.size.width + (20.0 * UtilityManager.sharedInstance.conversionWidth))
      
      newWidthForLine = newPositionX + newWidth
      
      newPositionXForLine = -newPositionX
      
      
    } else {
      
      newPositionX = 4.0 * UtilityManager.sharedInstance.conversionWidth
      
      newWidth = 220.0 * UtilityManager.sharedInstance.conversionWidth
      
      newPositionXForLine = -4.0 * UtilityManager.sharedInstance.conversionWidth
      
      newWidthForLine = 220.0 * UtilityManager.sharedInstance.conversionWidth
      
    }
    
    if titleLabel != nil {
      
      newPositionY = titleLabel!.frame.origin.y + titleLabel!.frame.size.height + (13.0 * UtilityManager.sharedInstance.conversionHeight)
      
    } else {
      
      newPositionY = 16.0 * UtilityManager.sharedInstance.conversionHeight
      
    }
    
    let frameForTextField = CGRect.init(x: newPositionX,
                                    y: newPositionY,
                                    width: newWidth,
                                    height: 44.0 * UtilityManager.sharedInstance.conversionHeight)
    
    mainTextField = UITextField.init(frame: frameForTextField)
    
    mainTextField.backgroundColor = UIColor.clearColor()
    
    let border = CALayer()
    let width = CGFloat(0.5)
    border.borderColor = UIColor.darkGrayColor().CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: newPositionXForLine,
                               y: mainTextField.frame.size.height + (1.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: newWidthForLine,
                               height: 0.5)
    mainTextField.layer.masksToBounds = false
    mainTextField.layer.addSublayer(border)
    mainTextField.clearButtonMode = UITextFieldViewMode.WhileEditing
    mainTextField.font = UIFont(name:"SFUIText-Regular",
                                 size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    self.addSubview(mainTextField)

  }
  
}
