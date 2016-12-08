//
//  VisualizeAllPitchesForNormalClientViewController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 12/7/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol VisualizeAllPitchesForNormalClientViewControllerShowAndHideDelegate {
  
  func requestToDisolveTabBarFromVisualizeAllPitchesForNormalClientViewControllerDelegate()
  func requestToConcentrateTabBarFromVisualizeAllPitchesForNormalClientViewControllerDelegate()
  
  func requestToHideTabBarFromVisualizeAllPitchesForNormalClientViewControllerDelegate()
  func requestToShowTabBarFromVisualizeAllPitchesForNormalClientViewControllerDelegate()
  
}

class VisualizeAllPitchesForNormalClientViewController: UIViewController, UITextFieldDelegate, iCarouselDelegate, iCarouselDataSource {
  
  private var mainCarousel: iCarousel! = nil
  private var frontCard: UIView! = nil
  private var searchView: CustomTextFieldWithTitleView! = nil
  private var arrayOfPitchesByUser = [PitchEvaluationByUserModelDataForCompany]()
  private var arrayOfPitchesByUserWithoutModifications = [PitchEvaluationByUserModelDataForCompany]()
  
  var delegateForShowAndHideTabBar: VisualizeAllPitchesForNormalClientViewControllerShowAndHideDelegate?
  
  
  override func loadView() {
    
    self.view = UIView.init(frame: UIScreen.mainScreen().bounds)
    self.view.backgroundColor = UIColor.blackColor()
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.view.addSubview(self.createGradientView())
    self.changeNavigationBarTitle()
    self.changeNavigationRigthButtonItem()
    self.createSearchView()
    self.requestForAllPitchesAndTheirEvaluations()
    
//    self.createFilterButton()
//    self.createAddPitchButton()
//    self.createArchiveButton()
//    self.createArchiveLabel()
    
//    self.requestForAllPitchesAndTheirEvaluations()
//    
//    let notToShowPitchesTutorial = NSUserDefaults.standardUserDefaults().boolForKey(UtilityManager.sharedInstance.kNotToShowPitchesTutorial + UserSession.session.email)
//    
//    if notToShowPitchesTutorial == false {
//      
//      let tutorialPitches = PitchesTutorialView.init(frame: CGRect.init())
//      let rootViewController = UtilityManager.sharedInstance.currentViewController()
//      rootViewController.view.addSubview(tutorialPitches)
//      
    }
  
