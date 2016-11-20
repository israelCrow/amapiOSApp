//
//  DashboardSecondScreenTutorialView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 11/18/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class DashboardSeconScreenTutorialView: UIView {
  
  private var topLabel: UILabel! = nil
  private var bottomDashboardLabel: UILabel! = nil
  
  private var downImageView: UIImageView! = nil
  private var lineImageView: UIImageView! = nil
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
    
    self.createTopLabel()
    self.createBottomPitchesLabel()
    
    
    self.createDownImageView()
    self.createLineImageView()
    self.createDashboardImageView()
    
  }
  
  
  private func createTopLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    topLabel = UILabel.init(frame: frameForLabel)
    topLabel.numberOfLines = 0
    topLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: TutorialConstants.DashboardSecondScreenTutotial.topLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    topLabel.attributedText = stringWithFormat
    topLabel.sizeToFit()
    let newFrame = CGRect.init(x: 78.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 247.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: topLabel.frame.size.width,
                               height: topLabel.frame.size.height)
    
    topLabel.frame = newFrame
    
    self.addSubview(topLabel)
    
  }
  
  private func createBottomPitchesLabel() {
    
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
    let newFrame = CGRect.init(x: 37.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 653.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: bottomDashboardLabel.frame.size.width,
                               height: bottomDashboardLabel.frame.size.height)
    
    bottomDashboardLabel.frame = newFrame
    
    self.addSubview(bottomDashboardLabel)
    
  }
  
  private func createDownImageView() {
    
    downImageView = UIImageView.init(image: UIImage.init(named: "whiteDropdown"))
    let imageViewFrame = CGRect.init(x: 276.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 190.0 * UtilityManager.sharedInstance.conversionHeight,
                                 width: 14.0 * UtilityManager.sharedInstance.conversionWidth,
                                height: 14.0 * UtilityManager.sharedInstance.conversionHeight)
    downImageView.frame = imageViewFrame
    
    self.addSubview(downImageView)
    
  }
  
  private func createLineImageView() {
    
    lineImageView = UIImageView.init(image: UIImage.init(named: "imputLine"))
    let imageViewFrame = CGRect.init(x: 78.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 220.0 * UtilityManager.sharedInstance.conversionHeight,
                                 width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                height: 1.0 * UtilityManager.sharedInstance.conversionHeight)
    lineImageView.frame = imageViewFrame
    
    self.addSubview(lineImageView)
    
  }
  
  private func createDashboardImageView() {
    
    dashboardImageView = UIImageView.init(image: UIImage.init(named: "iconDashboardWhite"))
    let imageViewFrame = CGRect.init(x: 50.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 623 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 25.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 25.0 * UtilityManager.sharedInstance.conversionHeight)
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
    
    let tutorialThirdScreenDashboard = DashboardThirdScreenTutorialView.init(frame: CGRect.init())
    let rootViewController = UtilityManager.sharedInstance.currentViewController()
    rootViewController.view.addSubview(tutorialThirdScreenDashboard)
    
  }
  
  
  
}
