//
//  PitchesTutorialView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 11/17/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class PitchesTutorialView: UIView {
  
  private var lefTopLabel: UILabel! = nil
  private var rightTopLabel: UILabel! = nil
  private var bottomLabel: UILabel! = nil
  private var bottomPitchesLabel: UILabel! = nil
  
  private var lookForImageView: UIImageView! = nil
  private var filterImageView: UIImageView! = nil
  private var pitchesImageView: UIImageView! = nil
  
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
    
    self.createLeftTopLabel()
    self.createRightTopLabel()
    self.createBottomLabel()
    self.createBottomPitchesLabel()
    
    self.createLookForImageView()
    self.createFilterImageView()
    self.createPitchesImageView()
    
  }
  
  
  private func createLeftTopLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 145.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    lefTopLabel = UILabel.init(frame: frameForLabel)
    lefTopLabel.numberOfLines = 0
    lefTopLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: TutorialConstants.PitchesTutorial.leftTopLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    lefTopLabel.attributedText = stringWithFormat
    lefTopLabel.sizeToFit()
    let newFrame = CGRect.init(x: 14.5 * UtilityManager.sharedInstance.conversionWidth,
                               y: 139.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: lefTopLabel.frame.size.width,
                               height: lefTopLabel.frame.size.height)
    
    lefTopLabel.frame = newFrame
    
    self.addSubview(lefTopLabel)
    
  }
  
  private func createRightTopLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 141.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    rightTopLabel = UILabel.init(frame: frameForLabel)
    rightTopLabel.numberOfLines = 0
    rightTopLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: TutorialConstants.PitchesTutorial.rightTopLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    rightTopLabel.attributedText = stringWithFormat
    rightTopLabel.sizeToFit()
    let newFrame = CGRect.init(x: 218.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 139.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: rightTopLabel.frame.size.width,
                               height: rightTopLabel.frame.size.height)
    
    rightTopLabel.frame = newFrame
    
    self.addSubview(rightTopLabel)
    
  }
  
  private func createBottomLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 158.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    bottomLabel = UILabel.init(frame: frameForLabel)
    bottomLabel.numberOfLines = 0
    bottomLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: TutorialConstants.PitchesTutorial.bottomLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    bottomLabel.attributedText = stringWithFormat
    bottomLabel.sizeToFit()
    let newFrame = CGRect.init(x: 109.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 553.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: bottomLabel.frame.size.width,
                               height: bottomLabel.frame.size.height)
    
    bottomLabel.frame = newFrame
    
    self.addSubview(bottomLabel)
    
  }
  
  private func createBottomPitchesLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 36.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    bottomPitchesLabel = UILabel.init(frame: frameForLabel)
    bottomPitchesLabel.numberOfLines = 0
    bottomPitchesLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: TutorialConstants.PitchesTutorial.bottomPitchesLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    bottomPitchesLabel.attributedText = stringWithFormat
    bottomPitchesLabel.sizeToFit()
    let newFrame = CGRect.init(x: 170.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 653.0 * UtilityManager.sharedInstance.conversionHeight,
                           width: bottomPitchesLabel.frame.size.width,
                          height: bottomPitchesLabel.frame.size.height)
    
    bottomPitchesLabel.frame = newFrame
    
    self.addSubview(bottomPitchesLabel)
    
  }
  
  private func createLookForImageView() {
    
    lookForImageView = UIImageView.init(image: UIImage.init(named: "whitesearchIcon"))
    let imageViewFrame = CGRect.init(x: 16.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 92.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: 25.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 25.0 * UtilityManager.sharedInstance.conversionHeight)
    lookForImageView.frame = imageViewFrame
    
    self.addSubview(lookForImageView)
    
  }
  
  private func createFilterImageView() {
    
    filterImageView = UIImageView.init(image: UIImage.init(named: "filters"))
    let imageViewFrame = CGRect.init(x: 334.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 94.0 * UtilityManager.sharedInstance.conversionHeight,
                                 width: 25.0 * UtilityManager.sharedInstance.conversionWidth,
                                height: 21.0 * UtilityManager.sharedInstance.conversionHeight)
    filterImageView.frame = imageViewFrame
    
    self.addSubview(filterImageView)
    
  }
  
  private func createPitchesImageView() {
    
    pitchesImageView = UIImageView.init(image: UIImage.init(named: "iconPitchesWhite"))
    let imageViewFrame = CGRect.init(x: 176.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 623.0 * UtilityManager.sharedInstance.conversionHeight,
                                 width: 23.0 * UtilityManager.sharedInstance.conversionWidth,
                                height: 25.0 * UtilityManager.sharedInstance.conversionHeight)
    pitchesImageView.frame = imageViewFrame
    
    self.addSubview(pitchesImageView)
    
  }
  
  private func addGesture() {
    
    let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapToThisView))
    tapGesture.numberOfTapsRequired = 1
    
    self.addGestureRecognizer(tapGesture)
    
  }
  
  @objc private func tapToThisView() {
    
    self.removeFromSuperview()
    
    //UtilityManager.sharedInstance.mainTabBarController.selectedIndex = 0
    
    NSUserDefaults.standardUserDefaults().setBool(true, forKey: UtilityManager.sharedInstance.kNotToShowPitchesTutorial + UserSession.session.email)
    
  }
  

  
}
