//
//  EditCompanyProfileViewController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 12/9/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol EditCompanyProfileViewControllerDelegate {
  
  func requestToShowTabBarFromEditCompanyProfileViewControllerDelegate()
  
}

class EditCompanyProfileViewController: UIViewController {
  
  private var flipCard: FlipCardView! = nil
  private var scrollViewFrontFlipCard: UIScrollView! = nil
  private var saveChangesButton: UIButton! = nil
  private var leftButton: UIButton! = nil
  private var rightButton: UIButton! = nil
  
  private var editProfile: EditCompanyProfileView! = nil
  private var editConflicts: EditConflictsView! = nil
  
  private var actualPage = 0
  
  private let kNumberOfCardsInScrollViewMinusOne = 1
  
  var delegate: EditCompanyProfileViewControllerDelegate?
  
  override func loadView() {
    
    self.view = UIView.init(frame: UIScreen.mainScreen().bounds)
    self.view.backgroundColor = UIColor.blackColor()
    self.view.addSubview(self.createGradientView())
    self.editNavigationBar()
    
  }
  
  private func editNavigationBar() {
    
    self.navigationController?.navigationBarHidden = false
    
    self.changeBackButtonItem()
    self.changeNavigationBarTitle()
    self.changeRigthButtonItem()
    
    self.addSomeGestures()
    
  }

  private func changeBackButtonItem() {
    
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
      string: "Editar Perfil Marca",
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
    
    let rightButton = UIBarButtonItem(title: AgencyProfileEditConstants.EditAgencyProfileViewController.navigationRightButtonText,
                                      style: UIBarButtonItemStyle.Plain,
                                      target: self,
                                      action: #selector(popThisViewController))
    
    let fontForButtonItem =  UIFont(name: "SFUIText-Regular",
                                    size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    
    let attributesDict: [String:AnyObject] = [NSFontAttributeName: fontForButtonItem!,
                                              NSForegroundColorAttributeName: UIColor.whiteColor()
    ]
    
    rightButton.setTitleTextAttributes(attributesDict, forState: .Normal)
    
    self.navigationItem.rightBarButtonItem = rightButton
    
  }
  
  private func addSomeGestures() {
    
    let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyboard))
    tapGesture.numberOfTapsRequired = 1
    
    self.view.addGestureRecognizer(tapGesture)
    
  }
  
  override func viewDidLoad() {
    
//    let savedPhotoAndSavedName = NSUserDefaults.standardUserDefaults().boolForKey(UtilityManager.sharedInstance.kSavedPhotoAndSavedName + UserSession.session.email)
//    
//    if savedPhotoAndSavedName == false {
//      
//      let welcomeScreen = WelcomeScreenTutorialView.init(frame: CGRect.init())
//      let rootViewController = UtilityManager.sharedInstance.currentViewController()
//      rootViewController.view.addSubview(welcomeScreen)
//      
//    }
    
    self.createAndAddFlipCard()
    self.createSaveChangesButton()
    
  }
  
