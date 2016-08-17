//
//  CriteriaAgencyProfileEditView.swift
//  Amap
//
//  Created by Mac on 8/11/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class CriteriaAgencyProfileEditView: UIView {
  
  private var mainScrollView: UIScrollView! = nil
  private var arrayOfLabels: [CriterionView]! = nil
  
  private var criteriaLabel: UILabel! = nil
  private var presentationTimeCriterion: CriterionView! = nil
  private var minimumBudgetCriterion: CriterionView! = nil
  private var deliverIntelectualPropertyCriterion: CriterionView! = nil
  private var onlyPitchesPaymentsCriterion: CriterionView! = nil
  private var haveToKnowTheProjectBudgetCriterion: CriterionView! = nil
  
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
    
    self.createCriteriaLabel()
    self.createMainScrollView()
    self.createPresentationTimeCriterion()
    self.createMinimumBudgetCriterion()
    self.createDeliverIntelectualPropertyCriterion()
    self.createOnlyPitchesPaymentsCriterion()
    self.createHaveToKnowTheProjectBudgetCriterion()
    
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
  
  private func createCriteriaLabel() {
    criteriaLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: AgencyProfileEditConstants.CriteriaView.criteriaLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    criteriaLabel.attributedText = stringWithFormat
    criteriaLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (criteriaLabel.frame.size.width / 2.0),
                               y: 30.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: criteriaLabel.frame.size.width,
                               height: criteriaLabel.frame.size.height)
    
    criteriaLabel.frame = newFrame
    
    self.addSubview(criteriaLabel)
  }
  
  private func createPresentationTimeCriterion() {
    
    let frameForNewCriterion = CGRect.init(x: 4.0 * UtilityManager.sharedInstance.conversionWidth,
                                           y: 14.0 * UtilityManager.sharedInstance.conversionHeight,
                                       width: 220 * UtilityManager.sharedInstance.conversionWidth,
                                      height: 56 * UtilityManager.sharedInstance.conversionHeight)

    presentationTimeCriterion = CriterionView.init(frame: frameForNewCriterion,
                                      textLabel: AgencyProfileEditConstants.CriteriaView.presentationTimeLabelText)
    presentationTimeCriterion.adaptSize()
    
    arrayOfLabels.append(presentationTimeCriterion)
    
  }
  
  private func createMinimumBudgetCriterion() {
    
    let frameForNewCriterion = CGRect.init(x: 4.0 * UtilityManager.sharedInstance.conversionWidth,
                                           y: 14.0 * UtilityManager.sharedInstance.conversionHeight,
                                       width: 220 * UtilityManager.sharedInstance.conversionWidth,
                                      height: 56 * UtilityManager.sharedInstance.conversionHeight)
    
    minimumBudgetCriterion = CriterionView.init(frame: frameForNewCriterion,
                                          textLabel: AgencyProfileEditConstants.CriteriaView.minimumBudgetLabelText)
    minimumBudgetCriterion.adaptSize()
    
    arrayOfLabels.append(minimumBudgetCriterion)
    
  }
  
  private func createDeliverIntelectualPropertyCriterion() {
    
    let frameForNewCriterion = CGRect.init(x: 4.0 * UtilityManager.sharedInstance.conversionWidth,
                                           y: 14.0 * UtilityManager.sharedInstance.conversionHeight,
                                           width: 220 * UtilityManager.sharedInstance.conversionWidth,
                                           height: 56 * UtilityManager.sharedInstance.conversionHeight)
    
    deliverIntelectualPropertyCriterion = CriterionView.init(frame: frameForNewCriterion,
                                          textLabel: AgencyProfileEditConstants.CriteriaView.deliverIntelectualPropertyLabelText)
    deliverIntelectualPropertyCriterion.adaptSize()
    
    arrayOfLabels.append(deliverIntelectualPropertyCriterion)
    
  }
  
  private func createOnlyPitchesPaymentsCriterion() {
    
    let frameForNewCriterion = CGRect.init(x: 4.0 * UtilityManager.sharedInstance.conversionWidth,
                                           y: 14.0 * UtilityManager.sharedInstance.conversionHeight,
                                           width: 220 * UtilityManager.sharedInstance.conversionWidth,
                                           height: 56 * UtilityManager.sharedInstance.conversionHeight)
    
    onlyPitchesPaymentsCriterion = CriterionView.init(frame: frameForNewCriterion,
                                          textLabel: AgencyProfileEditConstants.CriteriaView.onlyPitchesPaymentsLabelText)
    onlyPitchesPaymentsCriterion.adaptSize()
    
    arrayOfLabels.append(onlyPitchesPaymentsCriterion)
    
  }
  
  private func createHaveToKnowTheProjectBudgetCriterion() {
    
    let frameForNewCriterion = CGRect.init(x: 4.0 * UtilityManager.sharedInstance.conversionWidth,
                                           y: 14.0 * UtilityManager.sharedInstance.conversionHeight,
                                           width: 220 * UtilityManager.sharedInstance.conversionWidth,
                                           height: 56 * UtilityManager.sharedInstance.conversionHeight)
    
    haveToKnowTheProjectBudgetCriterion = CriterionView.init(frame: frameForNewCriterion,
                                          textLabel: AgencyProfileEditConstants.CriteriaView.haveToKnowTheProjectBudgetLabelText)
    haveToKnowTheProjectBudgetCriterion.adaptSize()
    
    arrayOfLabels.append(haveToKnowTheProjectBudgetCriterion)
    
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
