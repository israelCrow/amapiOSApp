//
//  VisualizeAgencyProfileViewController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/30/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit
import MessageUI
import MapKit
import SafariServices

protocol VisualizeAgencyProfileViewControllerDelegate {
  
  func requestToHideTabBarFromVisualizeAgencyProfileViewControllerDelegate()
  func requestToShowTabBarFromVisualizeAgencyProfileViewControllerDelegate()
  
}

class VisualizeAgencyProfileViewController: UIViewController, VisualizeCasesDelegate, VisualizeSkillsViewDelegate, VisualizeSkillsLevelViewDelegate, EditAgencyProfileViewControllerDelegate, AgencyProfilePicNameButtonsViewDelegate, MFMailComposeViewControllerDelegate, SFSafariViewControllerDelegate, VisualizeCaseDetailViewControllerDelegate {
  
  let kNumberOfCardsInScrollViewMinusOne = 4
  
  private var mainTabBar: DashBoardPitchesAndAgencyProfileTabBarView! = nil
  private var flipCard: FlipCardView! = nil
  private var frontViewOfClipCard: UIView! = nil
  private var profilePicNameButtonsView: AgencyProfilePicNameButtonsView! = nil
  private var scrollViewFrontFlipCard: UIScrollView! = nil
  
  private var skillsView: VisualizeSkillsView! = nil
  private var visualizeCases: VisualizeCasesView! = nil
  
  private var leftButton: UIButton! = nil
  private var rightButton: UIButton! = nil
  
  private var favoriteButton: UIButton! = nil
  var isFavoriteAgency: Bool = false
  
  private var actualPage: Int! = 0
  private var numberOfPageToMove: Int! = nil
  
  var delegate: VisualizeAgencyProfileViewControllerDelegate?
  
  override func loadView() {
    
    self.view = UIView.init(frame: UIScreen.mainScreen().bounds)
    self.view.backgroundColor = UIColor.blackColor()
    self.view.addSubview(self.createGradientView())
    self.editNavigationBar()
    self.initInterface()
    
    let notToShowTutorial = NSUserDefaults.standardUserDefaults().boolForKey(UtilityManager.sharedInstance.kNotToShowProfileTutorial + UserSession.session.email)
    
      let savedPhotoAndSavedName = NSUserDefaults.standardUserDefaults().boolForKey(UtilityManager.sharedInstance.kSavedPhotoAndSavedName + UserSession.session.email)
    
    if notToShowTutorial == false && savedPhotoAndSavedName == true {
      
      let tutorialProfile = ProfileScreenTutorialView.init(frame: CGRect.init())
      let rootViewController = UtilityManager.sharedInstance.currentViewController()
      rootViewController.view.addSubview(tutorialProfile)
      
    }
    
  }
  
  private func editNavigationBar() {
    
    self.navigationController?.navigationBarHidden = false
    
    self.changeBackButtonItem()
    self.changeNavigationBarTitle()
    self.changeRigthButtonItem()
    
    //Checar si va aquí o va en otro lugar
    
    if UserSession.session.role == "2" {
    
      let savedPhotoAndSavedName = NSUserDefaults.standardUserDefaults().boolForKey(UtilityManager.sharedInstance.kSavedPhotoAndSavedName + UserSession.session.email)
    
      if savedPhotoAndSavedName == false {
      
        UIApplication.sharedApplication().sendAction((self.navigationItem.leftBarButtonItem?.action)!,
                                                 to: self.navigationItem.leftBarButtonItem?.target,
                                               from: nil,
                                           forEvent: nil)
      
      }
      
    } else
      if UserSession.session.role == "4" || UserSession.session.role == "5" {
        
        
        
      }
    
  }
  