  private func createAndAddFlipCard() {
    
    let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
    let heightOfCard = self.view.frame.size.height - (136.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let frameForFlipCard = CGRect.init(x: (40.0 * UtilityManager.sharedInstance.conversionWidth),
                                       y: (108.0 * UtilityManager.sharedInstance.conversionHeight),
                                       width: widthOfCard,
                                       height: heightOfCard)
    
    let frameForViewsOfCard = CGRect.init(x: 0.0, y: 0.0, width: widthOfCard, height: heightOfCard)
    
    //createTheFrontCard
    self.createFrontViewForFlipCard(frameForViewsOfCard)
    
    //createTheBackCard
    let blankView = UIView.init(frame:frameForViewsOfCard)
    
    flipCard = FlipCardView.init(frame: frameForFlipCard, viewOne: scrollViewFrontFlipCard, viewTwo: blankView)
    self.createButtonsForFlipCard()
    
    self.view.addSubview(flipCard )
    
  }
  
  private func createFrontViewForFlipCard(frameForCards: CGRect) {
    
    let contentSizeOfScrollView = CGSize.init(width: frameForCards.size.width * CGFloat(kNumberOfCardsInScrollViewMinusOne + 1),
                                              height: frameForCards.size.height)
    
    scrollViewFrontFlipCard = UIScrollView.init(frame: frameForCards)
    scrollViewFrontFlipCard.contentSize = contentSizeOfScrollView
    scrollViewFrontFlipCard.scrollEnabled = false
    //    scrollViewFrontFlipCard.directionalLockEnabled = true
    //    scrollViewFrontFlipCard.alwaysBounceHorizontal = false
    //    scrollViewFrontFlipCard.alwaysBounceVertical = false
    //    scrollViewFrontFlipCard.pagingEnabled = true
    
    //------------------------------------------SCREENS
    
    editProfile = EditCompanyProfileView.init(frame: frameForCards)
//    editProfile.delegate = self
    
    editConflicts = EditConflictsView.init(frame: CGRect.init(x: frameForCards.size.width,
      y: 0.0 ,
      width: frameForCards.size.width,
      height: frameForCards.size.height))
    
    scrollViewFrontFlipCard.addSubview(editProfile)
    scrollViewFrontFlipCard.addSubview(editConflicts)
    
  }
  
  private func createButtonsForFlipCard() {
    leftButton = nil
    rightButton = nil
    
    
    let sizeForButtons = CGSize.init(width: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 49.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let frameForLeftButton = CGRect.init(x: 23.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: 24.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: sizeForButtons.width,
                                         height:sizeForButtons.height)
    
    let frameForRightButton = CGRect.init(x: 235.0 * UtilityManager.sharedInstance.conversionWidth,
                                          y: 24.0 * UtilityManager.sharedInstance.conversionHeight,
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
      
    } else
      if actualPage == kNumberOfCardsInScrollViewMinusOne {
        
        self.hideRightButtonOfMainScrollView()
        
    }
    
    flipCard.addSubview(leftButton)
    flipCard.addSubview(rightButton)
    
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

  private func createSaveChangesButton() {
    
    if saveChangesButton != nil {
      
      saveChangesButton = nil
      
    }
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let colorWhenPressed = UIColor.greenColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: AgencyProfileEditConstants.EditAgencyProfileViewController.saveChangesButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    let stringWithFormatWhenpressed = NSMutableAttributedString(
      string: AgencyProfileEditConstants.EditAgencyProfileViewController.saveChangesButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: colorWhenPressed
      ]
    )
    
    let frameForButton = CGRect.init(x: 0.0,
                                     y: self.flipCard.frame.size.height - (70.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: self.flipCard.frame.size.width,
                                     height: (70.0 * UtilityManager.sharedInstance.conversionHeight))
    saveChangesButton = UIButton.init(frame: frameForButton)
    saveChangesButton.addTarget(self,
                                action: #selector(saveChangesButtonPressed),
                                forControlEvents: .TouchUpInside)
    saveChangesButton.backgroundColor = UIColor.blackColor()
    saveChangesButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    saveChangesButton.setAttributedTitle(stringWithFormatWhenpressed, forState: .Highlighted)
    
    self.flipCard.addSubview(saveChangesButton)
    
    if actualPage == 4 {
      
      self.saveChangesButton.alpha = 0.0
      
    }
    
  }
  
  @objc private func saveChangesButtonPressed() {
    
    self.requestToEveryScreenToSave(){
      
//      self.criteriaView.thereAreChanges = false
//      self.participateView.thereAreChanges = false
//      self.exclusiveView.thereAreChanges = false
//      self.skillsView.thereAreChanges = false
//      self.profileView.thereAreChanges = false
      
    }
    
  }
  
  @objc private func requestToEveryScreenToSave(actionsToMakeAfterExecuting: () -> Void) {
    //this for every screen
    
//    let savedPhotoAndSavedName = NSUserDefaults.standardUserDefaults().boolForKey(UtilityManager.sharedInstance.kSavedPhotoAndSavedName + UserSession.session.email)
//    
//    if savedPhotoAndSavedName == false && profileView.isAgencyNameAndAgencyImageWithInfo() == false {
//      
//      self.showMessageOfMandatoryInfo()
//      
//    } else {
//      
//      self.criteriaView.saveCriterionsSelected()
//      
//      self.exclusiveView.requestToSaveNewBrands()
//      
//      //Profile Data and Participe In
//      let valuesFromParticipateView = self.participateView.getTheValuesSelected()
//      
//      self.profileView.saveChangesOfAgencyProfile(valuesFromParticipateView, actionsToMakeAfterExecution: {
//        actionsToMakeAfterExecuting()
//        
//        NSUserDefaults.standardUserDefaults().setBool(true, forKey: UtilityManager.sharedInstance.kSavedPhotoAndSavedName + UserSession.session.email)
//        
//      })
//  
//    }
    
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
  
  private func createGradientView() -> GradientView{
    
    let frameForView = CGRect.init(x: 0.0, y: 60.0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height - 60.0)
    
    let firstColorGradient = UIColor.init(red: 214.0/255.0, green: 240.0/255.0, blue: 96.0/255.0, alpha: 1.0)
    let secondColorGradient = UIColor.init(red: 40.0/255.0, green: 255.0/255.0, blue: 141.0/255.0, alpha: 1.0)
    let colorsForBackground = [firstColorGradient,secondColorGradient]
    
    return GradientView.init(frame: frameForView, arrayOfcolors: colorsForBackground, typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
    
  }
  
  @objc private func popThisViewController() {
    
    self.requestToShowTabBar()
    self.navigationController?.popViewControllerAnimated(true)
    
  }
  
  private func requestToShowTabBar() {
    
    self.delegate?.requestToShowTabBarFromEditCompanyProfileViewControllerDelegate()
    
  }
  
  @objc private func dismissKeyboard() {
    
    self.view.endEditing(true)
    
  }
  
}
