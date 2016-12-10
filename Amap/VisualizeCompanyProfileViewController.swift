//
//  VisualizeCompanyProfileViewController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 12/9/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol VisualizeCompanyProfileViewControllerDelegate {
  
  func requestToHideTabBarFromVisualizeCompanyProfileViewControllerDelegate()
  func requestToShowTabBarFromVisualizeCompanyProfileViewControllerDelegate()
  
}

class VisualizeCompanyProfileViewController: UIViewController, DetailedInfoCompanyContactViewDelegate {
  
  private var flipCard: FlipCardView! = nil
  private var topDetailCompanyView: DetailedInfoCompanyContactView! = nil
  private var frontViewOfFlipCard: UIView! = nil
  private var scrollViewFrontFlipCard: UIScrollView! = nil
  
  
  var delegate: VisualizeCompanyProfileViewControllerDelegate?
  
  override func loadView() {
    
    self.view = UIView.init(frame: UIScreen.mainScreen().bounds)
    self.view.backgroundColor = UIColor.blackColor()
    self.view.addSubview(self.createGradientView())
    self.editNavigationBar()
    self.initInterface()
    
  }
  
  private func editNavigationBar() {
    
    self.navigationController?.navigationBarHidden = false
    
    self.changeBackButtonItem()
    self.changeNavigationBarTitle()
    self.changeRigthButtonItem()
    
    //Checar si va aquí o va en otro lugar
    
//    let savedPhotoAndSavedName = NSUserDefaults.standardUserDefaults().boolForKey(UtilityManager.sharedInstance.kSavedPhotoAndSavedName + UserSession.session.email)
//    
//    if savedPhotoAndSavedName == false {
//      
//      UIApplication.sharedApplication().sendAction((self.navigationItem.leftBarButtonItem?.action)!,
//                                                   to: self.navigationItem.leftBarButtonItem?.target,
//                                                   from: nil,
//                                                   forEvent: nil)
//      
//    }
    
  }
  
