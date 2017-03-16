//
//  ProfileScreenTutorialView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 11/18/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class ProfileScreenTutorialView: UIView {

  private var rightBottomLabel: UILabel! = nil
  private var bottomProfileLabel: UILabel! = nil
  
  private var profileImageView: UIImageView! = nil
  
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
    
    self.createRightBottomLabel()
    self.createBottomProfileLabel()
    
    self.createProfileImageView()
    
  }
  
  
  private func createRightBottomLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 131.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    rightBottomLabel = UILabel.init(frame: frameForLabel)
    rightBottomLabel.numberOfLines = 0
    rightBottomLabel.lineBreakMode = .ByWordWrapping
    
    var font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    
    //this is for screen in "ipad version"
    if UIScreen.mainScreen().bounds.size.width == 320.0 && UIScreen.mainScreen().bounds.size.height == 480.0 {
      
      font = UIFont(name: "SFUIText-Light",
                    size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
      
    }
    
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Right
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Aquí podrás ver y editar tu perfil",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    rightBottomLabel.attributedText = stringWithFormat
    rightBottomLabel.sizeToFit()
    var newFrame = CGRect.init(x: 216.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 541.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: rightBottomLabel.frame.size.width,
                               height: rightBottomLabel.frame.size.height)
    
    //this is for screen in "ipad version"
    if UIScreen.mainScreen().bounds.size.width == 320.0 && UIScreen.mainScreen().bounds.size.height == 480.0 {
      
      newFrame = CGRect.init(x: 200.0 * UtilityManager.sharedInstance.conversionWidth,
                             y: 465.0 * UtilityManager.sharedInstance.conversionHeight,
                             width: rightBottomLabel.frame.size.width,
                             height: rightBottomLabel.frame.size.height)
      
    }
    
    rightBottomLabel.frame = newFrame
    
    self.addSubview(rightBottomLabel)
    
  }
  
  private func createBottomProfileLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 66.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    bottomProfileLabel = UILabel.init(frame: frameForLabel)
    bottomProfileLabel.numberOfLines = 0
    bottomProfileLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Perfil Agencia",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    bottomProfileLabel.attributedText = stringWithFormat
    bottomProfileLabel.sizeToFit()
    var newFrame = CGRect.init(x: 278.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 653.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: bottomProfileLabel.frame.size.width,
                               height: bottomProfileLabel.frame.size.height)
    
    //this is for screen in "ipad version"
    if UIScreen.mainScreen().bounds.size.width == 320.0 && UIScreen.mainScreen().bounds.size.height == 480.0 {
      
      newFrame = CGRect.init(x: 276.0 * UtilityManager.sharedInstance.conversionWidth,
                            y: 548.0 * UtilityManager.sharedInstance.conversionHeight,
                                 width: bottomProfileLabel.frame.size.width,
                                 height: bottomProfileLabel.frame.size.height)
      
    }
    
    bottomProfileLabel.frame = newFrame
    
    self.addSubview(bottomProfileLabel)
    
  }
  
  private func createProfileImageView() {
    
    profileImageView = UIImageView.init(image: UIImage.init(named: "white_agencyBlack"))
    var imageViewFrame = CGRect.init(x: 306.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 623.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 14.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 25.0 * UtilityManager.sharedInstance.conversionHeight)
    
    //this is for screen in "ipad version"
    if UIScreen.mainScreen().bounds.size.width == 320.0 && UIScreen.mainScreen().bounds.size.height == 480.0 {
      
      imageViewFrame = CGRect.init(x: 305.0 * UtilityManager.sharedInstance.conversionWidth,
                                       y: 516.0 * UtilityManager.sharedInstance.conversionHeight,
                                       width: 14.0 * UtilityManager.sharedInstance.conversionWidth,
                                       height: 25.0 * UtilityManager.sharedInstance.conversionHeight)
      
    }
    
    profileImageView.frame = imageViewFrame
    
    self.addSubview(profileImageView)
    
  }
  
  private func addGesture() {
    
    let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapToThisView))
    tapGesture.numberOfTapsRequired = 1
    
    self.addGestureRecognizer(tapGesture)
    
    
  }
  
  @objc private func tapToThisView() {
    
    self.removeFromSuperview()
    
    //UtilityManager.sharedInstance.mainTabBarController.selectedIndex = 1
    
    NSUserDefaults.standardUserDefaults().setBool(true, forKey: UtilityManager.sharedInstance.kNotToShowProfileTutorial + UserSession.session.email)
    
  }
  
}

