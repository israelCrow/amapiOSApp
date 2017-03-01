//
//  CompanyDashboardTutorialView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 01/03/17.
//  Copyright © 2017 Alejandro Aristi C. All rights reserved.
//

import UIKit

class CompanyDashboardTutorialView: UIView {
  
  private var leftBottomLabel: UILabel! = nil
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
                                    width: 198.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    leftBottomLabel = UILabel.init(frame: frameForLabel)
    leftBottomLabel.numberOfLines = 0
    leftBottomLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Aquí verás las estadísticas de la campaña",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    leftBottomLabel.attributedText = stringWithFormat
    leftBottomLabel.sizeToFit()
    let newFrame = CGRect.init(x: 20.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 541.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: leftBottomLabel.frame.size.width,
                               height: leftBottomLabel.frame.size.height)
    
    leftBottomLabel.frame = newFrame
    
    self.addSubview(leftBottomLabel)
    
  }
  
  private func createBottomProfileLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 55.0 * UtilityManager.sharedInstance.conversionWidth,
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
      string: "Dashboard",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    bottomProfileLabel.attributedText = stringWithFormat
    bottomProfileLabel.sizeToFit()
    let newFrame = CGRect.init(x: 37.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 653.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: bottomProfileLabel.frame.size.width,
                               height: bottomProfileLabel.frame.size.height)
    
    bottomProfileLabel.frame = newFrame
    
    self.addSubview(bottomProfileLabel)
    
  }
  
  private func createProfileImageView() {
    
    profileImageView = UIImageView.init(image: UIImage.init(named: "iconDashboardWhite"))
    let imageViewFrame = CGRect.init(x: 50.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 623 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 25.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 25.0 * UtilityManager.sharedInstance.conversionHeight)
    profileImageView.frame = imageViewFrame
    
    self.addSubview(profileImageView)
    
  }
  
  private func addGesture() {
    
    let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapToThisView))
    tapGesture.numberOfTapsRequired = 1
    
    self.addGestureRecognizer(tapGesture)
    
    
  }
  
  @objc private func tapToThisView() {
    
    NSUserDefaults.standardUserDefaults().setBool(true, forKey: UtilityManager.sharedInstance.kNotToShowCompanyDashboardTutorial + UserSession.session.email)
    NSUserDefaults.standardUserDefaults().setBool(true, forKey: UtilityManager.sharedInstance.kNotToShowCompanyWelcomeScreen + UserSession.session.email)
    
    self.removeFromSuperview()
    
  }
  
}

