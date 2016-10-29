//
//  SimpleIconLabelView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/29/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class SimpleIconLabelView: UIView {
  
  private var textOfLabel: String! = nil
  private var descriptionLabel: UILabel! = nil
  private var nameOfIcon: String! = nil
  private var iconView: UIImageView! = nil
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newTextOfLabel: String, newNameOfIcon: String) {
    
    textOfLabel = newTextOfLabel
    nameOfIcon = newNameOfIcon
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.clearColor()
    self.createIconView()
    self.createLabel()
    
  }
  
  private func createIconView() {
    
    iconView = UIImageView.init(image: UIImage.init(named: nameOfIcon))
    let canceledImageViewFrame = CGRect.init(x: 0.0,
                                             y: 5.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: iconView.frame.size.width,
                                        height: iconView.frame.size.height)
    
    iconView.frame = canceledImageViewFrame
    
    self.addSubview(iconView)
    
  }
  
  private func createLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 158.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    descriptionLabel = UILabel.init(frame: frameForLabel)
    descriptionLabel.numberOfLines = 0
    descriptionLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: textOfLabel,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    descriptionLabel.attributedText = stringWithFormat
    descriptionLabel.sizeToFit()
    let newFrame = CGRect.init(x: 35.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 0.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: descriptionLabel.frame.size.width,
                               height: descriptionLabel.frame.size.height)
    
    descriptionLabel.frame = newFrame
    
    self.addSubview(descriptionLabel)

    
  }
  

  
}
