//
//  CreateAccountProcessAlreadyBegunView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/4/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class CreateAccountProcessAlreadyBegunView: UIView {
  
  private var errorImageView: UIImageView! = nil
  private var oopsLabel: UILabel! = nil
  private var alreadyBegunProcessLabel: UILabel! = nil
  private var nextButton: UIButton! = nil
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.initInterface()
  }
  
  private func initInterface() {
    self.backgroundColor = UIColor.whiteColor()
    
    //    self.addActions()
    self.createLikeImageView()
    self.createOopsLabel()
    self.createAlreadyBegunProcessLabel()
    self.createNextButton()
    
  }
  
  private func createLikeImageView() {
    errorImageView = UIImageView.init(image: UIImage.init(named: "error"))
    let frameForImageView = CGRect.init(x: (self.frame.size.width / 2.0) - (errorImageView.frame.size.width / 2.0),
                                        y: 40.0 * UtilityManager.sharedInstance.conversionHeight,
                                    width: errorImageView.frame.size.width,
                                   height: errorImageView.frame.size.height)
    errorImageView.frame = frameForImageView
    
    self.addSubview(errorImageView)
  }
  
  private func createOopsLabel() {
    
    oopsLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 53.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: CreateAccountConstants.ExistingAccountView.oopsText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    oopsLabel.attributedText = stringWithFormat
    oopsLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (oopsLabel.frame.size.width / 2.0),
                               y: errorImageView.frame.origin.y + errorImageView.frame.size.height + (33.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: oopsLabel.frame.size.width,
                               height: oopsLabel.frame.size.height)
    
    oopsLabel.frame = newFrame
    
    self.addSubview(oopsLabel)
    
  }
  
  private func createAlreadyBegunProcessLabel() {
    
    alreadyBegunProcessLabel = UILabel.init(frame: CGRect.init(x: 0.0,
      y: 0.0,
      width: self.frame.size.width - (63.0 * UtilityManager.sharedInstance.conversionWidth),
      height: 0.0))
    alreadyBegunProcessLabel.adjustsFontSizeToFitWidth = true
    alreadyBegunProcessLabel.numberOfLines = 5
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: CreateAccountConstants.CreateAccountProcessAlreadyBegunView.alreadyBegunProcessText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    alreadyBegunProcessLabel.attributedText = stringWithFormat
    alreadyBegunProcessLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (alreadyBegunProcessLabel.frame.size.width / 2.0),
                               y: oopsLabel.frame.origin.y + oopsLabel.frame.size.height + (40.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: alreadyBegunProcessLabel.frame.size.width,
                               height: alreadyBegunProcessLabel.frame.size.height)
    
    alreadyBegunProcessLabel.frame = newFrame
    
    self.addSubview(alreadyBegunProcessLabel)
    
  }
  
  private func createNextButton() {
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let colorWhenPressed = UIColor.greenColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: CreateAccountConstants.ExistingAccountView.nextButtonText ,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    let stringWithFormatWithPressed = NSMutableAttributedString(
      string: CreateAccountConstants.ExistingAccountView.nextButtonText ,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: colorWhenPressed
      ]
    )
    
    let frameForButton = CGRect.init(x: 0.0, y: self.frame.size.height - (70.0 * UtilityManager.sharedInstance.conversionHeight), width: self.frame.size.width, height: (70.0 * UtilityManager.sharedInstance.conversionHeight))
    nextButton = UIButton.init(frame: frameForButton)
    nextButton.addTarget(self,
                         action: #selector(doSomething),
                         forControlEvents: .TouchUpInside)
    nextButton.backgroundColor = UIColor.blackColor()
    nextButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    nextButton.setAttributedTitle(stringWithFormatWithPressed, forState: .Highlighted)
    
    self.addSubview(nextButton)
  }
  
  @objc private func doSomething() {
    
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}