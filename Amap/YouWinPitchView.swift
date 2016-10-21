//
//  YouWinPitchView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/20/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol YouWinPitchViewDelegate {
  
  func youWinPitchNextButtonPressed()
  
}

class YouWinPitchView: UIView {
  
  private var titleLabel: UILabel! = nil
  private var messageLabel: UILabel! = nil
  private var nextButton: UIButton! = nil
  var regionPosition: PositionOfCardsAddResults! = nil
  
  var delegate: YouWinPitchViewDelegate?
  
  let kSpaceInSegments = 36.0 * UtilityManager.sharedInstance.conversionWidth
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    
    self.initValues()
    self.initInterface()
    
  }
  
  private func initValues() {
    
    self.tag = 4
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    
    self.createTitleLabel()
    self.createMessageLabel()
    self.createNextButton()
  }
  
  private func createTitleLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 247.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    titleLabel = UILabel.init(frame: frameForLabel)
    titleLabel.numberOfLines = 0
    titleLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: EditPitchesConstants.YouWinPitchView.titleLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    titleLabel.attributedText = stringWithFormat
    titleLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (titleLabel.frame.size.width / 2.0),
                               y: 30.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: titleLabel.frame.size.width,
                               height: titleLabel.frame.size.height)
    
    titleLabel.frame = newFrame
    
    self.addSubview(titleLabel)
    
  }
  
  private func createMessageLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 247.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    messageLabel = UILabel.init(frame: frameForLabel)
    messageLabel.numberOfLines = 0
    messageLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: EditPitchesConstants.YouWinPitchView.messageLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    messageLabel.attributedText = stringWithFormat
    messageLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (messageLabel.frame.size.width / 2.0),
                               y: 142.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: messageLabel.frame.size.width,
                               height: messageLabel.frame.size.height)
    
    messageLabel.frame = newFrame
    
    self.addSubview(messageLabel)
    
  }
  
  private func createNextButton() {
    
    
    nextButton = UIButton.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: EditPitchesConstants.YouWinPitchView.nextButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    let colorWhenDisabled = UIColor.whiteColor()
    let styleWhenDisabled = NSMutableParagraphStyle()
    styleWhenDisabled.alignment = NSTextAlignment.Center
    
    let stringWithFormatWhenDisabled = NSMutableAttributedString(
      string: EditPitchesConstants.YouWinPitchView.nextButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: styleWhenDisabled,
        NSForegroundColorAttributeName: colorWhenDisabled
      ]
    )
    
    nextButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    nextButton.setAttributedTitle(stringWithFormatWhenDisabled, forState: .Disabled)
    nextButton.backgroundColor = UIColor.blackColor()
    nextButton.addTarget(self,
                         action: #selector(nextButtonPressed),
                         forControlEvents: .TouchUpInside)
    nextButton.sizeToFit()
    
    let frameForButton = CGRect.init(x: 0.0,
                                     y: self.frame.size.height - (70.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: self.frame.size.width,
                                     height: 70.0 * UtilityManager.sharedInstance.conversionHeight)
    
    nextButton.frame = frameForButton
    nextButton.enabled = true
    
    self.addSubview(nextButton)
    
  }
  
  @objc private func nextButtonPressed() {
    
    self.delegate?.youWinPitchNextButtonPressed()
    
  }
  
}

