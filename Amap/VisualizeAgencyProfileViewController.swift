//
//  VisualizeAgencyProfileViewController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/30/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class VisualizeAgencyProfileViewController: UIViewController, VisualizeCasesDelegate {
  
  let kNumberOfCardsInScrollViewMinusOne = 5
  
  private var mainTabBar: DashBoardPitchesAndAgencyProfileTabBarView! = nil
  private var flipCard: FlipCardView! = nil
  private var frontViewOfClipCard: UIView! = nil
  private var profilePicNameButtonsView: AgencyProfilePicNameButtonsView! = nil
  private var scrollViewFrontFlipCard: UIScrollView! = nil
  
  
  private var leftButton: UIButton! = nil
  private var rightButton: UIButton! = nil
  
  private var actualPage: Int! = 0
  
  override func loadView() {
    
    self.view = UIView.init(frame: UIScreen.mainScreen().bounds)
    self.view.backgroundColor = UIColor.blackColor()
    self.view.addSubview(self.createGradientView())
    self.editNavigationBar()
    self.createBottomTabBar()
    self.initInterface()
    
  }
  
  private func editNavigationBar() {
    
    self.navigationController?.navigationBarHidden = false
    
    self.changeBackButtonItem()
    self.changeNavigationBarTitle()
    self.changeRigthButtonItem()
    
  }
  
  private func changeBackButtonItem() {
    
    let backButton = UIBarButtonItem(title: AgencyProfileVisualizeConstants.VisualizeAgencyProfileViewController.backButtonText,
      style: UIBarButtonItemStyle.Plain,
      target: self,
      action: #selector(pushEditAgencyProfile))
    
    let fontForButtonItem =  UIFont(name: "SFUIText-Regular",
                                    size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    
    let attributesDict: [String:AnyObject] = [NSFontAttributeName: fontForButtonItem!,
                                              NSForegroundColorAttributeName: UIColor.whiteColor()
                                              ]
    
    backButton.setTitleTextAttributes(attributesDict, forState: .Normal)
  
    self.navigationItem.leftBarButtonItem = backButton
    
  }
  
  private func changeNavigationBarTitle() {
    
    let titleLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 17.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: AgencyProfileVisualizeConstants.VisualizeAgencyProfileViewController.navigationBarText,
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    titleLabel.attributedText = stringWithFormat
    titleLabel.sizeToFit()
    self.navigationItem.titleView = titleLabel
    
  }
  
  private func changeRigthButtonItem() {
    
    let rightButton = UIBarButtonItem(title: AgencyProfileVisualizeConstants.VisualizeAgencyProfileViewController.rightButtonText,
      style: UIBarButtonItemStyle.Plain,
      target: self,
      action: #selector(logOutAndPopThis))
    
    let fontForButtonItem =  UIFont(name: "SFUIText-Regular",
                                    size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    
    let attributesDict: [String:AnyObject] = [NSFontAttributeName: fontForButtonItem!,
                                              NSForegroundColorAttributeName: UIColor.whiteColor()
                                              ]
    
    rightButton.setTitleTextAttributes(attributesDict, forState: .Normal)
    
    self.navigationItem.rightBarButtonItem = rightButton
    
  }
  
  private func createBottomTabBar() {
    
    let pointYForTabBar = UIScreen.mainScreen().bounds.size.height - (60.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let pointToAddTabBar = CGPoint.init(x: 0.0,
                                        y: pointYForTabBar)
    
    mainTabBar = DashBoardPitchesAndAgencyProfileTabBarView.init(atPoint: pointToAddTabBar)
    self.view.addSubview(mainTabBar)
  }
  
  private func initInterface() {
    
    self.createAndAddFlipCard()
    
  }
  
  private func createGradientView() -> GradientView{
    
    let frameForView = CGRect.init(x: 0.0, y: 60.0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height - 60.0)
    
    let firstColorGradient = UIColor.init(red: 239.0/255.0, green: 255.0/255.0, blue: 145.0/255.0, alpha: 1.0)
    let secondColorGradient = UIColor.init(red: 250.0/255.0, green: 117.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    let colorsForBackground = [firstColorGradient,secondColorGradient]
    
    return GradientView.init(frame: frameForView, arrayOfcolors: colorsForBackground, typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
    
  }
  
  
  private func createAndAddFlipCard() {
    
    let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
    let heightOfCard = self.view.frame.size.height - (168.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let frameForFlipCard = CGRect.init(x: (40.0 * UtilityManager.sharedInstance.conversionWidth),
                                       y: (108.0 * UtilityManager.sharedInstance.conversionHeight),
                                       width: widthOfCard,
                                       height: heightOfCard)
    
    let frameForViewsOfCard = CGRect.init(x: 0.0, y: 0.0, width: widthOfCard, height: heightOfCard)

    //createTheFrontCard
    self.createFrontViewForFlipCard(frameForViewsOfCard)

    //createTheBackCard
    let blankView = UIView.init(frame:frameForViewsOfCard)
//
    flipCard = FlipCardView.init(frame: frameForFlipCard, viewOne: frontViewOfClipCard, viewTwo: blankView)
    self.view.addSubview(flipCard)
    self.createButtonsForFlipCard()
    
  }
  
  private func createFrontViewForFlipCard(frameForCards: CGRect) {
    
    frontViewOfClipCard = UIView.init(frame: frameForCards)
    frontViewOfClipCard.backgroundColor = UIColor.whiteColor()
    
    self.createProfilePicNameButtonsView()
    self.createMainScrollView(frameForCards)
    
  }
  
  private func createProfilePicNameButtonsView() {
    
    let frameForProfilePicStuff = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                              y: 30.0 * UtilityManager.sharedInstance.conversionHeight,
                                          width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                         height: 123.0 * UtilityManager.sharedInstance.conversionHeight)
    
    profilePicNameButtonsView = AgencyProfilePicNameButtonsView.init(frame: frameForProfilePicStuff)

    frontViewOfClipCard.addSubview(profilePicNameButtonsView)
    
  }
  
  private func createMainScrollView(frameForCards: CGRect) {
    
    self.createScrollViewFrontFlipCard(frameForCards)

  }
  
  private func createScrollViewFrontFlipCard(frameForCards: CGRect) {
    
    let realFrameForScrollView = CGRect.init(x: frameForCards.origin.x,
                                             y: 183.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: frameForCards.size.width,
                                        height: 315.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let contentSizeOfScrollView = CGSize.init(width: frameForCards.size.width * CGFloat(kNumberOfCardsInScrollViewMinusOne),
                                             height: frameForCards.size.height)
    
    scrollViewFrontFlipCard = UIScrollView.init(frame: realFrameForScrollView)
    scrollViewFrontFlipCard.backgroundColor = UIColor.whiteColor()
    scrollViewFrontFlipCard.contentSize = contentSizeOfScrollView
    scrollViewFrontFlipCard.scrollEnabled = false
    
    //------------------------------------------SCREENS
    
    let frameForScreensOfScrollView = CGRect.init(x: 0.0,
                                                  y: 0.0,
                                              width: frameForCards.size.width,
                                             height: 316.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let criteriaVisualize = VisualizeCriteriaView.init(frame: frameForScreensOfScrollView)
    criteriaVisualize.backgroundColor = UIColor.clearColor()
    scrollViewFrontFlipCard.addSubview(criteriaVisualize)
    
    let exclusiveVisualize = VisualizeExclusiveView.init(frame: CGRect.init(x: frameForCards.size.width * 1,
      y: frameForScreensOfScrollView.origin.y,
      width: frameForScreensOfScrollView.size.width,
      height: frameForScreensOfScrollView.size.height))
    exclusiveVisualize.backgroundColor = UIColor.clearColor()
    scrollViewFrontFlipCard.addSubview(exclusiveVisualize)
    
    let participateInVisualize = VisualizeParticipateInView.init(frame: CGRect.init(x: frameForCards.size.width * 2,
      y: frameForScreensOfScrollView.origin.y,
      width: frameForScreensOfScrollView.size.width,
      height: frameForScreensOfScrollView.size.height))
    participateInVisualize.backgroundColor = UIColor.clearColor()
    scrollViewFrontFlipCard.addSubview(participateInVisualize)
    
    let numberEmployees = VisualizeNumberOfEmployeesView.init(frame: CGRect.init(x: frameForCards.size.width * 3,
      y: frameForScreensOfScrollView.origin.y,
      width: frameForScreensOfScrollView.size.width,
      height: frameForScreensOfScrollView.size.height))
    scrollViewFrontFlipCard.addSubview(numberEmployees)
    
    let cases = VisualizeCasesView.init(frame: CGRect.init(x: frameForCards.size.width * 4,
      y: frameForScreensOfScrollView.origin.y,
      width: frameForScreensOfScrollView.size.width,
      height: frameForScreensOfScrollView.size.height))
    cases.justVisualizeDelegate = self
    scrollViewFrontFlipCard.addSubview(cases)
    
    let skills = VisualizeSkillsView.init(frame: CGRect.init(x: frameForCards.size.width * 5,
      y: frameForScreensOfScrollView.origin.y,
      width: frameForScreensOfScrollView.size.width,
      height: frameForScreensOfScrollView.size.height))
    scrollViewFrontFlipCard.addSubview(skills)
    skills.getAllSkillsFromServer()

    
      
      
      
      
    
    
    
    
    
    
 
    frontViewOfClipCard.addSubview(scrollViewFrontFlipCard)
    
  }

  private func createButtonsForFlipCard() {
    leftButton = nil
    rightButton = nil
    
    
    let sizeForButtons = CGSize.init(width: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 49.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let frameForLeftButton = CGRect.init(x: 23.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: 177.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: sizeForButtons.width,
                                         height:sizeForButtons.height)
    
    let frameForRightButton = CGRect.init(x: 235.0 * UtilityManager.sharedInstance.conversionWidth,
                                          y: 177.0 * UtilityManager.sharedInstance.conversionHeight,
                                          width: sizeForButtons.width,
                                          height: sizeForButtons.height)
    
    let leftButtonImage = UIImage(named: "navNext") as UIImage?
    let rightButtonImage = UIImage(named: "navPrev") as UIImage?
    
    leftButton = UIButton.init(frame: frameForLeftButton)
    //    leftButton.backgroundColor = UIColor.redColor()
    rightButton = UIButton.init(frame: frameForRightButton)
    //    rightButton.backgroundColor = UIColor.redColor()
    
    leftButton.setImage(leftButtonImage, forState: .Normal)
    rightButton.setImage(rightButtonImage, forState: .Normal)
    
    leftButton.addTarget(self, action: #selector(moveScrollViewToLeft), forControlEvents: .TouchUpInside)
    rightButton.addTarget(self, action: #selector(moveScrollViewToRight), forControlEvents: .TouchUpInside)
    
    if actualPage == 0 {
      self.hideLeftButtonOfMainScrollView()
    }
    
    flipCard.addSubview(leftButton)
    flipCard.addSubview(rightButton)
    
  }
  
  
  
  @objc private func pushEditAgencyProfile() {
  
    let editStuffAgency = EditAgencyProfileViewController()
    self.navigationController?.pushViewController(editStuffAgency, animated: true)
    
  }
  
  @objc private func logOutAndPopThis() {
    
    RequestToServerManager.sharedInstance.logOut(){
      self.navigationController?.popViewControllerAnimated(true)
    }
    
  }
  
  @objc private func moveScrollViewToLeft() {
    
    if actualPage > 0 {
      
      actualPage = actualPage - 1
      
      if actualPage == 0 {
        
        self.hideLeftButtonOfMainScrollView()
        
      }
      
      if actualPage < kNumberOfCardsInScrollViewMinusOne && self.rightButton.alpha == 0.0 {
        
        self.showRightButtonOfMainScrollView()
        
      }
      
      let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
      
      let pointToMove = CGPoint.init(x: widthOfCard * CGFloat(actualPage), y: 0.0)
      
      scrollViewFrontFlipCard.setContentOffset(pointToMove, animated: true)
      
    }
    
  }
  
  @objc private func moveScrollViewToRight() {
    
    if actualPage < kNumberOfCardsInScrollViewMinusOne {
      
      actualPage = actualPage + 1
      
      if actualPage == kNumberOfCardsInScrollViewMinusOne {
        
        self.hideRightButtonOfMainScrollView()
        
      }
      
      if actualPage > 0 && self.leftButton.alpha == 0.0 {
        
        self.showLeftButtonOfMainScrollView()
        
      }
      
      let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
      
      let pointToMove = CGPoint.init(x: widthOfCard * CGFloat(actualPage), y: 0.0)
      
      scrollViewFrontFlipCard.setContentOffset(pointToMove, animated: true)
      
    }
    
  }
  
  private func hideLeftButtonOfMainScrollView() {
    
    UIView.animateWithDuration(0.35){
      
      self.leftButton.alpha = 0.0
      
    }
    
  }
  
  private func hideRightButtonOfMainScrollView() {
    
    UIView.animateWithDuration(0.35){
      
      self.rightButton.alpha = 0.0
      
    }
    
  }
  
  private func showLeftButtonOfMainScrollView() {
    
    UIView.animateWithDuration(0.35){
      
      self.leftButton.alpha = 1.0
      
    }
    
  }
  
  private func showRightButtonOfMainScrollView() {
    
    UIView.animateWithDuration(0.35){
      
      self.rightButton.alpha = 1.0
      
    }
    
  }
  
  //MARK: - VisualizeCasesDelegate
  
  func showDetailOfCases(caseData: Case) {
    
  }
  
  
}
