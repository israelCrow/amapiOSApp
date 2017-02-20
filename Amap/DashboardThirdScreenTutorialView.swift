//
//  DashboardThirdScreenTutorialView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 11/18/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class DashboardThirdScreenTutorialView: UIView {
  
  private var topLabel: UILabel! = nil
  
  private var happitchLabel: UILabel! = nil
  private var happyLabel: UILabel! = nil
  private var okLabel: UILabel! = nil
  private var unHappyLabel: UILabel! = nil

  private var bottomDashboardLabel: UILabel! = nil
  
  //
  
  private var happitchImageView: UIImageView! = nil
  private var happyImageView: UIImageView! = nil
  private var okImageView: UIImageView! = nil
  private var unhappyImageView: UIImageView! = nil
  
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
    self.createHappitchLabel()
    self.createHappyLabel()
    self.createOKLabel()
    self.createUnhappyLabel()
    self.createBottomDashboardLabel()
    
    
    self.createHappitchImageView()
    self.createHappyImageView()
    self.createOKImageView()
    self.createUnhappyImageView()
    
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
      string: "Aquí verás el tipo de pitches en los que has participado",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    topLabel.attributedText = stringWithFormat
    topLabel.sizeToFit()
    let newFrame = CGRect.init(x: 78.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 356.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: topLabel.frame.size.width,
                               height: topLabel.frame.size.height)
    
    topLabel.frame = newFrame
    
    self.addSubview(topLabel)
    
  }
  
  private func createHappitchLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 42.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    happitchLabel = UILabel.init(frame: frameForLabel)
    happitchLabel.numberOfLines = 0
    happitchLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 9.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Happitch",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    happitchLabel.attributedText = stringWithFormat
    happitchLabel.sizeToFit()
    let newFrame = CGRect.init(x: 80.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 282.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: happitchLabel.frame.size.width,
                               height: happitchLabel.frame.size.height)
    
    happitchLabel.frame = newFrame
    
    self.addSubview(happitchLabel)
    
  }
  
  private func createHappyLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 42.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    happyLabel = UILabel.init(frame: frameForLabel)
    happyLabel.numberOfLines = 0
    happyLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 9.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Happy",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    happyLabel.attributedText = stringWithFormat
    happyLabel.sizeToFit()
    let newFrame = CGRect.init(x: 143.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 282.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: happyLabel.frame.size.width,
                               height: happyLabel.frame.size.height)
    
    happyLabel.frame = newFrame
    
    self.addSubview(happyLabel)
    
  }
  
  
  private func createOKLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 42.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    okLabel = UILabel.init(frame: frameForLabel)
    okLabel.numberOfLines = 0
    okLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 9.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Unhappy",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    okLabel.attributedText = stringWithFormat
    okLabel.sizeToFit()
    let newFrame = CGRect.init(x: 197.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 282.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: okLabel.frame.size.width,
                               height: okLabel.frame.size.height)
    
    okLabel.frame = newFrame
    
    self.addSubview(okLabel)
    
  }
  
  private func createUnhappyLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 42.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    unHappyLabel = UILabel.init(frame: frameForLabel)
    unHappyLabel.numberOfLines = 0
    unHappyLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 9.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Badpitch",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    unHappyLabel.attributedText = stringWithFormat
    unHappyLabel.sizeToFit()
    let newFrame = CGRect.init(x: 258.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 282.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: unHappyLabel.frame.size.width,
                               height: unHappyLabel.frame.size.height)
    
    unHappyLabel.frame = newFrame
    
    self.addSubview(unHappyLabel)
    
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
  
  private func createHappitchImageView() {
    
    happitchImageView = UIImageView.init(image: UIImage.init(named: "white_fill1"))
    let imageViewFrame = CGRect.init(x: 77.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 239.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 42.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 40.3 * UtilityManager.sharedInstance.conversionHeight)
    happitchImageView.frame = imageViewFrame
    
    self.addSubview(happitchImageView)
    
  }
  
  private func createHappyImageView() {
    
    happyImageView = UIImageView.init(image: UIImage.init(named: "white_fill3"))
    let imageViewFrame = CGRect.init(x: 136.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 238.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 42.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 40.3 * UtilityManager.sharedInstance.conversionHeight)
    happyImageView.frame = imageViewFrame
    
    self.addSubview(happyImageView)
    
  }
  
  private func createOKImageView() {
    
    okImageView = UIImageView.init(image: UIImage.init(named: "white_fill5"))
    let imageViewFrame = CGRect.init(x: 194.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 238.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 42.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 40.3 * UtilityManager.sharedInstance.conversionHeight)
    okImageView.frame = imageViewFrame
    
    self.addSubview(okImageView)
    
  }
  
  private func createUnhappyImageView() {
    
    unhappyImageView = UIImageView.init(image: UIImage.init(named: "white_fill7"))
    let imageViewFrame = CGRect.init(x: 255.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 238.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 42.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 40.3 * UtilityManager.sharedInstance.conversionHeight)
    unhappyImageView.frame = imageViewFrame
    
    self.addSubview(unhappyImageView)
    
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
    
    let tutorialFourthScreenDashboard = DashboardFourthScreenTutorialView.init(frame: CGRect.init())
    let rootViewController = UtilityManager.sharedInstance.currentViewController()
    rootViewController.view.addSubview(tutorialFourthScreenDashboard)
    
  }
  
  
  
}

