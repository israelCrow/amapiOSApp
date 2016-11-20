//
//  WelcomeScreenTutorialView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 11/17/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class WelcomeScreenTutorialView: UIView {
  
  private var welcomeLabel: UILabel! = nil
  private var descriptionLabel: UILabel! = nil
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect){
    
    super.init(frame: UIScreen.mainScreen().bounds)
    
    self.initInterface()
    self.addGesture()
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.init(white: 0.0, alpha: 0.85)
    
    self.createWelcomeLabel()
    self.createDescriptionLabel()
    
  }

  private func createWelcomeLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 190.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    welcomeLabel = UILabel.init(frame: frameForLabel)
    welcomeLabel.numberOfLines = 0
    welcomeLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 38.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: TutorialConstants.WelcomeScreen.welcomeMessageText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    welcomeLabel.attributedText = stringWithFormat
    welcomeLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (welcomeLabel.frame.size.width / 2.0),
                               y: 267.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: welcomeLabel.frame.size.width,
                               height: welcomeLabel.frame.size.height)
    
    welcomeLabel.frame = newFrame
    
    self.addSubview(welcomeLabel)

    
  }
  
  private func createDescriptionLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 190.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    descriptionLabel = UILabel.init(frame: frameForLabel)
    descriptionLabel.numberOfLines = 0
    descriptionLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: TutorialConstants.WelcomeScreen.descriptionText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    descriptionLabel.attributedText = stringWithFormat
    descriptionLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (descriptionLabel.frame.size.width / 2.0),
                               y: 332.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: descriptionLabel.frame.size.width,
                               height: descriptionLabel.frame.size.height)
    
    descriptionLabel.frame = newFrame
    
    self.addSubview(descriptionLabel)
    
  }
  
  private func addGesture() {
    
    let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapToThisView))
    tapGesture.numberOfTapsRequired = 1
    
    self.addGestureRecognizer(tapGesture)
    
  }
  
  @objc private func tapToThisView() {
    
    self.removeFromSuperview()
    
  }
  
  
}