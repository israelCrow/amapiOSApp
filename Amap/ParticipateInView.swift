//
//  ParticipateInView.swift
//  Amap
//
//  Created by Mac on 8/12/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit


class ParticipateInView: UIView {
  
  private var mainScrollView: UIScrollView! = nil
  private var arrayOfLabels: [CriterionView]! = nil
  
  private var participateInLabel: UILabel! = nil
  private var goldenPitchCriterion: CriterionView! = nil
  private var silverPitchCriterion: CriterionView! = nil
  private var mRiskPitchCriterion: CriterionView! = nil
  private var highRiskPitchCriterion: CriterionView! = nil
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.initSomeValues()
    self.createInterface()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func initSomeValues() {
    
    self.arrayOfLabels = []
    
  }
  
  private func createInterface() {
    self.backgroundColor = UIColor.whiteColor()
    
    self.createParticipateLabel()
    self.createMainScrollView()
    self.createGoldenPitchCriterion()
    self.createSilverPitchCriterion()
    self.createMRiskPitchCriterion()
    self.createHighRiskPitchCriterion()
    
    self.addAllLabels()
    
  }
  
  private func createMainScrollView() {
    
    let frameForMainScrollView = CGRect.init(x: 34.0 * UtilityManager.sharedInstance.conversionWidth,
                                             y: 106.0 * UtilityManager.sharedInstance.conversionHeight,
                                             width: 235.0 * UtilityManager.sharedInstance.conversionWidth,
                                             height: 355.0 * UtilityManager.sharedInstance.conversionHeight)
    
    //Change the value of the next 'size' to make scrollViewAnimate
    let sizeOfScrollViewContent = CGSize.init(width: frameForMainScrollView.size.width, height: frameForMainScrollView.size.height + 0.0)
    
    mainScrollView = UIScrollView.init(frame: frameForMainScrollView)
    mainScrollView.contentSize = sizeOfScrollViewContent
    mainScrollView.showsVerticalScrollIndicator = false
    
    self.addSubview(mainScrollView)
    
  }
  
  private func createParticipateLabel() {
    participateInLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: AgencyProfileEditConstants.ParticipateInView.participateInLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    participateInLabel.attributedText = stringWithFormat
    participateInLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (participateInLabel.frame.size.width / 2.0),
                               y: 30.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: participateInLabel.frame.size.width,
                               height: participateInLabel.frame.size.height)
    
    participateInLabel.frame = newFrame
    
    self.addSubview(participateInLabel)
  }
  
  private func createGoldenPitchCriterion() {
    
    let frameForNewCriterion = CGRect.init(x: 4.0 * UtilityManager.sharedInstance.conversionWidth,
                                           y: 14.0 * UtilityManager.sharedInstance.conversionHeight,
                                           width: 220 * UtilityManager.sharedInstance.conversionWidth,
                                           height: 56 * UtilityManager.sharedInstance.conversionHeight)
    
    goldenPitchCriterion = CriterionView.init(frame: frameForNewCriterion,
                                                   textLabel: AgencyProfileEditConstants.ParticipateInView.goldenPitchLabelText)
    goldenPitchCriterion.adaptSize()
    
    arrayOfLabels.append(goldenPitchCriterion)
    
  }
  
  private func createSilverPitchCriterion() {
    
    let frameForNewCriterion = CGRect.init(x: 4.0 * UtilityManager.sharedInstance.conversionWidth,
                                           y: 14.0 * UtilityManager.sharedInstance.conversionHeight,
                                           width: 220 * UtilityManager.sharedInstance.conversionWidth,
                                           height: 56 * UtilityManager.sharedInstance.conversionHeight)
    
    silverPitchCriterion = CriterionView.init(frame: frameForNewCriterion,
                                                textLabel: AgencyProfileEditConstants.ParticipateInView.silverPitchLabelText)
    silverPitchCriterion.adaptSize()
    
    arrayOfLabels.append(silverPitchCriterion)
    
  }
  
  private func createMRiskPitchCriterion() {
    
    let frameForNewCriterion = CGRect.init(x: 4.0 * UtilityManager.sharedInstance.conversionWidth,
                                           y: 14.0 * UtilityManager.sharedInstance.conversionHeight,
                                           width: 220 * UtilityManager.sharedInstance.conversionWidth,
                                           height: 56 * UtilityManager.sharedInstance.conversionHeight)
    
    mRiskPitchCriterion = CriterionView.init(frame: frameForNewCriterion,
                                                             textLabel: AgencyProfileEditConstants.ParticipateInView.mRiskPitchLabelText)
    mRiskPitchCriterion.adaptSize()
    
    arrayOfLabels.append(mRiskPitchCriterion)
    
  }
  
  private func createHighRiskPitchCriterion() {
    
    let frameForNewCriterion = CGRect.init(x: 4.0 * UtilityManager.sharedInstance.conversionWidth,
                                           y: 14.0 * UtilityManager.sharedInstance.conversionHeight,
                                           width: 220 * UtilityManager.sharedInstance.conversionWidth,
                                           height: 56 * UtilityManager.sharedInstance.conversionHeight)
    
    highRiskPitchCriterion = CriterionView.init(frame: frameForNewCriterion,
                                                      textLabel: AgencyProfileEditConstants.ParticipateInView.highRiskPitchLabelText)
    highRiskPitchCriterion.adaptSize()
    
    arrayOfLabels.append(highRiskPitchCriterion)
    
  }
    
  private func addAllLabels() {
    
    let firstElement = arrayOfLabels.first
    mainScrollView.addSubview(firstElement!)
    
    for i in 1 ..< arrayOfLabels.count {
      let lastCriterion = arrayOfLabels[i-1]
      let nextCriterion = arrayOfLabels[i]
      let newFrame = CGRect.init(x: nextCriterion.frame.origin.x,
                                 y: lastCriterion.frame.origin.y + lastCriterion.frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight),
                                 width: nextCriterion.frame.size.width,
                                 height: nextCriterion.frame.size.height)
      nextCriterion.frame = newFrame
      mainScrollView.addSubview(nextCriterion)
    }
    
    
  }
  
}
