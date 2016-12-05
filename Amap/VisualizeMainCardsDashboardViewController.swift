//
//  VisualizeMainCardsDashboardViewController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/28/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol VisualizeMainCardsDashboardViewControllerShowAndHideDelegate {
  
  func requestToHideTabBarFromVisualizeMainCardsDashboardViewController()
  func requestToShowTabBarFromVisualizeMainCardsDashboardViewController()
  
}

class VisualizeMainCardsDashboardViewController: UIViewController, UIScrollViewDelegate,  GrapAccordingToUserViewDelegate, FilterAccordingToUserAndAgencyViewDelegate, GraphOfAgencyVSIndustryViewDelegate, GeneralPerformanceCardViewDelegate {
  
  enum ScrollDirection {
    case toLeft
    case toRight
  }
  
  private let kNumberOfCards = 3
  
  private var mainScrollView: UIScrollView! = nil
  private var gralPerformanceCardView: GeneralPerformanceCardView! = nil
  
  private var firstCard: FlipCardView! = nil
  private var thirdCard: FlipCardView! = nil
  
  private var graphAccordingUser: GraphAccordingToUserView! = nil
  private var graphAgencyVSIndustry: GraphOfAgencyVSIndustryView! = nil
  
  private var arrayOfUsers = [AgencyUserModelData]()
  private var arrayOfScoresByAgency = [PitchEvaluationAveragePerMonthModelData]()
  private var arrayOfScoresByIndustry = [PitchEvaluationAveragePerMonthModelData]()
  private var numberOfPitchesByAgency = [String: Int]()
  
  private var firstFilterView: FilterAccordingToUserAndAgencyView! = nil
  private var secondFilterView: FilterAccordingToUserAndAgencyView! = nil
  
  private var nextTimeFlipFirstCard: Bool! = false
  private var actualPage: Int = 1
  private var lastOffSetOfMainScroll: CGPoint = CGPoint.init(x: UIScreen.mainScreen().bounds.size.width,
                                                             y: 0.0)
  private var directionOfScroll: ScrollDirection! = nil

  var delegateForShowAndHideTabBar: VisualizeAllPitchesViewControllerShowAndHideDelegate?
  
  override func loadView() {
    
    self.view = UIView.init(frame: UIScreen.mainScreen().bounds)
    self.view.backgroundColor = UIColor.blackColor()
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.view.addSubview(self.createGradientView())
    self.changeNavigationBarTitle()
    self.changeNavigationRigthButtonItem()
    
    self.createMainScrollView()
    
    self.getInfoFromServer()
    
    let notToShowDashboardTutorial = NSUserDefaults.standardUserDefaults().boolForKey(UtilityManager.sharedInstance.kNotToShowDashboardTutorial + UserSession.session.email)
    
    if notToShowDashboardTutorial == false {
      
      let tutorialFirstScreenDashboard = DashboardFirstScreenTutorialView.init(frame: CGRect.init())
      let rootViewController = UtilityManager.sharedInstance.currentViewController()
      rootViewController.view.addSubview(tutorialFirstScreenDashboard)
      
    }
    
  }
  
