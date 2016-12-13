//
//  ExistingAccountView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/4/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol ExistingAccountViewDelegate {
  func nextButtonPressedExistingAccountView()
}

class ExistingAccountView: UIView {
  
  private var errorImageView: UIImageView! = nil
  private var oopsLabel: UILabel! = nil
  private var alreadyHaveAnAccountLabel: UILabel! = nil
  private var recommendationLabel: UILabel! = nil
  private var nextButton: UIButton! = nil
  private var showAlreadyExistingAgencyUser: Bool! = nil
  private var typeOfUser: Int! = nil
  
  var delegate: ExistingAccountViewDelegate?
  
  init(frame: CGRect, newShowAlreadyExistingAgencyUser: Bool, newTypeOfUser: Int?) {
    
    typeOfUser = newTypeOfUser
    showAlreadyExistingAgencyUser = newShowAlreadyExistingAgencyUser
    
    super.init(frame: frame)
    self.initInterface()
  }
  
  private func initInterface() {
    self.backgroundColor = UIColor.whiteColor()
    
    //    self.addActions()
    self.createLikeImageView()
    self.createOopsLabel()
    self.createAlreadyHaveAnAccountLabel()
    self.createRecommendationLabel()
    self.createNextButton()
    
  }
  
  private func createLikeImageView() {
    errorImageView = UIImageView.init(image: UIImage.init(named: "error"))
    let frameForImageView = CGRect.init(x: (self.frame.size.width / 2.0) - (errorImageView.frame.size.width / 2.0),
                                        y: (40.0 * UtilityManager.sharedInstance.conversionHeight),
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
  
  private func createAlreadyHaveAnAccountLabel() {
    
    var message = ""
    
    if showAlreadyExistingAgencyUser == true {
      
      if typeOfUser != nil && typeOfUser == 2 {
      
        message = CreateAccountConstants.ExistingAccountView.alreadyExistAgencyUser
      
      } else
        if typeOfUser != nil && typeOfUser == 4 {
          
          message = CreateAccountConstants.ExistingAccountView.alreadyExistCompanyUser
          
        }
      
    } else {
      
      message = CreateAccountConstants.ExistingAccountView.alreadyHaveAnAccount
      
    }
    
    alreadyHaveAnAccountLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: message,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    alreadyHaveAnAccountLabel.numberOfLines = 2
    alreadyHaveAnAccountLabel.attributedText = stringWithFormat
    alreadyHaveAnAccountLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (alreadyHaveAnAccountLabel.frame.size.width / 2.0),
                               y: oopsLabel.frame.origin.y + oopsLabel.frame.size.height + (25.0 * UtilityManager.sharedInstance.conversionHeight),
                           width: alreadyHaveAnAccountLabel.frame.size.width,
                          height: alreadyHaveAnAccountLabel.frame.size.height)
    
    alreadyHaveAnAccountLabel.frame = newFrame
    
    self.addSubview(alreadyHaveAnAccountLabel)
    
  }
  
  private func createRecommendationLabel() {
    
    recommendationLabel = UILabel.init(frame: CGRect.init(x: 0.0,
      y: 0.0,
      width: self.frame.size.width - (55.0 * UtilityManager.sharedInstance.conversionWidth),
      height: 0.0))
    recommendationLabel.adjustsFontSizeToFitWidth = true
    recommendationLabel.numberOfLines = 5
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: CreateAccountConstants.ExistingAccountView.recommendationText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    recommendationLabel.attributedText = stringWithFormat
    recommendationLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (recommendationLabel.frame.size.width / 2.0),
                               y: alreadyHaveAnAccountLabel.frame.origin.y + alreadyHaveAnAccountLabel.frame.size.height + (15.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: recommendationLabel.frame.size.width,
                               height: recommendationLabel.frame.size.height)
    
    recommendationLabel.frame = newFrame
    
    self.addSubview(recommendationLabel)
    
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
    
    let frameForButton = CGRect.init(x: 0.0,
                                     y: self.frame.size.height - (70.0 * UtilityManager.sharedInstance.conversionHeight),
                                 width: self.frame.size.width,
                                height: (70.0 * UtilityManager.sharedInstance.conversionHeight))
    nextButton = UIButton.init(frame: frameForButton)
    nextButton.addTarget(self,
                         action: #selector(nextButtonWasPressed),
                         forControlEvents: .TouchUpInside)
    nextButton.backgroundColor = UIColor.blackColor()
    nextButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    nextButton.setAttributedTitle(stringWithFormatWithPressed, forState: .Highlighted)
    
    self.addSubview(nextButton)
  }
  
  @objc private func nextButtonWasPressed() {
    
    self.delegate?.nextButtonPressedExistingAccountView()
    
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
