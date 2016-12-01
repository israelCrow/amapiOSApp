//
//  DashboardFourthScreenTutorialView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 11/18/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class DashboardFourthScreenTutorialView: UIView {
  
  private var topLabel: UILabel! = nil
  private var rateLabel: UILabel! = nil
  private var percentageLabel: UILabel! = nil
  private var bottomDashboardLabel: UILabel! = nil
  
  //
  
  private var circleImageView: UIImageView! = nil
  private var textImageView: UIImageView! = nil
  
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
    self.createRateLabel()
    self.createPercentageLabel()
    self.createBottomDashboardLabel()
    
    
    self.createCircleImageView()
//    self.createTextImageView()
    
    self.createDashboardImageView()
    
  }
  
  
  private func createTopLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 215.0 * UtilityManager.sharedInstance.conversionWidth,
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
      string: "Aquí verás tu rate de bateo",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    topLabel.attributedText = stringWithFormat
    topLabel.sizeToFit()
    let newFrame = CGRect.init(x: 79.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 269.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: topLabel.frame.size.width,
                               height: topLabel.frame.size.height)
    
    topLabel.frame = newFrame
    
    self.addSubview(topLabel)
    
  }
  
  private func createRateLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 215.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    rateLabel = UILabel.init(frame: frameForLabel)
    rateLabel.numberOfLines = 0
    rateLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Rate de bateo",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    rateLabel.attributedText = stringWithFormat
    rateLabel.sizeToFit()
    let newFrame = CGRect.init(x: 136.5 * UtilityManager.sharedInstance.conversionWidth,
                               y: 420.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: rateLabel.frame.size.width,
                               height: rateLabel.frame.size.height)
    
    rateLabel.frame = newFrame
    
    self.addSubview(rateLabel)
    
  }
  
  private func createPercentageLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 215.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    percentageLabel = UILabel.init(frame: frameForLabel)
    percentageLabel.numberOfLines = 0
    percentageLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "%",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    percentageLabel.attributedText = stringWithFormat
    percentageLabel.sizeToFit()
    let newFrame = CGRect.init(x: 207.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 379.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: percentageLabel.frame.size.width,
                               height: percentageLabel.frame.size.height)
    
    percentageLabel.frame = newFrame
    
    self.addSubview(percentageLabel)
    
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
    let newFrame = CGRect.init(x: 37.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 653.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: bottomDashboardLabel.frame.size.width,
                               height: bottomDashboardLabel.frame.size.height)
    
    bottomDashboardLabel.frame = newFrame
    
    self.addSubview(bottomDashboardLabel)
    
  }
  
  private func createCircleImageView() {
    
    circleImageView = UIImageView.init(image: UIImage.init(named: "oval3"))
    let imageViewFrame = CGRect.init(x: 98.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 319.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 181.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 181.0 * UtilityManager.sharedInstance.conversionHeight)
    circleImageView.frame = imageViewFrame
    
    self.addSubview(circleImageView)
    
  }
  
  private func createTextImageView() {
    
    textImageView = UIImageView.init(image: UIImage.init(named: "rateBateo"))
    let imageViewFrame = CGRect.init(x: 135.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 386.0 * UtilityManager.sharedInstance.conversionHeight,
                                  width: 105.0 * UtilityManager.sharedInstance.conversionWidth,
                                  height: 51.0 * UtilityManager.sharedInstance.conversionHeight)
    textImageView.frame = imageViewFrame
    
    self.addSubview(textImageView)
    
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
    
    NSUserDefaults.standardUserDefaults().setBool(true, forKey: UtilityManager.sharedInstance.kNotToShowDashboardTutorial + UserSession.session.email)
    
  }
  
  
  
}

