//
//  CompanyPitchesSecondTutorialView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 01/03/17.
//  Copyright © 2017 Alejandro Aristi C. All rights reserved.
//

import UIKit

class CompanyPitchesSecondTutorialView: UIView {
  
  private var rightBottomLabel: UILabel! = nil
  private var bottomProfileLabel: UILabel! = nil
  
  private var profileImageView: UIImageView! = nil //magnifying glass
  private var closeImageView: UIImageView! = nil
  
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
    self.createCloseImageView()
    
  }
  
  
  private func createRightBottomLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 55.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    rightBottomLabel = UILabel.init(frame: frameForLabel)
    rightBottomLabel.numberOfLines = 0
    rightBottomLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Nombre",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    rightBottomLabel.attributedText = stringWithFormat
    rightBottomLabel.sizeToFit()
    let newFrame = CGRect.init(x: 112.5 * UtilityManager.sharedInstance.conversionWidth,
                               y: 88.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: rightBottomLabel.frame.size.width,
                               height: rightBottomLabel.frame.size.height)
    
    rightBottomLabel.frame = newFrame
    
    self.addSubview(rightBottomLabel)
    
  }
  
  private func createBottomProfileLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 159.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    bottomProfileLabel = UILabel.init(frame: frameForLabel)
    bottomProfileLabel.numberOfLines = 0
    bottomProfileLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Usa el buscador para encontrar un pitch",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    bottomProfileLabel.attributedText = stringWithFormat
    bottomProfileLabel.sizeToFit()
    let newFrame = CGRect.init(x: 115.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 136.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: bottomProfileLabel.frame.size.width,
                               height: bottomProfileLabel.frame.size.height)
    
    bottomProfileLabel.frame = newFrame
    
    self.addSubview(bottomProfileLabel)
    
  }
  
  private func createProfileImageView() {
    
    profileImageView = UIImageView.init(image: UIImage.init(named: "smallWhiteSearchIcon"))
    let imageViewFrame = CGRect.init(x: 79.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 88.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 14.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 14.0 * UtilityManager.sharedInstance.conversionHeight)
    profileImageView.frame = imageViewFrame
    
    self.addSubview(profileImageView)
    
  }
  
  private func createCloseImageView() {
    
    closeImageView = UIImageView.init(image: UIImage.init(named: "clear"))
    let imageViewFrame = CGRect.init(x: 274.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 94.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 14.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 14.0 * UtilityManager.sharedInstance.conversionHeight)
    closeImageView.frame = imageViewFrame
    
    self.addSubview(closeImageView)
    
  }
  
  private func addGesture() {
    
    let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapToThisView))
    tapGesture.numberOfTapsRequired = 1
    
    self.addGestureRecognizer(tapGesture)
    
    
  }
  
  @objc private func tapToThisView() {
    
    let companyDashboardTutorial = CompanyDashboardTutorialView.init(frame: CGRect.init())
    let rootViewController = UtilityManager.sharedInstance.currentViewController()
    
    self.removeFromSuperview()
    NSUserDefaults.standardUserDefaults().setBool(true, forKey: UtilityManager.sharedInstance.kNotToShowCompanyPitchesSecondTutorial + UserSession.session.email)
    
    rootViewController.view.addSubview(companyDashboardTutorial)
    
  }
  
}

