//
//  DetailPitchView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/12/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol DetailPitchViewDelegate {
  
  func declineEvaluationPitch(params: [String: AnyObject])
  func cancelEvaluationPitch(params: [String: AnyObject])
  func archiveEvaluationPitch(params: [String: AnyObject])
  func deleteEvaluationPitch(params: [String: AnyObject])
  
  func pushAddResultsViewController(pitchaEvaluationData: PitchEvaluationByUserModelData)
  
  func editPitchEvaluation(pitchEvaluationData: PitchEvaluationByUserModelData)
  
}

class DetailPitchView: UIView, DetailPitchCanceledDeclinedButtonsDelegate, DetailPitchAddResultsViewDelegate, TabBarArchiveEditDeletePitchViewDelegate {
  
  var pitchEvaluationData: PitchEvaluationByUserModelData! = nil
  private var mainScrollView: UIScrollView! = nil
  private var graphPitchView: GraphPartPitchCardView! = nil
  private var bottomContainerView: UIView! = nil
  private var pitchSkillsView: DetailPitchSkillsEvaluationView! = nil
  private var fillSurveyView: DetailPitchAddResultsView! = nil
  private var cancelDeclinButtonsView: DetailPitchCanceledDeclinedButtons! = nil
  private var tabBarForPitchDetail: TabBarArchiveEditDeletePitchView! = nil
  
  var delegate: DetailPitchViewDelegate?
  
  private let originalFrameForContainerView = CGRect.init(x: 0.0,
                                                          y: UIScreen.mainScreen().bounds.size.height + (50.0 * UtilityManager.sharedInstance.conversionHeight),
                                                      width: UIScreen.mainScreen().bounds.size.width,
                                                     height: 600.0 * UtilityManager.sharedInstance.conversionHeight)
  
