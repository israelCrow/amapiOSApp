//
//  PitchRecommendationImageLabelView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 12/16/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class PitchRecommendationImageLabelView: UIView {
  
  private var iconName: String! = nil
  private var recommendationText: String! = nil

  private var icon: UIImageView! = nil
  private var recommendationLabel: UILabel! = nil
  private var createForDashboard: Bool = false
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newIconName: String, newRecommendationText: String) {
    
    iconName = newIconName
    recommendationText = newRecommendationText
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  init(frame: CGRect, newIconName: String, newRecommendationText: String, newCreateForDashboard: Bool) {
    
    createForDashboard = newCreateForDashboard
    iconName = newIconName
    recommendationText = newRecommendationText
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.createLabel()
    self.createIcon()
    
  }
  
  private func createLabel() {
    
    var widthForLabel: CGFloat = 261.0 * UtilityManager.sharedInstance.conversionWidth
    
    if createForDashboard == true {
      
      widthForLabel = 193.0 * UtilityManager.sharedInstance.conversionWidth
      
    }
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: widthForLabel,
                                    height: CGFloat.max)
    
    recommendationLabel = UILabel.init(frame: frameForLabel)
    recommendationLabel.numberOfLines = 0
    recommendationLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Justified
    
    let stringWithFormat = NSMutableAttributedString(
      string: recommendationText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    recommendationLabel.attributedText = stringWithFormat
    recommendationLabel.sizeToFit()
    let newFrame = CGRect.init(x: 34.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 0.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: recommendationLabel.frame.size.width,
                               height: recommendationLabel.frame.size.height)
    
    recommendationLabel.frame = newFrame
    
    let frameForView = CGRect.init(x: self.frame.origin.x,
                                   y: self.frame.origin.y,
                               width: self.frame.size.width,
                              height: recommendationLabel.frame.size.height)
    
    self.frame = frameForView
    
    self.addSubview(recommendationLabel)

  }
  
  private func createIcon() {
    
    icon = UIImageView.init(image: UIImage.init(named: iconName))
    let imageViewFrame = CGRect.init(x: 0.0,
                                     y: (self.frame.size.height / 2.0) - (icon.frame.size.height / 2.0),
                                 width: icon.frame.size.width,
                                height: icon.frame.size.height)
    icon.frame = imageViewFrame
    
    self.addSubview(icon)
    
  }
  
}
