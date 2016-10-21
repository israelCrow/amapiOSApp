//
//  AddResultViewController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/19/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class AddResultViewController: UIViewController, DidYouShowYourProposalViewDelegate, DidReceiveRulingViewDelegate, DidWinPitchViewDelegate, YouWinPitchViewDelegate, DidGetFeedbackViewDelegate, RecommendationViewDelegate, WhenGonnaReceiveRulingViewDelegate, WhenGonnaToShowPitchViewDelegate {
  
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
  
  private let leftPositionCard = CGPoint.init(x: -UIScreen.mainScreen().bounds.size.width,
                                              y: 148.0 * UtilityManager.sharedInstance.conversionHeight)
  
  private let centerPositionCard = CGPoint.init(x: 40.0 * UtilityManager.sharedInstance.conversionWidth,
                                                y: 148.0 * UtilityManager.sharedInstance.conversionHeight)
  
  private let rightPositionCard = CGPoint.init(x: UIScreen.mainScreen().bounds.size.width,
                                               y: 148.0 * UtilityManager.sharedInstance.conversionHeight)
  
  private var leftFrameForCards: CGRect! = nil
  private var centerFrameForCards: CGRect! = nil
  private var rightFrameForCards: CGRect! = nil
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(newPitchEvaluationDataByUser: PitchEvaluationByUserModelData) {
    
    pitchEvaluationData = newPitchEvaluationDataByUser
    
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
    
    let frameForDetailedNav = CGRect.init(x: self.view.frame.size.width,
                                          y: (self.navigationController?.navigationBar.frame.size.height)!,
                                          width: self.view.frame.size.width,
                                          height: 108.0 * UtilityManager.sharedInstance.conversionHeight)
    
    detailedNavigation = DetailedNavigationEvaluatPitchView.init(frame: frameForDetailedNav,
                                                                 newProjectName: pitchEvaluationData.pitchName,
                                                                 newBrandName: pitchEvaluationData.brandName,
                                                                 newCompanyName: pitchEvaluationData.companyName,
                                                                 newDateString: pitchEvaluationData.briefDate)
    
    detailedNavigation.alpha = 0.0
    self.navigationController?.navigationBar.addSubview(detailedNavigation)
    
  }
  
  private func createAllCards() {
    
    self.createShowedYourProposal()
    self.createDidReceiveRuling()
    self.createDidWinPitch()
    self.createYouWinPitch()
    self.createGetFeedBack()
    self.createRecommendation()
    self.createGonnaReceiveRuling()
    self.createGonnaShowPitch()
    
  }
  
  private func createShowedYourProposal() {
    
    showedYourProposal = DidYouShowYourProposalView.init(frame: centerFrameForCards)
    showedYourProposal.regionPosition = .center
    showedYourProposal.delegate = self
    
    containerAndGradientView.addSubview(showedYourProposal)
    
  }
  
  private func createDidReceiveRuling() {
    
    didReceiveRuling = DidReceiveRulingView.init(frame: rightFrameForCards)
    didReceiveRuling.regionPosition = .right
    didReceiveRuling.alpha = 0.0
    didReceiveRuling.delegate = self
    
    containerAndGradientView.addSubview(didReceiveRuling)
    
  }
  
  private func createDidWinPitch() {
    
    didWinPitch = DidWinPitchView.init(frame: rightFrameForCards)
    didWinPitch.regionPosition = .right
    didWinPitch.alpha = 0.0
    didWinPitch.delegate = self
    
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
    
    containerAndGradientView.addSubview(gonnaReceiveRuling)
    
  }
  
  private func createGonnaShowPitch() {
    
    gonnaShowPitch = WhenGonnaToShowPitchView.init(frame: rightFrameForCards)
    gonnaShowPitch.regionPosition = .right
    gonnaShowPitch.alpha = 0.0
    gonnaShowPitch.delegate = self
    
    containerAndGradientView.addSubview(gonnaShowPitch)
    
  }
  
  private func createGradientView() -> GradientView{
    
    let frameForView = CGRect.init(x: 0.0, y: 60.0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height - 60.0)
    
    let firstColorGradient = UIColor.init(red: 237.0/255.0, green: 237.0/255.0, blue: 24.0/255.0, alpha: 1.0)
    let secondColorGradient = UIColor.init(red: 255.0/255.0, green: 85.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    let colorsForBackground = [firstColorGradient,secondColorGradient]
    
    return GradientView.init(frame: frameForView, arrayOfcolors: colorsForBackground, typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
    
  }
  
  @objc private func navigationRightButtonPressed() {
    
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

  
  
  //MARK: - DidYouShowYourProposalViewDelegate
  
  func didYouShowYourProposalNextButtonPressedSoShowScreenWithTag(valueSelected: String, nextScreenToShowWithTag: Int) {
  
    self.moveShowedYourProposalTo(.left)
    
    if nextScreenToShowWithTag == 2 {
      
      self.moveDidReceiveRulingTo(.center)
      
    }else
      if nextScreenToShowWithTag == 9 {
        
        self.moveGonnaShowPitchTo(.center)
        
      }
    
  }
  
  //MARK: - DidReceiveRulingViewDelegate
  
  func didReceiveRulingNextButtonPressedSoShowScreenWithTag(valueSelected: String, nextScreenToShowWithTag: Int) {
    
    self.moveDidReceiveRulingTo(.left)
    
    if nextScreenToShowWithTag == 3 {
      
      self.moveDidWinPitchTo(.center)
      
    }
    
    
  }
  
  func lookForWinnerOfPitch() {
    
    //USER WEB SERVICE TO ASK IF THERE IS A WINNER
    
    //By the moment
    
    self.moveDidReceiveRulingTo(.left)
    
    self.moveRecommendationTo(.center)
    
  }
  
  //MARK: - DidWinPitchViewDelegate
  
  func didWinPitchNextButtonPressedSoShowScreenWithTag(valueSelected: String, nextScreenToShowWithTag: Int) {
    
    self.moveDidWinPitchTo(.left)
    
    if nextScreenToShowWithTag == 4 {
      
      self.moveYouWinPitchTo(.center)
      
    }else
      if nextScreenToShowWithTag == 5 {
        
        self.moveGetFeedBackTo(.center)
        
      }
    
  }
  
  //MARK: - YouWinPitchViewDelegate
  
  func youWinPitchNextButtonPressed() {
    
    //By the moment
    self.navigationController?.popToRootViewControllerAnimated(true)
    
  }
  
  //MARK: - DidGetFeedbackViewDelegate
  
  func didGetFeedbackNextButtonPressed(selectedAnswer: String) {
    
    self.navigationController?.popToRootViewControllerAnimated(true)
    
  }
  
  //MARK: - RecommendationViewDelegate
  
  func recommendationNextButtonPressed() {
    
    self.navigationController?.popToRootViewControllerAnimated(true)
    
  }
  
  //MARK: - WhenGonnaReceiveRulingViewDelegate
  
  func whenGonnaReceiveRulingNextButtonPressed(dateSelected: String) {
    
    
    
  }
  
  //MARK: - WhenGonnaToShowPitchViewDelegate
  
  func whenGonnaToShowPitchNextButtonPressed(dateSelected: String) {
    
    self.navigationController?.popToRootViewControllerAnimated(true)
    
  }
  
  
  //MARK: -
  //MARK: - 
  //MARK: - 
  
  
  
}