  private func changeBackButtonItem() {
    
    let backButton = UIBarButtonItem(title: AgencyProfileVisualizeConstants.VisualizeAgencyProfileViewController.backButtonText,
                                     style: UIBarButtonItemStyle.Plain,
                                     target: self,
                                     action: #selector(pushEditCompanyProfile))
    
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
      string: "Perfil Marca",
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
  
  private func initInterface() {
      
    self.createAndAddFlipCard()
    
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
    flipCard = FlipCardView.init(frame: frameForFlipCard, viewOne: frontViewOfFlipCard, viewTwo: blankView)
    self.view.addSubview(flipCard)
    
  }
  
  private func createFrontViewForFlipCard(frameForCards: CGRect) {
    
    frontViewOfFlipCard = UIView.init(frame: frameForCards)
    frontViewOfFlipCard.backgroundColor = UIColor.whiteColor()
    
    self.createDetailedCompanyInfo()
    self.createMainScrollView(frameForCards)
    
  }
  
  private func createDetailedCompanyInfo() {
    
    let frameForView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                   y: 30.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                              height: 147.0 * UtilityManager.sharedInstance.conversionHeight)
    
    topDetailCompanyView = DetailedInfoCompanyContactView.init(frame: frameForView)
    topDetailCompanyView.delegate = self
    
    frontViewOfFlipCard.addSubview(topDetailCompanyView)
    
  }
  
  private func createMainScrollView(frameForCards: CGRect) {
    
    self.createScrollViewFrontFlipCard(frameForCards)
    
  }
  
  private func createScrollViewFrontFlipCard(frameForCards: CGRect) {
    
    let realFrameForScrollView = CGRect.init(x: frameForCards.origin.x,
                                             y: 183.0 * UtilityManager.sharedInstance.conversionHeight,
                                             width: frameForCards.size.width,
                                             height: 315.0 * UtilityManager.sharedInstance.conversionHeight)
    
//    let contentSizeOfScrollView = CGSize.init(width: frameForCards.size.width,
//                                             height: frameForCards.size.height)
    
    scrollViewFrontFlipCard = UIScrollView.init(frame: realFrameForScrollView)
    scrollViewFrontFlipCard.backgroundColor = UIColor.whiteColor()
//    scrollViewFrontFlipCard.contentSize = contentSizeOfScrollView
    scrollViewFrontFlipCard.scrollEnabled = false
    
    //------------------------------------------SCREENS
    
    let frameForScreensOfScrollView = CGRect.init(x: 0.0,
                                                  y: 0.0,
                                                  width: frameForCards.size.width,
                                                  height: 316.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let companyConflict = CompanyConflictsView.init(frame: frameForScreensOfScrollView)
//    infoVisualize.delegate = self
//    infoVisualize.backgroundColor = UIColor.clearColor()
//    scrollViewFrontFlipCard.addSubview(infoVisualize)
//    profilePicNameButtonsView.animateWhenInfoIsShowing()
//    
//    let criteriaVisualize = VisualizeCriteriaView.init(frame: CGRect.init(x: frameForCards.size.width * 1,
//      y: frameForScreensOfScrollView.origin.y,
//      width: frameForScreensOfScrollView.size.width,
//      height: frameForScreensOfScrollView.size.height))
//    criteriaVisualize.backgroundColor = UIColor.clearColor()
//    scrollViewFrontFlipCard.addSubview(criteriaVisualize)
//    
//    let exclusiveVisualize = VisualizeExclusiveView.init(frame: CGRect.init(x: frameForCards.size.width * 2,
//      y: frameForScreensOfScrollView.origin.y,
//      width: frameForScreensOfScrollView.size.width,
//      height: frameForScreensOfScrollView.size.height))
//    exclusiveVisualize.backgroundColor = UIColor.clearColor()
//    scrollViewFrontFlipCard.addSubview(exclusiveVisualize)
//    
//    let participateInVisualize = VisualizeParticipateInView.init(frame: CGRect.init(x: frameForCards.size.width * 3,
//      y: frameForScreensOfScrollView.origin.y,
//      width: frameForScreensOfScrollView.size.width,
//      height: frameForScreensOfScrollView.size.height))
//    participateInVisualize.backgroundColor = UIColor.clearColor()
//    scrollViewFrontFlipCard.addSubview(participateInVisualize)
//    
//    //    let numberEmployees = VisualizeNumberOfEmployeesView.init(frame: CGRect.init(x: frameForCards.size.width * 4,
//    //      y: frameForScreensOfScrollView.origin.y,
//    //      width: frameForScreensOfScrollView.size.width,
//    //      height: frameForScreensOfScrollView.size.height))
//    //    scrollViewFrontFlipCard.addSubview(numberEmployees)
//    
//    visualizeCases = VisualizeCasesView.init(frame: CGRect.init(x: frameForCards.size.width * 4,
//      y: frameForScreensOfScrollView.origin.y,
//      width: frameForScreensOfScrollView.size.width,
//      height: frameForScreensOfScrollView.size.height))
//    visualizeCases.justVisualizeDelegate = self
//    scrollViewFrontFlipCard.addSubview(visualizeCases)
//    
//    skillsView = VisualizeSkillsView.init(frame: CGRect.init(x: frameForCards.size.width * 5,
//      y: frameForScreensOfScrollView.origin.y,
//      width: frameForScreensOfScrollView.size.width,
//      height: frameForScreensOfScrollView.size.height))
//    scrollViewFrontFlipCard.addSubview(skillsView)
//    skillsView.getAllSkillsFromServer()
//    skillsView.delegate = self
//    
    scrollViewFrontFlipCard.addSubview(companyConflict)
    frontViewOfFlipCard.addSubview(scrollViewFrontFlipCard)
//
//    if numberOfPageToMove != nil {
//      
//      self.moveScrollViewToPageToShow()
//      
//    }
    
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  //MARK: - DetailedInfoCompanyContactViewDelegate
  
  func mailIconPressedFromDetailedInfoView() {
    
    
    
  }
  
  @objc private func pushEditCompanyProfile() {
    
    
    
  }

  @objc private func logOutAndPopThis() {
    
    UtilityManager.sharedInstance.showLoader()
    
    RequestToServerManager.sharedInstance.logOut(){
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
  
  private func createGradientView() -> GradientView{
    
    let frameForView = CGRect.init(x: 0.0, y: 60.0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height - 60.0)
    
    let firstColorGradient = UIColor.init(red: 214.0/255.0, green: 240.0/255.0, blue: 96.0/255.0, alpha: 1.0)
    let secondColorGradient = UIColor.init(red: 40.0/255.0, green: 255.0/255.0, blue: 141.0/255.0, alpha: 1.0)
    let colorsForBackground = [firstColorGradient,secondColorGradient]
    
    return GradientView.init(frame: frameForView, arrayOfcolors: colorsForBackground, typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
    
  }
  
  
}

