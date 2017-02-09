//
//  AddResultViewController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/19/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol AddResultViewControllerDelegate {
  
  func doActionsWhenDisappear()
  
}

class AddResultViewController: UIViewController, DidYouShowYourProposalViewDelegate, DidReceiveRulingViewDelegate, DidWinPitchViewDelegate, YouWinPitchViewDelegate, DidGetFeedbackViewDelegate, RecommendationViewDelegate, WhenGonnaReceiveRulingViewDelegate, WhenGonnaToShowPitchViewDelegate, DidSignContractPitchSurveyViewDelegate, DidProjectActivePitchSurveyViewDelegate, WhenYouWillSignTheContractPitchSurveyViewDelegate, WhenProjectWillActivePitchSurveyViewDelegate {
  
  private var pitchEvaluationData: PitchEvaluationByUserModelData! = nil
  private var containerAndGradientView: GradientView! = nil
  private var arrayOfQuestionCards = [UIView]()
  private var detailedNavigation: DetailedNavigationEvaluatPitchView! = nil
  //Questions
  private var showedYourProposal: DidYouShowYourProposalView! = nil
  private var didReceiveRuling: DidReceiveRulingView! = nil
  private var didWinPitch: DidWinPitchView! = nil
  private var youWinPitch: YouWinPitchView! = nil
  private var getFeedBack: DidGetFeedbackView! = nil
  private var recommendation: RecommendationView! = nil
  private var gonnaReceiveRuling: WhenGonnaReceiveRulingView! = nil
  private var gonnaShowPitch: WhenGonnaToShowPitchView! = nil
  //Result of questions
  private var showedYourProposalSelectedValue: Int! = nil
  private var didReceiveRulingSelectedValue: Int! = nil
  private var didWinPitchSelectedValue: Int! = nil
  private var getFeedBackSelectedValue: Int! = nil
  private var gonnaReceiveRulingSelectedValue: String! = nil
  private var gonnaShowPitchSelectedValue: String! = nil
  
  //Pitch Survey
  private var didSignContractView: DidSignContractPitchSurveyView! = nil
  private var didProjectActiveView: DidProjectActivePitchSurveyView! = nil
  private var whenYouWillSignView: WhenYouWillSignTheContractPitchSurveyView! = nil
  private var whenProjectWillActiveView: WhenProjectWillActivePitchSurveyView! = nil
  
  //Pitch Survey Results
  private var showDirectlyPitchSurvey: Bool! = nil
  private var didSignContractSelectedValue: Int! = nil
  private var didProjectActiveSelectedValue: Int! = nil
  private var whenYouWillSignSelectedValue: String! = nil
  private var whenProjectWillActiveSelectedValue: String! = nil
  
  var delegate: AddResultViewControllerDelegate?
  
  private let leftPositionCard = CGPoint.init(x: -UIScreen.mainScreen().bounds.size.width,
                                              y: 148.0 * UtilityManager.sharedInstance.conversionHeight)
  
  private let centerPositionCard = CGPoint.init(x: 40.0 * UtilityManager.sharedInstance.conversionWidth,
                                                y: 148.0 * UtilityManager.sharedInstance.conversionHeight)
  
  private let rightPositionCard = CGPoint.init(x: UIScreen.mainScreen().bounds.size.width,
                                               y: 148.0 * UtilityManager.sharedInstance.conversionHeight)
  
  private var leftFrameForCards: CGRect! = nil
  private var centerFrameForCards: CGRect! = nil
  private var rightFrameForCards: CGRect! = nil
  
  private var infoSelectedBefore: PitchResultsModelData! = nil
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(newPitchEvaluationDataByUser: PitchEvaluationByUserModelData) {
    
    pitchEvaluationData = newPitchEvaluationDataByUser
    
    super.init(nibName: nil, bundle: nil)
    
  }
  
  init(newPitchEvaluationDataByUser: PitchEvaluationByUserModelData, newInfoSelectedBefore: PitchResultsModelData) {
    
    pitchEvaluationData = newPitchEvaluationDataByUser
    infoSelectedBefore = newInfoSelectedBefore
    
    super.init(nibName: nil, bundle: nil)
    
  }
  
  init(newPitchEvaluationDataByUser: PitchEvaluationByUserModelData, initDirectlyInPitchSurveyPitch: Bool) {
    
    pitchEvaluationData = newPitchEvaluationDataByUser
    showDirectlyPitchSurvey = initDirectlyInPitchSurveyPitch
    
    super.init(nibName: nil, bundle: nil)
    
  }
  
