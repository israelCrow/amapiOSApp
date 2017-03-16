//
//  DashboardFirstScreenTutorialView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 11/18/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class DashboardFirstScreenTutorialView: UIView {
  
  private var lefBottomLabel: UILabel! = nil
  private var bottomDashboardLabel: UILabel! = nil
  
  private var dashboardImageView: UIImageView! = nil
  
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
    
    self.createLeftBottomLabel()
    self.createBottomDashboardLabel()
  
    self.createDashboardImageView()
    
  }
  
  
  private func createLeftBottomLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 255.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    lefBottomLabel = UILabel.init(frame: frameForLabel)
    lefBottomLabel.numberOfLines = 0
    lefBottomLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: TutorialConstants.DashboardFirstScreenTutorial.leftBottomLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    lefBottomLabel.attributedText = stringWithFormat
    lefBottomLabel.sizeToFit()
    var newFrame = CGRect.init(x: 25.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 530.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: lefBottomLabel.frame.size.width,
                               height: lefBottomLabel.frame.size.height)
    
    //this is for screen in "ipad version"
    if UIScreen.mainScreen().bounds.size.width == 320.0 && UIScreen.mainScreen().bounds.size.height == 480.0 {
      
      newFrame = CGRect.init(x: 25.0 * UtilityManager.sharedInstance.conversionWidth,
                             y: 440.0 * UtilityManager.sharedInstance.conversionHeight,
                             width: lefBottomLabel.frame.size.width,
                             height: lefBottomLabel.frame.size.height)
      
    }
    
    lefBottomLabel.frame = newFrame
    
    self.addSubview(lefBottomLabel)
    
  }
  
  private func createBottomDashboardLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 53.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    bottomDashboardLabel = UILabel.init(frame: frameForLabel)
    bottomDashboardLabel.numberOfLines = 0
    bottomDashboardLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: TutorialConstants.DashboardFirstScreenTutorial.bottomDashBoardLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    bottomDashboardLabel.attributedText = stringWithFormat
    bottomDashboardLabel.sizeToFit()
    var newFrame = CGRect.init(x: 37.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 653.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: bottomDashboardLabel.frame.size.width,
                               height: bottomDashboardLabel.frame.size.height)
    
    //this is for screen in "ipad version"
    if UIScreen.mainScreen().bounds.size.width == 320.0 && UIScreen.mainScreen().bounds.size.height == 480.0 {
      
      newFrame = CGRect.init(x: 36.0 * UtilityManager.sharedInstance.conversionWidth,
                             y: 548.0 * UtilityManager.sharedInstance.conversionHeight,
                             width: bottomDashboardLabel.frame.size.width,
                             height: bottomDashboardLabel.frame.size.height)
      
    }
    
    bottomDashboardLabel.frame = newFrame
    
    self.addSubview(bottomDashboardLabel)
    
  }
  
  private func createDashboardImageView() {
    
    dashboardImageView = UIImageView.init(image: UIImage.init(named: "iconDashboardWhite"))
    var imageViewFrame = CGRect.init(x: 50.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 623 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 25.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 25.0 * UtilityManager.sharedInstance.conversionHeight)
    
    //this is for screen in "ipad version"
    if UIScreen.mainScreen().bounds.size.width == 320.0 && UIScreen.mainScreen().bounds.size.height == 480.0 {
      
      imageViewFrame = CGRect.init(x: 50.0 * UtilityManager.sharedInstance.conversionWidth,
                                   y: 515 * UtilityManager.sharedInstance.conversionHeight,
                                   width: 25.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 25.0 * UtilityManager.sharedInstance.conversionHeight)
      
    }
    
    dashboardImageView.frame = imageViewFrame
    
    self.addSubview(dashboardImageView)
    
  }
  
  private func addGesture() {
    
    let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapToThisView))
    tapGesture.numberOfTapsRequired = 1
    
    self.addGestureRecognizer(tapGesture)
    
  }
  
  @objc private func tapToThisView() {
    
    self.removeFromSuperview()
    
//    let tutorialSecondScreenDashboard = DashboardSeconScreenTutorialView.init(frame: CGRect.init())
//    let rootViewController = UtilityManager.sharedInstance.currentViewController()
//    rootViewController.view.addSubview(tutorialSecondScreenDashboard)
    
    let tutorialThirdScreenDashboard = DashboardThirdScreenTutorialView.init(frame: CGRect.init())
    let rootViewController = UtilityManager.sharedInstance.currentViewController()
    rootViewController.view.addSubview(tutorialThirdScreenDashboard)

    
  }
  
}