  private var frameWhenAnimateShowOfContainerView = CGRect.init(x: 0.0,
                                                               y: (344.0 * UtilityManager.sharedInstance.conversionHeight),
                                                           width: UIScreen.mainScreen().bounds.size.width,
                                                          height: 600.0 * UtilityManager.sharedInstance.conversionHeight)
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newPitchData: PitchEvaluationByUserModelData, newGraphPart: GraphPartPitchCardView) {
  
    pitchEvaluationData = newPitchData
    graphPitchView = newGraphPart
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.clearColor()
    
    self.createMainScrollView()
    self.createBottomContainerView()
    self.createPitchSkillsView()
    self.createFillSurveyView()
    self.createCancelEditButtonsView()
    self.createTabBarForPitchDetail()
    
  }
  
  private func createMainScrollView() {
    
    let frameForMainScrollView = CGRect.init(x: 0.0,
                                             y: 180.0 * UtilityManager.sharedInstance.conversionHeight,
                                             width: UIScreen.mainScreen().bounds.size.width,
                                             height: UIScreen.mainScreen().bounds.size.height)//Value that I considered
    let sizeForContentScrollView = CGSize.init(width: frameForMainScrollView.size.width,
                                               height: frameForMainScrollView.size.height + (350.0 * UtilityManager.sharedInstance.conversionHeight))//Value that i considered
    
    mainScrollView = UIScrollView.init(frame: frameForMainScrollView)
    mainScrollView.backgroundColor = UIColor.whiteColor()
    mainScrollView.contentSize = sizeForContentScrollView
    mainScrollView.showsVerticalScrollIndicator = true
    mainScrollView.alpha = 0.0
    mainScrollView.userInteractionEnabled = false
    
    self.addSubview(mainScrollView)
    
  }
  
  private func createBottomContainerView() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: UIScreen.mainScreen().bounds.size.height + (50.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: UIScreen.mainScreen().bounds.size.width,
                              height: 450.0 * UtilityManager.sharedInstance.conversionHeight)
    
    bottomContainerView = UIView.init(frame: frameForView)
    bottomContainerView.backgroundColor = UIColor.whiteColor()
    
    mainScrollView.addSubview(bottomContainerView)
    
  }
  
  private func createPitchSkillsView() {
    
    let frameForView = CGRect.init(x: 40.0 * UtilityManager.sharedInstance.conversionWidth,
                                   y: 30.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                              height: 135.0 * UtilityManager.sharedInstance.conversionHeight)
    
    pitchSkillsView = DetailPitchSkillsEvaluationView.init(frame: frameForView, newArrayOfEvaluationPitchSkillCategories: pitchEvaluationData.arrayOfEvaluationPitchSkillCategory)
    
    bottomContainerView.addSubview(pitchSkillsView)
    
  }
  
  private func createFillSurveyView() {
    
    if fillSurveyView != nil {
      
      fillSurveyView.removeFromSuperview()
      fillSurveyView = nil
      
    }
    
    let frameForView = CGRect.init(x: 40.0 * UtilityManager.sharedInstance.conversionWidth,
                                   y: pitchSkillsView.frame.origin.y + pitchSkillsView.frame.size.height + (30.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                              height: 185.0 * UtilityManager.sharedInstance.conversionHeight)
    
    var stringForButton = ""
    if pitchEvaluationData.hasResults == true {
      
      stringForButton = "editar resultado"
      
    } else {
      
      stringForButton = EditPitchesConstants.DetailPitchAddResultsView.addResultsButtonText
      
    }
    
    fillSurveyView = DetailPitchAddResultsView.init(frame: frameForView, newStringForButton: stringForButton)
    fillSurveyView.delegate = self
    
    bottomContainerView.addSubview(fillSurveyView)
    
  }
  
  func reloadOnlyFillSurveyView() {
    
    self.createFillSurveyView()
    
  }
  
  private func createCancelEditButtonsView() {
    
    let frameForView = CGRect.init(x: 40.0 * UtilityManager.sharedInstance.conversionWidth,
                                   y: fillSurveyView.frame.origin.y + fillSurveyView.frame.size.height + (30.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                              height: 70.0 * UtilityManager.sharedInstance.conversionHeight)
    
    cancelDeclinButtonsView = DetailPitchCanceledDeclinedButtons.init(frame: frameForView)
    cancelDeclinButtonsView.delegate = self
    
    bottomContainerView.addSubview(cancelDeclinButtonsView)
    
  }
  
  private func createTabBarForPitchDetail() {
    
    let pointForView = CGPoint.init(x: 0.0,
                                    y: UIScreen.mainScreen().bounds.size.height - (49.0 * UtilityManager.sharedInstance.conversionHeight))
    
    tabBarForPitchDetail = TabBarArchiveEditDeletePitchView.init(atPoint: pointForView)
    tabBarForPitchDetail.delegate = self
    tabBarForPitchDetail.alpha = 0.0
    tabBarForPitchDetail.userInteractionEnabled = false
    self.addSubview(tabBarForPitchDetail)
    
  }
  
  func reloadDataAndInterface(newPitchEvaluationByUserData: PitchEvaluationByUserModelData, newGraphPart: GraphPartPitchCardView) {
    
    graphPitchView = newGraphPart
    pitchEvaluationData = newPitchEvaluationByUserData
    
    if pitchSkillsView != nil {
      
      pitchSkillsView.setArrayOfEvaluationPitchSkillCategories(pitchEvaluationData.arrayOfEvaluationPitchSkillCategory)
      
    }
    
    if fillSurveyView != nil {
      
      self.createFillSurveyView()
      
    }
    
  }
  
  func animateShowPitchEvaluationDetail() {
    
    self.enableMainScrollView()
    self.enableTabBarForPitchDetail()

    if graphPitchView != nil {
      
      graphPitchView.alpha = 1.0
      mainScrollView.addSubview(graphPitchView)
      
      UIView.animateWithDuration(
        0.55,
        delay: 0.0,
        usingSpringWithDamping: 0.3,
        initialSpringVelocity: 10.0,
        options: .BeginFromCurrentState,
        animations: { () -> Void in
          self.graphPitchView.containerAndGradientView.transform = CGAffineTransformMakeScale(1.27, 0.99)
      }) { (completed:Bool) -> Void in
        
      
      }

    }
    
    self.animateShowBottomContainerView()
    
  }
  
  private func enableMainScrollView() {
    
    mainScrollView.userInteractionEnabled = true
    mainScrollView.alpha = 1.0
    
  }
  
  private func enableTabBarForPitchDetail() {
    
    UIView.animateWithDuration(0.35,
      animations: { 
        
        self.tabBarForPitchDetail.alpha = 1.0
        
      }) { (finished) in
        if finished == true {
          
          self.tabBarForPitchDetail.userInteractionEnabled = true
          
        }
    }
    
  }
  
  private func animateShowBottomContainerView() {
    
    UIView.animateWithDuration(0.55,
      delay: 0.0,
      usingSpringWithDamping: 0.5,
      initialSpringVelocity: 10.0,
      options: UIViewAnimationOptions.CurveEaseOut,
      animations: {
      //Do all animations here
      
        self.bottomContainerView.frame = self.frameWhenAnimateShowOfContainerView
      
      }, completion: {
        //Code to run after animating
        (finished) in
        
        if finished == true {
          
          //Do something
          
        }
    })
    
  }
  
  func animateHiddingPitchEvaluationDetail() {
    
    self.disableTabBarForPitchDetail()
    
    if graphPitchView != nil {
      
      UIView.animateWithDuration(
        0.15,
        animations: { () -> Void in
          
          self.graphPitchView.containerAndGradientView.alpha = 0.0
          
      }) { (completed:Bool) -> Void in
        
        if completed == true {
        
          self.animateHiddingBottomContainerView()
          self.graphPitchView.alpha = 0.0
          self.graphPitchView.removeFromSuperview()
          
        }
        
      }
      
    }
    
  }
  
  private func disableTabBarForPitchDetail() {
    
    UIView.animateWithDuration(0.35,
                               animations: {
                                
                                self.tabBarForPitchDetail.alpha = 0.0
                                
    }) { (finished) in
      if finished == true {
        
        self.tabBarForPitchDetail.userInteractionEnabled = false
        
      }
    }
    
  }
  
  private func disableMainScrollView() {
    
    mainScrollView.userInteractionEnabled = false
    mainScrollView.alpha = 0.0
    
  }
  
  private func animateHiddingBottomContainerView() {
    
    UIView.animateWithDuration(0.55,
                               delay: 0.0,
                               usingSpringWithDamping: 0.5,
                               initialSpringVelocity: 10.0,
                               options: UIViewAnimationOptions.CurveEaseOut,
                               animations: {
                                //Do all animations here
                                
                                self.bottomContainerView.frame = self.originalFrameForContainerView
                                
      }, completion: {
        //Code to run after animating
        (finished) in
        
        if finished == true {
          
          self.disableMainScrollView()
          
        }
    })
    
  }
  
  //MARK: - DetailPitchAddResultsViewDelegate 
  
  func pushAddResultsViewController() {
    
    self.delegate?.pushAddResultsViewController(pitchEvaluationData)
    
  }
  
  //MARK: - DetailPitchCanceledDeclinedButtonsDelegate
  
  func doCanceledPitchFunction() {
    
    let params: [String: AnyObject] = ["auth_token": UserSession.session.auth_token,
                                       "id": pitchEvaluationData.pitchEvaluationId
                                      ]
    
    self.delegate?.cancelEvaluationPitch(params)
    
  }
  
  func doDeclinedPitchFunction() {
    
    let params: [String: AnyObject] = ["auth_token": UserSession.session.auth_token,
                                       "id": pitchEvaluationData.pitchEvaluationId
    ]
    
    self.delegate?.declineEvaluationPitch(params)
    
  }
  
  //MARK: - TabBarArchiveEditDeletePitchViewDelegate
  
  func archivePitchEvaluationButtonFromTabBarPressed() {
    
    let params: [String: AnyObject] = ["auth_token": UserSession.session.auth_token,
                                       "id": pitchEvaluationData.pitchEvaluationId
    ]
    
    self.delegate?.archiveEvaluationPitch(params)
    
  }
  
  func deletePitchEvaluationButtonFromTabBarPressed() {
    
    let params: [String: AnyObject] = ["auth_token": UserSession.session.auth_token,
                                       "id": pitchEvaluationData.pitchEvaluationId
    ]
    
    self.delegate?.deleteEvaluationPitch(params)
    
  }
  
  func editPitchEvaluationButtonFromTabBarPressed() {
    
    self.delegate?.editPitchEvaluation(pitchEvaluationData)
    
  }
  
  func changeFrameOfContainerView(heightOfNavigationBar: CGFloat) {
    
    let frameForMainScrolView = CGRect.init(x: 0.0,
                                            y: heightOfNavigationBar,
                                        width: frameWhenAnimateShowOfContainerView.size.width,
                                       height: frameWhenAnimateShowOfContainerView.size.height)
    
    mainScrollView.frame = frameForMainScrolView
  
  }
  
}
