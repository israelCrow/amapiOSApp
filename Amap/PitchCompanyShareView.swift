//
//  PitchCompanyShareView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 12/16/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol PitchCompanyshareViewDelegate {
  
  func shareButtonPressed(mails: [String])
  
}

class PitchCompanyshareView: UIView {
  
  private var shareWithTeam: UILabel! = nil
  private var shareOne: CustomTextFieldWithTitleView! = nil
  private var shareTwo: CustomTextFieldWithTitleView! = nil
  private var shareThree: CustomTextFieldWithTitleView! = nil
  private var shareButton: UIButton! = nil
  
  var delegate: PitchCompanyshareViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
  
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.createShareWithTeamLabel()
    self.createShareOne()
    self.createShareTwo()
    self.createShareThree()
    self.createShareButton()
    
  }
  
  private func createShareWithTeamLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 275.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    shareWithTeam = UILabel.init(frame: frameForLabel)
    shareWithTeam.numberOfLines = 0
    shareWithTeam.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Compártelo con tu equipo",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    shareWithTeam.attributedText = stringWithFormat
    shareWithTeam.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (shareWithTeam.frame.size.width / 2.0),
                               y: 0.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: shareWithTeam.frame.size.width,
                               height: shareWithTeam.frame.size.height)
    
    shareWithTeam.frame = newFrame
    
    self.addSubview(shareWithTeam)
    
  }
  
  private func createShareOne() {
    
    let frameForSearchView = CGRect.init(x: 30.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: 92.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                         height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
    
    shareOne = CustomTextFieldWithTitleView.init(frame: frameForSearchView,
                                                   title: nil,
                                                   image: "iconMail")
    
    self.addSubview(shareOne)
    
  }
  
  private func createShareTwo() {
    
    let frameForSearchView = CGRect.init(x: 30.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: 148.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                         height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
    
    shareTwo = CustomTextFieldWithTitleView.init(frame: frameForSearchView,
                                                 title: nil,
                                                 image: "iconMail")
    
    self.addSubview(shareTwo)
    
  }
  
  private func createShareThree() {
    
    let frameForSearchView = CGRect.init(x: 30.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: 204.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                         height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
    
    shareThree = CustomTextFieldWithTitleView.init(frame: frameForSearchView,
                                                 title: nil,
                                                 image: "iconMail")
    
    self.addSubview(shareThree)
    
  }
  
  private func createShareButton() {
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let colorWhenPressed = UIColor.greenColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Compartir",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(1.5),
        NSForegroundColorAttributeName: color
      ]
    )
    
    let stringWithFormatWhenpressed = NSMutableAttributedString(
      string: "Compartir",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(1.5),
        NSForegroundColorAttributeName: colorWhenPressed
      ]
    )
    
    let frameForButton = CGRect.init(x: 0.0,
                                     y: self.frame.size.height - (70.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: self.frame.size.width,
                                     height: (70.0 * UtilityManager.sharedInstance.conversionHeight))
    shareButton = UIButton.init(frame: frameForButton)
    shareButton.addTarget(self,
                         action: #selector(shareButtonPressed),
                         forControlEvents: .TouchUpInside)
    shareButton.backgroundColor = UIColor.blackColor()
    shareButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    shareButton.setAttributedTitle(stringWithFormatWhenpressed, forState: .Highlighted)
    
    self.addSubview(shareButton)
    
  }
  
  @objc private func shareButtonPressed() {
   
    self.delegate?.shareButtonPressed([shareOne.mainTextField.text!, shareTwo.mainTextField.text!, shareThree.mainTextField.text!])
    
  }
  
}
