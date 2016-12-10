//
//  PitchRecommendationView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 12/9/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class PitchRecommendationView: UIView {
  
  private var recommendationImage: UIImageView! = nil
  private var recommendationLabel: UILabel! = nil
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, imageName: String, textLabel: String) {
    
    super.init(frame: frame)
    
    self.initInterface(imageName, textLabel: textLabel)
    
  }
  
  private func initInterface(imageName: String, textLabel: String) {
    
    self.createRecommendationImage(imageName)
    self.createRecommendationLabel(textLabel)
    
  }
  
  private func createRecommendationImage(imageName: String) {
    
    recommendationImage = UIImageView.init(image: UIImage.init(named: imageName))
    let frameForImageView = CGRect.init(x: (self.frame.size.width / 2.0) - (10.5 * UtilityManager.sharedInstance.conversionWidth),
                                        y: 0.0,
                                        width: 21.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 21.0 * UtilityManager.sharedInstance.conversionHeight)
    recommendationImage.frame = frameForImageView
    
    self.addSubview(recommendationImage)
    
  }
  
  private func createRecommendationLabel(textLabel: String) {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 94.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: 50.0 * UtilityManager.sharedInstance.conversionHeight)
    
    recommendationLabel = UILabel.init(frame: frameForLabel)
    recommendationLabel.numberOfLines = 4
    recommendationLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: textLabel,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    recommendationLabel.attributedText = stringWithFormat
    recommendationLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (recommendationLabel.frame.size.width / 2.0),
                               y: recommendationImage.frame.origin.y + recommendationImage.frame.size.width + (7.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: recommendationLabel.frame.size.width,
                               height: recommendationLabel.frame.size.height)
    
    recommendationLabel.frame = newFrame
    
    self.addSubview(recommendationLabel)
    
  }
  
  
}