  override func loadView() {
    
    self.view = UIView.init(frame: UIScreen.mainScreen().bounds)
    self.view.backgroundColor = UIColor.blackColor()
    
    self.initValues()
    self.initInterface()
    
  }
  
  private func initValues() {
    
    let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
    let heightOfCard = self.view.frame.size.height - (276.0 * UtilityManager.sharedInstance.conversionHeight)
    
    leftFrameForCards = CGRect.init(x: leftPositionCard.x,
                                    y: leftPositionCard.y,
                                width: widthOfCard,
                               height: heightOfCard)
    
    centerFrameForCards = CGRect.init(x: centerPositionCard.x,
                                      y: centerPositionCard.y,
                                  width: widthOfCard,
                                 height: heightOfCard)
    
    rightFrameForCards = CGRect.init(x: rightPositionCard.x,
                                     y: rightPositionCard.y,
                                 width: widthOfCard,
                                height: heightOfCard)
  }
  
  private func initInterface() {
    
    containerAndGradientView = self.createGradientView()
    self.view.addSubview(containerAndGradientView)
    
    self.editNavigationController()
    self.createAllCards()
    
  }
  
  private func editNavigationController() {
    
    self.changeBackButtonItemToNil()
    self.changeNavigationBarTitle()
    self.changeNavigationRigthButtonItem()
    
    self.addDetailNavigationController()
    
  }
  
