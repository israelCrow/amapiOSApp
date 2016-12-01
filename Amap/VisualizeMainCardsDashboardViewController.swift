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

class VisualizeMainCardsDashboardViewController: UIViewController, GrapAccordingToUserViewDelegate, FilterAccordingToUserAndAgencyViewDelegate, GraphOfAgencyVSIndustryViewDelegate, GeneralPerformanceCardViewDelegate {
  
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
    
    let frameForFirstCard = CGRect.init(x: (40.0 * UtilityManager.sharedInstance.conversionWidth),
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
    
    let frameForThirdCard  = CGRect.init(x: (40.0 * UtilityManager.sharedInstance.conversionWidth) + (mainScrollView.frame.size.width * CGFloat(kNumberOfCards - 1)),
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
  
  
  
}