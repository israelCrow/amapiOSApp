//
//  VisualizeCriteriaView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/1/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class VisualizeCriteriaView: UIView {
  
  private var criteriaLabel: UILabel! = nil
  private var mainScrollView: UIScrollView! = nil
  private var arrayOfCriteriaLabel = Array<UILabel>()
  
  
  private var arrayOfCriteriaString = Array<String>()
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    
    self.initSomeValues()
    self.createInterface()
    
  }
  
  private func initSomeValues() {
    
    for criterion in AgencyModel.Data.criteria! {
      
      arrayOfCriteriaString.append(criterion.name)
      
    }
    
//    arrayOfCriteriaString.append(AgencyProfileEditConstants.CriteriaView.presentationTimeLabelText)
//    arrayOfCriteriaString.append(AgencyProfileEditConstants.CriteriaView.minimumBudgetLabelText)
//    arrayOfCriteriaString.append(AgencyProfileEditConstants.CriteriaView.deliverIntelectualPropertyLabelText)
//    arrayOfCriteriaString.append(AgencyProfileEditConstants.CriteriaView.onlyPitchesPaymentsLabelText)
//    arrayOfCriteriaString.append(AgencyProfileEditConstants.CriteriaView.haveToKnowTheProjectBudgetLabelText)
//    
  }
  
  private func createInterface() {
    
    self.createCriteriaLabel()
    self.createMainScrollView()
    self.createAllLabels()
    
  }

  private func createCriteriaLabel() {
    
    criteriaLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: AgencyProfileVisualizeConstants.VisualizeCriteriaView.criteriaLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    criteriaLabel.attributedText = stringWithFormat
    criteriaLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (criteriaLabel.frame.size.width / 2.0),
                               y: 0.0,
                           width: criteriaLabel.frame.size.width,
                          height: criteriaLabel.frame.size.height)
    
    criteriaLabel.frame = newFrame
    
    self.addSubview(criteriaLabel)
    
  }
  
  private func createMainScrollView() {
    
    let frameForMainScrollView = CGRect.init(x: 34.0 * UtilityManager.sharedInstance.conversionWidth,
                                             y: 46.0 * UtilityManager.sharedInstance.conversionHeight,
                                             width: 235.0 * UtilityManager.sharedInstance.conversionWidth,
                                             height: 270.0 * UtilityManager.sharedInstance.conversionHeight)
    
    //Change the value of the next 'size' to make scrollViewAnimate
    let sizeOfScrollViewContent = CGSize.init(width: frameForMainScrollView.size.width, height: frameForMainScrollView.size.height + (50.0 * UtilityManager.sharedInstance.conversionHeight))
    
    mainScrollView = UIScrollView.init(frame: frameForMainScrollView)
    mainScrollView.backgroundColor = UIColor.clearColor()
    mainScrollView.contentSize = sizeOfScrollViewContent
    mainScrollView.showsVerticalScrollIndicator = true
    
    self.addSubview(mainScrollView)
    
  }
  
  private func createAllLabels() {
    
    var frameForLabels = CGRect.init(x: 14.0 * UtilityManager.sharedInstance.conversionHeight,
                                     y: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                 width: 206.0 * UtilityManager.sharedInstance.conversionWidth,
                                height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
    
    for eachCriteria in arrayOfCriteriaString {
      
      let newCriterionLabel = UILabel.init(frame: frameForLabels)
      newCriterionLabel.numberOfLines = 3
      
      let font = UIFont(name: "SFUIText-Light",
                        size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
      let color = UIColor.blackColor()
      let style = NSMutableParagraphStyle()
      style.alignment = NSTextAlignment.Left
      
      let stringWithFormat = NSMutableAttributedString(
        string: eachCriteria,
        attributes:[NSFontAttributeName: font!,
          NSParagraphStyleAttributeName: style,
          NSForegroundColorAttributeName: color
        ]
      )
      
      newCriterionLabel.attributedText = stringWithFormat
      newCriterionLabel.sizeToFit()
      let newFrame = CGRect.init(x: frameForLabels.origin.x,
                                 y: frameForLabels.origin.y,
                                 width: frameForLabels.size.width,
                                 height: newCriterionLabel.frame.size.height + (40.0 * UtilityManager.sharedInstance.conversionHeight))
      
      newCriterionLabel.frame = newFrame
      
      let border = CALayer()
      let width = CGFloat(1)
      border.borderColor = UIColor.darkGrayColor().CGColor
      border.borderWidth = width
      border.frame = CGRect.init(x: -14.0 * UtilityManager.sharedInstance.conversionWidth,
                                 y: newCriterionLabel.frame.size.height - (1.0 * UtilityManager.sharedInstance.conversionHeight),
                                 width: frameForLabels.size.width + (14.0 * UtilityManager.sharedInstance.conversionWidth),
                                 height: 0.5)
      newCriterionLabel.layer.addSublayer(border)
      newCriterionLabel.layer.masksToBounds = false
      
      mainScrollView.addSubview(newCriterionLabel)
      
      frameForLabels = CGRect.init(x: newCriterionLabel.frame.origin.x,
                                   y: newCriterionLabel.frame.origin.y + newCriterionLabel.frame.size.height  ,
                               width: frameForLabels.size.width,
                              height: 56.0 * UtilityManager.sharedInstance.conversionWidth)
      
      arrayOfCriteriaLabel.append(newCriterionLabel)
      
    }
    
    mainScrollView.contentSize = CGSize.init(width: mainScrollView.contentSize.width,
                                            height: frameForLabels.origin.y + frameForLabels.size.height)
    
  }
  
}
