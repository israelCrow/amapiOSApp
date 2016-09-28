//
//  CustomSegmentedControlWithTitleView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/18/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol CustomSegmentedControlWithTitleViewDelegate {
  
  func customSegmentedControlWithTitleViewDidBeginEditing(sender: AnyObject)
  
}

class CustomSegmentedControlWithTitleView: UIView {
  
  private var textOfTitleString: String?
  private var nameOfImageString: String?
  private var iconImageView: UIImageView?
  private var titleLabel: UILabel?
  private var arrayOfSegments: [String]! = nil
  var mainSegmentedControl: UISegmentedControl! = nil
  
  var delegate : CustomSegmentedControlWithTitleViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, title: String?, image: String?, segmentsText: [String]) {
    
    arrayOfSegments = segmentsText
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
      
      let frameForLabel = CGRect.init(x: 0.0,
                                      y: 0.0,
                                      width: 210.0 * UtilityManager.sharedInstance.conversionWidth,
                                      height: CGFloat.max)
      
      titleLabel = UILabel.init(frame: frameForLabel)
      titleLabel!.numberOfLines = 0
      titleLabel!.lineBreakMode = .ByWordWrapping
      
      let font = UIFont(name: "SFUIText-Medium",
                        size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
      let color = UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.25)
      let style = NSMutableParagraphStyle()
      style.alignment = NSTextAlignment.Left
      
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
      
      positionY = titleLabel!.frame.origin.y + titleLabel!.frame.size.height + (18.0 * UtilityManager.sharedInstance.conversionHeight) //When has title but not icon
      
    } else {
      
      positionY = 24.0 * UtilityManager.sharedInstance.conversionHeight //When doesn't have an title but icon
      
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
//    var newPositionXForLine: CGFloat
    var newPositionY: CGFloat
    var newWidth: CGFloat
//    var newWidthForLine: CGFloat
    
    if iconImageView != nil {
      
      newPositionX = iconImageView!.frame.origin.x + iconImageView!.frame.size.width + (20.0 * UtilityManager.sharedInstance.conversionWidth)
      
      newWidth = (210.0 * UtilityManager.sharedInstance.conversionWidth) - (iconImageView!.frame.origin.x + iconImageView!.frame.size.width + (20.0 * UtilityManager.sharedInstance.conversionWidth))
      
//      newWidthForLine = newPositionX + newWidth
      
//      newPositionXForLine = -newPositionX
      
      
    } else {
      
      newPositionX = 4.0 * UtilityManager.sharedInstance.conversionWidth
      
      newWidth = 210.0 * UtilityManager.sharedInstance.conversionWidth
      
//      newPositionXForLine = -4.0 * UtilityManager.sharedInstance.conversionWidth
//      
//      newWidthForLine = 220.0 * UtilityManager.sharedInstance.conversionWidth
      
    }
    
    if titleLabel != nil {
      
      newPositionY = titleLabel!.frame.origin.y + titleLabel!.frame.size.height + (13.0 * UtilityManager.sharedInstance.conversionHeight)
      
    } else {
      
      newPositionY = 16.0 * UtilityManager.sharedInstance.conversionHeight
      
    }
    
    let frameForSegmentedControl = CGRect.init(x: newPositionX,
                                        y: newPositionY,
                                        width: newWidth,
                                        height: 30.0 * UtilityManager.sharedInstance.conversionHeight)
    
    mainSegmentedControl = UISegmentedControl.init(items: arrayOfSegments)
    mainSegmentedControl.addTarget(self,
                                   action: #selector(mainSegmentedControlEditingDidBegin),
                         forControlEvents: UIControlEvents.ValueChanged)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let attributes = [NSFontAttributeName:font!,
            NSParagraphStyleAttributeName:style,
           NSForegroundColorAttributeName:color]
    
    mainSegmentedControl.setTitleTextAttributes(attributes, forState: .Normal)
    
    mainSegmentedControl.frame = frameForSegmentedControl
    mainSegmentedControl.layer.borderColor = UIColor.clearColor().CGColor
    mainSegmentedControl.layer.borderWidth = 0.0
    
    mainSegmentedControl.setDividerImage(self.imageWithColor(UIColor.clearColor()), forLeftSegmentState: UIControlState.Normal, rightSegmentState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
    
    mainSegmentedControl.setBackgroundImage(self.imageWithColor(UIColor.clearColor()), forState:UIControlState.Normal, barMetrics:UIBarMetrics.Default)
    
    mainSegmentedControl.setBackgroundImage(self.imageWithColor(UIColor.blackColor()), forState:UIControlState.Selected, barMetrics:UIBarMetrics.Default);
    
    for  borderview in mainSegmentedControl.subviews {
      
      let upperBorder: CALayer = CALayer()
      upperBorder.backgroundColor = UIColor.clearColor().CGColor
      upperBorder.frame = CGRectMake(0, borderview.frame.size.height-1, borderview.frame.size.width, 1.0);
      borderview.layer .addSublayer(upperBorder);
      
    }
    
    for index in 0..<arrayOfSegments.count {
      
      mainSegmentedControl.setWidth(72.0 * UtilityManager.sharedInstance.conversionWidth,
                                    forSegmentAtIndex: index)
      
    }
    
    for segment in mainSegmentedControl.subviews {
      
      segment.tintColor = UIColor.blackColor()
      segment.layer.borderColor = UIColor.clearColor().CGColor
      segment.layer.borderWidth = 0.0
      
    }
    
    let border = CALayer()
    let width = CGFloat(0.5)
    border.borderColor = UIColor.darkGrayColor().CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 0.0,
                               y: self.frame.size.height - (0.5 * UtilityManager.sharedInstance.conversionHeight),
                               width: self.frame.size.width,
                               height: 0.5 * UtilityManager.sharedInstance.conversionHeight)
    self.layer.masksToBounds = false
    self.layer.addSublayer(border)
    mainSegmentedControl.backgroundColor = UIColor.whiteColor()
    
    self.addSubview(mainSegmentedControl)
    
  }
  
  private func imageWithColor(color: UIColor) -> UIImage {
    
    let rect = CGRectMake(0.0, 0.0, 1.0, mainSegmentedControl.frame.size.height)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    let image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image
    
  }
  
  func returnValueSelectedFromSegmentControl() -> String {
    
    return arrayOfSegments[mainSegmentedControl.selectedSegmentIndex]
    
  }
  
  @objc private func mainSegmentedControlEditingDidBegin() {
  
    self.delegate?.customSegmentedControlWithTitleViewDidBeginEditing(self)
  
  }
  
}