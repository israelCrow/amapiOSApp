//
//  EvaluatePitchView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/14/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol EvaluatePitchViewDelegate {
  
}


class EvaluatePitchView: UIView {
  
  private var mainScrollView: UIScrollView! = nil
  private var clearObjectivesView: CustomSegmentedControlWithTitleView! = nil
  private var howManyDaysToShow: CustomTextFieldWithTitleView! = nil
  private var projectBudget: CustomSegmentedControlWithTitleView! = nil
  private var numberOfAgenciesInPitch: CustomSegmentedControlWithTitleView! = nil
  private var clearDeliverable: CustomSegmentedControlWithTitleView! = nil
  private var involvementOfMarketing: CustomSegmentedControlWithTitleView! = nil
  private var howManyDaysTheyGiveTheRuling: CustomTextFieldWithTitleView! = nil
  private var deliverIntelectualPropertyJustToPitch: CustomSegmentedControlWithTitleView! = nil
  private var youKnoHowManyPresentationRounds: CustomSegmentedControlWithTitleView! = nil
  private var howManyAreThere: CustomTextFieldWithTitleView! = nil

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    self.createMainScrollView()
    self.createClearObjectivesView()
    
  }
  
  private func createMainScrollView() {
    
    let frameForMainScrollView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                             y: 30.0 * UtilityManager.sharedInstance.conversionHeight,
                                             width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                             height: 291.0 * UtilityManager.sharedInstance.conversionHeight)//Value that I considered
    let sizeForContentScrollView = CGSize.init(width: frameForMainScrollView.size.width,
                                               height: frameForMainScrollView.size.height + (1000.0 * UtilityManager.sharedInstance.conversionHeight))//Value that i considered
    
    mainScrollView = UIScrollView.init(frame: frameForMainScrollView)
    mainScrollView.backgroundColor = UIColor.clearColor()
    mainScrollView.contentSize = sizeForContentScrollView
    mainScrollView.showsVerticalScrollIndicator = true
    self.addSubview(mainScrollView)
    
  }
  
  private func createClearObjectivesView() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: 0.0,
                               width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                              height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let segmentsArray = ["Sí", "No sé", "No"]
    
    clearObjectivesView = CustomSegmentedControlWithTitleView.init(frame: frameForView,
                                                                   title: "¿Tienes los objetivos claros?",
                                                                   image: nil,
                                                                   segmentsText: segmentsArray)
    
    mainScrollView.addSubview(clearObjectivesView)
    
    
  }

}