  private func changeBackButtonItem() {
    
    if UserSession.session.role == "2" {
      
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
      
    } else
      if UserSession.session.role == "4" || UserSession.session.role == "5" {
        
        let backButton = UIBarButtonItem(title: "Atrás",
                                         style: UIBarButtonItemStyle.Plain,
                                         target: self,
                                         action: #selector(backButtonPressed))
        
        let fontForButtonItem =  UIFont(name: "SFUIText-Regular",
                                        size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
        
        let attributesDict: [String:AnyObject] = [NSFontAttributeName: fontForButtonItem!,
                                                  NSForegroundColorAttributeName: UIColor.whiteColor()
        ]
        
        backButton.setTitleTextAttributes(attributesDict, forState: .Normal)
        
        self.navigationItem.leftBarButtonItem = backButton
        
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
    
    if UserSession.session.role == "2" {
      
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
      
    } else
      if UserSession.session.role == "4" || UserSession.session.role == "5" {
        
        let rightButton = UIBarButtonItem(title: "",
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
    profilePicNameButtonsView.delegate = self
    
    if numberOfPageToMove != nil && numberOfPageToMove != 0 {
      
      profilePicNameButtonsView.animateWhenInfoIsHidding()
      
    }else
      if numberOfPageToMove != nil && numberOfPageToMove == 0 {
        
        profilePicNameButtonsView.animateWhenInfoIsShowing()
        
    }

    frontViewOfClipCard.addSubview(profilePicNameButtonsView)
    
  }
  
  private func createMainScrollView(frameForCards: CGRect) {
    
    self.createScrollViewFrontFlipCard(frameForCards)

  }
  
  private func createScrollViewFrontFlipCard(frameForCards: CGRect) {
    
    var realFrameForScrollView = CGRect.init(x: frameForCards.origin.x,
                                             y: 183.0 * UtilityManager.sharedInstance.conversionHeight,
                                             width: frameForCards.size.width,
                                             height: 315.0 * UtilityManager.sharedInstance.conversionHeight)
    
    if UserSession.session.role == "4" || UserSession.session.role == "5" {
      
      realFrameForScrollView = CGRect.init(x: frameForCards.origin.x,
                                           y: 219.0 * UtilityManager.sharedInstance.conversionHeight,
                                       width: frameForCards.size.width,
                                      height: 279.0 * UtilityManager.sharedInstance.conversionHeight)
      
      self.createFavoriteButton()
      
    }
    
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
    
    let infoVisualize = VisualizeAgencyInfoView.init(frame: frameForScreensOfScrollView)
    infoVisualize.delegate = self
    infoVisualize.backgroundColor = UIColor.clearColor()
    scrollViewFrontFlipCard.addSubview(infoVisualize)
    profilePicNameButtonsView.animateWhenInfoIsShowing()
    
    let criteriaVisualize = VisualizeCriteriaView.init(frame: CGRect.init(x: frameForCards.size.width * 1,
      y: frameForScreensOfScrollView.origin.y,
      width: frameForScreensOfScrollView.size.width,
      height: frameForScreensOfScrollView.size.height))
    criteriaVisualize.backgroundColor = UIColor.clearColor()
    scrollViewFrontFlipCard.addSubview(criteriaVisualize)
    
    let exclusiveVisualize = VisualizeExclusiveView.init(frame: CGRect.init(x: frameForCards.size.width * 2,
      y: frameForScreensOfScrollView.origin.y,
      width: frameForScreensOfScrollView.size.width,
      height: frameForScreensOfScrollView.size.height))
    exclusiveVisualize.backgroundColor = UIColor.clearColor()
    scrollViewFrontFlipCard.addSubview(exclusiveVisualize)
    
    let participateInVisualize = VisualizeParticipateInView.init(frame: CGRect.init(x: frameForCards.size.width * 3,
      y: frameForScreensOfScrollView.origin.y,
      width: frameForScreensOfScrollView.size.width,
      height: frameForScreensOfScrollView.size.height))
    participateInVisualize.backgroundColor = UIColor.clearColor()
    scrollViewFrontFlipCard.addSubview(participateInVisualize)
    
//    let numberEmployees = VisualizeNumberOfEmployeesView.init(frame: CGRect.init(x: frameForCards.size.width * 4,
//      y: frameForScreensOfScrollView.origin.y,
//      width: frameForScreensOfScrollView.size.width,
//      height: frameForScreensOfScrollView.size.height))
//    scrollViewFrontFlipCard.addSubview(numberEmployees)
    
    visualizeCases = VisualizeCasesView.init(frame: CGRect.init(x: frameForCards.size.width * 4,
      y: frameForScreensOfScrollView.origin.y,
      width: frameForScreensOfScrollView.size.width,
      height: frameForScreensOfScrollView.size.height))
    visualizeCases.justVisualizeDelegate = self
    scrollViewFrontFlipCard.addSubview(visualizeCases)
    
    skillsView = VisualizeSkillsView.init(frame: CGRect.init(x: frameForCards.size.width * 5,
      y: frameForScreensOfScrollView.origin.y,
      width: frameForScreensOfScrollView.size.width,
      height: frameForScreensOfScrollView.size.height))
    scrollViewFrontFlipCard.addSubview(skillsView)
    skillsView.getAllSkillsFromServer()
    skillsView.delegate = self
 
    frontViewOfClipCard.addSubview(scrollViewFrontFlipCard)
    
    if numberOfPageToMove != nil {
      
      self.moveScrollViewToPageToShow()
      
    }
    
  }
  
  private func createFavoriteButton() {
    
    favoriteButton = UIButton.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    var stringWithFormat: NSMutableAttributedString
    
    if isFavoriteAgency == false {
    
      stringWithFormat = NSMutableAttributedString(
        string: "Agregar a favoritos              \u{2661}",
        attributes:[NSFontAttributeName: font!,
          NSParagraphStyleAttributeName: style,
          NSForegroundColorAttributeName: color
        ]
      )
    
    } else {
      
      stringWithFormat = NSMutableAttributedString(
        string: "Agregar a favoritos              \u{2665}",
        attributes:[NSFontAttributeName: font!,
          NSParagraphStyleAttributeName: style,
          NSForegroundColorAttributeName: color
        ]
      )
      
    }
    
    favoriteButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    favoriteButton.backgroundColor = UIColor.clearColor()
    favoriteButton.addTarget(self,
                        action: #selector(favoriteButtonPressed),
                        forControlEvents: .TouchUpInside)
    favoriteButton.sizeToFit()
    
    let frameForButton = CGRect.init(x: (frontViewOfClipCard.frame.size.width / 2.0) - (favoriteButton.frame.size.width / 2.0),
                                     y: 173.0 * UtilityManager.sharedInstance.conversionHeight,
                                 width: favoriteButton.frame.size.width,
                                height: favoriteButton.frame.size.height)
    
    favoriteButton.frame = frameForButton
    favoriteButton.alpha = 1.0
    
    self.frontViewOfClipCard.addSubview(favoriteButton)
    
  }
  
  @objc private func favoriteButtonPressed() {
    
    if isFavoriteAgency == false {
      
      let params = ["auth_token": UserSession.session.auth_token,
                    "agency_id": AgencyModel.Data.id
                    ]
      
      UtilityManager.sharedInstance.showLoader()
      
      RequestToServerManager.sharedInstance.requestToSetAgencyToFavorite(params, actionsToMakeAfterSetAgencyToFavorite: {
        
        let font = UIFont(name: "SFUIText-Light",
          size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
        let color = UIColor.blackColor()
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.Center
        
        let stringWithFormat = NSMutableAttributedString(
          string: "Agregar a favoritos              \u{2665}",
          attributes:[NSFontAttributeName: font!,
            NSParagraphStyleAttributeName: style,
            NSForegroundColorAttributeName: color
          ]
        )
        
        self.favoriteButton.setAttributedTitle(stringWithFormat, forState: .Normal)
        
        UtilityManager.sharedInstance.hideLoader()
        
      })
      
      
    } else {
      
      let params = ["auth_token": UserSession.session.auth_token,
                    "agency_id": AgencyModel.Data.id
                   ]
      
      UtilityManager.sharedInstance.showLoader()
      
      RequestToServerManager.sharedInstance.requestToRemoveAgencyFromFavorite(params, actionsToMakeAfterRemoveAgencyFromFavorite: {
        
        let font = UIFont(name: "SFUIText-Light",
          size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
        let color = UIColor.blackColor()
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.Center
        
        let stringWithFormat = NSMutableAttributedString(
          string: "Agregar a favoritos              \u{2661}",
          attributes:[NSFontAttributeName: font!,
            NSParagraphStyleAttributeName: style,
            NSForegroundColorAttributeName: color
          ]
        )
        
        self.favoriteButton.setAttributedTitle(stringWithFormat, forState: .Normal)
        
        UtilityManager.sharedInstance.hideLoader()
        
      })
      
    }
    
    isFavoriteAgency = !isFavoriteAgency
    print("Is favorite?: \(isFavoriteAgency)")
    
  }

  private func createButtonsForFlipCard() {
    leftButton = nil
    rightButton = nil
    
    
    let sizeForButtons = CGSize.init(width: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 49.0 * UtilityManager.sharedInstance.conversionHeight)
    
    var frameForLeftButton = CGRect.init(x: 23.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: 177.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: sizeForButtons.width,
                                         height:sizeForButtons.height)
    
    var frameForRightButton = CGRect.init(x: 235.0 * UtilityManager.sharedInstance.conversionWidth,
                                          y: 177.0 * UtilityManager.sharedInstance.conversionHeight,
                                          width: sizeForButtons.width,
                                          height: sizeForButtons.height)
    
    
    if UserSession.session.role == "4" || UserSession.session.role == "5" {
      
      frameForLeftButton = CGRect.init(x: 23.0 * UtilityManager.sharedInstance.conversionWidth,
                                       y: 213.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: sizeForButtons.width,
                                  height: sizeForButtons.height)
      
      frameForRightButton = CGRect.init(x: 235.0 * UtilityManager.sharedInstance.conversionWidth,
                                        y: 213.0 * UtilityManager.sharedInstance.conversionHeight,
                                    width: sizeForButtons.width,
                                   height: sizeForButtons.height)
      
    }
    
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
    }else
      if actualPage == kNumberOfCardsInScrollViewMinusOne {
      
          self.hideRightButtonOfMainScrollView()
        
      }
    
    flipCard.addSubview(leftButton)
    flipCard.addSubview(rightButton)
    
  }
  
  @objc private func backButtonPressed() {
    
    self.navigationController?.popViewControllerAnimated(true)
    
  }
  
  @objc private func pushEditAgencyProfile() {
    
    self.requestToHideTapBar()
    
    var pageToShow = 0
    
    switch actualPage {
    case 0:
      pageToShow = 0
      break
    
    case 1:
      pageToShow = 1
      break
      
    case 2:
      pageToShow = 2
      break
      
    case 3:
      pageToShow = 3
      break
      
    case 4:
      pageToShow = 4
      break
      
    case 5:
      pageToShow = 5
      break

//    case 6:
//      pageToShow = 4
      
    default:
      pageToShow = 0
    }
  
    let editStuffAgency = EditAgencyProfileViewController(pageOfCardToShow: pageToShow)
    editStuffAgency.delegate = self
    self.navigationController?.pushViewController(editStuffAgency, animated: true)
    
  }
  
  private func requestToHideTapBar() {
    
    self.delegate?.requestToHideTabBarFromVisualizeAgencyProfileViewControllerDelegate()
    
  }
  
  func pageOfCardToShow(numberOfPageToMove: Int) {
    
    self.numberOfPageToMove = numberOfPageToMove
    
  }
  
  @objc private func logOutAndPopThis() {
    
    UtilityManager.sharedInstance.showLoader()
    
    RequestToServerManager.sharedInstance.logOut(){
      
      AgencyModel.Data.reset()
      MyCompanyModelData.Data.reset()
      
      self.initAndChangeRootToLoginViewController()
      
    }
    
  }
  
  private func initAndChangeRootToLoginViewController() {
    
    UtilityManager.sharedInstance.hideLoader()
    
    let loginViewController = LoginViewController()
    let newNavController = UINavigationController.init(rootViewController: loginViewController)
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    UIView.transitionWithView(appDelegate.window!,
                              duration: 0.25,
                              options: UIViewAnimationOptions.TransitionCrossDissolve,
                              animations: {
                                self.view.alpha = 0.0
                                appDelegate.window?.rootViewController = newNavController
                                appDelegate.window?.makeKeyAndVisible()
                                
      },
                              completion: nil)
    
  }
  
  @objc private func moveScrollViewToLeft() {
    
    if actualPage > 0 {
      
      actualPage = actualPage - 1
      
      if actualPage == 0 {
        
        self.hideLeftButtonOfMainScrollView()
        profilePicNameButtonsView.animateWhenInfoIsShowing()
        
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
      
      if actualPage > 0 {
        
        if actualPage == 1 {
          
          profilePicNameButtonsView.animateWhenInfoIsHidding()
          
        }
        
        if self.leftButton.alpha == 0.0 {
          
          self.showLeftButtonOfMainScrollView()
          
        }
        
        
      }
      
      let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
      
      let pointToMove = CGPoint.init(x: widthOfCard * CGFloat(actualPage), y: 0.0)
      
      scrollViewFrontFlipCard.setContentOffset(pointToMove, animated: true)
      
    }
    
  }
  
  private func moveScrollViewToPageToShow() {
    
    actualPage = numberOfPageToMove
    
    let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
    
    let pointToMove = CGPoint.init(x: widthOfCard * CGFloat(numberOfPageToMove), y: 0.0)
    
    scrollViewFrontFlipCard.setContentOffset(pointToMove, animated: false)
    
    if numberOfPageToMove == kNumberOfCardsInScrollViewMinusOne {
      
      profilePicNameButtonsView.animateWhenInfoIsHidding()
      self.hideRightButtonOfMainScrollView()
      
    } else {
    
      if numberOfPageToMove == 0 {
       
        profilePicNameButtonsView.animateWhenInfoIsShowing()
        self.hideLeftButtonOfMainScrollView()
        
      }else{
        
        profilePicNameButtonsView.animateWhenInfoIsHidding()
        
      }
      
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
  
  private func goToLastPage() {
    
    let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
    
    let pointToMove = CGPoint.init(x: widthOfCard * CGFloat(kNumberOfCardsInScrollViewMinusOne), y: 0.0)
    
    scrollViewFrontFlipCard.setContentOffset(pointToMove, animated: false)
    
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    UIView.setAnimationsEnabled(true)
    
    if UserSession.session.role == "2" {
      
      let notToShowProfileTutorial = NSUserDefaults.standardUserDefaults().boolForKey(UtilityManager.sharedInstance.kNotToShowProfileTutorial + UserSession.session.email)
      
      let savedPhotoAndSavedName = NSUserDefaults.standardUserDefaults().boolForKey(UtilityManager.sharedInstance.kSavedPhotoAndSavedName + UserSession.session.email)
      
      if notToShowProfileTutorial == false && savedPhotoAndSavedName == true {
        
        let tutorialProfile = ProfileScreenTutorialView.init(frame: CGRect.init())
        let rootViewController = UtilityManager.sharedInstance.currentViewController()
        rootViewController.view.addSubview(tutorialProfile)
        
      }
      
//      if flipCard != nil {
//        
//        //      UtilityManager.sharedInstance.hideLoader()
//        
//        flipCard.removeFromSuperview()
//        flipCard = nil
//        actualPage = 0
//        self.createAndAddFlipCard()
//        //      self.hideLeftButtonOfMainScrollView()
//        
//      }
 
    } else
    
      if UserSession.session.role == "4" || UserSession.session.role == "5" {
        //MakeSomething If necessary
        print()
 
      }

    if flipCard != nil {
      
      //      UtilityManager.sharedInstance.hideLoader()
      
      flipCard.removeFromSuperview()
      flipCard = nil
      actualPage = 0
      self.createAndAddFlipCard()
      //      self.hideLeftButtonOfMainScrollView()
      
    }
    
  }
  
  override func viewWillDisappear(animated: Bool) {
    
    super.viewWillDisappear(animated)
    
//    if UserSession.session.role == "4" {
//      
//      AgencyModel.Data.reset()
//      
//    }
    
  }
  
  //MARK: - VisualizeCasesDelegate
  
  func showDetailOfCase(caseData: Case) {
    
    let previewVisualizerCase = VisualizeCaseDetailViewController.init(dataOfCase: caseData)
    previewVisualizerCase.delegate = self
    
    self.navigationController?.pushViewController(previewVisualizerCase, animated: true)
    
  }
  
  //MARK: - VisualizeCaseDetailViewControllerDelegate
  
  func showCasesFromCaseDetailViewController() {
  
    self.numberOfPageToMove = 4
    
  }
  
  //MARK: - VisualizeSkillsViewDelegate
  
  func flipCardToShowSkillsOfCategory(skills: [Skill], skillCategoryName: String) {
    let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
    let heightOfCard = self.view.frame.size.height - (168.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let frameForViewsOfCard = CGRect.init(x: 0.0, y: 0.0, width: widthOfCard, height: heightOfCard)
    
    let skillsLevels = VisualizeSkillsLevelView.init(frame: frameForViewsOfCard, skillCategory: skillCategoryName, arrayOfSkills: skills)
    skillsLevels.delegate = self
    skillsLevels.hidden = true
    flipCard.setSecondView(skillsLevels)
    flipCard.flip()
    
    self.goToLastPage()
  }
  
  //MARK: - VisualizeSkillsLevelViewDelegate
  
  func cancelShowSkillsLevelView() {
    
    flipCard.flip()
    let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
    let heightOfCard = self.view.frame.size.height - (136.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let frameForViewsOfCard = CGRect.init(x: 0.0, y: 0.0, width: widthOfCard, height: heightOfCard)
    
    //createTheBackCard
    let blankView = UIView.init(frame:frameForViewsOfCard)
    blankView.hidden = true
    flipCard.setSecondView(blankView)
    self.createButtonsForFlipCard()
    self.hideRightButtonOfMainScrollView()
    
  }
  
  //MARK: - EditAgencyProfileViewControllerDelegate
  
  func requestToShowTabBarFromEditAgencyProfileViewControllerDelegate() {
    
    self.delegate?.requestToShowTabBarFromVisualizeAgencyProfileViewControllerDelegate()
    
  }
  
  //MARK: - AgencyProfilePicNameButtonsViewDelegate
  
  func mailIconButtonPressed() {
    
    if AgencyModel.Data.contact_email != nil {
      
      let mailComposeViewController = configuredMailComposeViewController()
      mailComposeViewController.navigationBar.barTintColor = UIColor.init(white: 1.0, alpha: 1.0)
      
      if MFMailComposeViewController.canSendMail() {
  
        self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        
      } else {
        
        self.showSendMailErrorAlert()
        
      }
      
    } else {
      
      let alertController = UIAlertController(title: "Error al mandar email", message: "La agencia no cuenta aún con una cuenta de email", preferredStyle: UIAlertControllerStyle.Alert)
      
      let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel) { (result : UIAlertAction) -> Void in
        
      }
      
      alertController.addAction(okAction)
      self.presentViewController(alertController, animated: true, completion: nil)
      
    }

  }
  
  func configuredMailComposeViewController() -> MFMailComposeViewController {
    let mailComposerVC = MFMailComposeViewController()
    mailComposerVC.mailComposeDelegate = self
    
    mailComposerVC.setToRecipients([AgencyModel.Data.contact_email!])
    mailComposerVC.setSubject("Contactado desde Happitch :)")
    mailComposerVC.setMessageBody("", isHTML: false)
    
    return mailComposerVC
  }
  
  
  func showSendMailErrorAlert() {
    
    let alertController = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: UIAlertControllerStyle.Alert)

    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel) { (result : UIAlertAction) -> Void in
      
    }
    
    alertController.addAction(okAction)
    self.presentViewController(alertController, animated: true, completion: nil)
    
  }
  
  func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
    controller.dismissViewControllerAnimated(true, completion: nil)
  }
  
  
  func telephoneIconButtonPressed() {
    
    if AgencyModel.Data.phone != nil {
      
      var finalPhone = AgencyModel.Data.phone.stringByReplacingOccurrencesOfString(".", withString: "")
      finalPhone = finalPhone.stringByReplacingOccurrencesOfString(" ", withString: "")
      finalPhone = finalPhone.stringByReplacingOccurrencesOfString("(", withString: "")
      finalPhone = finalPhone.stringByReplacingOccurrencesOfString(")", withString: "")
      
      if let url = NSURL(string: "tel://\(finalPhone)") {
        UIApplication.sharedApplication().openURL(url)
      }
      
    } else {
      
      let alertController = UIAlertController(title: "Error al marcar por teléfono", message: "La agencia no cuenta aún con un número telefónico", preferredStyle: UIAlertControllerStyle.Alert)
      
      let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel) { (result : UIAlertAction) -> Void in
        
      }
      
      alertController.addAction(okAction)
      self.presentViewController(alertController, animated: true, completion: nil)
      
    }
    
  }
  
  func weblinkIconButtonPressed() {
    
    if AgencyModel.Data.website_url != nil && UIApplication.sharedApplication().canOpenURL(NSURL.init(string: AgencyModel.Data.website_url!)!) {

      let url = NSURL.init(string: AgencyModel.Data.website_url!)
      
      let safariExplorer = SFSafariViewController.init(URL: url!)
      safariExplorer.delegate = self
      
      self.navigationController?.presentViewController(safariExplorer, animated: true, completion: nil)
      
//      UIApplication.sharedApplication().openURL(NSURL.init(string: AgencyModel.Data.website_url!)!)
      
    } else {
      
      let alertController = UIAlertController(title: "No se puede abrir página web", message: "La agencia no cuenta aún con una página web válida", preferredStyle: UIAlertControllerStyle.Alert)
      
      let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel) { (result : UIAlertAction) -> Void in
        
      }
      
      alertController.addAction(okAction)
      self.presentViewController(alertController, animated: true, completion: nil)
      
    }
    
  }
  
  func locationIconButtonPressed() {
    
    if AgencyModel.Data.longitude != nil && AgencyModel.Data.latitude != nil {
      
      
      let isGoogleMapsInstalled = UIApplication.sharedApplication().canOpenURL(NSURL.init(string:"comgooglemaps://")!)
      
      if isGoogleMapsInstalled == true {
        
        UIApplication.sharedApplication().openURL(NSURL(string:
          "comgooglemaps://?center=\(AgencyModel.Data.latitude!),\(AgencyModel.Data.latitude!)&zoom=18")!)
        
      } else {
        
        let lat1 : NSString = AgencyModel.Data.latitude!
        let lng1 : NSString = AgencyModel.Data.longitude!
        
        let latitude:CLLocationDegrees =  lat1.doubleValue
        let longitude:CLLocationDegrees =  lng1.doubleValue
        
        let regionDistance:CLLocationDistance = 100
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
          MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: regionSpan.center),
          MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        if AgencyModel.Data.address != nil {
          mapItem.name = "\(AgencyModel.Data.address!)"
        }
        mapItem.openInMapsWithLaunchOptions(options)
        
      }

    }
    
  }
  
  //MARK: - SFSafariViewControllerDelegate
  
  func safariViewControllerDidFinish(controller: SFSafariViewController) {
    
    
    
  }
  
}
