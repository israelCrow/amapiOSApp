//
//  VisualizeAllPitchesViewController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/8/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol VisualizeAllPitchesViewControllerShowAndHideDelegate {
  
  func requestToDisolveTabBarFromVisualizeAllPitchesViewControllerDelegate()
  func requestToConcentrateTabBarFromVisualizeAllPitchesViewControllerDelegate()
  
  func requestToHideTabBarFromVisualizeAllPitchesViewControllerDelegate()
  func requestToShowTabBarFromVisualizeAllPitchesViewControllerDelegate()
  
}

class VisualizeAllPitchesViewController: UIViewController, iCarouselDelegate, iCarouselDataSource, NoPitchAssignedViewDelegate, CreateAddNewPitchAndWriteCompanyNameViewControllerDelegate, PitchCardViewDelegate, DetailPitchViewDelegate, CanceledPitchEvaluationViewDelegate, ArchivedPitchEvaluationViewDelegate, DeletedPitchEvaluationViewDelegate, DeclinedPitchEvaluationViewDelegate, LookForPitchCardViewDelegate, FilterPitchCardViewDelegate, PendingEvaluationCardViewDelegate {
  
  private var mainCarousel: iCarousel! = nil
  
  private var searchButton: UIButton! = nil
  private var filterButton: UIButton! = nil
  private var arrayOfPitchesByUser = [PitchEvaluationByUserModelData]()
  private var arrayOfPitchesByUserWithoutModifications = [PitchEvaluationByUserModelData]()
  private var frontCard: PitchCardView! = nil
  private var pendingEvaluationFrontCard: PendingEvaluationCardView! = nil
  private var mainDetailPitchView: DetailPitchView! = nil
  private var detailNavigationBar: DetailedNavigationEvaluatPitchView! = nil
  
  private var pitchEvaluationIDToLookForAfterCreated: String = "-1"
  private var isSecondTimeAppearing: Bool = false
  private var isShowingAMessageCard: Bool = false
  private var isComingFromAddResultsController: Bool = false
  
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
    self.createSearchButton()
    self.createFilterButton()
    
    self.requestForAllPitchesAndTheirEvaluations()
    
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
    
    let rightButton = UIBarButtonItem(title: VisualizePitchesConstants.VisualizeAllPitchesViewController.navigationRightButtonText,
                                      style: UIBarButtonItemStyle.Plain,
                                      target: self,
                                      action: #selector(showInfo))
    
    let fontForButtonItem =  UIFont(name: "SFUIText-Regular",
                                    size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    
    let attributesDict: [String:AnyObject] = [NSFontAttributeName: fontForButtonItem!,
                                              NSForegroundColorAttributeName: UIColor.whiteColor()
    ]
    
    rightButton.setTitleTextAttributes(attributesDict, forState: .Normal)
    
    self.navigationItem.rightBarButtonItem = rightButton
    
  }
  
  private func createSearchButton() {
    
    let frameForButton = CGRect.init(x: 16.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 92.0 * UtilityManager.sharedInstance.conversionHeight,
                                 width: 25.0 * UtilityManager.sharedInstance.conversionWidth,
                                height: 25.0 * UtilityManager.sharedInstance.conversionHeight)
    
    searchButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "searchIcon") as UIImage?
    searchButton.setImage(image, forState: .Normal)
    searchButton.tag = 1
    searchButton.addTarget(self, action: #selector(searchButtonPressed), forControlEvents:.TouchUpInside)
    
    self.view.addSubview(searchButton)
    
  }
  
  
  private func createFilterButton() {
    
    let frameForButton = CGRect.init(x: 334.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 94.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 25.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 21.0 * UtilityManager.sharedInstance.conversionHeight)
    
    filterButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "iconNavBarFilters") as UIImage?
    filterButton.setImage(image, forState: .Normal)
    filterButton.tag = 1
    filterButton.addTarget(self, action: #selector(filterButtonPressed), forControlEvents:.TouchUpInside)
    
    self.view.addSubview(filterButton)
    
  }
  
  private func createCarousel() {
    
    let frameForCarousel = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                       y: 120.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: UIScreen.mainScreen().bounds.width,
                                  height: 464.0 * UtilityManager.sharedInstance.conversionHeight)
    
    mainCarousel = iCarousel.init(frame: frameForCarousel)
    mainCarousel.type = .Rotary
    mainCarousel.backgroundColor = UIColor.clearColor()
    mainCarousel.delegate = self
    mainCarousel.dataSource = self
    self.view.addSubview(mainCarousel)
    
  }
  
