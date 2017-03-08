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

class VisualizeMainCardsDashboardViewController: UIViewController, UIScrollViewDelegate,  GrapAccordingToUserViewDelegate, FilterAccordingToUserAndAgencyViewDelegate, GraphOfAgencyVSIndustryViewDelegate, GeneralPerformanceCardViewDelegate, GeneralPerformanceOwnStatisticsCardViewDelegate {
  
  enum ScrollDirection {
    case toLeft
    case toRight
  }
  
  private let kNumberOfCards = 3
  private let kNumberOfCardsForCompany = 4
  
  private var mainScrollView: UIScrollView! = nil
  private var gralPerformanceCardView: GeneralPerformanceCardView! = nil
  
  private var firstCard: FlipCardView! = nil
  private var thirdCard: FlipCardView! = nil
  
  private var graphAccordingUser: GraphAccordingToUserView! = nil
  private var graphAgencyVSIndustry: GraphOfAgencyVSIndustryView! = nil
  
  //For Company
  private var secondCardFlipped: Bool = false
  private var secondCard: FlipCardView! = nil
  private var thirdFilterView: FilterAccordingToUserAndAgencyView! = nil
  private var graphAccordingBrand: GraphAccordingToUserView! = nil
//  private var companyStatisticsPerformanceCardView: GeneralPerformanceOwnStatisticsCardView! = nil
  private var gralOwnStatisticsPerformanceCardView: GeneralPerformanceOwnStatisticsCardView! = nil
  private var numberOfPitchesByMyself = [String: Int]()
  private var arrayOfUsersFromCompany = [AgencyUserModelData]()
  private var arrayOfOwnBrands = [BrandModelData]()
  private var recommendations = [RecommendationModelData]()
  
  private var secondTimeShowing: Bool = false
  private var arrayOfUsers = [AgencyUserModelData]()
  private var arrayOfScoresByAgency = [PitchEvaluationAveragePerMonthModelData]()  //Will work for agencya or company, depends on type of user
  private var arrayOfScoresByIndustry = [PitchEvaluationAveragePerMonthModelData]()
  private var numberOfPitchesByAgency = [String: Int]()
  
  private var firstFilterView: FilterAccordingToUserAndAgencyView! = nil
  private var secondFilterView: FilterAccordingToUserAndAgencyView! = nil
  
  private var lastUserSelectedInfo: [String: AnyObject]! = nil
  private var lastBrandSelectecInfo: [String: AnyObject]! = nil
  
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
    
