//
//  SuccessfullyAskForAccountView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/4/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol SuccessfullyAskForAccountViewDelegate {
  func nextButtonPressedSuccessfullyAskForAccountView()
}


class SuccessfullyAskForAccountView: UIView {
  
  private var likeImageView: UIImageView! = nil
  private var readyLabel: UILabel! = nil
  private var messageLabel: UILabel! = nil
  private var nextButton: UIButton! = nil
  
  var delegate: SuccessfullyAskForAccountViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.initInterface()
  }
  
  private func initInterface() {
    self.backgroundColor = UIColor.whiteColor()
    
//    self.addActions()
    self.createLikeImageView()
    self.createReadyLabel()
    self.createMessageLabel()
    self.createNextButton()

  }
  
  private func createLikeImageView() {
    likeImageView = UIImageView.init(image: UIImage.init(named: "okey"))
    let frameForImageView = CGRect.init(x: (self.frame.size.width / 2.0) - (likeImageView.frame.size.width / 2.0), y: 40.0, width: likeImageView.frame.size.width, height: likeImageView.frame.size.height)
    likeImageView.frame = frameForImageView
    
    self.addSubview(likeImageView)
  }
  
  private func createReadyLabel() {
    
    readyLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Ultralight", size: 53.0)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: CreateAccountConstants.SuccessfullyAskForAccountView.readyText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    readyLabel.attributedText = stringWithFormat
    readyLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (readyLabel.frame.size.width / 2.0),
                               y: likeImageView.frame.origin.y + likeImageView.frame.size.height + 10.0,
                               width: readyLabel.frame.size.width,
                               height: readyLabel.frame.size.height)
    
    readyLabel.frame = newFrame
    
    self.addSubview(readyLabel)

  }
  
  private func createMessageLabel() {
  
    messageLabel = UILabel.init(frame: CGRect.init(x: 0.0, y: 0.0, width: self.frame.size.width - 104.0, height: 0.0))
    messageLabel.adjustsFontSizeToFitWidth = true
    messageLabel.numberOfLines = 5
    let font = UIFont(name: "SFUIText-Light", size: 16.0)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: CreateAccountConstants.SuccessfullyAskForAccountView.successfullyMessageText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    messageLabel.attributedText = stringWithFormat
    messageLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (messageLabel.frame.size.width / 2.0),
                               y: readyLabel.frame.origin.y + readyLabel.frame.size.height + 40.0,
                               width: messageLabel.frame.size.width,
                               height: messageLabel.frame.size.height)
    
    messageLabel.frame = newFrame
    
    self.addSubview(messageLabel)
    
  }
  
  private func createNextButton() {
    
    let font = UIFont(name: "SFUIDisplay-Light", size: 22.0)
    let color = UIColor.whiteColor()
    let colorWhenPressed = UIColor.greenColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: CreateAccountConstants.SuccessfullyAskForAccountView.nextButtonText ,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    let stringWithFormatWithPressed = NSMutableAttributedString(
      string: CreateAccountConstants.SuccessfullyAskForAccountView.nextButtonText ,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: colorWhenPressed
      ]
    )
    
    let frameForButton = CGRect.init(x: 0.0, y: self.frame.size.height - 70.0, width: self.frame.size.width, height: 70.0)
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
    self.delegate?.nextButtonPressedSuccessfullyAskForAccountView()
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