  private func changeBackButtonItemToNil() {
    
    let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: navigationController, action: nil)
    navigationItem.leftBarButtonItem = backButton
    
  }
  
  private func changeNavigationBarTitle() {
    
    let titleLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 17.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.AddResultViewController.navigationBarTitleText,
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    titleLabel.attributedText = stringWithFormat
    titleLabel.sizeToFit()
    self.navigationItem.titleView = titleLabel
    
  }
  
  private func changeNavigationRigthButtonItem() {
    
    let rightButton = UIBarButtonItem(title: VisualizePitchesConstants.AddResultViewController.rightButtonItemText,
                                      style: UIBarButtonItemStyle.Plain,
                                      target: self,
                                      action: #selector(navigationRightButtonPressed))
    
    let fontForButtonItem =  UIFont(name: "SFUIText-Regular",
                                    size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    
    let attributesDict: [String:AnyObject] = [NSFontAttributeName: fontForButtonItem!,
                                              NSForegroundColorAttributeName: UIColor.whiteColor()
    ]
    
    rightButton.setTitleTextAttributes(attributesDict, forState: .Normal)
    
    self.navigationItem.rightBarButtonItem = rightButton
    
  }
  
  private func addDetailNavigationController() {
    
    let frameForDetailedNav = CGRect.init(x: 0.0,
                                          y: (self.navigationController?.navigationBar.frame.size.height)!,
                                          width: self.view.frame.size.width,
                                          height: 108.0 * UtilityManager.sharedInstance.conversionHeight)
    
    detailedNavigation = DetailedNavigationEvaluatPitchView.init(frame: frameForDetailedNav,
                                                                 newProjectName: pitchEvaluationData.pitchName,
                                                                 newBrandName: pitchEvaluationData.brandName,
                                                                 newCompanyName: pitchEvaluationData.companyName,
                                                                 newDateString: pitchEvaluationData.briefDate)
    
    detailedNavigation.alpha = 1.0
    self.navigationController?.navigationBar.addSubview(detailedNavigation)
    
  }
  
  private func createAllCards() {
    
    if showDirectlyPitchSurvey != nil && showDirectlyPitchSurvey == true {
      
      self.createDidSignContractView()
      self.moveDidSignContractView(.center)
      self.createDidProjectActiveView()
      self.createWhenYouWillSignView()
      self.createWhenProjectWillActiveView()
      
    } else {
      
      self.createShowedYourProposal()
      self.createDidReceiveRuling()
      self.createDidWinPitch()
      self.createYouWinPitch()
      self.createGetFeedBack()
      self.createRecommendation()
      self.createGonnaReceiveRuling()
      self.createGonnaShowPitch()
      //
      self.createDidSignContractView()
      self.createDidProjectActiveView()
      self.createWhenYouWillSignView()
      self.createWhenProjectWillActiveView()
      
    }
    
  }
  
  private func createShowedYourProposal() {
    
    showedYourProposal = DidYouShowYourProposalView.init(frame: centerFrameForCards)
    showedYourProposal.regionPosition = .center
    showedYourProposal.delegate = self
    
    if infoSelectedBefore != nil && infoSelectedBefore.wasProposalPresented != nil {
      
      if infoSelectedBefore.wasProposalPresented! == true {
        
        showedYourProposal.didYouShowYourProposalView.mainSegmentedControl.selectedSegmentIndex = 0
        
      } else {
      
        showedYourProposal.didYouShowYourProposalView.mainSegmentedControl.selectedSegmentIndex = 2
        
      }
      
      showedYourProposal.changeNextButtonToEnabled()
      
    }
    
    containerAndGradientView.addSubview(showedYourProposal)
    
  }
  
  private func createDidReceiveRuling() {
    
    didReceiveRuling = DidReceiveRulingView.init(frame: rightFrameForCards)
    didReceiveRuling.regionPosition = .right
    didReceiveRuling.alpha = 0.0
    didReceiveRuling.delegate = self
    
    if infoSelectedBefore != nil && infoSelectedBefore.gotResponse != nil {
      
      if infoSelectedBefore.gotResponse! == true {
        
        didReceiveRuling.didYouReceiveRulingView.mainSegmentedControl.selectedSegmentIndex = 0
        
      } else {
        
        didReceiveRuling.didYouReceiveRulingView.mainSegmentedControl.selectedSegmentIndex = 2
        
      }
      
      didReceiveRuling.changeNextButtonToEnabled()
      
    }
    
    containerAndGradientView.addSubview(didReceiveRuling)
    
  }
  
  private func createDidWinPitch() {
    
    didWinPitch = DidWinPitchView.init(frame: rightFrameForCards)
    didWinPitch.regionPosition = .right
    didWinPitch.alpha = 0.0
    didWinPitch.delegate = self
    
    if infoSelectedBefore != nil && infoSelectedBefore.wasPitchWon != nil {
      
      if infoSelectedBefore.wasPitchWon! == true {
        
        didWinPitch.didYouReceiveRulingView.mainSegmentedControl.selectedSegmentIndex = 0
        
      } else {
        
        didWinPitch.didYouReceiveRulingView.mainSegmentedControl.selectedSegmentIndex = 2
        
      }
      
      didWinPitch.changeNextButtonToEnabled()
      
    }
    
    
    containerAndGradientView.addSubview(didWinPitch)
    
  }
  
  private func createYouWinPitch() {
    
    youWinPitch = YouWinPitchView.init(frame: rightFrameForCards)
    youWinPitch.regionPosition = .right
    youWinPitch.alpha = 0.0
    youWinPitch.delegate = self
    
    containerAndGradientView.addSubview(youWinPitch)
    
  }
  
  private func createGetFeedBack() {
    
    getFeedBack = DidGetFeedbackView.init(frame: rightFrameForCards)
    getFeedBack.regionPosition = .right
    getFeedBack.alpha = 0.0
    getFeedBack.delegate = self
    
    if infoSelectedBefore != nil && infoSelectedBefore.gotFeedback != nil {
      
      if infoSelectedBefore.gotFeedback! == true {
        
        getFeedBack.didYouGetFeedbackView.mainSegmentedControl.selectedSegmentIndex = 0
        
      } else {
        
        getFeedBack.didYouGetFeedbackView.mainSegmentedControl.selectedSegmentIndex = 2
        
      }
      
      getFeedBack.changeNextButtonToEnabled()
      
    }
    
    containerAndGradientView.addSubview(getFeedBack)
    
  }
  
  private func createRecommendation() {
    
    recommendation = RecommendationView.init(frame: rightFrameForCards)
    recommendation.regionPosition = .right
    recommendation.alpha = 0.0
    recommendation.delegate = self
    
    containerAndGradientView.addSubview(recommendation)
    
  }
  
  private func createGonnaReceiveRuling() {
    
    gonnaReceiveRuling = WhenGonnaReceiveRulingView.init(frame: rightFrameForCards)
    gonnaReceiveRuling.regionPosition = .right
    gonnaReceiveRuling.alpha = 0.0
    gonnaReceiveRuling.delegate = self
    
    if infoSelectedBefore != nil && infoSelectedBefore.whenWillYouGetResponse != nil && infoSelectedBefore.whenWillYouGetResponse != "" {
      
      gonnaReceiveRuling.whenGonnaReceiveRulingView.mainTextField.text = infoSelectedBefore.whenWillYouGetResponse
      
      gonnaReceiveRuling.changeNextButtonToEnabled()
      
    }
    
    containerAndGradientView.addSubview(gonnaReceiveRuling)
    
  }
  
  private func createGonnaShowPitch() {
    
    gonnaShowPitch = WhenGonnaToShowPitchView.init(frame: rightFrameForCards)
    gonnaShowPitch.regionPosition = .right
    gonnaShowPitch.alpha = 0.0
    gonnaShowPitch.delegate = self
    
    if infoSelectedBefore != nil && infoSelectedBefore.whenAreYouPresenting != nil && infoSelectedBefore.whenAreYouPresenting != "" {
      
      gonnaShowPitch.whenGonnaToShowPitchView.mainTextField.text = infoSelectedBefore.whenAreYouPresenting
      
      gonnaShowPitch.changeNextButtonToEnabled()
      
    }
    
    containerAndGradientView.addSubview(gonnaShowPitch)
    
  }
  
  
  private func createDidSignContractView() {
    
    didSignContractView = DidSignContractPitchSurveyView.init(frame: rightFrameForCards)
    didSignContractView.regionPosition = .right
    didSignContractView.alpha = 0.0
    didSignContractView.delegate = self
    
    containerAndGradientView.addSubview(didSignContractView)
    
  }
  
  private func createDidProjectActiveView() {
    
    didProjectActiveView = DidProjectActivePitchSurveyView.init(frame: rightFrameForCards)
    didProjectActiveView.regionPosition = .right
    didProjectActiveView.alpha = 0.0
    didProjectActiveView.delegate = self
    
    containerAndGradientView.addSubview(didProjectActiveView)
    
  }
  
  private func createWhenYouWillSignView() {
    
    whenYouWillSignView = WhenYouWillSignTheContractPitchSurveyView.init(frame: rightFrameForCards)
    whenYouWillSignView.regionPosition = .right
    whenYouWillSignView.alpha = 0.0
    whenYouWillSignView.delegate = self
    
    containerAndGradientView.addSubview(whenYouWillSignView)
    
  }
  
  private func createWhenProjectWillActiveView() {
    
    whenProjectWillActiveView = WhenProjectWillActivePitchSurveyView.init(frame: rightFrameForCards)
    whenProjectWillActiveView.regionPosition = .right
    whenProjectWillActiveView.alpha = 0.0
    whenProjectWillActiveView.delegate = self
    
    containerAndGradientView.addSubview(whenProjectWillActiveView)
    
  }
  
  private func createGradientView() -> GradientView{
    
    let frameForView = CGRect.init(x: 0.0, y: 60.0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height - 60.0)
    
    let firstColorGradient = UIColor.init(red: 237.0/255.0, green: 237.0/255.0, blue: 24.0/255.0, alpha: 1.0)
    let secondColorGradient = UIColor.init(red: 255.0/255.0, green: 85.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    let colorsForBackground = [firstColorGradient,secondColorGradient]
    
    return GradientView.init(frame: frameForView, arrayOfcolors: colorsForBackground, typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
    
  }
  
  private func dismissDetailedNavigation() {
    
    let newFrameForDetailedNavigation = CGRect.init(x: UIScreen.mainScreen().bounds.size.width,
                                                    y: detailedNavigation.frame.origin.y,
                                                width: detailedNavigation.frame.size.width,
                                               height: detailedNavigation.frame.size.height)
    
    UIView.animateWithDuration(0.25,
      animations: {
        
        self.detailedNavigation.frame = newFrameForDetailedNavigation
        self.detailedNavigation.alpha = 0.0
        
      }) { (finished) in
        
            if finished == true {
          
              if self.detailedNavigation != nil {
          
                self.detailedNavigation.removeFromSuperview()
          
              }
          
            }
        
      }
    
  }
  
  @objc private func navigationRightButtonPressed() {
    
    self.dismissDetailedNavigation()
//    self.delegate?.doActionsWhenDisappear()
    self.navigationController?.popToRootViewControllerAnimated(true)
    
  }
  
  private func moveShowedYourProposalTo(position: PositionOfCardsAddResults) {
    
    switch position {
    case .left:

      UIView.animateWithDuration(0.35,
        animations: { 
          
          self.showedYourProposal.frame = self.leftFrameForCards
          
        }, completion: { (finished) in
          if finished == true {
            
            self.showedYourProposal.regionPosition = .left
            self.showedYourProposal.alpha = 0.0
            
          }
      })
      
      break
      
    case .center:
      
      self.showedYourProposal.alpha = 1.0
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
          self.showedYourProposal.frame = self.centerFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            self.showedYourProposal.regionPosition = .center
            
          }
      })
      
      break
      
    case .right:
      
      UIView.animateWithDuration(0.35,
        animations: {
                                  
          self.showedYourProposal.frame = self.rightFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            self.showedYourProposal.regionPosition = .right
            self.showedYourProposal.alpha = 0.0
            
          }
      })
      
      break
      
    }
    
  }
  
  private func moveDidReceiveRulingTo(position: PositionOfCardsAddResults) {
    
    switch position {
    case .left:
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.didReceiveRuling.frame = self.leftFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            self.didReceiveRuling.alpha = 0.0
            
          }
      })
      
      break
      
    case .center:
      
      self.didReceiveRuling.alpha = 1.0
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.didReceiveRuling.frame = self.centerFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            
            
          }
      })
      
      break
      
    case .right:
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.didReceiveRuling.frame = self.rightFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            self.didReceiveRuling.alpha = 0.0
            
          }
      })
      
      break
      
    }
    
  }
  
  private func moveDidWinPitchTo(position: PositionOfCardsAddResults) {
    
    switch position {
    case .left:
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.didWinPitch.frame = self.leftFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            self.didWinPitch.alpha = 0.0
            
          }
      })
      
      break
      
    case .center:
      
      self.didWinPitch.alpha = 1.0
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.didWinPitch.frame = self.centerFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            
            
          }
      })
      
      break
      
    case .right:
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.didWinPitch.frame = self.rightFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            self.didWinPitch.alpha = 0.0
            
          }
      })
      
      break
      
    }
    
  }
  
  private func moveYouWinPitchTo(position: PositionOfCardsAddResults) {
    
    switch position {
    case .left:
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.youWinPitch.frame = self.leftFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            self.youWinPitch.alpha = 0.0
            
          }
      })
      
      break
      
    case .center:
      
      self.youWinPitch.alpha = 1.0
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.youWinPitch.frame = self.centerFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            
            
          }
      })
      
      break
      
    case .right:
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.youWinPitch.frame = self.rightFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            self.youWinPitch.alpha = 0.0
            
          }
      })
      
      break
      
    }
    
  }
  
  private func moveGetFeedBackTo(position: PositionOfCardsAddResults) {
    
    switch position {
    case .left:
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.getFeedBack.frame = self.leftFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            self.getFeedBack.alpha = 0.0
            
          }
      })
      
      break
      
    case .center:
      
      self.getFeedBack.alpha = 1.0
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.getFeedBack.frame = self.centerFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            
            
          }
      })
      
      break
      
    case .right:
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.getFeedBack.frame = self.rightFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            self.getFeedBack.alpha = 0.0
            
          }
      })
      
      break
      
    }
    
  }
  
  private func moveRecommendationTo(position: PositionOfCardsAddResults) {
    
    switch position {
    case .left:
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.recommendation.frame = self.leftFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            self.recommendation.alpha = 0.0
            
          }
      })
      
      break
      
    case .center:
      
      self.recommendation.alpha = 1.0
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.recommendation.frame = self.centerFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            
            
          }
      })
      
      break
      
    case .right:
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.recommendation.frame = self.rightFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            self.recommendation.alpha = 0.0
            
          }
      })
      
      break
      
    }
    
  }
  
  private func moveGonnaReceiveRulingTo(position: PositionOfCardsAddResults) {
    
    switch position {
    case .left:
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.gonnaReceiveRuling.frame = self.leftFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            self.gonnaReceiveRuling.alpha = 0.0
            
          }
      })
      
      break
      
    case .center:
      
      self.gonnaReceiveRuling.alpha = 1.0
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.gonnaReceiveRuling.frame = self.centerFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            
            
          }
      })
      
      break
      
    case .right:
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.gonnaReceiveRuling.frame = self.rightFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            self.gonnaReceiveRuling.alpha = 0.0
            
          }
      })
      
      break
      
    }
    
  }

  private func moveGonnaShowPitchTo(position: PositionOfCardsAddResults) {
    
    switch position {
    case .left:
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.gonnaShowPitch.frame = self.leftFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            self.gonnaShowPitch.alpha = 0.0
            
          }
      })
      
      break
      
    case .center:
      
      self.gonnaShowPitch.alpha = 1.0
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.gonnaShowPitch.frame = self.centerFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            
            
          }
      })
      
      break
      
    case .right:
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.gonnaShowPitch.frame = self.rightFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            self.gonnaShowPitch.alpha = 0.0
            
          }
      })
      
      break
      
    }
    
  }
  
  private func moveDidSignContractView(position: PositionOfCardsAddResults){
  
    switch position {
    case .left:
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.didSignContractView.frame = self.leftFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            self.didSignContractView.alpha = 0.0
            
          }
      })
      
      break
      
    case .center:
      
      self.didSignContractView.alpha = 1.0
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.didSignContractView.frame = self.centerFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            
            
          }
      })
      
      break
      
    case .right:
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.didSignContractView.frame = self.rightFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            self.didSignContractView.alpha = 0.0
            
          }
      })
      
      break
      
    }
    
  }
 
  private func moveDidProjectActiveView(position: PositionOfCardsAddResults){
  
    switch position {
    case .left:
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.didProjectActiveView.frame = self.leftFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            self.didProjectActiveView.alpha = 0.0
            
          }
      })
      
      break
      
    case .center:
      
      self.didProjectActiveView.alpha = 1.0
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.didProjectActiveView.frame = self.centerFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            
            
          }
      })
      
      break
      
    case .right:
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.didProjectActiveView.frame = self.rightFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            self.didProjectActiveView.alpha = 0.0
            
          }
      })
      
      break
      
    }
  
  }
  
  private func moveWhenYouWillSignView(position: PositionOfCardsAddResults){
  
    switch position {
    case .left:
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.whenYouWillSignView.frame = self.leftFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            self.whenYouWillSignView.alpha = 0.0
            
          }
      })
      
      break
      
    case .center:
      
      self.whenYouWillSignView.alpha = 1.0
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.whenYouWillSignView.frame = self.centerFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            
            
          }
      })
      
      break
      
    case .right:
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.whenYouWillSignView.frame = self.rightFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            self.whenYouWillSignView.alpha = 0.0
            
          }
      })
      
      break
      
    }
  
  }
  
  private func moveWhenProjectWillActiveView(position: PositionOfCardsAddResults){
  
    switch position {
    case .left:
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.whenProjectWillActiveView.frame = self.leftFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            self.whenProjectWillActiveView.alpha = 0.0
            
          }
      })
      
      break
      
    case .center:
      
      self.whenProjectWillActiveView.alpha = 1.0
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.whenProjectWillActiveView.frame = self.centerFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            
            
          }
      })
      
      break
      
    case .right:
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
                                  self.whenProjectWillActiveView.frame = self.rightFrameForCards
                                  
        }, completion: { (finished) in
          if finished == true {
            
            self.whenProjectWillActiveView.alpha = 0.0
            
          }
      })
      
      break
      
    }
  
  }

  
  
  //MARK: - DidYouShowYourProposalViewDelegate
  
  func didYouShowYourProposalNextButtonPressedSoShowScreenWithTag(valueSelected: String, nextScreenToShowWithTag: Int) {
  
    self.moveShowedYourProposalTo(.left)
    
    if nextScreenToShowWithTag == 2 {
      
      showedYourProposalSelectedValue = 1
      self.moveDidReceiveRulingTo(.center)
      
    }else
      if nextScreenToShowWithTag == 9 {
        
        showedYourProposalSelectedValue = 0
        self.moveGonnaShowPitchTo(.center)
        
      }
    
  }
  
  //MARK: - DidReceiveRulingViewDelegate
  
  func didReceiveRulingNextButtonPressedSoShowScreenWithTag(valueSelected: String, nextScreenToShowWithTag: Int) {
    
    self.moveDidReceiveRulingTo(.left)
    
    if nextScreenToShowWithTag == 3 {
      
      didReceiveRulingSelectedValue = 1
      self.moveDidWinPitchTo(.center)
      
    }else{
      
      didReceiveRulingSelectedValue = 0
      
    }
    
    
  }
  
  func lookForWinnerOfPitch() {
    
    didReceiveRulingSelectedValue = 0
    
    self.moveDidReceiveRulingTo(.left)
    
    if pitchEvaluationData.wasWon == true {
      
      self.moveRecommendationTo(.center)
      
    } else {
      
      self.moveGonnaReceiveRulingTo(.center)
      
    }
    
  }
  
  //MARK: - DidWinPitchViewDelegate
  
  func didWinPitchNextButtonPressedSoShowScreenWithTag(valueSelected: String, nextScreenToShowWithTag: Int) {
    
    self.moveDidWinPitchTo(.left)
    
    if nextScreenToShowWithTag == 4 {
      
      didWinPitchSelectedValue = 1
      self.moveYouWinPitchTo(.center)
      
    }else
      if nextScreenToShowWithTag == 5 {
        
        didWinPitchSelectedValue = 0
        self.moveGetFeedBackTo(.center)
        
      }
    
  }
  
  //MARK: - YouWinPitchViewDelegate
  
  func youWinPitchNextButtonPressed() {
    
    self.moveYouWinPitchTo(.left)
    
    
    UtilityManager.sharedInstance.showLoader()
    
    
    if pitchEvaluationData.hasResults == true {
      
      /////////CHECK UPDATE OF RESULTS!!!
      
      let paramsForUpdate = self.createParamsToUpdate()
      
      RequestToServerManager.sharedInstance.requestToUpdatePitchResults(paramsForUpdate, actionsToMakeAfterSuccesfullyPitchResultsSaved: { 
        
        UtilityManager.sharedInstance.hideLoader()
        self.delegate?.doActionsWhenDisappear()
        self.moveDidSignContractView(.center)
        
      })
      
    } else {
      
      let params = self.createParamsToSave()
      
      RequestToServerManager.sharedInstance.requestToSaveAddResults(params) {
        
        UtilityManager.sharedInstance.hideLoader()
        self.delegate?.doActionsWhenDisappear()
        self.moveDidSignContractView(.center)
        
      }
      
    }
   
  }
  
  //MARK: - DidGetFeedbackViewDelegate
  
  func didGetFeedbackNextButtonPressed(selectedAnswer: String) {
    
    if selectedAnswer == "Sí" {
      
      getFeedBackSelectedValue = 1
      
    }else{
      
      getFeedBackSelectedValue = 0
      
    }
    
    self.saveDataToServer()
    self.dismissDetailedNavigation()
    
  }
  
  //MARK: - RecommendationViewDelegate
  
  func recommendationNextButtonPressed() {
    
    self.saveDataToServer()
    self.dismissDetailedNavigation()
    
  }
  
  //MARK: - WhenGonnaReceiveRulingViewDelegate
  
  func whenGonnaReceiveRulingNextButtonPressed(dateSelected: String) {
    
    gonnaReceiveRulingSelectedValue = dateSelected
    self.saveDataToServer()
    self.dismissDetailedNavigation()
    
  }
  
  //MARK: - WhenGonnaToShowPitchViewDelegate
  
  func whenGonnaToShowPitchNextButtonPressed(dateSelected: String) {
    
    gonnaShowPitchSelectedValue = dateSelected
    
    self.saveDataToServer()
    self.dismissDetailedNavigation()
    
  }
  
  private func saveDataToServer() {
    
    let params = self.createParamsToSave()
    UtilityManager.sharedInstance.showLoader()
    
    if pitchEvaluationData.hasResults == true {
      
      /////////CHECK UPDATE OF RESULTS!!!
      
      let paramsForUpdate = self.createParamsToUpdate()
      
      RequestToServerManager.sharedInstance.requestToUpdatePitchResults(paramsForUpdate, actionsToMakeAfterSuccesfullyPitchResultsSaved: {
        
        UtilityManager.sharedInstance.hideLoader()
        self.delegate?.doActionsWhenDisappear()
        self.navigationController?.popToRootViewControllerAnimated(true)
        
      })
      
    } else {
      
      RequestToServerManager.sharedInstance.requestToSaveAddResults(params) {
        
        UtilityManager.sharedInstance.hideLoader()
        self.delegate?.doActionsWhenDisappear()
        self.navigationController?.popToRootViewControllerAnimated(true)
        
      }
      
    }
    
  }
  
  private func createParamsToUpdate() -> [String: AnyObject] {
    
    var pitchResult = [String:AnyObject]()
    
    if showedYourProposalSelectedValue != nil {
      
      pitchResult["was_proposal_presented"] = showedYourProposalSelectedValue
      
    }
    if didReceiveRulingSelectedValue != nil {
      
      pitchResult["got_response"] = didReceiveRulingSelectedValue
      
    }
    if didWinPitchSelectedValue != nil {
      
      pitchResult["was_pitch_won"] = didWinPitchSelectedValue
      
    }
    if getFeedBackSelectedValue != nil {
      
      pitchResult["got_feedback"] = getFeedBackSelectedValue
      
    }
    if gonnaReceiveRulingSelectedValue != nil {
      
      pitchResult["when_will_you_get_response"] = gonnaReceiveRulingSelectedValue
      
    }
    if gonnaShowPitchSelectedValue != nil {
      
      pitchResult["when_are_you_presenting"] = gonnaShowPitchSelectedValue
      
    }
    
    
    //Checar antes InfoSelectedBefore.pitchResultsId check if is nil
    
    let finalParams = [
      "auth_token"  : UserSession.session.auth_token,
      "id": infoSelectedBefore.pitchResultsId!,
      "pitch_result": pitchResult
    ]
    
    return finalParams as! [String : AnyObject]
    
  }
  
  private func createParamsToSave() -> [String: AnyObject] {
    
    var pitchResult = [String:AnyObject]()
    
    pitchResult["agency_id"] = AgencyModel.Data.id
    pitchResult["pitch_id"] = pitchEvaluationData.pitchId
    
    if showedYourProposalSelectedValue != nil {
      
      pitchResult["was_proposal_presented"] = showedYourProposalSelectedValue
      
    }
    if didReceiveRulingSelectedValue != nil {
      
      pitchResult["got_response"] = didReceiveRulingSelectedValue
      
    }
    if didWinPitchSelectedValue != nil {
      
      pitchResult["was_pitch_won"] = didWinPitchSelectedValue
      
    }
    if getFeedBackSelectedValue != nil {
      
      pitchResult["got_feedback"] = getFeedBackSelectedValue
      
    }
    if gonnaReceiveRulingSelectedValue != nil {
      
      pitchResult["when_will_you_get_response"] = gonnaReceiveRulingSelectedValue
      
    }
    if gonnaShowPitchSelectedValue != nil {
      
      pitchResult["when_are_you_presenting"] = gonnaShowPitchSelectedValue
      
    }
    
    let finalParams = [
                       "auth_token"  : UserSession.session.auth_token,
                       "pitch_result": pitchResult
    ]
    
    return finalParams as! [String : AnyObject]
    
  }
  
  //MARK: - DidSignContractPitchSurveyViewDelegate
  
  func didSignContractPitchSurveyNextButtonPressedSoShowScreenWithTag(valueSelected: String, nextScreenToShowWithTag: Int) {
    
    self.moveDidSignContractView(.left)
    
    if nextScreenToShowWithTag == 11 {
      
      didSignContractSelectedValue = 1
      self.moveDidProjectActiveView(.center)
      
    }else
      if nextScreenToShowWithTag == 13 {
        
        didSignContractSelectedValue = 0
        self.moveWhenYouWillSignView(.center)
        
    }
    
  }
  
  //MARK: - DidProjectActivePitchSurveyViewDelegate
  
  func didProjectActivePitchSurveyNextButtonPressedSoShowScreenWithTag(valueSelected: String, nextScreenToShowWithTag: Int) {
    
    if nextScreenToShowWithTag == -1 {
      
      didProjectActiveSelectedValue = 1
      self.saveDataForPitchSurvey()
      
    }else
      if nextScreenToShowWithTag == 12 {
        
        self.moveDidProjectActiveView(.left)
        
        didProjectActiveSelectedValue = 0
        self.moveWhenProjectWillActiveView(.center)
        
      }

  }
  
  //MARK: - WhenYouWillSignTheContractPitchSurveyViewDelegate
  
  func whenYouWillSignTheContractNextButtonPressed(dateSelected: String) {
    
    whenYouWillSignSelectedValue = dateSelected
    
    self.moveWhenYouWillSignView(.left)
    
    self.moveDidProjectActiveView(.center)
    
  }
  
  //MARK: - WhenProjectWillActivePitchSurveyViewDelegate
  
  func whenProjectWillActiveNextButtonPressed(dateSelected: String) {
    
    whenProjectWillActiveSelectedValue = dateSelected
    
    self.saveDataForPitchSurvey()
    
  }
  
  private func saveDataForPitchSurvey() {
    
    let paramsForPitchSurvey = self.createParamsForPitchSurvey()
    
    UtilityManager.sharedInstance.showLoader()
    
    RequestToServerManager.sharedInstance.requestToSavePitchSurvey(paramsForPitchSurvey) { 
    
      UtilityManager.sharedInstance.hideLoader()
      self.dismissDetailedNavigation()
      self.navigationController?.popToRootViewControllerAnimated(true)
      
    }
    
  }
  
  private func createParamsForPitchSurvey() -> [String: AnyObject] {
    
    var pitchResult = [String:AnyObject]()
    
    pitchResult["pitch_id"] = pitchEvaluationData.pitchId
    pitchResult["agency_id"] = AgencyModel.Data.id
    
    if didSignContractSelectedValue != nil {
      
      pitchResult["was_contract_signed"] = didSignContractSelectedValue
      
    }
    if whenYouWillSignSelectedValue != nil {
      
      pitchResult["contract_signature_date"] = whenYouWillSignSelectedValue
      
    }
    if didProjectActiveSelectedValue != nil {
      
      pitchResult["was_project_activated"] = didProjectActiveSelectedValue
      
    }
    if whenProjectWillActiveSelectedValue != nil {
      
      pitchResult["when_will_it_activate"] = whenProjectWillActiveSelectedValue
      
    }
    
    let finalParams = [
      "auth_token"  : UserSession.session.auth_token,
      "pitch_winner_survey": pitchResult
    ]
    
    return finalParams as! [String : AnyObject]
    
  }
  
  //MARK: -
  
  
  
}
