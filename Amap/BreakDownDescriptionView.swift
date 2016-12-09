//
//  BreakDownDescriptionView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 12/8/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class BreakDownDescription: UIView {
  
  private var descriptionLabel: UILabel! = nil
  private var percentageLabel: UILabel! = nil
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newDescriptionText: String, newPercentageText: String) {
    
    super.init(frame: frame)
    
    self.initInterface(newDescriptionText, percentageText: newPercentageText)
    
  }
  
  private func initInterface(descriptionText: String, percentageText: String) {
    
    self.createDescriptionLabel(descriptionText)
    self.createPercentageLabel(percentageText)
    
  }
  
  private func createDescriptionLabel(descriptionText: String) {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 225.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    descriptionLabel = UILabel.init(frame: frameForLabel)
    descriptionLabel.numberOfLines = 0
    descriptionLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: descriptionText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    descriptionLabel.attributedText = stringWithFormat
    descriptionLabel.sizeToFit()
    let newFrame = CGRect.init(x: 0.0,
                               y: 0.0,
                               width: descriptionLabel.frame.size.width,
                               height: descriptionLabel.frame.size.height)
    
    descriptionLabel.frame = newFrame
    
    let newFrameForView = CGRect.init(x: self.frame.origin.x,
                                      y: self.frame.origin.y,
                                  width: self.frame.size.width,
                                 height: descriptionLabel.frame.size.height + (2.0 * UtilityManager.sharedInstance.conversionHeight))
    
    self.frame = newFrameForView
    
    self.addSubview(descriptionLabel)
    
  }
  
  private func createPercentageLabel(percentageText: String) {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 225.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    percentageLabel = UILabel.init(frame: frameForLabel)
    percentageLabel.numberOfLines = 0
    percentageLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 24.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: percentageText + "%",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    percentageLabel.attributedText = stringWithFormat
    percentageLabel.sizeToFit()
    let newFrame = CGRect.init(x: 258.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: (self.frame.size.height / 2.0) - (percentageLabel.frame.size.height / 2.0),
                           width: percentageLabel.frame.size.width,
                          height: percentageLabel.frame.size.height)
    
    percentageLabel.frame = newFrame
    
    self.addSubview(percentageLabel)
    
  }
  
}