  private func requestForAllPitchesAndTheirEvaluations() {
    
    UtilityManager.sharedInstance.showLoader()
    
    RequestToServerManager.sharedInstance.requestToGetAllPitchEvaluationByUser { (pitchEvaluationsByUser) in
      
      self.arrayOfPitchesByUser = pitchEvaluationsByUser
      self.arrayOfPitchesByUserWithoutModifications = pitchEvaluationsByUser
      
      if self.arrayOfPitchesByUser.count == 0 {
        
        self.createAndAddNoPitchesAssignedView()
        
      }else{
        
        if self.mainCarousel == nil {
        
          self.createCarousel()
          
        }
    
        self.mainCarousel.reloadData()
        if self.pitchEvaluationIDToLookForAfterCreated != "-1" && Int(self.pitchEvaluationIDToLookForAfterCreated) > 0 {
          
          self.lookForThisPitchID(self.pitchEvaluationIDToLookForAfterCreated)
          self.pitchEvaluationIDToLookForAfterCreated = "-1"
          
        }
        
      }
      
      
      UtilityManager.sharedInstance.hideLoader()
      
    }
    
    
    
  }
  
  private func createGradientView() -> GradientView{
    
    let frameForView = CGRect.init(x: 0.0, y: 60.0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height - 60.0)
    
    let firstColorGradient = UIColor.init(red: 242.0/255.0, green: 242.0/255.0, blue: 2555.0/255.0, alpha: 1.0)
    let secondColorGradient = UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
    let colorsForBackground = [firstColorGradient,secondColorGradient]
    
    return GradientView.init(frame: frameForView, arrayOfcolors: colorsForBackground, typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
    
  }
  
  private func createAndAddNoPitchesAssignedView() {
    
    let positionForNoPitchesView = CGPoint.init(x: 40.0 * UtilityManager.sharedInstance.conversionWidth,
                                                y: 133.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let noPitchesAssignedView = NoPitchAssignedView.init(position: positionForNoPitchesView)
    noPitchesAssignedView.delegate = self
    self.view.addSubview(noPitchesAssignedView)
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
    
    if isComingFromAddResultsController == true {
    
      isComingFromAddResultsController = false
      
    }else{
      
      self.delegateForShowAndHideTabBar?.requestToShowTabBarFromVisualizeAllPitchesViewControllerDelegate()
    
    }
    
    if isSecondTimeAppearing == false {
      
      isSecondTimeAppearing = true
      
    } else {
      
      if isShowingAMessageCard == false {
       
        requestForAllPitchesAndTheirEvaluations()
      
      } else {
        
        if mainCarousel != nil {
          
          mainCarousel.scrollEnabled = false
          
        }
        
      }
      
    }
    
  }
  
  func changePitchEvaluationIDToLookForAfterCreated(newPitchEvaluationToLookFor: String) {
    
    pitchEvaluationIDToLookForAfterCreated = newPitchEvaluationToLookFor
    
  }
  
  @objc private func searchButtonPressed() {
  
    if mainCarousel != nil {
      
      isShowingAMessageCard = true
      
      searchButton.userInteractionEnabled = false
      searchButton.enabled = false
      filterButton.userInteractionEnabled = false
      filterButton.enabled = false
      mainCarousel.scrollEnabled = false
      
      let newElement = PitchEvaluationByUserModelData.init(newPitchEvaluationId: "-9999",
        newPitchId: "-9999",
        newPitchName: "qwertyytrewqqwertyytrewq",
        newBriefDate: "-9999",
        newScore: -9999,
        newBrandName: "-9999",
        newCompanyName: "-9999",
        newOtherScores: [Int](),
        newArrayOfEvaluationPitchSkillCategory: [EvaluationPitchSkillCategoryModelData](),
        newWasWon: false,
        newPitchStatus: -1,
        newEvaluationStatus: false)
      
      let actualIndex = mainCarousel.currentItemIndex
      self.arrayOfPitchesByUser.insert(newElement, atIndex: actualIndex)
      mainCarousel.insertItemAtIndex(actualIndex, animated: true)
      
    }
  
  }
  
  @objc private func filterButtonPressed() {
    
    if mainCarousel != nil {
      
      isShowingAMessageCard = true
      
      searchButton.userInteractionEnabled = false
      searchButton.enabled = false
      filterButton.userInteractionEnabled = false
      filterButton.enabled = false
      mainCarousel.scrollEnabled = false
      
      let newElement = PitchEvaluationByUserModelData.init(newPitchEvaluationId: "-8888",
        newPitchId: "-8888",
        newPitchName: "qwertyytrewqqwertyytrewq",
        newBriefDate: "-8888",
        newScore: -8888,
        newBrandName: "-8888",
        newCompanyName: "-8888",
        newOtherScores: [Int](),
        newArrayOfEvaluationPitchSkillCategory: [EvaluationPitchSkillCategoryModelData](),
        newWasWon: false,
        newPitchStatus: -1,
        newEvaluationStatus: false)
      
      let actualIndex = mainCarousel.currentItemIndex
      self.arrayOfPitchesByUser.insert(newElement, atIndex: actualIndex)
      mainCarousel.insertItemAtIndex(actualIndex, animated: true)
      
    }
    
  }
  
  @objc private func showInfo() {
    
    
  }
  
  //MARK: - NoPitchAssignedViewDelegate
  
  func pushCreateAddNewPitchAndWriteBrandNameViewController() {
    
    self.delegateForShowAndHideTabBar?.requestToHideTabBarFromVisualizeAllPitchesViewControllerDelegate()
    
    let createAddNewPitch = CreateAddNewPitchAndWriteCompanyNameViewController()
    createAddNewPitch.delegateForShowTabBar = self
    self.navigationController?.pushViewController(createAddNewPitch, animated: true)
    
  }
  
  //MARK: - CreateAddNewPitchAndWriteCompanyNameViewControllerDelegate
  
  func requestToShowTabBarFromCreateAddNewPitchAndWriteCompanyNameViewControllerDelegate() {
    
    self.delegateForShowAndHideTabBar?.requestToShowTabBarFromVisualizeAllPitchesViewControllerDelegate()
    
  }
  
  //MARK: - PitchCardViewDelegate
  
  func pushCreateAddNewPitchAndWriteBrandNameViewControllerFromPitchCard() {
    
    self.delegateForShowAndHideTabBar?.requestToHideTabBarFromVisualizeAllPitchesViewControllerDelegate()
    
    let createAddNewPitch = CreateAddNewPitchAndWriteCompanyNameViewController()
    createAddNewPitch.delegateForShowTabBar = self
    self.navigationController?.pushViewController(createAddNewPitch, animated: true)
    
  }
  
  func createAndShowDetailedPitchView() {
    
    self.navigationItem.rightBarButtonItem?.enabled = false
    mainCarousel.userInteractionEnabled = false
    frontCard.userInteractionEnabled = false
    
    let pitchEvaluationData = frontCard.getPitchEvaluationByUserData()
    let copyGraphInUse = self.makeACopyOfActualGraph()
    copyGraphInUse.animateGraph()
    copyGraphInUse.alpha = 0.0
    
    self.createDetailNavigationBar()
    
    if mainDetailPitchView == nil {
      
      let frameForMainDetailPitchView = UIScreen.mainScreen().bounds
      mainDetailPitchView = DetailPitchView.init(frame: frameForMainDetailPitchView,
                                          newPitchData: pitchEvaluationData,
                                          newGraphPart: copyGraphInUse)
      
      let heightOfDetailNavigationBar = (self.navigationController?.navigationBar.frame.size.height)! + (103.0 * UtilityManager.sharedInstance.conversionHeight) + UIApplication.sharedApplication().statusBarFrame.size.height

      mainDetailPitchView.changeFrameOfContainerView(heightOfDetailNavigationBar)
      mainDetailPitchView.backgroundColor = UIColor.clearColor()
      mainDetailPitchView.userInteractionEnabled = true
      mainDetailPitchView.delegate = self
      self.view.addSubview(mainDetailPitchView)
      
    } else {
  
      mainDetailPitchView.alpha = 1.0
      mainDetailPitchView.reloadDataAndInterface(pitchEvaluationData,
                                                  newGraphPart: copyGraphInUse)
      mainDetailPitchView.backgroundColor = UIColor.clearColor()
      mainDetailPitchView.userInteractionEnabled = true
      
    }
    
    self.delegateForShowAndHideTabBar?.requestToDisolveTabBarFromVisualizeAllPitchesViewControllerDelegate()
    mainDetailPitchView.animateShowPitchEvaluationDetail()
    self.animateShowingDetailPitchView()
    NSTimer.scheduledTimerWithTimeInterval(0.75, target: self, selector: #selector(changeRightButtonOfNavigationBarWhenDetailPitchViewIsShown), userInfo: nil, repeats: false)
    
  }
  
  private func makeACopyOfActualGraph() -> GraphPartPitchCardView {
  
    let globalPoint = frontCard.getGraphPart().convertPoint(frontCard.getGraphPart().frame.origin, toView: UIApplication.sharedApplication().delegate!.window!)
    
    let frameForGraphPart = CGRect.init(x: globalPoint.x,
                                        y: 0.0,
                                    width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 347.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let arrayOfQualifications: [Int] = [frontCard.getPitchEvaluationByUserData().score]
    let arrayOfAgencyNames: [String] = [AgencyModel.Data.name]
    
    return GraphPartPitchCardView.init(frame: frameForGraphPart,
                                            newArrayOfQualifications: arrayOfQualifications,
                                            newArrayOfAgencyNames: arrayOfAgencyNames)
    
  }
  
  private func createDetailNavigationBar() {
    
    if detailNavigationBar != nil {
      
      detailNavigationBar.removeFromSuperview()
      detailNavigationBar = nil
      
    }
    
    let frameForDetailedNav = CGRect.init(x: 0.0,
                                          y: -100.0 * UtilityManager.sharedInstance.conversionHeight,
                                          width: self.view.frame.size.width,
                                          height: 108.0 * UtilityManager.sharedInstance.conversionHeight)
   
    detailNavigationBar = DetailedNavigationEvaluatPitchView.init(frame: frameForDetailedNav,
      newProjectName: frontCard.getPitchEvaluationByUserData().pitchName,
      newBrandName: frontCard.getPitchEvaluationByUserData().brandName,
      newCompanyName: frontCard.getPitchEvaluationByUserData().companyName,
      newDateString: frontCard.getPitchEvaluationByUserData().briefDate)
    
    
    self.navigationController?.navigationBar.addSubview(detailNavigationBar)
    
  }
  
  private func animateShowingDetailPitchView() {
    
    let newFrameForDetailedNav = CGRect.init(x: 0.0,
    y: (self.navigationController?.navigationBar.frame.size.height)!,
                                         width: detailNavigationBar.frame.size.width,
                                        height: detailNavigationBar.frame.size.height)
    
    UIView.animateWithDuration(
      0.25,
      delay: 0.0,
      usingSpringWithDamping: 0.8,
      initialSpringVelocity: 8.0,
      options: .BeginFromCurrentState,
      animations: { () -> Void in
        
        self.detailNavigationBar.frame = newFrameForDetailedNav
        
    }) { (completed:Bool) -> Void in
      
      
    }

  }
  
  private func animateHiddingDetailPitchView() {
    
    NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(changeValuesWhenDetailPitchViewHidden), userInfo: nil, repeats: false)
    
    let newFrameForDetailedNav = CGRect.init(x: 0.0,
                                             y: -150.0 * UtilityManager.sharedInstance.conversionHeight,
                                             width: detailNavigationBar.frame.size.width,
                                             height: detailNavigationBar.frame.size.height)
    
    UIView.animateWithDuration(
      0.35,
      delay: 0.0,
      usingSpringWithDamping: 0.8,
      initialSpringVelocity: 8.0,
      options: .BeginFromCurrentState,
      animations: { () -> Void in
        
        self.detailNavigationBar.frame = newFrameForDetailedNav
        
    }) { (completed:Bool) -> Void in
      
        self.detailNavigationBar.removeFromSuperview()
      
    }
    
  }
  
  @objc private func changeValuesWhenDetailPitchViewHidden() {
    
    mainCarousel.userInteractionEnabled = true
    frontCard.userInteractionEnabled = true
    
  }
  
  @objc private func changeRightButtonOfNavigationBarWhenDetailPitchViewIsShown() {
    
    let rightButton = UIBarButtonItem(title: VisualizePitchesConstants.VisualizeAllPitchesViewController.navigationRightButtonWhenDetailPitchViewIsShownText,
                                      style: UIBarButtonItemStyle.Plain,
                                      target: self,
                                      action: #selector(hideDetailPitchView))
    
    let fontForButtonItem =  UIFont(name: "SFUIText-Regular",
                                    size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    
    let attributesDict: [String:AnyObject] = [NSFontAttributeName: fontForButtonItem!,
                                              NSForegroundColorAttributeName: UIColor.whiteColor()
    ]
    
    rightButton.setTitleTextAttributes(attributesDict, forState: .Normal)
    
    self.navigationItem.setRightBarButtonItem(rightButton, animated: true)
    
  }
  
  private func changeRightButtonOfNavigationBarWhenDetailPitchViewIsHidden() {
    
    let rightButton = UIBarButtonItem(title: VisualizePitchesConstants.VisualizeAllPitchesViewController.navigationRightButtonText,
                                      style: UIBarButtonItemStyle.Plain,
                                      target: self,
                                      action: #selector(showInfo))
    
    let fontForButtonItem =  UIFont(name: "SFUIText-Regular",
                                    size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    
    let attributesDict: [String:AnyObject] = [NSFontAttributeName: fontForButtonItem!,
                                              NSForegroundColorAttributeName: UIColor.whiteColor()
    ]
    
    rightButton.setTitleTextAttributes(attributesDict, forState: .Normal)
    
    self.navigationItem.setRightBarButtonItem(rightButton, animated: true)
    
  }
  
  @objc private func hideDetailPitchView() {
    
    self.changeRightButtonOfNavigationBarWhenDetailPitchViewIsHidden()
    
    self.delegateForShowAndHideTabBar?.requestToConcentrateTabBarFromVisualizeAllPitchesViewControllerDelegate()
    
    if mainDetailPitchView != nil {
    
      mainDetailPitchView.animateHiddingPitchEvaluationDetail()
      
    }
    
    self.animateHiddingDetailPitchView()
    
    mainCarousel.userInteractionEnabled = true
    
    mainDetailPitchView.alpha = 0.0
    
  }
  
  //MARK: - iCarouselDelegates
  
  func carousel(carousel: iCarousel, shouldSelectItemAtIndex index: Int) -> Bool {
    return false
  }
  
  func numberOfItemsInCarousel(carousel: iCarousel) -> Int {
    
    return arrayOfPitchesByUser.count
    
  }
  
  func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView {
    
    var genericCard = PitchCardView()
    
    if view == nil {
      
      let frameForNewView = CGRect.init(x: 0.0,
                                        y: 0.0,
                                    width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 454.0 * UtilityManager.sharedInstance.conversionHeight)
      
      genericCard = PitchCardView.init(frame: frameForNewView)
      genericCard.delegate = self
      
    }else{
      
      if view as? PitchCardView != nil {
      
        genericCard = view as! PitchCardView
      
      }
      
    }
    
    genericCard.userInteractionEnabled = false
    
    let pitchData = arrayOfPitchesByUser[index]
    
    
    if pitchData.pitchId == "-9999" { //-9999 is for LookForPitch
      
      let frameForNewView = CGRect.init(x: 0.0,
                                        y: 0.0,
                                        width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 454.0 * UtilityManager.sharedInstance.conversionHeight)
      
      let lookForPitchCard = LookForPitchCardView.init(frame: frameForNewView,
                                   newArrayOfPitchesToFilter: arrayOfPitchesByUserWithoutModifications)
      lookForPitchCard.delegate = self
      return lookForPitchCard
      
    } else
      if pitchData.pitchId == "-8888" {  //-8888 for filtering
        
        let frameForNewView = CGRect.init(x: 0.0,
                                          y: 0.0,
                                          width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                                          height: 454.0 * UtilityManager.sharedInstance.conversionHeight)
        
        let filterView = FilterPitchCardView.init(frame: frameForNewView)
        filterView.delegate = self
        return filterView
     
    } else
      
      if pitchData.evaluationStatus == false {
        let frameForNewView = CGRect.init(x: 0.0,
                                          y: 0.0,
                                      width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 454.0 * UtilityManager.sharedInstance.conversionHeight)
          
        let pendingEvaluation = PendingEvaluationCardView.init(frame: frameForNewView,
                                                          newPitchData: pitchData)
        pendingEvaluation.delegate = self
          
        return pendingEvaluation
          
    } else {
      
      let frameForNewView = CGRect.init(x: 0.0,
                                        y: 0.0,
                                    width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 454.0 * UtilityManager.sharedInstance.conversionHeight)
        
      genericCard = PitchCardView.init(frame: frameForNewView)
      genericCard.delegate = self
        
      genericCard.changePitchData(arrayOfPitchesByUser[index])
      return genericCard
      
    }
    
  }
  
  func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat
  {
    
    if option == .Spacing {
      
      return 1.05 * value
      
    }
    
    if option == .Radius {
      
      return 1.1 * value
      
    }
    
    if option == .Arc {
      
      return 0.65 * value
      
    }
    
    return value
    
  }
  
  func carouselDidEndScrollingAnimation(carousel: iCarousel) {
    
    let possibleFrontCard = carousel.itemViewAtIndex(carousel.currentItemIndex)
    
    if possibleFrontCard != nil && possibleFrontCard as? PitchCardView != nil{
      
      frontCard = possibleFrontCard! as! PitchCardView
      frontCard.animateGraph()
      
      UIView.animateWithDuration(0.35,
        animations: {
          
          self.frontCard.layer.shadowColor = UIColor.blackColor().CGColor
          self.frontCard!.layer.shadowOpacity = 0.25
          self.frontCard!.layer.shadowOffset = CGSizeZero
          self.frontCard!.layer.shadowRadius = 5
          
        }, completion: { (finished) in
          if finished == true {
            
            self.frontCard.userInteractionEnabled = true
            
          }
      })
      
    }else
      if possibleFrontCard != nil && possibleFrontCard as? PendingEvaluationCardView != nil {
        
        pendingEvaluationFrontCard = possibleFrontCard as! PendingEvaluationCardView
        
        UIView.animateWithDuration(0.35,
          animations: {
                                    
          self.pendingEvaluationFrontCard.layer.shadowColor = UIColor.blackColor().CGColor
          self.pendingEvaluationFrontCard!.layer.shadowOpacity = 0.25
          self.pendingEvaluationFrontCard!.layer.shadowOffset = CGSizeZero
          self.pendingEvaluationFrontCard!.layer.shadowRadius = 5
                                    
          }, completion: { (finished) in
            if finished == true {
              
              self.pendingEvaluationFrontCard.userInteractionEnabled = true
              
            }
        })
        
      }

  }
  
  func carouselWillBeginDragging(carousel: iCarousel) {
    
    if frontCard != nil {
      
      frontCard.userInteractionEnabled = false
      
      UIView.animateWithDuration(0.35){
        
        self.frontCard.layer.shadowColor = UIColor.clearColor().CGColor
        self.frontCard!.layer.shadowOpacity = 0.0
        self.frontCard!.layer.shadowOffset = CGSizeZero
        self.frontCard!.layer.shadowRadius = 0
        
      }
      
    }
    
    if pendingEvaluationFrontCard != nil {
      
      pendingEvaluationFrontCard.userInteractionEnabled = false
      
      UIView.animateWithDuration(0.35,
        animations: { 
          
          self.pendingEvaluationFrontCard.layer.shadowColor = UIColor.clearColor().CGColor
          self.pendingEvaluationFrontCard!.layer.shadowOpacity = 0.0
          self.pendingEvaluationFrontCard!.layer.shadowOffset = CGSizeZero
          self.pendingEvaluationFrontCard!.layer.shadowRadius = 0
          
        }, completion: { (finished) in
          if finished == true {
            
            self.pendingEvaluationFrontCard = nil
            
          }
      })
      
    }
    
  }
  //MARK: - FilterPitchCardViewDelegate 
  
  func doCancelFilteringPitches() {
    
    self.removeFilterPitchCardView()
    
  }
  
  
  //MARK: - DetailPitchViewDelegate
  
  func pushAddResultsViewController(pitchaEvaluationData: PitchEvaluationByUserModelData) {
    
    isComingFromAddResultsController = true
    
    let addResultsController = AddResultViewController.init(newPitchEvaluationDataByUser: pitchaEvaluationData)
    
    self.navigationController?.pushViewController(addResultsController, animated: true)
    
  }
  
  func declineEvaluationPitch(params: [String: AnyObject]) {
    
    let alertController = UIAlertController(title: "Declinar Evaluación", message: "¿Deseas declinar la evaluación?", preferredStyle: UIAlertControllerStyle.Alert)
    
    let cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel) { (result : UIAlertAction) -> Void in
      
      //Something To Do
      
    }
    
    let okAction = UIAlertAction(title: "Sí", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
      
      self.requestToDeclinePitchEvaluation(params)
      
    }
    
    alertController.addAction(cancelAction)
    alertController.addAction(okAction)
    self.presentViewController(alertController, animated: true, completion: nil)
    
  }
  
  private func requestToDeclinePitchEvaluation(params: [String: AnyObject]) {
    
    self.disabledSearchAndFilterButtons()
    
    UtilityManager.sharedInstance.showLoader()
    
    RequestToServerManager.sharedInstance.requestToDeclinePitchEvaluation(params) { (pitchEvaluationDeclined) in
      
      self.mainCarousel.scrollEnabled = false
      self.mainCarousel.userInteractionEnabled = false
      UtilityManager.sharedInstance.hideLoader()
      self.hideDetailPitchView()
      self.flipFrontCardToDecline()
      
    }
    
  }
  
  func cancelEvaluationPitch(params: [String: AnyObject]) {
    
    let alertController = UIAlertController(title: "Cancelar Evaluación", message: "¿Deseas cancelar la evaluación?", preferredStyle: UIAlertControllerStyle.Alert)
    
    let cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel) { (result : UIAlertAction) -> Void in
      
      //Something To Do
      
    }
    
    let okAction = UIAlertAction(title: "Sí", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
      
      self.requestToCancelPitchEvaluation(params)
        
    }
    
    alertController.addAction(cancelAction)
    alertController.addAction(okAction)
    self.presentViewController(alertController, animated: true, completion: nil)
    
  }

  private func requestToCancelPitchEvaluation(params: [String: AnyObject]) {
    
    self.disabledSearchAndFilterButtons()
  
    UtilityManager.sharedInstance.showLoader()
    
    RequestToServerManager.sharedInstance.requestToCancelPitchEvaluation(params) { (pitchEvaluationCancelled) in
      
      self.mainCarousel.scrollEnabled = false
      self.mainCarousel.userInteractionEnabled = false
      UtilityManager.sharedInstance.hideLoader()
      self.hideDetailPitchView()
      self.flipFrontCardToCancel()
      
    }
    
  }
  
  func archiveEvaluationPitch(params: [String: AnyObject]) {
    
    let alertController = UIAlertController(title: "Archivar Evaluación", message: "¿Deseas archivar la evaluación?", preferredStyle: UIAlertControllerStyle.Alert)
    
    let cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel) { (result : UIAlertAction) -> Void in
      
      //Something To Do
      
    }
    
    let okAction = UIAlertAction(title: "Sí", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
      
      self.requestToArchivePitchEvaluation(params)
      
    }
    
    alertController.addAction(cancelAction)
    alertController.addAction(okAction)
    self.presentViewController(alertController, animated: true, completion: nil)
    
  }
  
  private func requestToArchivePitchEvaluation(params: [String: AnyObject]) {
    
    self.disabledSearchAndFilterButtons()
    
    UtilityManager.sharedInstance.showLoader()
    
    RequestToServerManager.sharedInstance.requestToArchivePitchEvaluation(params) { (pitchEvaluationArchived) in
      
      self.mainCarousel.scrollEnabled = false
      self.mainCarousel.userInteractionEnabled = false
      UtilityManager.sharedInstance.hideLoader()
      self.hideDetailPitchView()
      self.flipFrontCardToArchived()
      
    }
    
  }
  
  func deleteEvaluationPitch(params: [String: AnyObject]) {
    
    let alertController = UIAlertController(title: "Eliminar Evaluación", message: "¿Deseas eliminar la evaluación?", preferredStyle: UIAlertControllerStyle.Alert)
    
    let cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel) { (result : UIAlertAction) -> Void in
      
      //Something To Do
      
    }
    
    let okAction = UIAlertAction(title: "Sí", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
      
      self.requestToDeletePitchEvaluation(params)
      
    }
    
    alertController.addAction(cancelAction)
    alertController.addAction(okAction)
    self.presentViewController(alertController, animated: true, completion: nil)
    
  }
  
  private func requestToDeletePitchEvaluation(params: [String: AnyObject]) {
    
    self.disabledSearchAndFilterButtons()
    
    self.disabledSearchAndFilterButtons()
    
    UtilityManager.sharedInstance.showLoader()
    
    RequestToServerManager.sharedInstance.requestToDestroyPitchEvaluation(params) {

      UtilityManager.sharedInstance.hideLoader()
      self.hideDetailPitchView()
      self.flipFrontCardToDelete()
      
    }
    
  }
  
  private func flipFrontCardToCancel() {
    
    isShowingAMessageCard = true
    
    let frameForBlanckView = CGRect.init(x: 0.0,
                                         y: 0.0,
                                         width: self.frontCard.frame.size.width,
                                         height: self.frontCard.frame.size.height)
    
    let canceledPitch = CanceledPitchEvaluationView.init(frame: frameForBlanckView)
    canceledPitch.backgroundColor = UIColor.whiteColor()
    canceledPitch.delegate = self
    self.frontCard.hidden = true
    canceledPitch.hidden = false
    
    UIView.transitionFromView(self.frontCard,
                              toView: canceledPitch,
                              duration: 0.5,
                              options: .TransitionFlipFromLeft) { (finished) in
                                if finished {
                                
                                  
                                  
                                }
    }
    
  }
  
  private func flipFrontCardToDecline() {
    
    isShowingAMessageCard = true
    
    let frameForBlanckView = CGRect.init(x: 0.0,
                                         y: 0.0,
                                         width: self.frontCard.frame.size.width,
                                         height: self.frontCard.frame.size.height)
    
    let declinedPitch = DeclinedPitchEvaluationView.init(frame: frameForBlanckView)
    declinedPitch.backgroundColor = UIColor.whiteColor()
    declinedPitch.delegate = self
    self.frontCard.hidden = true
    declinedPitch.hidden = false
    
    UIView.transitionFromView(self.frontCard,
                              toView: declinedPitch,
                              duration: 0.5,
                              options: .TransitionFlipFromLeft) { (finished) in
                                if finished {
                                  
                                  
                                  
                                }
    }
    
  }
  
  private func flipFrontCardToArchived() {
    
    isShowingAMessageCard = true
    
    let frameForBlanckView = CGRect.init(x: 0.0,
                                         y: 0.0,
                                         width: self.frontCard.frame.size.width,
                                         height: self.frontCard.frame.size.height)
    
    let canceledPitch = ArchivedPitchEvaluationView.init(frame: frameForBlanckView)
    canceledPitch.backgroundColor = UIColor.whiteColor()
    canceledPitch.delegate = self
    self.frontCard.hidden = true
    canceledPitch.hidden = false
    
    UIView.transitionFromView(self.frontCard,
                              toView: canceledPitch,
                              duration: 0.5,
                              options: .TransitionFlipFromLeft) { (finished) in
                                if finished {
                                  
                                  
                                  
                                }
    }
    
  }
  
  
  private func flipFrontCardToDelete() {
    
    isShowingAMessageCard = true
    
    let frameForBlanckView = CGRect.init(x: 0.0,
                                         y: 0.0,
                                         width: self.frontCard.frame.size.width,
                                         height: self.frontCard.frame.size.height)
    
    let deletedPitch = DeletedPitchEvaluationView.init(frame: frameForBlanckView)
    deletedPitch.backgroundColor = UIColor.whiteColor()
    deletedPitch.delegate = self
    self.frontCard.hidden = true
    deletedPitch.hidden = false
    
    UIView.transitionFromView(self.frontCard,
                              toView: deletedPitch,
                              duration: 0.5,
                              options: .TransitionFlipFromLeft) { (finished) in
                                if finished {
                                  
                                  
                                  
                                }
    }
    
  }
  
  
  //MARK: CanceledPitchEvaluationViewDelegate 
  
  func nextButtonPressedFromCanceledPitchEvaluationView(sender: CanceledPitchEvaluationView) {
    
    UIView.animateWithDuration(0.45,
      animations: {
        
        sender.alpha = 0.0
        
      }) { (finished) in
        if finished == true {
          
          
          self.requestForAllPitchesAndTheirEvaluations()
          
          self.mainCarousel.scrollEnabled = true
          self.mainCarousel.userInteractionEnabled = true
          self.enableSearchAndFilterButtons()
          self.isShowingAMessageCard = false
          
        }
    }
    
    let actualIndex = mainCarousel.currentItemIndex
    self.arrayOfPitchesByUser.removeAtIndex(actualIndex)
    mainCarousel.removeItemAtIndex(actualIndex, animated: true)

  }
  
  func nextButtonPressedFromArchivedPitchEvaluationView(sender: ArchivedPitchEvaluationView) {
    
    UIView.animateWithDuration(0.45,
                               animations: {
                                
                                sender.alpha = 0.0
                                
    }) { (finished) in
      if finished == true {
        
        self.requestForAllPitchesAndTheirEvaluations()
        
        self.mainCarousel.scrollEnabled = true
        self.mainCarousel.userInteractionEnabled = true
        self.enableSearchAndFilterButtons()
        self.isShowingAMessageCard = false
        
      }
    }
    
    let actualIndex = mainCarousel.currentItemIndex
    self.arrayOfPitchesByUser.removeAtIndex(actualIndex)
    mainCarousel.removeItemAtIndex(actualIndex, animated: true)
    
  }
  
  func nextButtonPressedFromDeclinedPitchEvaluationView(sender: DeclinedPitchEvaluationView) {
    
    UIView.animateWithDuration(0.45,
                               animations: {
                                
                                sender.alpha = 0.0
                                
    }) { (finished) in
      if finished == true {
        
        self.requestForAllPitchesAndTheirEvaluations()
        
        self.mainCarousel.scrollEnabled = true
        self.mainCarousel.userInteractionEnabled = true
        self.enableSearchAndFilterButtons()
        self.isShowingAMessageCard = false
        
      }
    }
    
    let actualIndex = mainCarousel.currentItemIndex
    self.arrayOfPitchesByUser.removeAtIndex(actualIndex)
    mainCarousel.removeItemAtIndex(actualIndex, animated: true)
    
  }
  
  func nextButtonPressedFromDeletedPitchEvaluationView(sender: DeletedPitchEvaluationView) {
    
    UIView.animateWithDuration(0.45,
                               animations: {
                                
                                sender.alpha = 0.0
                                
    }) { (finished) in
      if finished == true {
        
        self.requestForAllPitchesAndTheirEvaluations()
        
        self.mainCarousel.scrollEnabled = true
        self.mainCarousel.userInteractionEnabled = true
        self.enableSearchAndFilterButtons()
        self.isShowingAMessageCard = false
        
      }
    }
    
    let actualIndex = mainCarousel.currentItemIndex
    self.arrayOfPitchesByUser.removeAtIndex(actualIndex)
    mainCarousel.removeItemAtIndex(actualIndex, animated: true)

    
  }
  
  private func disabledSearchAndFilterButtons() {
    
    searchButton.userInteractionEnabled = false
    filterButton.userInteractionEnabled = false
    
  }
  
  private func enableSearchAndFilterButtons() {
    
    searchButton.userInteractionEnabled = true
    filterButton.userInteractionEnabled = true
    
  }
  
  //MARK: LookForPitchCardViewDelegate
  
  func lookForThisPitchID(pitchIDToLookFor: String) {
    
    for i in 0..<arrayOfPitchesByUserWithoutModifications.count {
      
      let pitchData = arrayOfPitchesByUserWithoutModifications[i]
      if pitchData.pitchId == pitchIDToLookFor {
        
        self.removeLookForPitchCardView()
        mainCarousel.reloadData()
        mainCarousel.scrollToItemAtIndex(i, animated: true)

        return
        
      }
      
    }
    
  }
  
  @objc private func removeLookForPitchCardView() {
  
    for i in 0..<arrayOfPitchesByUser.count - 1 {
    
      if arrayOfPitchesByUser[i].pitchId == "-9999" {
    
        self.arrayOfPitchesByUser.removeAtIndex(i)
        mainCarousel.removeItemAtIndex(i, animated: false)
        searchButton.userInteractionEnabled = true
        searchButton.enabled = true
        filterButton.userInteractionEnabled = true
        filterButton.enabled = true
        mainCarousel.scrollEnabled = true
        
        isShowingAMessageCard = false
      
      }
    
    }
    
  }
  
  @objc private func removeFilterPitchCardView() {
    
    for i in 0..<arrayOfPitchesByUser.count - 1 {
      
      if arrayOfPitchesByUser[i].pitchId == "-8888" {
        
        self.arrayOfPitchesByUser.removeAtIndex(i)
        mainCarousel.removeItemAtIndex(i, animated: true)
        searchButton.userInteractionEnabled = true
        searchButton.enabled = true
        filterButton.userInteractionEnabled = true
        filterButton.enabled = true
        mainCarousel.scrollEnabled = true
        
        isShowingAMessageCard = false
        
      }
      
    }
    
  }
  
  //MARK: - PendingEvaluationCardViewDelegate
  
  func nextButtonPressedFromPendingEvaluationCardView(pitchData: PitchEvaluationByUserModelData) {
    
    let projectPitchData = ProjectPitchModelData.init(newId: pitchData.pitchId,
      newName: pitchData.pitchName,
      newBrandId: "-1",
      newBriefDate: pitchData.briefDate,
      newBrieEMailContact: "",
      newArrayOfPitchCategories: Array<PitchSkillCategory>())
    
    projectPitchData.voidPitchEvaluationId = pitchData.pitchEvaluationId
    
    
    let evaluatePitch = EvaluatePitchViewController(newPitchData: projectPitchData,
                                                    creatingANewPitchEvaluation: false,
                                                    updatingAPreviousPitchEvaluation: true)
    self.navigationController?.pushViewController(evaluatePitch, animated: true)
    
  }
  
}