    if UserSession.session.role == "2" || UserSession.session.role == "3" {
      
      let notToShowDashboardTutorial = NSUserDefaults.standardUserDefaults().boolForKey(UtilityManager.sharedInstance.kNotToShowDashboardTutorial + UserSession.session.email)
      
      if notToShowDashboardTutorial == false {
        
        let tutorialFirstScreenDashboard = DashboardFirstScreenTutorialView.init(frame: CGRect.init())
        let rootViewController = UtilityManager.sharedInstance.currentViewController()
        rootViewController.view.addSubview(tutorialFirstScreenDashboard)
        
      }
      
    } else
      if UserSession.session.role == "4" || UserSession.session.role == "5" {
        
        let notToShowDashboardTutorial = NSUserDefaults.standardUserDefaults().boolForKey(UtilityManager.sharedInstance.kNotToShowCompanyDashboardTutorial + UserSession.session.email)
        
        if notToShowDashboardTutorial == false {
          
          let tutorialFirstScreenDashboard = CompanyDashboardTutorialView.init(frame: CGRect.init())
          let rootViewController = UtilityManager.sharedInstance.currentViewController()
          rootViewController.view.addSubview(tutorialFirstScreenDashboard)
          
        }
        
      }
    

    
  }
  
  private func changeNavigationBarTitle() {
    
    let titleLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 17.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    var stringWithFormat = NSMutableAttributedString(
      string: VisualizeDashboardConstants.VisualizeMainCardsDashboardViewController.navigationBarTitleText,
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    
    if UserSession.session.role == "4" || UserSession.session.role == "5" {
      
      stringWithFormat = NSMutableAttributedString(
        string: VisualizeDashboardConstants.VisualizeMainCardsDashboardViewController.navigationBarTitleTextForCompany,
        attributes:[NSFontAttributeName:font!,
          NSParagraphStyleAttributeName:style,
          NSForegroundColorAttributeName:color
        ]
      )

      
    }
    
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
    
    if UserSession.session.role == "2" || UserSession.session.role == "3" {
    
      mainScrollView.contentSize = CGSize.init(width: UIScreen.mainScreen().bounds.width * CGFloat(kNumberOfCards),
                                              height: UIScreen.mainScreen().bounds.height)
      
    }else
      if UserSession.session.role == "4" || UserSession.session.role == "5" {
        
        mainScrollView.contentSize = CGSize.init(width: UIScreen.mainScreen().bounds.width * CGFloat(kNumberOfCardsForCompany),
                                                 height: UIScreen.mainScreen().bounds.height)
        
      }

    mainScrollView.pagingEnabled = true
    mainScrollView.setContentOffset(firstCardPoint, animated: false)
    mainScrollView.delegate = self
    
    self.view.addSubview(mainScrollView)
    
  }
  
  private func moveToSecondPage() {
    
    if mainScrollView != nil {
      
      let secondPagePoint = CGPoint.init(x: UIScreen.mainScreen().bounds.width,
                                         y: 0.0)
      mainScrollView.setContentOffset(secondPagePoint, animated: true)
      
    }
  
  }
  
  private func moveToThirdPage() {
    
    if mainScrollView != nil {
      
      let thirdPagePoint = CGPoint.init(x: UIScreen.mainScreen().bounds.width * 2.0,
                                        y: 0.0)
      mainScrollView.setContentOffset(thirdPagePoint, animated: true)
      
    }
    
  }
  
  private func getInfoFromServer() {
    
    lastBrandSelectecInfo = nil
    lastUserSelectedInfo = nil
    
    if UserSession.session.role == "2" || UserSession.session.role == "3" {
     
      UtilityManager.sharedInstance.showLoader()
      
      RequestToServerManager.sharedInstance.requestToGetPitchEvaluationsAveragePerMonthByAgency(nil) { (arrayOfScoresPerMonthOfAgency, arrayOfUsers) in
        
        print(arrayOfUsers)
        print(arrayOfScoresPerMonthOfAgency)
        
        self.arrayOfUsers = arrayOfUsers
        self.arrayOfScoresByAgency = arrayOfScoresPerMonthOfAgency
        
        
        
        RequestToServerManager.sharedInstance.requestToGetPitchEvaluationsAveragePerMonthByIndustry(nil, actionsToMakeAfterGetingInfo: { (arrayOfScoresPerMonthOfIndustry) in
          
          self.arrayOfScoresByIndustry = arrayOfScoresPerMonthOfIndustry
          
          RequestToServerManager.sharedInstance.requestToGetPitchEvaluationsDashboardSumaryByAgency({ (numberOfPitchesByAgencyForDashboardSumary, arrayOfUsers, recommendations) in
            
            self.numberOfPitchesByAgency = numberOfPitchesByAgencyForDashboardSumary
            self.recommendations = recommendations
            
            UtilityManager.sharedInstance.hideLoader()
            
            self.createCards()
            
            
          })
          
        })
        
      }
      
    } else
      if UserSession.session.role == "4" || UserSession.session.role == "5" {
        
        UtilityManager.sharedInstance.showLoader()
        
        RequestToServerManager.sharedInstance.requestToGetPitchEvaluationsAveragePerMonthByCompany(nil, actionsToMakeAfterGetingInfo: { (arrayOfScoresPerMonthOfCompany, arrayOfBrands, arrayOfUsersFromCompany) in
          
          self.arrayOfOwnBrands = arrayOfBrands
          self.arrayOfScoresByAgency = arrayOfScoresPerMonthOfCompany
          self.arrayOfUsersFromCompany = arrayOfUsersFromCompany
          
          RequestToServerManager.sharedInstance.requestToGetPitchEvaluationsDashboardSummaryByClient({ (numberOfPitchesByClientForDashboardSummary, arrayOfBrands, recommendations) in
            
            self.arrayOfOwnBrands = arrayOfBrands
            self.numberOfPitchesByMyself = numberOfPitchesByClientForDashboardSummary //number Of pitches by company
            self.recommendations = recommendations
            
            RequestToServerManager.sharedInstance.requestToGetPitchEvaluationsAveragePerMonthByIndustry(nil, actionsToMakeAfterGetingInfo: { (arrayOfScoresPerMonthOfIndustry) in
              
              self.arrayOfScoresByIndustry = arrayOfScoresPerMonthOfIndustry
              self.createCards()
              
              UtilityManager.sharedInstance.hideLoader()
              
            })
            
          })
          
        })
        
        
        //CORRECT ALL THE NEXT!!
        

          

          
        
        
        
        
        
        
//        let userOne =  AgencyUserModelData.init(newId: "-1",
//                                         newFirstName: "Usuario 1",
//                                          newLastName: "One")
//        
//        let userTwo =  AgencyUserModelData.init(newId: "-2",
//                                                newFirstName: "Usuario 2",
//                                                newLastName: "Two")
//        
//        arrayOfUsers = [userOne, userTwo]//
//        
//        let scoreOne = PitchEvaluationAveragePerMonthModelData.init(newId: "-1",
//                                                             newMonthYear: "octubre-2016",
//                                                                 newScore: "45")
//        
//        let scoreTwo = PitchEvaluationAveragePerMonthModelData.init(newId: "-2",
//                                                                    newMonthYear: "noviembre-2016",
//                                                                    newScore: "87")
//        
//        arrayOfScoresByAgency = [scoreOne, scoreTwo]//
//        
//        arrayOfScoresByIndustry = [scoreTwo, scoreOne]//
//        
//        numberOfPitchesByAgency = [
//          "happitch": 7,
//          "happy":    11,
//          "ok":       5,
//          "unhappy":  15,
//          "lost":     6,
//          "won":      5
//        ]
//        
//        UtilityManager.sharedInstance.showLoader()
//        
//        
//        RequestToServerManager.sharedInstance.requestToGetPitchEvaluationsDashboardSummaryByClient({ (numberOfPitchesByClientForDashboardSummary, arrayOfBrands, recommendations) in
//          
//          self.arrayOfOwnBrands = arrayOfBrands
//          self.numberOfPitchesByMyself = numberOfPitchesByClientForDashboardSummary //number Of pitches by company
//          self.recommendations = recommendations
//          
//          RequestToServerManager.sharedInstance.requestToGetPitchEvaluationsAveragePerMonthByIndustry(nil, actionsToMakeAfterGetingInfo: { (arrayOfScoresPerMonthOfIndustry) in
//            
//            self.arrayOfScoresByIndustry = arrayOfScoresPerMonthOfIndustry
//            self.createCards()
//            
//            UtilityManager.sharedInstance.hideLoader()
//            
//          })
//          
//        })
        
      }
    
  }
  
  private func createCards() {
    
    if UserSession.session.role == "2" || UserSession.session.role == "3" {
      
      UIView.animateWithDuration(0.15,
        animations: {
          
          self.mainScrollView.alpha = 0.0
          
        }, completion: { finished in
          
          if finished == true {
            
            self.createGeneralPerformanceCard()
            self.moveToSecondPage()
            self.moveToThirdPage()
            self.moveToSecondPage()
            
            UIView.animateWithDuration(0.15) {
              
              self.mainScrollView.alpha = 1.0
              
            }
            
          }
          
      })
      
    } else
      if UserSession.session.role == "4" || UserSession.session.role == "5" {
        
        UIView.animateWithDuration(0.15,
                                   animations: {
                                    
                                    self.mainScrollView.alpha = 0.0
                                    
          }, completion: { finished in
            
            if finished == true {
              
              self.createCardsForCompany()
              
              self.moveToSecondPage()
              self.moveToThirdPage()
              
              UIView.animateWithDuration(0.15) {
                
                self.mainScrollView.alpha = 1.0
                
              }
              
            }
            
        })
        
      }
    
    
  }
  
  
  private func createGeneralPerformanceCard() {
    
    let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
    let heightOfCard = self.view.frame.size.height - (157.0 * UtilityManager.sharedInstance.conversionHeight)
    
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
    if firstFilterView != nil {
      
      firstFilterView.removeFromSuperview()
      firstFilterView = nil
      
    }
    
    if secondFilterView != nil {
      
      secondFilterView.removeFromSuperview()
      secondFilterView = nil
      
    }
    
    if graphAccordingUser != nil {
      
      graphAccordingUser.removeFromSuperview()
      graphAccordingUser = nil
      
    }
    
    if graphAgencyVSIndustry != nil {
      
      graphAgencyVSIndustry.removeFromSuperview()
      graphAgencyVSIndustry = nil
      
    }
    
    if firstCard != nil {
      
      firstCard.removeFromSuperview()
      firstCard = nil
      
    }
    
    if secondCard != nil {
      
      secondCard.removeFromSuperview()
      secondCard = nil
      
    }
    
    if thirdCard != nil {
      
      thirdCard.removeFromSuperview()
      thirdCard = nil
      
    }
    
    if gralPerformanceCardView != nil {
      
      gralPerformanceCardView.removeFromSuperview()
      gralPerformanceCardView = nil
      
    }
    
    
    firstFilterView = FilterAccordingToUserAndAgencyView.init(frame: frameForFrontAndBack)
    firstFilterView.tag = 1
    firstFilterView.delegate = self
    
    secondFilterView = FilterAccordingToUserAndAgencyView.init(frame: frameForFrontAndBack)
    secondFilterView.tag = 2
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
        
    scoresAgency = self.orderScoresPerMonth(arrayOfScoresByAgency)
    scoresIndustry = self.orderScoresPerMonth(arrayOfScoresByIndustry)
    
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
    
    gralPerformanceCardView = GeneralPerformanceCardView.init(frame: frameForSecondCard, newArrayOfUsers: finalUsersforGeneralPerformance,
        newNumberOfPitchesByAgency: numberOfPitchesByAgency,
        newRecommendationsData: recommendations)
    gralPerformanceCardView.delegate = self
    
    if UserSession.session.role == "3" {
      
      gralPerformanceCardView.actionToMakeWhenUserRoleThree()
      
    }
    
    mainScrollView.addSubview(gralPerformanceCardView)
    
  }
  
  private func createCardsForCompany() {
    
    let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
    let heightOfCard = self.view.frame.size.height - (168.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let frameForFrontAndBack = CGRect.init(x: 0.0,
                                           y: 0.0,
                                           width: widthOfCard,
                                           height: heightOfCard - (51.0 * UtilityManager.sharedInstance.conversionHeight))
    
    let frameForFirstCard = CGRect.init(x: (90.0 * UtilityManager.sharedInstance.conversionWidth),
                                        y: (108.0 * UtilityManager.sharedInstance.conversionHeight),
                                        width: widthOfCard,
                                        height: heightOfCard - (51.0 * UtilityManager.sharedInstance.conversionHeight))
    
    let frameForSecondCard = CGRect.init(x: (90.0 * UtilityManager.sharedInstance.conversionWidth) + (mainScrollView.frame.size.width * CGFloat(kNumberOfCardsForCompany - 3)),
                                         y: (108.0 * UtilityManager.sharedInstance.conversionHeight),
                                         width: widthOfCard,
                                         height: heightOfCard - (51.0 * UtilityManager.sharedInstance.conversionHeight))
    
    let frameForThirdCard = CGRect.init(x: (mainScrollView.frame.size.width * CGFloat(kNumberOfCardsForCompany - 2)) + (40.0 * UtilityManager.sharedInstance.conversionWidth),
                                         y: (108.0 * UtilityManager.sharedInstance.conversionHeight),
                                         width: widthOfCard,
                                         height: heightOfCard)
    
    let frameForFourthCard = CGRect.init(x: (mainScrollView.frame.size.width * CGFloat(kNumberOfCardsForCompany - 1)) - (10.0 * UtilityManager.sharedInstance.conversionWidth),
                                         y: (108.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: widthOfCard,
                                    height: heightOfCard - (51.0 * UtilityManager.sharedInstance.conversionHeight))
    
    if firstFilterView != nil {
      
      firstFilterView.removeFromSuperview()
      firstFilterView = nil
      
    }
    
    if secondFilterView != nil {
      
      secondFilterView.removeFromSuperview()
      secondFilterView = nil
      
    }
    
    if graphAccordingUser != nil {
      
      graphAccordingUser.removeFromSuperview()
      graphAccordingUser = nil
      
    }
    
    if graphAgencyVSIndustry != nil {
      
      graphAgencyVSIndustry.removeFromSuperview()
      graphAgencyVSIndustry = nil
      
    }
    
    if graphAccordingBrand != nil {
      
      graphAccordingBrand.removeFromSuperview()
      graphAccordingBrand = nil
      
    }
    
    if graphAgencyVSIndustry != nil {
      
      graphAgencyVSIndustry.removeFromSuperview()
      graphAgencyVSIndustry = nil
      
    }
    
    if gralOwnStatisticsPerformanceCardView != nil {
      
      gralOwnStatisticsPerformanceCardView.removeFromSuperview()
      gralOwnStatisticsPerformanceCardView = nil
      
    }
    
    if firstCard != nil {
      
      firstCard.removeFromSuperview()
      firstCard = nil
      
    }
    
    if secondCard != nil {
      
      secondCard.removeFromSuperview()
      secondCard = nil
      
    }
    
    if thirdCard != nil {
      
      thirdCard.removeFromSuperview()
      thirdCard = nil
      
    }

    
    firstFilterView = FilterAccordingToUserAndAgencyView.init(frame: frameForFrontAndBack)
    firstFilterView.tag = 1
    firstFilterView.delegate = self
    secondFilterView = FilterAccordingToUserAndAgencyView.init(frame: frameForFrontAndBack)
    secondFilterView.tag = 2
    secondFilterView.delegate = self
    thirdFilterView = FilterAccordingToUserAndAgencyView.init(frame: frameForFrontAndBack)
    thirdFilterView.tag = 3
    thirdFilterView.delegate = self
    
    graphAccordingUser = GraphAccordingToUserView.init(frame: frameForFrontAndBack, newArrayOfUsers: arrayOfUsersFromCompany)
    graphAccordingUser.tag = 1
    graphAccordingUser.delegate = self
    graphAccordingUser.layer.shadowColor = UIColor.blackColor().CGColor
    graphAccordingUser.layer.shadowOpacity = 0.25
    graphAccordingUser.layer.shadowOffset = CGSizeZero
    graphAccordingUser.layer.shadowRadius = 5
    
    //Despite the model is AgencyUserModelData, the info is about the Brands of the Company
    var arrayOfBrands = [AgencyUserModelData]()
    
    for brand in arrayOfOwnBrands {
      
      let newBrand = AgencyUserModelData.init(newId: brand.id,
                                       newFirstName: brand.name,
                                        newLastName: "")
      
      arrayOfBrands.append(newBrand)
      
    }
    
    graphAccordingBrand = GraphAccordingToUserView.init(frame: frameForFrontAndBack, newArrayOfUsers: arrayOfBrands, newDropDownTitleText: "Desempeño por marca", forUsers: true)
    graphAccordingBrand.tag = 2
    graphAccordingBrand.delegate = self
    graphAccordingBrand.layer.shadowColor = UIColor.blackColor().CGColor
    graphAccordingBrand.layer.shadowOpacity = 0.25
    graphAccordingBrand.layer.shadowOffset = CGSizeZero
    graphAccordingBrand.layer.shadowRadius = 5
    
    //third card
    
    var scoresAgency = [Double]()
    var scoresIndustry = [Double]()
    
    scoresAgency = orderScoresPerMonth(arrayOfScoresByAgency)
    scoresIndustry = orderScoresPerMonth(arrayOfScoresByIndustry)
    
    graphAgencyVSIndustry = GraphOfAgencyVSIndustryView.init(frame: frameForFrontAndBack, newArrayByAgency: scoresAgency, newArrayByIndustry: scoresIndustry)
    graphAgencyVSIndustry.delegate = self
    
    
    
    firstCard = FlipCardView.init(frame: frameForFirstCard,
                                  viewOne: graphAccordingUser,
                                  viewTwo: firstFilterView)
    
    //ADDED
    secondCard = FlipCardView.init(frame: frameForSecondCard,
                                 viewOne: graphAccordingBrand,
                                 viewTwo: secondFilterView)
    
    //Third card will be the fourth card
    thirdCard = FlipCardView.init(frame: frameForFourthCard,
                                  viewOne: graphAgencyVSIndustry,
                                  viewTwo: thirdFilterView)
    
    
    
    mainScrollView.addSubview(firstCard)
    mainScrollView.addSubview(secondCard)
    mainScrollView.addSubview(thirdCard)
    
    let companyUser = AgencyUserModelData.init(newId: MyCompanyModelData.Data.id,
                                              newFirstName: MyCompanyModelData.Data.name,
                                              newLastName: "")
    
    let myCompany = BrandModelData.init(newId: MyCompanyModelData.Data.id,
                                          newName: MyCompanyModelData.Data.name,
                                   newContactName: nil,
                                  newContactEMail: nil,
                               newContactPosition: nil,
                            newProprietaryCompany: nil)
    
    var finalUsersforGeneralPerformance = arrayOfUsers
    finalUsersforGeneralPerformance.insert(companyUser, atIndex: 0)
    
    var finalUserForOwnStatistics = arrayOfOwnBrands
    finalUserForOwnStatistics.insert(myCompany, atIndex: 0)
    
//    let exampleBrand = BrandModelData.init(newId: "-1",
//                                         newName: "Example One",
//                                  newContactName: nil,
//                                 newContactEMail: nil,
//                              newContactPosition: nil,
//                          newProprietaryCompany: nil)
//    
//    let exampleBrandTwo = BrandModelData.init(newId: "-1",
//                                           newName: "Example Two",
//                                           newContactName: nil,
//                                           newContactEMail: nil,
//                                           newContactPosition: nil,
//                                           newProprietaryCompany: nil)
//    
//    let exampleBrandThree = BrandModelData.init(newId: "-1",
//                                           newName: "Example Three",
//                                           newContactName: nil,
//                                           newContactEMail: nil,
//                                           newContactPosition: nil,
//                                           newProprietaryCompany: nil)
    
//    let arrayOfExampleBrands = [exampleBrand, exampleBrandTwo, exampleBrandThree]
    
//    companyStatisticsPerformanceCardView = GeneralPerformanceOwnStatisticsCardView.init(frame: frameForSecondCard,
//      newArrayOfBrands: arrayOfExampleBrands,
//      newNumberOfPitchesByCompany: numberOfPitchesByMyself,
//      newTitleText: "Estadísticas de la compañía")
//    mainScrollView.addSubview(companyStatisticsPerformanceCardView)
    
//    gralPerformanceCardView = GeneralPerformanceCardView.init(frame: frameForSecondCard, newArrayOfUsers: finalUsersforGeneralPerformance,
//        newNumberOfPitchesByAgency: numberOfPitchesByAgency)
//    gralPerformanceCardView.delegate = self
//    mainScrollView.addSubview(gralPerformanceCardView)
    
    gralOwnStatisticsPerformanceCardView = GeneralPerformanceOwnStatisticsCardView.init(frame: frameForThirdCard,
      newArrayOfBrands: finalUserForOwnStatistics,
      newNumberOfPitchesByCompany: numberOfPitchesByMyself,
      newTitleText: "Tus estadísticas",
      newRecommendationsData: self.recommendations)
    gralOwnStatisticsPerformanceCardView.delegate = self
    
    if UserSession.session.role == "5" {
      
      gralOwnStatisticsPerformanceCardView.actionToMakeWhenUserRoleIsFive()
      
    }
    
    mainScrollView.addSubview(gralOwnStatisticsPerformanceCardView)
    
    let thirdPagePoint = CGPoint.init(x: UIScreen.mainScreen().bounds.width * 2.0,
                                      y: 0.0)
    
    mainScrollView.setContentOffset(thirdPagePoint, animated: true)
    
    self.showOnlyValueFromAgencyOrCompany(graphAccordingUser)
    self.showOnlyValueFromAgencyOrCompany(graphAccordingBrand)
    
  }
  
  private func createGradientView() -> GradientView{
    
    let frameForView = CGRect.init(x: 0.0, y: 60.0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height - 60.0)
    
    let firstColorGradient = UIColor.init(red: 195.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    let secondColorGradient = UIColor.init(red: 117.0/255.0, green: 236.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    let colorsForBackground = [firstColorGradient,secondColorGradient]
    
    return GradientView.init(frame: frameForView, arrayOfcolors: colorsForBackground, typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
    
  }
  
  //MARK: - GrapAccordingToUserViewDelegate
  
  func getEvaluationsAveragePerMonth(params: [String : AnyObject], sender: GraphAccordingToUserView) {
    
    UtilityManager.sharedInstance.showLoader()
    
      if UserSession.session.role == "2" || UserSession.session.role == "3" {
        
        RequestToServerManager.sharedInstance.requestToGetPitchEvaluationsAveragePerMonthByAgency(params) { (arrayOfScoresPerMonthOfAgency, arrayOfUsers) in
          
          self.arrayOfScoresByAgency = arrayOfScoresPerMonthOfAgency
          self.lastUserSelectedInfo = params
   
          RequestToServerManager.sharedInstance.requestToGetPitchEvaluationsAveragePerMonthByUser(params) { (arrayOfScoresPerMonthByUser) in
          
            var arrayOfScoresInDouble = [Double]()
            var arrayOfScoresInDoubleByAgency = [Double]()
 
            arrayOfScoresInDouble = self.orderScoresPerMonth(arrayOfScoresPerMonthByUser)
            arrayOfScoresInDoubleByAgency = self.orderScoresPerMonth(self.arrayOfScoresByAgency)
          
            sender.changeData(arrayOfScoresInDouble, newValuesForAgency: arrayOfScoresInDoubleByAgency)
          
            UtilityManager.sharedInstance.hideLoader()
          
          }
        }
      } else
        if UserSession.session.role == "4" || UserSession.session.role == "5" {
          
          RequestToServerManager.sharedInstance.requestToGetPitchEvaluationsAveragePerMonthByCompany(params, actionsToMakeAfterGetingInfo: { (arrayOfScoresPerMonthOfCompany, arrayOfBrands, arrayOfUsersFromCompany) in
                    
            self.arrayOfScoresByAgency = arrayOfScoresPerMonthOfCompany
                    
            
            if sender == self.graphAccordingUser { //This is when the app is for company and user select inside graphAccordingUser (the first card)
              
              self.lastUserSelectedInfo = params
              
              RequestToServerManager.sharedInstance.requestToGetPitchEvaluationsAveragePerMonthByUser(params) { (arrayOfScoresPerMonthByUser) in
                
                var arrayOfScoresInDouble = [Double]()
                var arrayOfScoresInDoubleByAgency = [Double]()
                
                arrayOfScoresInDouble = self.orderScoresPerMonth(arrayOfScoresPerMonthByUser)
                arrayOfScoresInDoubleByAgency = self.orderScoresPerMonth(self.arrayOfScoresByAgency)
                
                sender.changeData(arrayOfScoresInDouble, newValuesForAgency: arrayOfScoresInDoubleByAgency)
                
                UtilityManager.sharedInstance.hideLoader()
                
              }
              
            } else
              
              if sender == self.graphAccordingBrand { //This is when the app is for company and user select inside graphAccordingBrand (the second card)
                
                self.lastBrandSelectecInfo = params
                
                RequestToServerManager.sharedInstance.requestToGetPitchEvaluationsAveragePerMonthByBrand(params) { (arrayOfScoresPerMonthByUser) in
                  
                  var arrayOfScoresInDouble = [Double]()
                  var arrayOfScoresInDoubleByAgency = [Double]()
                  
                  arrayOfScoresInDouble = self.orderScoresPerMonth(arrayOfScoresPerMonthByUser)
                  arrayOfScoresInDoubleByAgency = self.orderScoresPerMonth(self.arrayOfScoresByAgency)
                  
                  sender.changeData(arrayOfScoresInDouble, newValuesForAgency: arrayOfScoresInDoubleByAgency)
                  
                  UtilityManager.sharedInstance.hideLoader()
                  
                }
                
            }
            
          })
          
    }
    
  }
  
  func showOnlyValueFromAgencyOrCompany(sender: GraphAccordingToUserView) {
    
    UtilityManager.sharedInstance.showLoader()
      
      if UserSession.session.role == "2" || UserSession.session.role == "3" {
        
        let arrayOfScoresInDouble = [Double]()
        var arrayOfScoresInDoubleByAgency = [Double]()

        arrayOfScoresInDoubleByAgency = self.orderScoresPerMonth(self.arrayOfScoresByAgency)
          
        sender.changeData(arrayOfScoresInDouble, newValuesForAgency: arrayOfScoresInDoubleByAgency)
          
        UtilityManager.sharedInstance.hideLoader()
        
      } else
        if UserSession.session.role == "4" || UserSession.session.role == "5" {
          
          if sender == self.graphAccordingUser { //This is when the app is for company and user select inside graphAccordingUser (the first card)
              
              let arrayOfScoresInDouble = [Double]()
              var arrayOfScoresInDoubleByAgency = [Double]()
            
              arrayOfScoresInDoubleByAgency = self.orderScoresPerMonth(self.arrayOfScoresByAgency)
              
              sender.changeData(arrayOfScoresInDouble, newValuesForAgency: arrayOfScoresInDoubleByAgency)
              
              UtilityManager.sharedInstance.hideLoader()
            
          } else
            
            if sender == self.graphAccordingBrand { //This is when the app is for company and user select inside graphAccordingBrand (the second card)
                
                let arrayOfScoresInDouble = [Double]()
                var arrayOfScoresInDoubleByAgency = [Double]()
              
                arrayOfScoresInDoubleByAgency = self.orderScoresPerMonth(self.arrayOfScoresByAgency)
                
                sender.changeData(arrayOfScoresInDouble, newValuesForAgency: arrayOfScoresInDoubleByAgency)
                
                UtilityManager.sharedInstance.hideLoader()
                
            }
          
      }
  
  }
  
  private func orderScoresPerMonth(arrayOfSscoresToOrder: [PitchEvaluationAveragePerMonthModelData]) -> [Double] {
    
    var finalArrayOfScores = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    
    for score in arrayOfSscoresToOrder {
      
      if score.monthYear != nil {
      
        var numberMonth = score.monthYear
        numberMonth = numberMonth.substringWithRange(numberMonth.startIndex..<numberMonth.startIndex.advancedBy(2))
        
        switch numberMonth {
        case "01":
          finalArrayOfScores.insert(Double(score.score)!, atIndex: 0)
          break
          
        case "02":
          finalArrayOfScores.insert(Double(score.score)!, atIndex: 1)
          break
          
        case "03":
          finalArrayOfScores.insert(Double(score.score)!, atIndex: 2)
          break
          
        case "04":
          finalArrayOfScores.insert(Double(score.score)!, atIndex: 3)
          break
          
        case "05":
          finalArrayOfScores.insert(Double(score.score)!, atIndex: 4)
          break
          
        case "06":
          finalArrayOfScores.insert(Double(score.score)!, atIndex: 5)
          break
          
        case "07":
          finalArrayOfScores.insert(Double(score.score)!, atIndex: 6)
          break
          
        case "08":
          finalArrayOfScores.insert(Double(score.score)!, atIndex: 7)
          break
          
        case "09":
          finalArrayOfScores.insert(Double(score.score)!, atIndex: 8)
          break
          
        case "10":
          finalArrayOfScores.insert(Double(score.score)!, atIndex: 9)
          break
          
        case "11":
          finalArrayOfScores.insert(Double(score.score)!, atIndex: 10)
          break
          
        case "12":
          finalArrayOfScores.insert(Double(score.score)!, atIndex: 11)
          break
          
        default:
          break
          
        }
        
      }
      
    }
    
    return finalArrayOfScores
    
  }
  
  func flipCardToShowFilterOfGraphAccordingToUser(sender: GraphAccordingToUserView) {
    
    if UserSession.session.role == "2" || UserSession.session.role == "3" {
        
      if lastUserSelectedInfo == nil {
          
        let alertController = UIAlertController(title: "AVISO",
                                                  message: "Selecciona primero un usuario",
                                                  preferredStyle: UIAlertControllerStyle.Alert)
          
        let cancelAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
            
          return
            
        }
          
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
          
      } else {
          
        nextTimeFlipFirstCard = true
        self.firstFilterView.changeParamsToFilter(lastUserSelectedInfo)
        self.firstCard.flip()
          
      }
        
    } else
    
      if UserSession.session.role == "4" || UserSession.session.role == "5" {
      
        if sender.tag == 1 {
          
          if lastUserSelectedInfo == nil {
           
            let alertController = UIAlertController(title: "AVISO",
                                                    message: "Selecciona primero un usuario",
                                                    preferredStyle: UIAlertControllerStyle.Alert)
            
            let cancelAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
              
              return
              
            }
            
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            
          } else {
            
            self.firstFilterView.changeParamsToFilter(lastUserSelectedInfo)
            self.firstCard.flip()
            self.nextTimeFlipFirstCard = true
            
          }
          
        } else
          
        if sender.tag == 2 {
          
          if lastBrandSelectecInfo == nil {
            
            let alertController = UIAlertController(title: "AVISO",
                                                    message: "Selecciona primero un usuario",
                                                    preferredStyle: UIAlertControllerStyle.Alert)
            
            let cancelAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
              
              return
              
            }
            
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            
          } else {
            
            self.secondFilterView.changeParamsToFilter(lastBrandSelectecInfo)
            self.secondCard.flip()
            self.secondCardFlipped = true
            
          }
            
        }
      
      }
    
  }
  
  //MARK: - FilterAccordingToUserAndAgencyViewDelegate
  
  func cancelFilterButtonPressed(sender: FilterAccordingToUserAndAgencyView) {
    
    if UserSession.session.role == "2" || UserSession.session.role == "3" {
      
      if nextTimeFlipFirstCard == true {
        
        self.firstCard.flip()
        nextTimeFlipFirstCard = false
        
      } else {
        
        self.thirdCard.flip()
        
      }
      
    }else
    if UserSession.session.role == "4" || UserSession.session.role == "5" {
        
      if sender.tag == 1 {
        
        firstCard.flip()
        
      }else
      if sender.tag == 2 {
        
        secondCard.flip()
        
      }else
      if sender.tag == 3 {
          
        thirdCard.flip()
          
      }
        
    }
   

    
  }
  
  func applyFilterButtonPressedFromFilterAccordingToUserAndAgencyView(sender: FilterAccordingToUserAndAgencyView, params: [String : AnyObject]) {
    
    if UserSession.session.role == "2" || UserSession.session.role == "3" {
      
      if sender == firstFilterView {
        
        self.firstCard.flip()
        self.getEvaluationsAveragePerMonth(params, sender: graphAccordingUser)
        
      } else
      
        if sender == secondFilterView { //when tapped filter from agency versus industry
          
          self.thirdCard.flip()
          self.updateValuesOfAgencyVersusIndustry(params)
          
        }
      
    } else
    
      if UserSession.session.role == "4" || UserSession.session.role == "5" {
        
        if sender == firstFilterView {
          //graphAccordingUser
          self.firstCard.flip()
          self.getEvaluationsAveragePerMonth(params, sender: graphAccordingUser)
          
        } else
        
          if sender == secondFilterView {
            //graphAccordingBrand
            self.secondCard.flip()
            self.getEvaluationsAveragePerMonth(params, sender: graphAccordingBrand)
            
          } else
        
          if sender == thirdFilterView {
            //graphAgency
            self.thirdCard.flip()
            self.updateValuesOfAgencyVersusIndustry(params)
            
            print()
            
          }
        
      }
    
    
  }
  
  private func updateValuesOfAgencyVersusIndustry(params: [String: AnyObject]) {
    
    if UserSession.session.role == "2" || UserSession.session.role == "3" {
      
      UtilityManager.sharedInstance.showLoader()
      
      RequestToServerManager.sharedInstance.requestToGetPitchEvaluationsAveragePerMonthByAgency(params) { (arrayOfScoresPerMonthOfAgency, arrayOfUsers) in
        
        self.arrayOfScoresByAgency = arrayOfScoresPerMonthOfAgency
        
        RequestToServerManager.sharedInstance.requestToGetPitchEvaluationsAveragePerMonthByIndustry(params, actionsToMakeAfterGetingInfo: { (arrayOfScoresPerMonthOfIndustry) in
          
          UtilityManager.sharedInstance.hideLoader()
          
          self.arrayOfScoresByIndustry = arrayOfScoresPerMonthOfIndustry
          
          var arrayScoresAgency = [Double]()
          var arrayScoresIdustry = [Double]()
          
//          for score in self.arrayOfScoresByAgency {
//            
//            arrayScoresAgency.append(Double(score.score)!)
//            
//          }
//          
//          for scoreIndustry in self.arrayOfScoresByIndustry {
//            
//            arrayScoresIdustry.append(Double(scoreIndustry.score)!)
//            
//          }

          arrayScoresAgency = self.orderScoresPerMonth(self.arrayOfScoresByAgency)
          arrayScoresIdustry = self.orderScoresPerMonth(self.arrayOfScoresByIndustry)
          
          self.graphAgencyVSIndustry.changeData(AgencyModel.Data.name,
            newXValues: nil,
            newLineGraphData: arrayScoresAgency,
            newBarGraphData: arrayScoresIdustry)
          
        })
        
      }
      
    } else
    
      if UserSession.session.role == "4" || UserSession.session.role == "5" {
        
        UtilityManager.sharedInstance.showLoader()
        
        RequestToServerManager.sharedInstance.requestToGetPitchEvaluationsAveragePerMonthByIndustry(nil, actionsToMakeAfterGetingInfo: { (arrayOfScoresPerMonthOfIndustry) in
          
          self.arrayOfScoresByIndustry = arrayOfScoresPerMonthOfIndustry
          
          var arrayScoresAgency = [Double]()
          var arrayScoresIdustry = [Double]()
          
//          for score in self.arrayOfScoresByAgency {
//            
//            arrayScoresAgency.append(Double(score.score)!)
//            
//          }
//          
//          for scoreIndustry in self.arrayOfScoresByIndustry {
//            
//            arrayScoresIdustry.append(Double(scoreIndustry.score)!)
//            
//          }

          arrayScoresAgency = self.orderScoresPerMonth(self.arrayOfScoresByAgency)
          arrayScoresIdustry = self.orderScoresPerMonth(self.arrayOfScoresByIndustry)
          
          self.graphAgencyVSIndustry.changeData(MyCompanyModelData.Data.name,
            newXValues: nil,
            newLineGraphData: arrayScoresAgency,
            newBarGraphData: arrayScoresIdustry)
          
          UtilityManager.sharedInstance.hideLoader()
          
        })
        
      }
    
  }
  
  //MARK: - GraphOfAgencyVSIndustryViewDelegate
  
  func filterFromGraphOfAgencyVSIndustryPressed(sender: GraphOfAgencyVSIndustryView) {
    
    if UserSession.session.role == "2" || UserSession.session.role == "3" {
      
      self.secondFilterView.changeParamsToFilter([String: AnyObject]())
      
    } else
    
      if UserSession.session.role == "4" || UserSession.session.role == "5" {
        
        self.thirdFilterView.changeParamsToFilter([String: AnyObject]())
        
      }
    
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
      
    RequestToServerManager.sharedInstance.requestToGetPitchEvaluationsDashboardSumaryByAgency { (numberOfPitchesByAgencyForDashboardSumary, arrayOfUsers, recommendations) in
        
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
          
      }else
    
      if mainScrollView.contentOffset.x == UIScreen.mainScreen().bounds.size.width * 3.0 {
          
          actualPage = 3
          
      }
    
  }
  
  func scrollViewDidScroll(scrollView: UIScrollView) {
    
    if lastOffSetOfMainScroll.x > mainScrollView.contentOffset.x {
      
      directionOfScroll = .toLeft
      
    } else
    
      if lastOffSetOfMainScroll.x < mainScrollView.contentOffset.x {
        
        directionOfScroll = .toRight
        
      }
    
    if UserSession.session.role == "2" || UserSession.session.role == "3" {
      
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
      
    } else
      
      if UserSession.session.role == "4" || UserSession.session.role == "5" {
        
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
                                                          y: secondCard.frame.origin.y,
                                                          width: secondCard.frame.size.width,
                                                          height: secondCard.frame.size.height)
          
          firstCard.frame = newFramePosition
          
          secondCard.frame = newFramePositionForSecondCard
          
        } else
          
          if mainScrollView.contentOffset.x > UIScreen.mainScreen().bounds.size.width && mainScrollView.contentOffset.x < UIScreen.mainScreen().bounds.size.width * 2.0 {
            
            let proportion = (50.0 * UtilityManager.sharedInstance.conversionWidth) / UIScreen.mainScreen().bounds.size.width
            
            var newPositionInX: CGFloat = (mainScrollView.frame.size.width * CGFloat(kNumberOfCardsForCompany - 2)) - (10.0 * UtilityManager.sharedInstance.conversionWidth)
            
            var newPositionInXForSecondCard: CGFloat = 40.0 * UtilityManager.sharedInstance.conversionWidth
            
            if directionOfScroll == .toLeft {
              
              newPositionInX = (mainScrollView.frame.size.width * CGFloat(kNumberOfCardsForCompany - 2)) + (40.0 * UtilityManager.sharedInstance.conversionWidth) + ((mainScrollView.contentOffset.x - (UIScreen.mainScreen().bounds.size.width * 2.0)) * proportion)
              
              newPositionInXForSecondCard = (UIScreen.mainScreen().bounds.size.width) + (90.0 * UtilityManager.sharedInstance.conversionWidth) + ((mainScrollView.contentOffset.x - (UIScreen.mainScreen().bounds.size.width * 2.0)) * proportion)
              
            } else
              if directionOfScroll == .toRight {
                
                newPositionInX = (mainScrollView.frame.size.width * CGFloat(kNumberOfCardsForCompany - 2)) - (10.0 * UtilityManager.sharedInstance.conversionWidth) + ((mainScrollView.contentOffset.x - (UIScreen.mainScreen().bounds.size.width * 1.0)) * proportion)
                
                newPositionInXForSecondCard = ((40.0 * UtilityManager.sharedInstance.conversionWidth) + UIScreen.mainScreen().bounds.size.width) + ((mainScrollView.contentOffset.x - (UIScreen.mainScreen().bounds.size.width * 1.0)) * proportion)
                
            }
            
            let newFramePosition = CGRect.init(x: newPositionInX,
                                               y: gralOwnStatisticsPerformanceCardView.frame.origin.y,
                                               width: gralOwnStatisticsPerformanceCardView.frame.size.width,
                                               height: gralOwnStatisticsPerformanceCardView.frame.size.height)
            
            gralOwnStatisticsPerformanceCardView.frame = newFramePosition
            
            let newFramePositionForSecondCard = CGRect.init(x: newPositionInXForSecondCard,
                                                            y: secondCard.frame.origin.y,
                                                            width: secondCard.frame.size.width,
                                                            height: secondCard.frame.size.height)
            
            secondCard.frame = newFramePositionForSecondCard
            
          } else
            
          if mainScrollView.contentOffset.x > UIScreen.mainScreen().bounds.size.width * 2.0 && mainScrollView.contentOffset.x < UIScreen.mainScreen().bounds.size.width * 3.0 {
              
              let proportion = (50.0 * UtilityManager.sharedInstance.conversionWidth) / UIScreen.mainScreen().bounds.size.width
              
              var newPositionInX: CGFloat = (mainScrollView.frame.size.width * CGFloat(kNumberOfCardsForCompany - 1)) - (10.0 * UtilityManager.sharedInstance.conversionWidth)
              
              var newPositionInXForSecondCard: CGFloat = 40.0 * UtilityManager.sharedInstance.conversionWidth
              
              if directionOfScroll == .toLeft {
                
                newPositionInX = (mainScrollView.frame.size.width * CGFloat(kNumberOfCardsForCompany - 1)) + (40.0 * UtilityManager.sharedInstance.conversionWidth) + ((mainScrollView.contentOffset.x - (UIScreen.mainScreen().bounds.size.width * 3.0)) * proportion)
                
                newPositionInXForSecondCard = (UIScreen.mainScreen().bounds.size.width * 2.0) + (90.0 * UtilityManager.sharedInstance.conversionWidth) + ((mainScrollView.contentOffset.x - (UIScreen.mainScreen().bounds.size.width * 3.0)) * proportion)
                
              } else
                if directionOfScroll == .toRight {
                  
                  newPositionInX = (mainScrollView.frame.size.width * CGFloat(kNumberOfCardsForCompany - 1)) - (10.0 * UtilityManager.sharedInstance.conversionWidth) + ((mainScrollView.contentOffset.x - (UIScreen.mainScreen().bounds.size.width * 2.0)) * proportion)
                  
                  newPositionInXForSecondCard = ((40.0 * UtilityManager.sharedInstance.conversionWidth) + (UIScreen.mainScreen().bounds.size.width * 2.0)) + ((mainScrollView.contentOffset.x - (UIScreen.mainScreen().bounds.size.width * 2.0)) * proportion)
                  
              }
              
              let newFramePosition = CGRect.init(x: newPositionInX,
                                                 y: thirdCard.frame.origin.y,
                                                 width: thirdCard.frame.size.width,
                                                 height: thirdCard.frame.size.height)
              
              thirdCard.frame = newFramePosition
              
              let newFramePositionForSecondCard = CGRect.init(x: newPositionInXForSecondCard,
                                                              y: gralOwnStatisticsPerformanceCardView.frame.origin.y,
                                                              width: gralOwnStatisticsPerformanceCardView.frame.size.width,
                                                              height: gralOwnStatisticsPerformanceCardView.frame.size.height)
              
              gralOwnStatisticsPerformanceCardView.frame = newFramePositionForSecondCard
              
        }
        
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
  
  //MARK: - GeneralPerformanceOwnStatisticsCardViewDelegate
  
  func requestToGetValuesFromCompany() {
    
    UtilityManager.sharedInstance.showLoader()
    
    RequestToServerManager.sharedInstance.requestToGetPitchEvaluationsDashboardSummaryByClient { (numberOfPitchesByClientForDashboardSummary, arrayOfBrands, recommendations) in
      
      self.recommendations = recommendations
      
      self.gralOwnStatisticsPerformanceCardView.updateData(numberOfPitchesByClientForDashboardSummary, newRecommendations: self.recommendations)
      
      UtilityManager.sharedInstance.hideLoader()
      
    }
  
  }
  
  func requestToGetValuesByBrand(params: [String : AnyObject]) {
    
    UtilityManager.sharedInstance.showLoader()
    
    RequestToServerManager.sharedInstance.requestToGetPitchEvaluationsDashboardSummaryByBrand(params) { (numberOfPitchesByBrandForDashboardSummary) in
    
      self.gralOwnStatisticsPerformanceCardView.updateData(numberOfPitchesByBrandForDashboardSummary, newRecommendations: self.recommendations)
      
      UtilityManager.sharedInstance.hideLoader()
      
    }

  }
  
  override func viewWillAppear(animated: Bool) {
    
    super.viewWillAppear(animated)
    
    if secondTimeShowing == false {
      
      secondTimeShowing = true
      
    } else {
      
      self.getInfoFromServer()
      
    }
    
    
  }
  
}