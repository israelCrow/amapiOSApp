//
//  CanceledPitchEvaluationView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/17/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol CanceledPitchEvaluationViewDelegate {
  
  func nextButtonPressedFromCanceledPitchEvaluationView(sender: CanceledPitchEvaluationView)
  
}

class CanceledPitchEvaluationView: UIView {
  
  private var canceledImageView: UIImageView! = nil
  private var messageLabel: UILabel! = nil
  private var detailedMessageLabel: UILabel! = nil
  private var nextButton: UIButton! = nil
  
  var delegate: CanceledPitchEvaluationViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.createCanceledImageView()
    self.createMessageLabel()
    self.createDetailedMessageLabel()
    self.createNextButton()
    
  }
  
  private func createCanceledImageView() {
    
    canceledImageView = UIImageView.init(image: UIImage.init(named: "archivarIcon"))
    let canceledImageViewFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (canceledImageView.frame.size.width / 2.0),
                                           y: (103.0 * UtilityManager.sharedInstance.conversionHeight),
                                           width: canceledImageView.frame.size.width,
                                           height: canceledImageView.frame.size.height)
    canceledImageView.frame = canceledImageViewFrame
    
    self.addSubview(canceledImageView)
    
  }
  
  private func createMessageLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 219.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    messageLabel = UILabel.init(frame: frameForLabel)
    messageLabel.numberOfLines = 0
    messageLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: EditPitchesConstants.CanceledPitchEvaluationView.canceledMessageLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    messageLabel.attributedText = stringWithFormat
    messageLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (messageLabel.frame.size.width / 2.0),
                               y: 210.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: messageLabel.frame.size.width,
                               height: messageLabel.frame.size.height)
    
    messageLabel.frame = newFrame
    
    self.addSubview(messageLabel)
    
  }
  
  private func createDetailedMessageLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 219.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    detailedMessageLabel = UILabel.init(frame: frameForLabel)
    detailedMessageLabel.numberOfLines = 0
    detailedMessageLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: EditPitchesConstants.CanceledPitchEvaluationView.detailedMessageLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    detailedMessageLabel.attributedText = stringWithFormat
    detailedMessageLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (detailedMessageLabel.frame.size.width / 2.0),
                               y: 259.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: detailedMessageLabel.frame.size.width,
                               height: detailedMessageLabel.frame.size.height)
    
    detailedMessageLabel.frame = newFrame
    
    self.addSubview(detailedMessageLabel)
    
  }
  
  private func createNextButton() {
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let colorWhenPressed = UIColor.greenColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: EditPitchesConstants.CanceledPitchEvaluationView.nextButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(1.5),
        NSForegroundColorAttributeName: color
      ]
    )
    
    let stringWithFormatWhenpressed = NSMutableAttributedString(
      string: EditPitchesConstants.CanceledPitchEvaluationView.nextButtonText,
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
    nextButton.setAttributedTitle(stringWithFormatWhenpressed, forState: .Highlighted)
    
    self.addSubview(nextButton)
    
  }
  
  @objc private func nextButtonPressed() {
    
    self.delegate?.nextButtonPressedFromCanceledPitchEvaluationView(self)
    
  }
  
  
}