  private func changeNavigationBarTitle() {
    
    let titleLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 17.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.VisualizeAllPitchesViewController.navigationBarTitleText,
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
  
  private func createSearchView() {
    
    let frameForSearchView = CGRect.init(x: 78.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: 70.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                         height: 60.0 * UtilityManager.sharedInstance.conversionHeight)
    
    searchView = CustomTextFieldWithTitleView.init(frame: frameForSearchView,
                                                   title: nil,
                                                   image: "smallSearchIcon")
    searchView.backgroundColor = UIColor.clearColor()
    searchView.mainTextField.tag = -8888
    searchView.mainTextField.delegate = self
    
    self.view.addSubview(searchView)
    
  }
  
  private func requestForAllPitchesAndTheirEvaluations() {
    
    //ask to server for the info
    
    
    RequestToServerManager.sharedInstance.requestToGetAllPitchEvaluationByUser { (pitchEvaluationsByUser, pitchesForCompany) in
      
      if pitchesForCompany != nil {
        
        self.arrayOfPitchesByUser = pitchesForCompany!
        self.arrayOfPitchesByUserWithoutModifications = pitchesForCompany!
        
        self.createMainCarousel()
        
      }
      
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    let newElement = PitchEvaluationByUserModelData.init(newPitchEvaluationId: "-8888",
//                                                         newPitchId: "-8888",
//                                                         newPitchName: "Pitch name",
//                                                         newBriefDate: "-8888",
//                                                         newScore: -8888,
//                                                         newBrandName: "Brand name",
//                                                         newCompanyName: "Company name",
//                                                         newOtherScores: [Int](),
//                                                         newArrayOfEvaluationPitchSkillCategory: [EvaluationPitchSkillCategoryModelData](),
//                                                         newWasWon: false,
//                                                         newPitchStatus: -1,
//                                                         newEvaluationStatus: false,
//                                                         newHasResults: false,
//                                                         newHasPitchWinnerSurvey: false,
//                                                         newPitchResultsId: "-8888")
//    
//    arrayOfPitchesByUser.append(newElement)
//    arrayOfPitchesByUserWithoutModifications.append(newElement)
    
    
    
  }
  
  private func createMainCarousel() {
    
    let frameForCarousel = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                       y: 145.0 * UtilityManager.sharedInstance.conversionHeight,
                                       width: UIScreen.mainScreen().bounds.width,
                                       height: 464.0 * UtilityManager.sharedInstance.conversionHeight)
    
    mainCarousel = iCarousel.init(frame: frameForCarousel)
    mainCarousel.scrollSpeed = 0.5
    mainCarousel.type = .Rotary
    mainCarousel.backgroundColor = UIColor.clearColor()
    mainCarousel.delegate = self
    mainCarousel.dataSource = self
    mainCarousel.alpha = 1.0
    self.view.addSubview(mainCarousel)
    
  }
  
  //MARK: - iCarouselDelegates
  
  func carousel(carousel: iCarousel, shouldSelectItemAtIndex index: Int) -> Bool {
    return false
  }
  
  func numberOfItemsInCarousel(carousel: iCarousel) -> Int {
    
    return arrayOfPitchesByUser.count
    
  }
  
  func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView {
    
    var genericCard: PitchCardForNormalClientView
    
    if view == nil {
      
      let frameForNewView = CGRect.init(x: 0.0,
                                        y: 0.0,
                                        width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 454.0 * UtilityManager.sharedInstance.conversionHeight)
      
      genericCard = PitchCardForNormalClientView.init(frame: frameForNewView,
                                               newPitchData: arrayOfPitchesByUser[index])
      
//      genericCard = PitchCardView.init(frame: frameForNewView)
//      genericCard.delegate = self
      
    }else{
      
      if view as? PitchCardForNormalClientView != nil {
        
        genericCard = view as! PitchCardForNormalClientView
        
      } else {
      
//        let newElement = PitchEvaluationByUserModelData.init(newPitchEvaluationId: "-8888",
//                                                             newPitchId: "-8888",
//                                                             newPitchName: "Pitch name",
//                                                             newBriefDate: "-8888",
//                                                             newScore: -8888,
//                                                             newBrandName: "Brand name",
//                                                             newCompanyName: "Company name",
//                                                             newOtherScores: [Int](),
//                                                             newArrayOfEvaluationPitchSkillCategory: [EvaluationPitchSkillCategoryModelData](),
//                                                             newWasWon: false,
//                                                             newPitchStatus: -1,
//                                                             newEvaluationStatus: false,
//                                                             newHasResults: false,
//                                                             newHasPitchWinnerSurvey: false,
//                                                             newPitchResultsId: "-8888")
        
        let pitchData = arrayOfPitchesByUser[index]
        
        let frameForNewView = CGRect.init(x: 0.0,
                                          y: 0.0,
                                          width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                                          height: 454.0 * UtilityManager.sharedInstance.conversionHeight)
        
        genericCard = PitchCardForNormalClientView.init(frame: frameForNewView,
                                                        newPitchData: pitchData)
      
      }
      
    }
  
//    let pitchData = arrayOfPitchesByUser[index]
  
    return genericCard
    
  }
  
  func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat
  {
    
    if arrayOfPitchesByUser.count > 0 && arrayOfPitchesByUser.count < 5 {
      
      mainCarousel.scrollSpeed = 0.2
      
    }else{
      
      mainCarousel.scrollSpeed = 0.5
      
    }
    
    if option == .Spacing {
      
      if arrayOfPitchesByUser.count > 0 && arrayOfPitchesByUser.count < 5 {
        
        return 1.55 * value
        
      }else{
        
        return 1.05 * value
        
      }
      
    }
    
    if option == .Radius {
      
      if arrayOfPitchesByUser.count > 0 && arrayOfPitchesByUser.count < 5 {
        
        return 1.51 * value
        
      }else{
        
        return 1.1 * value
        
      }
      
    }
    
    if option == .Arc {
      
      if arrayOfPitchesByUser.count > 0 && arrayOfPitchesByUser.count < 5 {
        
        return 0.65 * value
        
      }else{
        
        return 0.65 * value
        
      }
      
    }
    
    return value
    
  }
  
  func carouselDidEndScrollingAnimation(carousel: iCarousel) {
    
//    let possibleFrontCard = carousel.itemViewAtIndex(carousel.currentItemIndex)
//    
//    if possibleFrontCard != nil && possibleFrontCard as? PitchCardView != nil{
//      
//      frontCard = possibleFrontCard! as! PitchCardView
//      frontCard.isCardDown = false
//      frontCard.animateGraph()
//      
//      UIView.animateWithDuration(0.35,
//                                 animations: {
//                                  
//                                  self.frontCard.layer.shadowColor = UIColor.blackColor().CGColor
//                                  self.frontCard!.layer.shadowOpacity = 0.25
//                                  self.frontCard!.layer.shadowOffset = CGSizeZero
//                                  self.frontCard!.layer.shadowRadius = 5
//                                  
//        }, completion: { (finished) in
//          if finished == true {
//            
//            self.frontCard.userInteractionEnabled = true
//            
//          }
//      })
//      
//    }else
//      if possibleFrontCard != nil && possibleFrontCard as? PendingEvaluationCardView != nil {
//        
//        pendingEvaluationFrontCard = possibleFrontCard as! PendingEvaluationCardView
//        
//        UIView.animateWithDuration(0.35,
//                                   animations: {
//                                    
//                                    self.pendingEvaluationFrontCard.layer.shadowColor = UIColor.blackColor().CGColor
//                                    self.pendingEvaluationFrontCard!.layer.shadowOpacity = 0.25
//                                    self.pendingEvaluationFrontCard!.layer.shadowOffset = CGSizeZero
//                                    self.pendingEvaluationFrontCard!.layer.shadowRadius = 5
//                                    
//          }, completion: { (finished) in
//            if finished == true {
//              
//              self.pendingEvaluationFrontCard.userInteractionEnabled = true
//              
//            }
//        })
//        
//    }
    
  }
  
  func carouselWillBeginDragging(carousel: iCarousel) {
    
//    if frontCard != nil {
//      
//      frontCard.userInteractionEnabled = false
//      
//      UIView.animateWithDuration(0.35){
//        
//        self.frontCard.layer.shadowColor = UIColor.clearColor().CGColor
//        self.frontCard!.layer.shadowOpacity = 0.0
//        self.frontCard!.layer.shadowOffset = CGSizeZero
//        self.frontCard!.layer.shadowRadius = 0
//        
//      }
//      
//    }
//    
//    if pendingEvaluationFrontCard != nil {
//      
//      pendingEvaluationFrontCard.userInteractionEnabled = false
//      
//      UIView.animateWithDuration(0.35,
//                                 animations: { 
//                                  
//                                  self.pendingEvaluationFrontCard.layer.shadowColor = UIColor.clearColor().CGColor
//                                  self.pendingEvaluationFrontCard!.layer.shadowOpacity = 0.0
//                                  self.pendingEvaluationFrontCard!.layer.shadowOffset = CGSizeZero
//                                  self.pendingEvaluationFrontCard!.layer.shadowRadius = 0
//                                  
//        }, completion: { (finished) in
//          if finished == true {
//            
//            self.pendingEvaluationFrontCard = nil
//            
//          }
//      })
//      
//    }
    
  }
  
  
  
  
  
  
  
  
  
  
  
  //MARK: UITextFieldDelegate
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    
    if textField.tag == -8888 {
      
      //look for pitch
      
    }
    
    return true
    
  }
  
  private func createGradientView() -> GradientView{
      
      let frameForView = CGRect.init(x: 0.0, y: 60.0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height - 60.0)
      
      let firstColorGradient = UIColor.init(red: 145.0/255.0, green: 243.0/255.0, blue: 255.0/255.0, alpha: 1.0)
      let secondColorGradient = UIColor.init(red: 223.0/255.0, green: 255.0/255.0, blue: 117.0/255.0, alpha: 1.0)
      let colorsForBackground = [firstColorGradient,secondColorGradient]
      
      return GradientView.init(frame: frameForView, arrayOfcolors: colorsForBackground, typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
      
    }
    
}