  private func changeNavigationBarTitle() {
    
    let titleLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 17.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizeDashboardConstants.VisualizeMainCardsDashboardViewController.navigationBarTitleText,
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
    
    let rightButton = UIBarButtonItem(title:"",
                                      style: UIBarButtonItemStyle.Plain,
                                      target: self,
                                      action: nil)
    
    let fontForButtonItem =  UIFont(name: "SFUIText-Regular",
                                    size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    
    let attributesDict: [String:AnyObject] = [NSFontAttributeName: fontForButtonItem!,
                                              NSForegroundColorAttributeName: UIColor.whiteColor()
    ]
    
    rightButton.setTitleTextAttributes(attributesDict, forState: .Normal)
    
    self.navigationItem.rightBarButtonItem = rightButton
    
  }
  
  private func createMainScrollView() {
    
    let firstCardPoint = CGPoint.init(x: UIScreen.mainScreen().bounds.width,
                                      y: 0.0)
    
    mainScrollView = UIScrollView.init(frame: UIScreen.mainScreen().bounds)
    mainScrollView.backgroundColor = UIColor.clearColor()
    mainScrollView.contentSize = CGSize.init(width: UIScreen.mainScreen().bounds.width * CGFloat(kNumberOfCards),
                                            height: UIScreen.mainScreen().bounds.height)
    mainScrollView.pagingEnabled = true
    mainScrollView.setContentOffset(firstCardPoint, animated: false)
    mainScrollView.delegate = self
    
    self.view.addSubview(mainScrollView)
    
  }
  
  private func getInfoFromServer() {
    
    UtilityManager.sharedInstance.showLoader()
    
    RequestToServerManager.sharedInstance.requestToGetPitchEvaluationsAveragePerMonthByAgency { (arrayOfScoresPerMonthOfAgency, arrayOfUsers) in
      
      
      print(arrayOfUsers)
      print(arrayOfScoresPerMonthOfAgency)
      
      self.arrayOfUsers = arrayOfUsers
      self.arrayOfScoresByAgency = arrayOfScoresPerMonthOfAgency
      
      
      RequestToServerManager.sharedInstance.requestToGetPitchEvaluationsAveragePerMonthByIndustry({ (arrayOfScoresPerMonthOfIndustry) in
        
        self.arrayOfScoresByIndustry = arrayOfScoresPerMonthOfIndustry
        
        RequestToServerManager.sharedInstance.requestToGetPitchEvaluationsDashboardSumaryByAgency({ (numberOfPitchesByAgencyForDashboardSumary, arrayOfUsers) in
          
          self.numberOfPitchesByAgency = numberOfPitchesByAgencyForDashboardSumary
          
          
          UtilityManager.sharedInstance.hideLoader()
          
          self.createCards()
          
          
        })
        
      })
      
    }
    
    
  }
  
  private func createCards() {
    
    self.createGeneralPerformanceCard()
    
  }
  
  
  private func createGeneralPerformanceCard() {
    
    let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
    let heightOfCard = self.view.frame.size.height - (168.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let frameForFirstCard = CGRect.init(x: (90.0 * UtilityManager.sharedInstance.conversionWidth),
                                        y: (108.0 * UtilityManager.sharedInstance.conversionHeight),
                                    width: widthOfCard,
                                   height: heightOfCard - (51.0 * UtilityManager.sharedInstance.conversionHeight))
    
    let frameForFrontAndBack = CGRect.init(x: 0.0,
                                             y: 0.0,
                                             width: widthOfCard,
                                             height: heightOfCard - (51.0 * UtilityManager.sharedInstance.conversionHeight))
    
    let frameForSecondCard = CGRect.init(x: (40.0 * UtilityManager.sharedInstance.conversionWidth) + (mainScrollView.frame.size.width * CGFloat(kNumberOfCards - 2)),
                                         y: (108.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: widthOfCard,
                                    height: heightOfCard)
    
    let frameForThirdCard  = CGRect.init(x: (mainScrollView.frame.size.width * CGFloat(kNumberOfCards - 1)) - (10.0 * UtilityManager.sharedInstance.conversionWidth),
                                         y: (108.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: widthOfCard,
                                    height: heightOfCard - (51.0 * UtilityManager.sharedInstance.conversionHeight))
    
    firstFilterView = FilterAccordingToUserAndAgencyView.init(frame: frameForFrontAndBack)
    firstFilterView.delegate = self
    secondFilterView = FilterAccordingToUserAndAgencyView.init(frame: frameForFrontAndBack)
    secondFilterView.delegate = self
    
    graphAccordingUser = GraphAccordingToUserView.init(frame: frameForFrontAndBack, newArrayOfUsers: arrayOfUsers)
    graphAccordingUser.delegate = self
    graphAccordingUser.layer.shadowColor = UIColor.blackColor().CGColor
    graphAccordingUser.layer.shadowOpacity = 0.25
    graphAccordingUser.layer.shadowOffset = CGSizeZero
    graphAccordingUser.layer.shadowRadius = 5
    
    
    //third card
    
    var scoresAgency = [Double]()
    var scoresIndustry = [Double]()
    
    for scoreAgency in arrayOfScoresByAgency {
      
      scoresAgency.append(Double(scoreAgency.score)!)
      
    }
    
    for scoreIndustry in arrayOfScoresByIndustry {
      
      scoresIndustry.append(Double(scoreIndustry.score)!)
      
    }
    
    graphAgencyVSIndustry = GraphOfAgencyVSIndustryView.init(frame: frameForFrontAndBack, newArrayByAgency: scoresAgency, newArrayByIndustry: scoresIndustry)
    graphAgencyVSIndustry.delegate = self

    
    
    firstCard = FlipCardView.init(frame: frameForFirstCard,
                                  viewOne: graphAccordingUser,
                                  viewTwo: firstFilterView)
    
    thirdCard = FlipCardView.init(frame: frameForThirdCard,
                                viewOne: graphAgencyVSIndustry,
                                viewTwo: secondFilterView)
    
    

    mainScrollView.addSubview(firstCard)
    mainScrollView.addSubview(thirdCard)
    
    let agencyUser = AgencyUserModelData.init(newId: AgencyModel.Data.id,
                                              newFirstName: AgencyModel.Data.name,
                                              newLastName: "")
    var finalUsersforGeneralPerformance = arrayOfUsers
    finalUsersforGeneralPerformance.insert(agencyUser, atIndex: 0)
    
    gralPerformanceCardView = GeneralPerformanceCardView.init(frame: frameForSecondCard, newArrayOfUsers: finalUsersforGeneralPerformance, newNumberOfPitchesByAgency: numberOfPitchesByAgency)
    gralPerformanceCardView.delegate = self
    mainScrollView.addSubview(gralPerformanceCardView)
    
  }
  
  private func createGradientView() -> GradientView{
    
    let frameForView = CGRect.init(x: 0.0, y: 60.0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height - 60.0)
    
    let firstColorGradient = UIColor.init(red: 195.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    let secondColorGradient = UIColor.init(red: 117.0/255.0, green: 236.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    let colorsForBackground = [firstColorGradient,secondColorGradient]
    
    return GradientView.init(frame: frameForView, arrayOfcolors: colorsForBackground, typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
    
  }
  
  //MARK: - GrapAccordingToUserViewDelegate
  
  func getEvaluationsAveragePerMonth(params: [String : AnyObject]) {
    
    UtilityManager.sharedInstance.showLoader()
    
    RequestToServerManager.sharedInstance.requestToGetPitchEvaluationsAveragePerMonthByUser(params) { (arrayOfScoresPerMonthByUser) in
      
      var arrayOfScoresInDouble = [Double]()
      var arrayOfScoresInDoubleByAgency = [Double]()
      
      for score in arrayOfScoresPerMonthByUser {
       
        arrayOfScoresInDouble.append(Double(score.score)!)
        
      }
      
      for score in self.arrayOfScoresByAgency {
        
        arrayOfScoresInDoubleByAgency.append(Double(score.score)!)
        
      }
      
      self.graphAccordingUser.changeData(arrayOfScoresInDouble, newValuesForAgency: arrayOfScoresInDoubleByAgency)
      
      UtilityManager.sharedInstance.hideLoader()
      
    }
    
  }
  
  func flipCardToShowFilterOfGraphAccordingToUser() {
    
    nextTimeFlipFirstCard = true
    
    self.firstCard.flip()
    
  }
  
  //MARK: - FilterAccordingToUserAndAgencyViewDelegate
  
  func cancelFilterButtonPressed() {
   
    if nextTimeFlipFirstCard == true {
      
      self.firstCard.flip()
      nextTimeFlipFirstCard = false
      
    } else {
      
      self.thirdCard.flip()
      
    }
    
  }
  
  func applyFilterButtonPressedFromFilterAccordingToUserAndAgencyView() {
    
    
    
  }
  
  //MARK: - GraphOfAgencyVSIndustryViewDelegate
  
  func filterFromGraphOfAgencyVSIndustryPressed() {

    self.thirdCard.flip()
    
  }
  
  //MARK: - GeneralPerformanceCardViewDelegate
  
  func requestToGetValuesByUser(params: [String : AnyObject]) {
    
    UtilityManager.sharedInstance.showLoader()
    
    RequestToServerManager.sharedInstance.requestToGetPitchEvaluationsDashboardSummaryByUser(params) { (numberOfPitchesByAgencyForDashboardSumary) in
      
      self.gralPerformanceCardView.updateData(numberOfPitchesByAgencyForDashboardSumary)
      
      UtilityManager.sharedInstance.hideLoader()
      
    }
    
  }
  
  func requestToGetValuesFromAgency() {
    
    UtilityManager.sharedInstance.showLoader()
    
    RequestToServerManager.sharedInstance.requestToGetPitchEvaluationsDashboardSumaryByAgency { (numberOfPitchesByAgencyForDashboardSumary, arrayOfUsers) in
      
      self.gralPerformanceCardView.updateData(numberOfPitchesByAgencyForDashboardSumary)
      
      UtilityManager.sharedInstance.hideLoader()
      
    }
    
  }
  
  //MARK: - UIScrollViewDelegate
  
  func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
    
    if mainScrollView.contentOffset.x == 0 {
      
      actualPage = 0
      
    }else
      
      if mainScrollView.contentOffset.x == UIScreen.mainScreen().bounds.size.width {
        
        actualPage = 1
        
      }else
        
        if mainScrollView.contentOffset.x == UIScreen.mainScreen().bounds.size.width * 2.0 {
          
          actualPage = 2
          
    }
    
  }
  
  func scrollViewDidScroll(scrollView: UIScrollView) {
    
    if lastOffSetOfMainScroll.x > mainScrollView.contentOffset.x {
      
      directionOfScroll = .toLeft
      
    } else
    
      if lastOffSetOfMainScroll.x < mainScrollView.contentOffset.x {
        
        directionOfScroll = .toRight
        
      }
    
    
    if mainScrollView.contentOffset.x > 0.0 && mainScrollView.contentOffset.x < UIScreen.mainScreen().bounds.size.width {
      
      let proportion = (50.0 * UtilityManager.sharedInstance.conversionWidth) / UIScreen.mainScreen().bounds.size.width
      
      var newPositionInX: CGFloat = 40.0 * UtilityManager.sharedInstance.conversionWidth
      
      var newPositionInXForSecondCard: CGFloat = 40.0 * UtilityManager.sharedInstance.conversionWidth

      if directionOfScroll == .toLeft {
        
        newPositionInX = (90.0 * UtilityManager.sharedInstance.conversionWidth) + ((mainScrollView.contentOffset.x - (UIScreen.mainScreen().bounds.size.width)) * proportion)
        
        newPositionInXForSecondCard = (((40.0 * UtilityManager.sharedInstance.conversionWidth) + UIScreen.mainScreen().bounds.size.width) + ((mainScrollView.contentOffset.x - (UIScreen.mainScreen().bounds.size.width)) * proportion))
        
      } else
        if directionOfScroll == .toRight {
          
          newPositionInX = (40.0 * UtilityManager.sharedInstance.conversionWidth) + (mainScrollView.contentOffset.x * proportion)
          
          newPositionInXForSecondCard = ((-10.0 * UtilityManager.sharedInstance.conversionWidth) + UIScreen.mainScreen().bounds.size.width) + (mainScrollView.contentOffset.x * proportion)
          
        }
      
      let newFramePosition = CGRect.init(x: newPositionInX,
                                         y: firstCard.frame.origin.y,
                                         width: firstCard.frame.size.width,
                                         height: firstCard.frame.size.height)
      
      let newFramePositionForSecondCard = CGRect.init(x: newPositionInXForSecondCard,
                                                      y: gralPerformanceCardView.frame.origin.y,
                                                  width: gralPerformanceCardView.frame.size.width,
                                                 height: gralPerformanceCardView.frame.size.height)
      
      firstCard.frame = newFramePosition
      
      gralPerformanceCardView.frame = newFramePositionForSecondCard
      
    } else
    
      if mainScrollView.contentOffset.x > UIScreen.mainScreen().bounds.size.width && mainScrollView.contentOffset.x < UIScreen.mainScreen().bounds.size.width * 3.0 {
        
        let proportion = (50.0 * UtilityManager.sharedInstance.conversionWidth) / UIScreen.mainScreen().bounds.size.width
        
        var newPositionInX: CGFloat = (mainScrollView.frame.size.width * CGFloat(kNumberOfCards - 1)) - (10.0 * UtilityManager.sharedInstance.conversionWidth)
        
        var newPositionInXForSecondCard: CGFloat = 40.0 * UtilityManager.sharedInstance.conversionWidth
        
        if directionOfScroll == .toLeft {
          
            newPositionInX = (mainScrollView.frame.size.width * CGFloat(kNumberOfCards - 1)) + (40.0 * UtilityManager.sharedInstance.conversionWidth) + ((mainScrollView.contentOffset.x - (UIScreen.mainScreen().bounds.size.width * 2.0)) * proportion)
          
            newPositionInXForSecondCard = (UIScreen.mainScreen().bounds.size.width) + (90.0 * UtilityManager.sharedInstance.conversionWidth) + ((mainScrollView.contentOffset.x - (UIScreen.mainScreen().bounds.size.width * 2.0)) * proportion)
          
        } else
          if directionOfScroll == .toRight {
            
            newPositionInX = (mainScrollView.frame.size.width * CGFloat(kNumberOfCards - 1)) - (10.0 * UtilityManager.sharedInstance.conversionWidth) + ((mainScrollView.contentOffset.x - (UIScreen.mainScreen().bounds.size.width * 1.0)) * proportion)
            
            newPositionInXForSecondCard = ((40.0 * UtilityManager.sharedInstance.conversionWidth) + UIScreen.mainScreen().bounds.size.width) + ((mainScrollView.contentOffset.x - (UIScreen.mainScreen().bounds.size.width * 1.0)) * proportion)
            
        }
        
        let newFramePosition = CGRect.init(x: newPositionInX,
                                           y: firstCard.frame.origin.y,
                                           width: firstCard.frame.size.width,
                                           height: firstCard.frame.size.height)
        
        thirdCard.frame = newFramePosition
        
        let newFramePositionForSecondCard = CGRect.init(x: newPositionInXForSecondCard,
                                                        y: gralPerformanceCardView.frame.origin.y,
                                                        width: gralPerformanceCardView.frame.size.width,
                                                        height: gralPerformanceCardView.frame.size.height)
        
        gralPerformanceCardView.frame = newFramePositionForSecondCard
        
        
      }
    
    
    
    
    
    lastOffSetOfMainScroll = mainScrollView.contentOffset

    
//    if actualPage == 0 {
//      
//      let newFrameForFirstCard = CGRect.init(x: positionForFirstCardInFirstPage.x,
//                                             y: positionForFirstCardInFirstPage.y,
//                                         width: firstCard.frame.size.width,
//                                        height: firstCard.frame.size.height)
//    
//      UIView.animateWithDuration(0.15){
//        
//        self.firstCard.frame = newFrameForFirstCard
//        
//      }
//    
//    }
//    
//    lastOffSetOfMainScroll = mainScrollView.contentOffset
    
  }
  
}