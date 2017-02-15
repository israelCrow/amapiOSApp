//
//  CriteriaAgencyProfileEditView.swift
//  Amap
//
//  Created by Mac on 8/11/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class CriteriaAgencyProfileEditView: UIView, CriterionViewDelegate {
  
  private var mainScrollView: UIScrollView! = nil
  private var arrayOfLabels: [CriterionView]! = nil
  
  private var criteriaLabel: UILabel! = nil
  private var descriptionLabel: UILabel! = nil
  private var presentationTimeCriterion: CriterionView! = nil
  private var minimumBudgetCriterion: CriterionView! = nil
  private var deliverIntelectualPropertyCriterion: CriterionView! = nil
  private var onlyPitchesPaymentsCriterion: CriterionView! = nil
  private var haveToKnowTheProjectBudgetCriterion: CriterionView! = nil
  
  var thereAreChanges: Bool = false
  
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
    self.createCriteriaDescription()
    self.createMainScrollView()
//    self.createPresentationTimeCriterion()
//    self.createMinimumBudgetCriterion()
//    self.createDeliverIntelectualPropertyCriterion()
//    self.createOnlyPitchesPaymentsCriterion()
//    self.createHaveToKnowTheProjectBudgetCriterion()
    
//    self.addAllLabels()
    
  }
  
  private func createMainScrollView() {
    
    let frameForMainScrollView = CGRect.init(x: 34.0 * UtilityManager.sharedInstance.conversionWidth,
                                        y: 170.0 * UtilityManager.sharedInstance.conversionHeight,
                                    width: 235.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 290.0 * UtilityManager.sharedInstance.conversionHeight)
    
    //Change the value of the next 'size' to make scrollViewAnimate
    let sizeOfScrollViewContent = CGSize.init(width: frameForMainScrollView.size.width, height: frameForMainScrollView.size.height + 0.0)
   
    mainScrollView = UIScrollView.init(frame: frameForMainScrollView)
    mainScrollView.backgroundColor = UIColor.clearColor()
    mainScrollView.contentSize = sizeOfScrollViewContent
    mainScrollView.showsVerticalScrollIndicator = true
    
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
  
  private func createCriteriaDescription() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    descriptionLabel = UILabel.init(frame: frameForLabel)
    descriptionLabel.numberOfLines = 0
    descriptionLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: AgencyProfileEditConstants.CriteriaView.criteriaDescriptionText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    descriptionLabel.attributedText = stringWithFormat
    descriptionLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (descriptionLabel.frame.size.width / 2.0),
                               y: 86.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: descriptionLabel.frame.size.width,
                               height: descriptionLabel.frame.size.height)
    
    descriptionLabel.frame = newFrame
    
    self.addSubview(descriptionLabel)
    
  }
  
  private func createPresentationTimeCriterion() {
    
    let frameForNewCriterion = CGRect.init(x: 4.0 * UtilityManager.sharedInstance.conversionWidth,
                                           y: 14.0 * UtilityManager.sharedInstance.conversionHeight,
                                       width: 220 * UtilityManager.sharedInstance.conversionWidth,
                                      height: 56 * UtilityManager.sharedInstance.conversionHeight)

    presentationTimeCriterion = CriterionView.init(frame: frameForNewCriterion,
                                      textLabel: AgencyProfileEditConstants.CriteriaView.presentationTimeLabelText, valueOfSwitch: false) //change this in future
    presentationTimeCriterion.adaptSize()
    presentationTimeCriterion.delegate = self
    
    arrayOfLabels.append(presentationTimeCriterion)
    
  }
  
  private func createMinimumBudgetCriterion() {
    
    let frameForNewCriterion = CGRect.init(x: 4.0 * UtilityManager.sharedInstance.conversionWidth,
                                           y: 14.0 * UtilityManager.sharedInstance.conversionHeight,
                                       width: 220 * UtilityManager.sharedInstance.conversionWidth,
                                      height: 56 * UtilityManager.sharedInstance.conversionHeight)
    
    minimumBudgetCriterion = CriterionView.init(frame: frameForNewCriterion,
                                          textLabel: AgencyProfileEditConstants.CriteriaView.minimumBudgetLabelText, valueOfSwitch: false) //change this in future
    minimumBudgetCriterion.adaptSize()
    minimumBudgetCriterion.delegate = self
    
    arrayOfLabels.append(minimumBudgetCriterion)
    
  }
  
  private func createDeliverIntelectualPropertyCriterion() {
    
    let frameForNewCriterion = CGRect.init(x: 4.0 * UtilityManager.sharedInstance.conversionWidth,
                                           y: 14.0 * UtilityManager.sharedInstance.conversionHeight,
                                           width: 220 * UtilityManager.sharedInstance.conversionWidth,
                                           height: 56 * UtilityManager.sharedInstance.conversionHeight)
    
    deliverIntelectualPropertyCriterion = CriterionView.init(frame: frameForNewCriterion,
                                                             textLabel: AgencyProfileEditConstants.CriteriaView.deliverIntelectualPropertyLabelText,  valueOfSwitch: false) //change this in future

    deliverIntelectualPropertyCriterion.adaptSize()
    deliverIntelectualPropertyCriterion.delegate = self
    
    arrayOfLabels.append(deliverIntelectualPropertyCriterion)
    
  }
  
  private func createOnlyPitchesPaymentsCriterion() {
    
    let frameForNewCriterion = CGRect.init(x: 4.0 * UtilityManager.sharedInstance.conversionWidth,
                                           y: 14.0 * UtilityManager.sharedInstance.conversionHeight,
                                           width: 220 * UtilityManager.sharedInstance.conversionWidth,
                                           height: 56 * UtilityManager.sharedInstance.conversionHeight)
    
    onlyPitchesPaymentsCriterion = CriterionView.init(frame: frameForNewCriterion,
                                                      textLabel: AgencyProfileEditConstants.CriteriaView.onlyPitchesPaymentsLabelText, valueOfSwitch: false) //change this in future

    onlyPitchesPaymentsCriterion.adaptSize()
    onlyPitchesPaymentsCriterion.delegate = self
    
    arrayOfLabels.append(onlyPitchesPaymentsCriterion)
    
  }
  
  private func createHaveToKnowTheProjectBudgetCriterion() {
    
    let frameForNewCriterion = CGRect.init(x: 4.0 * UtilityManager.sharedInstance.conversionWidth,
                                           y: 14.0 * UtilityManager.sharedInstance.conversionHeight,
                                           width: 220 * UtilityManager.sharedInstance.conversionWidth,
                                           height: 56 * UtilityManager.sharedInstance.conversionHeight)
    
    haveToKnowTheProjectBudgetCriterion = CriterionView.init(frame: frameForNewCriterion,
                                                             textLabel: AgencyProfileEditConstants.CriteriaView.haveToKnowTheProjectBudgetLabelText,  valueOfSwitch: false) //change this in future

    haveToKnowTheProjectBudgetCriterion.adaptSize()
    haveToKnowTheProjectBudgetCriterion.delegate = self
    
    arrayOfLabels.append(haveToKnowTheProjectBudgetCriterion)
    
  }
  
  private func addAllLabels() {
    
    var contentHeight: CGFloat = 0.0
    
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
      
      contentHeight = contentHeight + nextCriterion.frame.size.height + (0.0 * UtilityManager.sharedInstance.conversionHeight)
      
    }
    
    let newContentSizeForScroll = CGSize.init(width: mainScrollView.contentSize.width,
                                             height: mainScrollView.contentSize.height + contentHeight)
    
    mainScrollView.contentSize = newContentSizeForScroll
    
  }
  
  func getAllCriterionsFromServer() {
    
    UtilityManager.sharedInstance.showLoader()
    
    RequestToServerManager.sharedInstance.requestToGetAllCriterions { (criteria) in
      
      for criterion in criteria {
        
        let valueOfSwitch = self.selectedCriterion(criterion.id)
        
        let frameForNewCriterion = CGRect.init(x: 4.0 * UtilityManager.sharedInstance.conversionWidth,
          y: 14.0 * UtilityManager.sharedInstance.conversionHeight,
          width: 220 * UtilityManager.sharedInstance.conversionWidth,
          height: 56 * UtilityManager.sharedInstance.conversionHeight)
        
        let criterionView = CriterionView.init(frame: frameForNewCriterion,
          textLabel: criterion.name,
          valueOfSwitch: valueOfSwitch) //change this in future
        
        criterionView.adaptSize()
        criterionView.criterionId = criterion.id
        criterionView.delegate = self
        
        self.arrayOfLabels.append(criterionView)
        
        UtilityManager.sharedInstance.hideLoader()
        
      }
      
      self.addAllLabels()
      
    }
    
  }
  
  private func selectedCriterion(criterionID: String) -> Bool {
    
    if AgencyModel.Data.criteria != nil {
      
      for criterion in AgencyModel.Data.criteria! {
        
        if criterion.id == criterionID {
          
          return true
          
        }
        
      }
      
    }
    
    return false
    
  }
  
  func saveCriterionsSelected() {
    
    var arrayCriteria = [String]()
    
    for criterionView in arrayOfLabels {
      
      if criterionView.getValueOfSwitch() == true {
        
        arrayCriteria.append(criterionView.criterionId)
        
      }
      
    }
    
    let params = ["auth_token" : UserSession.session.auth_token,
                  "id" : AgencyModel.Data.id,
                  "criteria" : arrayCriteria
                 ]
    
    UtilityManager.sharedInstance.showLoader()
    
    RequestToServerManager.sharedInstance.requestToSaveDataFromCriterions(params as! [String : AnyObject]) {
      
      UtilityManager.sharedInstance.hideLoader()
      
    }
    
  }
  
  //MARK: - CriterionViewDelegate
  
  func theValueHasChanged(isValueChanged: Bool) {
  
    thereAreChanges = true
    
  }
  
}
