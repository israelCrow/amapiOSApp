//
//  SuccessfullyCreationOfPitchView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/13/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol SuccessfullyCreationOfPitchViewDelegate {
  
  func nextButtonPressedFromSuccessfullyCreationOfPitch()
  
}


class SuccessfullyCreationOfPitchView: UIView {
  
  private var likeImageView: UIImageView! = nil
  private var readyLabel: UILabel! = nil
  private var messageLabel: UILabel! = nil
  private var nextButton: UIButton! = nil
  
  var delegate: SuccessfullyCreationOfPitchViewDelegate?
  
  override init(frame: CGRect) {


    super.init(frame: frame)

    self.initInterface()

  }
  
  private func initInterface() {
    self.backgroundColor = UIColor.whiteColor()
    
    self.createLikeImageView()
    self.createReadyLabel()
    self.createMessageLabel()
    self.createNextButton()
    
  }
  
  private func createLikeImageView() {
    likeImageView = UIImageView.init(image: UIImage.init(named: "iconOkey"))
    let frameForImageView = CGRect.init(x: (self.frame.size.width / 2.0) - ((125.0 * UtilityManager.sharedInstance.conversionHeight) / 2.0),
                                        y: (30.0 * UtilityManager.sharedInstance.conversionHeight),
                                        width: 125.0 * UtilityManager.sharedInstance.conversionHeight,
                                        height: 125.0 * UtilityManager.sharedInstance.conversionHeight)
    likeImageView.frame = frameForImageView
    
    self.addSubview(likeImageView)
  }
  
  private func createReadyLabel() {
    
    readyLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 53.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.SuccessfullyCreationOfPitchView.readyLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    readyLabel.attributedText = stringWithFormat
    readyLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (readyLabel.frame.size.width / 2.0),
                               y: likeImageView.frame.origin.y + likeImageView.frame.size.height + (10.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: readyLabel.frame.size.width,
                               height: readyLabel.frame.size.height)
    
    readyLabel.frame = newFrame
    
    self.addSubview(readyLabel)
    
  }
  
  private func createMessageLabel() {
    
    messageLabel = UILabel.init(frame: CGRect.init(x: 0.0,
      y: 0.0,
      width: self.frame.size.width - (60.0 * UtilityManager.sharedInstance.conversionWidth),
      height: 0.0))
    messageLabel.numberOfLines = 2
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.SuccessfullyCreationOfPitchView.descriptionLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    messageLabel.attributedText = stringWithFormat
    messageLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (messageLabel.frame.size.width / 2.0),
                               y: readyLabel.frame.origin.y + readyLabel.frame.size.height + (25.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: messageLabel.frame.size.width,
                               height: messageLabel.frame.size.height)
    
    messageLabel.frame = newFrame
    
    self.addSubview(messageLabel)
    
  }
  
  private func createNextButton() {
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let colorWhenPressed = UIColor.greenColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.SuccessfullyCreationOfPitchView.nextButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    let stringWithFormatWithPressed = NSMutableAttributedString(
      string: VisualizePitchesConstants.SuccessfullyCreationOfPitchView.nextButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: colorWhenPressed
      ]
    )
    
    let frameForButton = CGRect.init(x: 0.0,
                                     y: self.frame.size.height - (70.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: self.frame.size.width,
                                     height: (70.0 * UtilityManager.sharedInstance.conversionHeight))
    nextButton = UIButton.init(frame: frameForButton)
    nextButton.addTarget(self,
                         action: #selector(nextButtonPressed),
                         forControlEvents: .TouchUpInside)
    nextButton.backgroundColor = UIColor.blackColor()
    nextButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    nextButton.setAttributedTitle(stringWithFormatWithPressed, forState: .Highlighted)
    
    self.addSubview(nextButton)
  }
  
  @objc private func nextButtonPressed() {
    
    self.delegate?.nextButtonPressedFromSuccessfullyCreationOfPitch()
    
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}

