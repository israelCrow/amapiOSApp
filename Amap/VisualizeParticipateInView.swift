//
//  VisualizeParticipateInView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/1/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

//
//  VisualizeCriteriaView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/1/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class VisualizeParticipateInView: UIView {
  
  private var exclusiveLabel: UILabel! = nil
  private var mainScrollView: UIScrollView! = nil
  private var arrayOfImageViews = Array<UIImageView>()
  private var arrayOfFrames = Array<CGRect>()
  private var actualFrame: Int = 0
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
  
    self.createInterface()
    
  }
  
  private func createInterface() {
    
    self.createAllPossibleFrames()
    self.createParticipateInLabel()
    self.createMainScrollView()
    self.createAllImageViews()
    self.createHappitchLabel()
    
  }
  
  private func createAllPossibleFrames() {
    
    
    //first quadrant
    var frameForImageView = CGRect.init(x: 28.0 * UtilityManager.sharedInstance.conversionWidth,
                                        y: 56.0 * UtilityManager.sharedInstance.conversionHeight,
                                    width: 60.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 60.0 * UtilityManager.sharedInstance.conversionHeight)
    
    arrayOfFrames.append(frameForImageView)
    
    //second quadrant
    
    frameForImageView = CGRect.init(x: 139.0 * UtilityManager.sharedInstance.conversionWidth,
                                    y: 56.0 * UtilityManager.sharedInstance.conversionHeight,
                                width: 60.0 * UtilityManager.sharedInstance.conversionWidth,
                               height: 60.0 * UtilityManager.sharedInstance.conversionHeight)
    
    arrayOfFrames.append(frameForImageView)
    
    
    //third quadrant
    
    frameForImageView = CGRect.init(x: 28.0 * UtilityManager.sharedInstance.conversionWidth,
                                    y: 167.0 * UtilityManager.sharedInstance.conversionHeight,
                                    width: 60.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: 60.0 * UtilityManager.sharedInstance.conversionHeight)
    
    arrayOfFrames.append(frameForImageView)
    
    //fourth quadrant
    
    frameForImageView = CGRect.init(x: 139.0 * UtilityManager.sharedInstance.conversionWidth,
                                    y: 167.0 * UtilityManager.sharedInstance.conversionHeight,
                                width: 60.0 * UtilityManager.sharedInstance.conversionWidth,
                               height: 60.0 * UtilityManager.sharedInstance.conversionHeight)
    
    arrayOfFrames.append(frameForImageView)
    
  }
  
  private func createParticipateInLabel() {
    
    exclusiveLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: AgencyProfileVisualizeConstants.VisualizeParticipateInView.participateInLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    exclusiveLabel.attributedText = stringWithFormat
    exclusiveLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (exclusiveLabel.frame.size.width / 2.0),
                               y: 0.0,
                               width: exclusiveLabel.frame.size.width,
                               height: exclusiveLabel.frame.size.height)
    
    exclusiveLabel.frame = newFrame
    
    self.addSubview(exclusiveLabel)
    
  }
  
  private func createMainScrollView() {
    
    let frameForMainScrollView = CGRect.init(x: 34.0 * UtilityManager.sharedInstance.conversionWidth,
                                             y: 30.0 * UtilityManager.sharedInstance.conversionHeight,
                                             width: 235.0 * UtilityManager.sharedInstance.conversionWidth,
                                             height: 270.0 * UtilityManager.sharedInstance.conversionHeight)
    
    //Change the value of the next 'size' to make scrollViewAnimate
//    let sizeOfScrollViewContent = CGSize.init(width: frameForMainScrollView.size.width, height: frameForMainScrollView.size.height + (50.0 * UtilityManager.sharedInstance.conversionHeight))
    
    mainScrollView = UIScrollView.init(frame: frameForMainScrollView)
    mainScrollView.backgroundColor = UIColor.clearColor()
//    mainScrollView.contentSize = sizeOfScrollViewContent
    mainScrollView.showsVerticalScrollIndicator = true
    
    self.addSubview(mainScrollView)
    
  }
  
  private func createAllImageViews() {
    
    if AgencyModel.Data.golden_pitch != nil && AgencyModel.Data.golden_pitch ==  true {
      
      self.createGoldImageView()
      actualFrame = actualFrame + 1
      
    }
    
    if AgencyModel.Data.silver_pitch != nil && AgencyModel.Data.silver_pitch ==  true {
      
      self.createSilverImageView()
      actualFrame = actualFrame + 1
      
    }
    
    if AgencyModel.Data.medium_risk_pitch != nil && AgencyModel.Data.medium_risk_pitch ==  true {
      
      self.createMediumRiskView()
      actualFrame = actualFrame + 1
      
    }
    
    if AgencyModel.Data.high_risk_pitch != nil && AgencyModel.Data.high_risk_pitch ==  true {
      
      self.createHighRiskView()
      actualFrame = actualFrame + 1
      
    }
    
  }
    
  private func createGoldImageView() {
    
    let imageView = UIImageView.init(image: UIImage.init(named: "goldFace"))
    imageView.frame = arrayOfFrames[actualFrame]
    
    arrayOfImageViews.append(imageView)
    mainScrollView.addSubview(imageView)
    
  }
  
  
  private func createSilverImageView() {
    
    let imageView = UIImageView.init(image: UIImage.init(named: "silverFace"))
    imageView.frame = arrayOfFrames[actualFrame]
    
    arrayOfImageViews.append(imageView)
    mainScrollView.addSubview(imageView)
    
  }
  
  
  private func createMediumRiskView() {
    
    let imageView = UIImageView.init(image: UIImage.init(named: "mediumFace"))
    imageView.frame = arrayOfFrames[actualFrame]
    
    arrayOfImageViews.append(imageView)
    mainScrollView.addSubview(imageView)
    
  }
  
  
  private func createHighRiskView() {
    
    let imageView = UIImageView.init(image: UIImage.init(named: "highFace"))
    imageView.frame = arrayOfFrames[actualFrame]
    
    arrayOfImageViews.append(imageView)
    mainScrollView.addSubview(imageView)
    
  }
  
  private func createHappitchLabel() {
    
    let happitchLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
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
    let newFrame = CGRect.init(x: 28.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 126.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: happitchLabel.frame.size.width,
                               height: happitchLabel.frame.size.height)
    
    happitchLabel.frame = newFrame
    
    mainScrollView.addSubview(happitchLabel)
    
  }
  
}
