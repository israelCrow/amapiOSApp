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

class VisualizeAllPitchesViewController: UIViewController, iCarouselDelegate, iCarouselDataSource, NoPitchAssignedViewDelegate, CreateAddNewPitchAndWriteCompanyNameViewControllerDelegate, PitchCardViewDelegate, DetailPitchViewDelegate, CanceledPitchEvaluationViewDelegate, ArchivedPitchEvaluationViewDelegate, DeletedPitchEvaluationViewDelegate, DeclinedPitchEvaluationViewDelegate, LookForPitchCardViewDelegate, FilterPitchCardViewDelegate, PendingEvaluationCardViewDelegate, YouWonThisPitchViewDelegate, AddResultViewControllerDelegate, EditPitchEvaluationViewControllerDelegate {
  
  private let kNotificationCenterForLookingForPitchEvaluation = "LookForThisPitchEvaluation"
  
  private var mainCarousel: iCarousel! = nil
  
  private var searchButton: UIButton! = nil
  private var filterButton: UIButton! = nil
  private var addPitchButton: UIButton! = nil
  private var archivedButton: UIButton! = nil
  private var archivedLabel: UILabel! = nil
  private var arrayOfPitchesByUser = [PitchEvaluationByUserModelData]()
  private var arrayOfPitchesByUserWithoutModifications = [PitchEvaluationByUserModelData]()
  private var frontCard: PitchCardView! = nil
  private var originalFrameOfFrontCard: CGRect! = nil
  private var noPitchesAssignedView: NoPitchAssignedView! = nil
  private var noFilterResultsView: NoFilterResultsView! = nil
  private var pendingEvaluationFrontCard: PendingEvaluationCardView! = nil
  private var mainDetailPitchView: DetailPitchView! = nil
  private var detailNavigationBar: DetailedNavigationEvaluatPitchView! = nil
  
  private var archivePitchEvaluationParams: [String: AnyObject]! = nil
  private var pitchEvaluationIDToLookForAfterCreated: String = "-1"
  private var isSecondTimeAppearing: Bool = false
  private var isShowingAMessageCard: Bool = false
  private var isComingFromAddResultsController: Bool = false
  private var isComingFromEditPitchEvaluationController: Bool = false
  
  private var indexOfArchivedButton: Int! = nil
  private var lastPitchEvaluationIdToEdit: String = "-1"
  
  private var paramsForFilterPitchEvaluations: [String: AnyObject] = ["auth_token": UserSession.session.auth_token,
                                                                      "happitch": 1,
                                                                      "happy": 1,
                                                                      "ok": 1,
                                                                      "unhappy": 1
//                                                                      "cancelled": 0
//                                                                      "declined": 0,
//                                                                      "archived": 0
                                                                      ]
  
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
    self.createAddPitchButton()
    self.createArchiveButton()
    self.createArchiveLabel()
    
    self.requestForAllPitchesAndTheirEvaluations()
    
    let notToShowPitchesTutorial = NSUserDefaults.standardUserDefaults().boolForKey(UtilityManager.sharedInstance.kNotToShowPitchesTutorial + UserSession.session.email)
    
    if notToShowPitchesTutorial == false {
      
      let tutorialPitches = PitchesTutorialView.init(frame: CGRect.init())
      let rootViewController = UtilityManager.sharedInstance.currentViewController()
      rootViewController.view.addSubview(tutorialPitches)
      
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
  
  private func createArchiveButton() {
    
    let archivedButtonFrame = CGRect.init(x: 139.0 * UtilityManager.sharedInstance.conversionWidth,
                                          y: 158.0 * UtilityManager.sharedInstance.conversionHeight,
                                      width: 97.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 97.0 * UtilityManager.sharedInstance.conversionHeight)
    
    
    archivedButton = UIButton.init(frame: archivedButtonFrame)
    let image = UIImage(named: "archivarIcon") as UIImage?
    archivedButton.setImage(image, forState: .Normal)
    archivedButton.addTarget(self, action: #selector(archiveButtonPressed),
                         forControlEvents:.TouchUpInside)
    
    archivedButton.alpha = 0.0
    
    self.view.addSubview(archivedButton)
    
  }
  
  private func createArchiveLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 201.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    archivedLabel = UILabel.init(frame: frameForLabel)
    archivedLabel.numberOfLines = 0
    archivedLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Archivar Pitch",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    archivedLabel.attributedText = stringWithFormat
    archivedLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.view.frame.size.width / 2.0) - (archivedLabel.frame.size.width / 2.0),
                               y: 265.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: archivedLabel.frame.size.width,
                               height: archivedLabel.frame.size.height)
    
    archivedLabel.frame = newFrame
    archivedLabel.alpha = 0.0
    
    self.view.addSubview(archivedLabel)

  }
  
  private func showArchiveButton() {
    
    indexOfArchivedButton = self.view.subviews.indexOf(self.archivedButton)
    
    self.view.bringSubviewToFront(self.archivedButton)
    
    if archivedButton != nil {
      
      self.archivedButton.userInteractionEnabled = true
      
      UIView.animateWithDuration(0.25) {
        
        self.archivedButton.alpha = 1.0
        
      }
      
    }
  
  }
  
  private func hideArchiveButton() {
    
    self.view.insertSubview(self.archivedButton, atIndex: indexOfArchivedButton)
    
    if archivedButton != nil {
      
      UIView.animateWithDuration(0.25) {
        
        self.archivedButton.alpha = 0.0
        
      }
      
    }
    
  }
  
  private func showArchiveLabel() {
    
    if archivedLabel != nil {
      
      UIView.animateWithDuration(0.25) {
        
        self.archivedLabel.alpha = 1.0
        
      }
      
    }
    
  }
  
  private func hideArchiveLabel() {
    
    if archivedLabel != nil {
      
      UIView.animateWithDuration(0.25) {
        
        self.archivedLabel.alpha = 0.0
        
      }
      
    }
    
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
    mainCarousel.scrollSpeed = 0.5
    mainCarousel.type = .Rotary
    mainCarousel.backgroundColor = UIColor.clearColor()
    mainCarousel.delegate = self
    mainCarousel.dataSource = self
    mainCarousel.alpha = 1.0
    self.view.addSubview(mainCarousel)
    
    if addPitchButton != nil {
      
      self.view.bringSubviewToFront(addPitchButton)
      
    }
    
  }
  
  private func createAddPitchButton() {
    
    let frameForButton = CGRect.init(x: (self.view.frame.size.width / 2.0) - (28.0 * UtilityManager.sharedInstance.conversionWidth), //283.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 78.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 56.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
    
    addPitchButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "buttonAddPitch") as UIImage?
    addPitchButton.setImage(image, forState: .Normal)
//    addPitchButton.tag = 1
    addPitchButton.addTarget(self, action: #selector(pushCreateAddNewPitchAndWriteBrandNameViewControllerFromPitchCard),
                             forControlEvents:.TouchUpInside)
    
    self.view.addSubview(addPitchButton)
    
  }
  
  private func requestForAllPitchesAndTheirEvaluations() {
    
    UtilityManager.sharedInstance.showLoader()
    
    RequestToServerManager.sharedInstance.requestToGetAllPitchEvaluationByUser { (pitchEvaluationsByUser, pitchesForCompany) in
      
      if pitchEvaluationsByUser != nil {
        
        self.arrayOfPitchesByUser = pitchEvaluationsByUser!
        self.arrayOfPitchesByUserWithoutModifications = pitchEvaluationsByUser!

        if self.arrayOfPitchesByUser.count == 0 {
          
          self.searchButton.userInteractionEnabled = false
          self.searchButton.enabled = false
          
          if self.mainCarousel != nil {
            
            UIView.animateWithDuration(0.2,
              animations: {
                
                self.mainCarousel.alpha = 0.0
                
              }, completion: { (finished) in
                
                self.createAndAddNoPitchesAssignedView()
                
            })
            
          }else{
            
            self.createAndAddNoPitchesAssignedView()
            
          }
          
        }else{
          
          self.hideNoPitchesView()
          self.hideNoFilterResultsView()
          
          if self.mainCarousel == nil {
            
            self.createCarousel()
            
          }
          
          if self.arrayOfPitchesByUser.count == 1 {
            
            self.mainCarousel.scrollEnabled = false
            
          }else{
            
            self.mainCarousel.scrollEnabled = true
            
          }
          
          self.mainCarousel.reloadData()
          self.searchButton.userInteractionEnabled = true
          self.searchButton.enabled = true
          
          if self.pitchEvaluationIDToLookForAfterCreated != "-1" && Int(self.pitchEvaluationIDToLookForAfterCreated) > 0 {
            
            self.lookForThisPitchID(self.pitchEvaluationIDToLookForAfterCreated)
            self.pitchEvaluationIDToLookForAfterCreated = "-1"
            
          }
          
        }
        
        
        UtilityManager.sharedInstance.hideLoader()

      }
      
    }
    
//    RequestToServerManager.sharedInstance.requestToGetAllPitchEvaluationByUser { (pitchEvaluationsByUser) in
//      
//      self.arrayOfPitchesByUser = pitchEvaluationsByUser
//      self.arrayOfPitchesByUserWithoutModifications = pitchEvaluationsByUser
//      
//      
//      
//      if self.arrayOfPitchesByUser.count == 0 {
//        
//        self.searchButton.userInteractionEnabled = false
//        self.searchButton.enabled = false
//        
//        if self.mainCarousel != nil {
//          
//          UIView.animateWithDuration(0.2,
//            animations: {
//              
//              self.mainCarousel.alpha = 0.0
//              
//            }, completion: { (finished) in
//              
//              self.createAndAddNoPitchesAssignedView()
//              
//          })
//        
//        }else{
//          
//          self.createAndAddNoPitchesAssignedView()
//          
//        }
//        
//      }else{
//        
//        self.hideNoPitchesView()
//        self.hideNoFilterResultsView()
//        
//        if self.mainCarousel == nil {
//        
//          self.createCarousel()
//          
//        }
//        
//        if self.arrayOfPitchesByUser.count == 1 {
//          
//          self.mainCarousel.scrollEnabled = false
//          
//        }else{
//          
//          self.mainCarousel.scrollEnabled = true
//          
//        }
//    
//        self.mainCarousel.reloadData()
//        self.searchButton.userInteractionEnabled = true
//        self.searchButton.enabled = true
//        
//        if self.pitchEvaluationIDToLookForAfterCreated != "-1" && Int(self.pitchEvaluationIDToLookForAfterCreated) > 0 {
//          
//          self.lookForThisPitchID(self.pitchEvaluationIDToLookForAfterCreated)
//          self.pitchEvaluationIDToLookForAfterCreated = "-1"
//          
//        }
//        
//      }
//      
//      
//      UtilityManager.sharedInstance.hideLoader()
//      
//    }
    
    
    
  }
  
  private func createGradientView() -> GradientView{
    
    let frameForView = CGRect.init(x: 0.0, y: 60.0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height - 60.0)
    
    let firstColorGradient = UIColor.init(red: 242.0/255.0, green: 242.0/255.0, blue: 2555.0/255.0, alpha: 1.0)
    let secondColorGradient = UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
    let colorsForBackground = [firstColorGradient,secondColorGradient]
    
    return GradientView.init(frame: frameForView, arrayOfcolors: colorsForBackground, typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
    
  }
  
  private func createAndAddNoPitchesAssignedView() {
    
    if noPitchesAssignedView != nil {
      
//      if noPitchesAssignedView.alpha == 0.0 {
//        
        noPitchesAssignedView.removeFromSuperview()
        noPitchesAssignedView = nil
        
//      } else {
//        
//        UIView.animateWithDuration(0.2,
//          animations: { 
//            
//            self.noPitchesAssignedView.alpha = 0.0
//            
//          }, completion: { (finished) in
//            if finished == true {
//              
//              self.noPitchesAssignedView.removeFromSuperview()
//              self.noPitchesAssignedView = nil
//              
//            }
//        })
//        
//      }

      
    }
    
    let positionForNoPitchesView = CGPoint.init(x: 40.0 * UtilityManager.sharedInstance.conversionWidth,
                                                y: 133.0 * UtilityManager.sharedInstance.conversionHeight)
    
    noPitchesAssignedView = NoPitchAssignedView.init(position: positionForNoPitchesView)
    noPitchesAssignedView.delegate = self
    noPitchesAssignedView.alpha = 1.0
    self.view.addSubview(noPitchesAssignedView)
    
    if addPitchButton != nil {
      
      self.view.bringSubviewToFront(addPitchButton)
      
    }
    
  }
  
  private func createAndAddNoFilterResultsView() {
    
    if noFilterResultsView != nil {
      
      //      if noPitchesAssignedView.alpha == 0.0 {
      //
      noFilterResultsView.removeFromSuperview()
      noFilterResultsView = nil
      
      //      } else {
      //
      //        UIView.animateWithDuration(0.2,
      //          animations: {
      //
      //            self.noPitchesAssignedView.alpha = 0.0
      //
      //          }, completion: { (finished) in
      //            if finished == true {
      //
      //              self.noPitchesAssignedView.removeFromSuperview()
      //              self.noPitchesAssignedView = nil
      //
      //            }
      //        })
      //
      //      }
      
      
    }
    
    let positionForNoFilterResultsView = CGPoint.init(x: 40.0 * UtilityManager.sharedInstance.conversionWidth,
                                                y: 133.0 * UtilityManager.sharedInstance.conversionHeight)
    
    noFilterResultsView = NoFilterResultsView.init(position: positionForNoFilterResultsView)
    noFilterResultsView.alpha = 1.0
    self.view.addSubview(noFilterResultsView)
    
    if addPitchButton != nil {
      
      self.view.bringSubviewToFront(addPitchButton)
      
    }
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewWillDisappear(animated: Bool) {
    
    super.viewWillDisappear(true)
    
    NSNotificationCenter.defaultCenter().removeObserver(self)
    
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(lookForPitchEvaluation) , name: kNotificationCenterForLookingForPitchEvaluation, object: nil)
  
    if mainCarousel != nil {
      
      if mainCarousel.alpha == 0.0 {
      
        UIView.animateWithDuration(0.2) {
        
          self.mainCarousel.alpha = 1.0
        
        }
      
      }
    
    }
    
    if isComingFromAddResultsController == true || isComingFromEditPitchEvaluationController == true {
    
      isComingFromAddResultsController = false
      isComingFromEditPitchEvaluationController = false
      
    }else{
      
      self.delegateForShowAndHideTabBar?.requestToShowTabBarFromVisualizeAllPitchesViewControllerDelegate()
    
    }
    
//    if isComingFromEditPitchEvaluationController == true {
//      
//      isComingFromEditPitchEvaluationController = false
//      
//    } else {
//      
//      self.delegateForShowAndHideTabBar?.requestToShowTabBarFromVisualizeAllPitchesViewControllerDelegate()
//      
//    }
    
    if isSecondTimeAppearing == false {
      
      isSecondTimeAppearing = true
      
    } else {
      
      if isShowingAMessageCard == false {
       
        self.requestForAllPitchesAndTheirEvaluations()
        
//        if lastPitchEvaluationIdToEdit != "-1" {
//          
//          self.lookForThisPitchID(lastPitchEvaluationIdToEdit)
//          self.hideDetailPitchView()
//          self.createAndShowDetailedPitchView()
//          lastPitchEvaluationIdToEdit = "-1"
//          
//        }
        
        //self.requestFilteringPitches()
        
      
      } else {
        
        if mainCarousel != nil {
          
          mainCarousel.scrollEnabled = false
          
        }
        
      }
      
    }
    
  }
  
  private func requestFilteringPitches() {
    
    UtilityManager.sharedInstance.showLoader()
    
    RequestToServerManager.sharedInstance.requestToFilterPitchEvaluations(paramsForFilterPitchEvaluations, actionsToMakeWhenReceiveElements: { (arrayFiltered) in
      
      self.arrayOfPitchesByUser = arrayFiltered
      self.arrayOfPitchesByUserWithoutModifications = arrayFiltered
      
      if self.arrayOfPitchesByUser.count == 0 {
        
        self.searchButton.userInteractionEnabled = false
        self.searchButton.enabled = false
        
        if self.mainCarousel != nil {
          
          UIView.animateWithDuration(0.2){
            
            self.mainCarousel.alpha = 0.0
            
          }
          
          self.mainCarousel.reloadData()
          
        }
        
        self.createAndAddNoFilterResultsView()
        
      }else{
        
        self.hideNoPitchesView()
        self.hideNoFilterResultsView()
        
        if self.mainCarousel.alpha == 0.0 {
          
          UIView.animateWithDuration(0.2) {
            
            self.mainCarousel.alpha = 1.0
            
          }
          
        }
        
        if self.mainCarousel == nil {
          
          self.createCarousel()
          
        }
        
        if self.arrayOfPitchesByUser.count == 1 {
          
          self.mainCarousel.scrollEnabled = false
          
        }else{
          
          self.mainCarousel.scrollEnabled = true
          
        }
        
        self.mainCarousel.reloadData()
        
        self.searchButton.userInteractionEnabled = true
        self.searchButton.enabled = true
        //          if self.pitchEvaluationIDToLookForAfterCreated != "-1" && Int(self.pitchEvaluationIDToLookForAfterCreated) > 0 {
        //
        //            self.lookForThisPitchID(self.pitchEvaluationIDToLookForAfterCreated)
        //            self.pitchEvaluationIDToLookForAfterCreated = "-1"
        //
        //          }
      }
      
      
      UtilityManager.sharedInstance.hideLoader()
      
    })

    
  }
  
  @objc private func archiveButtonPressed() {
    
    let alertController = UIAlertController(title: "Archivar Pitch", message: "¿Deseas archivar este pitch?", preferredStyle: UIAlertControllerStyle.Alert)
    
    let cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel) { (result : UIAlertAction) -> Void in
      
      self.hideArchiveButton()
      self.hideArchiveLabel()
      
      UIView.animateWithDuration(0.35,
                                 animations: {
                                  
          self.frontCard.frame = self.originalFrameOfFrontCard
                                  
        }, completion: { (finished) in
          if finished == true {
            
            self.enableSearchAndFilterButtons()
            self.mainCarousel.scrollEnabled = true
            self.mainCarousel.userInteractionEnabled = true
            self.navigationItem.rightBarButtonItem?.enabled = true
            self.addPitchButton.userInteractionEnabled = true
            self.isShowingAMessageCard = false
            
            self.frontCard.isCardDown = false
            
          }
      })
      
    }
    
    let okAction = UIAlertAction(title: "Sí", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
      
      
      if self.archivePitchEvaluationParams != nil {
        
        self.requestToArchivePitchEvaluationFromDraggingDown()
        
      }
      
    }
    
    
    alertController.addAction(cancelAction)
    alertController.addAction(okAction)
    self.presentViewController(alertController, animated: true, completion: nil)
    
  }
  
  @objc private func lookForPitchEvaluation(notification: NSNotification) {
    
    if notification.userInfo?["pitchEvaluationToLookFor"] as? String != nil {
      
      let pitchEvaluationIDToLookFor = notification.userInfo?["pitchEvaluationToLookFor"] as! String
      
      pitchEvaluationIDToLookForAfterCreated = pitchEvaluationIDToLookFor
      
//      self.lookForThisPitchID(pitchEvaluationIDToLookFor)
      
    }
    
  }
  
  func changePitchEvaluationIDToLookForAfterCreated(newPitchEvaluationToLookFor: String) {
    
    pitchEvaluationIDToLookForAfterCreated = newPitchEvaluationToLookFor
    
  }
  
  private func hideAddPitchButton() {
    
    UIView.animateWithDuration(0.15){
      
      self.addPitchButton.alpha = 0.0
      
    }
    
  }
  
  private func showAddPitchButton() {
    
    UIView.animateWithDuration(0.15){
      
      self.addPitchButton.alpha = 1.0
      
    }
    
  }
  
  @objc private func searchButtonPressed() {
  
    if mainCarousel != nil {
      
      self.hideAddPitchButton()
      
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
        newEvaluationStatus: false,
        newHasResults: false,
        newHasPitchWinnerSurvey: false,
        newPitchResultsId: "-9999")
      
      let actualIndex = mainCarousel.currentItemIndex
      self.arrayOfPitchesByUser.insert(newElement, atIndex: actualIndex)
      mainCarousel.insertItemAtIndex(actualIndex, animated: true)
      
    }
  
  }
  
  @objc private func filterButtonPressed() {
    
    self.hideNoPitchesView()
    self.hideNoFilterResultsView()
    
    if mainCarousel == nil {
      
      self.createCarousel()
      
    }
    
    if mainCarousel != nil {
      
      if mainCarousel.alpha == 0.0 {
        
        UIView.animateWithDuration(0.2) {
          
          self.mainCarousel.alpha = 1.0
          
        }
        
      }
      
      self.hideAddPitchButton()
      
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
        newEvaluationStatus: false,
        newHasResults: false,
        newHasPitchWinnerSurvey: false,
        newPitchResultsId: "-8888")
      
      let actualIndex = mainCarousel.currentItemIndex
      if actualIndex == -1 {
        
        self.arrayOfPitchesByUser.insert(newElement, atIndex: 0)
        
      } else {
        
        self.arrayOfPitchesByUser.insert(newElement, atIndex: actualIndex)
        
      }
      mainCarousel.insertItemAtIndex(actualIndex, animated: true)
      
    }
    
  }
  
  @objc private func showInfo() {
    
    let infoController = InfoPitchesViewController()
    self.navigationController?.pushViewController(infoController, animated: true)
    
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
  
  func showAlreadyArchivedMessage(alert: UIAlertController) {
    
    self.presentViewController(alert, animated: true, completion: nil)
    
  }
  
  func upSwipeDetectedInPitchCard() {
    
    self.hideArchiveButton()
    self.hideArchiveLabel()
    
    UIView.animateWithDuration(0.35,
                               animations: {
                                
                                self.frontCard.frame = self.originalFrameOfFrontCard
                                
      }, completion: { (finished) in
        if finished == true {
          
//          self.hideArchiveButton()
//          self.hideArchiveLabel()
          self.enableSearchAndFilterButtons()
          self.mainCarousel.scrollEnabled = true
          self.mainCarousel.userInteractionEnabled = true
          self.navigationItem.rightBarButtonItem?.enabled = true
          self.addPitchButton.userInteractionEnabled = true
          self.isShowingAMessageCard = false
          
          self.frontCard.isCardDown = false
          
        }
    })
    
  }
  
  func askForArchiveThisPitchCard(params: [String : AnyObject]) {
    
    self.archivePitchEvaluationParams = params
    
    if frontCard != nil {
      
      frontCard.isCardDown = true
      isShowingAMessageCard = true
      self.disabledSearchAndFilterButtons()
      self.mainCarousel.scrollEnabled = false
//      self.mainCarousel.userInteractionEnabled = false
      self.navigationItem.rightBarButtonItem?.enabled = false
      self.addPitchButton.userInteractionEnabled = false
      
      originalFrameOfFrontCard = frontCard.frame
      let newFrameForCard = CGRect.init(x: frontCard.frame.origin.x,
                                        y: frontCard.frame.origin.y + (185.0 * UtilityManager.sharedInstance.conversionHeight),
                                    width: frontCard.frame.size.width,
                                   height: frontCard.frame.size.height)
      
      self.showArchiveButton()
      self.showArchiveLabel()
      
      UIView.animateWithDuration(0.2) {
        
        self.frontCard.frame = newFrameForCard
        
      }

    }
    
  }
  
  func pushCreateAddNewPitchAndWriteBrandNameViewControllerFromPitchCard() {
    
    self.delegateForShowAndHideTabBar?.requestToHideTabBarFromVisualizeAllPitchesViewControllerDelegate()
    
    let createAddNewPitch = CreateAddNewPitchAndWriteCompanyNameViewController()
    createAddNewPitch.delegateForShowTabBar = self
    self.navigationController?.pushViewController(createAddNewPitch, animated: true)
    
  }
  
  @objc private func createAndShowDetailedPitchViewWithValuesUpdated(value: NSTimer) {
    
    let pitchEvaluationDataUpdated = (value.userInfo as? PitchEvaluationByUserModelData != nil ? value.userInfo as! PitchEvaluationByUserModelData : self.frontCard.getPitchEvaluationByUserData())
    
    
    if frontCard == nil {
      
      return
      
    }
    
    self.navigationItem.rightBarButtonItem?.enabled = false
    mainCarousel.userInteractionEnabled = false
    frontCard.userInteractionEnabled = false
    let copyGraphInUse = self.createUpdatedGraph(pitchEvaluationDataUpdated)
    copyGraphInUse.animateGraph()
    copyGraphInUse.alpha = 0.0
    
    self.createDetailNavigationBar()
    
    if mainDetailPitchView == nil {
      
      let frameForMainDetailPitchView = UIScreen.mainScreen().bounds
      mainDetailPitchView = DetailPitchView.init(frame: frameForMainDetailPitchView,
                                                 newPitchData: pitchEvaluationDataUpdated,
                                                 newGraphPart: copyGraphInUse)
      
      let heightOfDetailNavigationBar = (self.navigationController?.navigationBar.frame.size.height)! + (103.0 * UtilityManager.sharedInstance.conversionHeight) + UIApplication.sharedApplication().statusBarFrame.size.height
      
      mainDetailPitchView.changeFrameOfContainerView(heightOfDetailNavigationBar)
      mainDetailPitchView.backgroundColor = UIColor.clearColor()
      mainDetailPitchView.userInteractionEnabled = true
      mainDetailPitchView.delegate = self
      self.view.addSubview(mainDetailPitchView)
      
    } else {
      
      mainDetailPitchView.alpha = 1.0
      mainDetailPitchView.reloadDataAndInterface(pitchEvaluationDataUpdated,
                                                 newGraphPart: copyGraphInUse)
      mainDetailPitchView.backgroundColor = UIColor.clearColor()
      mainDetailPitchView.userInteractionEnabled = true
      
    }
    
    pitchEvaluationIDToLookForAfterCreated = mainDetailPitchView.pitchEvaluationData.pitchEvaluationId
    self.delegateForShowAndHideTabBar?.requestToDisolveTabBarFromVisualizeAllPitchesViewControllerDelegate()
    mainDetailPitchView.animateShowPitchEvaluationDetail()
    self.animateShowingDetailPitchView()
    NSTimer.scheduledTimerWithTimeInterval(0.75, target: self, selector: #selector(changeRightButtonOfNavigationBarWhenDetailPitchViewIsShown), userInfo: nil, repeats: false)

    
  }
  
  func createAndShowDetailedPitchView() {
    
    if frontCard == nil {
      
      return
      
    }
    
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
    
    pitchEvaluationIDToLookForAfterCreated = mainDetailPitchView.pitchEvaluationData.pitchEvaluationId
    self.delegateForShowAndHideTabBar?.requestToDisolveTabBarFromVisualizeAllPitchesViewControllerDelegate()
    mainDetailPitchView.animateShowPitchEvaluationDetail()
    self.animateShowingDetailPitchView()
    NSTimer.scheduledTimerWithTimeInterval(0.75, target: self, selector: #selector(changeRightButtonOfNavigationBarWhenDetailPitchViewIsShown), userInfo: nil, repeats: false)
    
  }
  
  private func createUpdatedGraph(updatedPitchEvaluationDataByUser: PitchEvaluationByUserModelData) -> GraphPartPitchCardView {
    
    let frameForGraphPart = CGRect.init(x: (40.0 * UtilityManager.sharedInstance.conversionWidth), //globalPoint.x
      y: 0.0,
      width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
      height: 347.0 * UtilityManager.sharedInstance.conversionHeight)
    
    var arrayOfQualifications: [Int] = updatedPitchEvaluationDataByUser.otherScores
    arrayOfQualifications.insert(updatedPitchEvaluationDataByUser.score, atIndex: 0)
    let arrayOfAgencyNames: [String] = [AgencyModel.Data.name]
    
    return GraphPartPitchCardView.init(frame: frameForGraphPart,
                                       newArrayOfQualifications: arrayOfQualifications,
                                       newArrayOfAgencyNames: arrayOfAgencyNames)
   
  }
  
  private func makeACopyOfActualGraph() -> GraphPartPitchCardView {
  
    //let globalPoint = frontCard.getGraphPart().convertPoint(frontCard.getGraphPart().frame.origin, toView: UIApplication.sharedApplication().delegate!.window!)
    
    let frameForGraphPart = CGRect.init(x: (40.0 * UtilityManager.sharedInstance.conversionWidth), //globalPoint.x
                                        y: 0.0,
                                    width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 347.0 * UtilityManager.sharedInstance.conversionHeight)
    
    var arrayOfQualifications: [Int] = frontCard.getPitchEvaluationByUserData().otherScores
    arrayOfQualifications.insert(frontCard.getPitchEvaluationByUserData().score, atIndex: 0)
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
    
    if detailNavigationBar != nil {
      
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
        
        let filterView = FilterPitchCardView.init(frame: frameForNewView, newOptionsSelected: paramsForFilterPitchEvaluations)
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
          
    } else
    
      if pitchData.wasWon == true {
      
        let frameForNewView = CGRect.init(x: 0.0,
                                          y: 0.0,
                                      width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 454.0 * UtilityManager.sharedInstance.conversionHeight)
        
        let pendingEvaluation = YouWonThisPitchView.init(frame: frameForNewView,
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
  
  func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
   
    if arrayOfPitchesByUser.count > 0 && arrayOfPitchesByUser.count < 3 {
      
      mainCarousel.scrollSpeed = 0.2
      
    }else
      if arrayOfPitchesByUser.count > 2 && arrayOfPitchesByUser.count < 6 {
      
        mainCarousel.scrollSpeed = 0.35
        
      } else {
      
        mainCarousel.scrollSpeed = 0.5
        
      }
    
    if option == .Spacing {
      
      if arrayOfPitchesByUser.count > 0 && arrayOfPitchesByUser.count < 3 {
        
        return 1.15 * value
        
      }else
        if arrayOfPitchesByUser.count == 3 {
          
          return 0.95 * value
          
        }else
        if arrayOfPitchesByUser.count == 4 {
            
          return 1.25 * value
            
        }else
        if arrayOfPitchesByUser.count == 5 {
              
          return 1.15 * value
              
        } else {
              
          return 1.05 * value
              
        }
      
//      if arrayOfPitchesByUser.count > 0 && arrayOfPitchesByUser.count < 5 {
//        
//        return 1.55 * value
//        
//      }else{
//      
//        return 1.05 * value
//      
//      }
      
    }
    
    if option == .Radius {
      
      if arrayOfPitchesByUser.count > 0 && arrayOfPitchesByUser.count < 3 {
        
        return 1.51 * value
        
      }else
        if arrayOfPitchesByUser.count == 3 {
          
          return 1.51 * value
          
        }else
        if arrayOfPitchesByUser.count == 4 {
            
          return 1.45 * value
            
        }else
        if arrayOfPitchesByUser.count == 5 {
              
          return 1.12 * value
              
        } else {
              
          return 1.1 * value
              
        }
      
      
//      if arrayOfPitchesByUser.count > 0 && arrayOfPitchesByUser.count < 5 {
//        
//        return 1.51 * value
//        
//      }else{
//        
//        return 1.1 * value
//        
//      }
      
    }
    
    if option == .Arc {
      
      if arrayOfPitchesByUser.count > 0 && arrayOfPitchesByUser.count < 3 {
        
        return 0.6 * value
        
      }else
        if arrayOfPitchesByUser.count == 3 {
          
          return 0.85 * value
          
        }else
        if arrayOfPitchesByUser.count == 4 {
            
          return 0.8 * value
            
        }else
        if arrayOfPitchesByUser.count == 5 {
              
          return 0.7 * value
              
        } else {
              
          return 0.65 * value
              
        }
      
//      if arrayOfPitchesByUser.count > 0 && arrayOfPitchesByUser.count < 5 {
//        
//        return 0.65 * value
//        
//      }else{
//        
//        return 0.65 * value
//        
//      }
      
    }
    
    return value
    
  }
  
  func carouselDidEndScrollingAnimation(carousel: iCarousel) {
    
    let possibleFrontCard = carousel.itemViewAtIndex(carousel.currentItemIndex)
    
    if possibleFrontCard != nil && possibleFrontCard as? PitchCardView != nil{
      
      frontCard = possibleFrontCard! as! PitchCardView
      frontCard.isCardDown = false
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
  
  func doApplyFilterPitches(paramsForFilter: [String : AnyObject]) {
    
    paramsForFilterPitchEvaluations = paramsForFilter
    self.removeFilterPitchCardView(paramsForFilterPitchEvaluations)
    self.showAddPitchButton()
    
  }
  
  
  func doCancelFilteringPitches() {
  
    self.onlyRemoveFilterPitchCardView()
    self.showAddPitchButton()
    
  }
  
  private func onlyRemoveFilterPitchCardView() {
    
    if arrayOfPitchesByUser.count == 1 {
      
      self.arrayOfPitchesByUser.removeAtIndex(0)
      mainCarousel.removeItemAtIndex(0, animated: true)
      searchButton.userInteractionEnabled = true
      searchButton.enabled = true
      filterButton.userInteractionEnabled = true
      filterButton.enabled = true
      mainCarousel.scrollEnabled = true
      
      isShowingAMessageCard = false
      
      self.createAndAddNoFilterResultsView()
      
    }else{
      
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
    
  }
  
  
  
  
  //MARK: - DetailPitchViewDelegate
  
  func showMessageOfAlreadyArchived(alert: UIAlertController) {
    
    self.presentViewController(alert, animated: true, completion: nil)
    
  }
  
  func editPitchEvaluation(pitchEvaluationData: PitchEvaluationByUserModelData) {
    
    isComingFromEditPitchEvaluationController = true
    lastPitchEvaluationIdToEdit = pitchEvaluationData.pitchEvaluationId
    
    UtilityManager.sharedInstance.showLoader()
  
    RequestToServerManager.sharedInstance.requestToGetPitchEvaluationByPitchID(pitchEvaluationData.pitchEvaluationId) { evaluationData in
      
      print(evaluationData)
      UtilityManager.sharedInstance.hideLoader()
      
      let editPitchEvaluation = EditPitchEvaluationViewController.init(newPitchEvaluationData: pitchEvaluationData,
                                                                       newEvaluationData: evaluationData)
      editPitchEvaluation.delegate = self
      self.navigationController?.pushViewController(editPitchEvaluation, animated: true)
      
    }
    
  }
  
  //EditPitchEvaluationViewControllerDelegate
  
  func updatedDetailInfoOfPitchEvaluation(newPitchData: PitchEvaluationByUserModelData?) {
    
    self.hideDetailPitchView()
    
    
    //If they don't want this, just comment the next if
    
    if newPitchData != nil {
      
      NSTimer.scheduledTimerWithTimeInterval(1.2, target: self, selector: #selector(createAndShowDetailedPitchViewWithValuesUpdated), userInfo: newPitchData!, repeats: false)
           
    //  self.createAndShowDetailedPitchViewWithValuesUpdated(newPitchData!)
      
    }
    
  }
  
  func pushAddResultsViewController(pitchaEvaluationData: PitchEvaluationByUserModelData) {
    
    isComingFromAddResultsController = true
//    let addResultsController = AddResultViewController.init(newPitchEvaluationDataByUser: pitchaEvaluationData)
//    addResultsController.delegate = self
//    self.navigationController?.pushViewController(addResultsController, animated: true)
    
    UtilityManager.sharedInstance.showLoader()
    
    RequestToServerManager.sharedInstance.requestToGetPitchResults(pitchaEvaluationData.pitchResultsId, functionToMakeWhenThereIsPitchResultCreated: { (pitchResult) in
      
        print(pitchResult)
      UtilityManager.sharedInstance.hideLoader()
      
      let addResultsController = AddResultViewController.init(newPitchEvaluationDataByUser: pitchaEvaluationData, newInfoSelectedBefore: pitchResult)
      addResultsController.delegate = self
      
      UtilityManager.sharedInstance.hideLoader()
      
      self.navigationController?.pushViewController(addResultsController, animated: true)
      
      }) { 
        
        let addResultsController = AddResultViewController.init(newPitchEvaluationDataByUser: pitchaEvaluationData)
        addResultsController.delegate = self
        
        UtilityManager.sharedInstance.hideLoader()
        
        self.navigationController?.pushViewController(addResultsController, animated: true)
        
    }
    
  }
  
  func declineEvaluationPitch(params: [String: AnyObject]) {
    
    let alertController = UIAlertController(title: "Declinar Evaluación", message: "¿Estás seguro que este pitch fue declinado?", preferredStyle: UIAlertControllerStyle.Alert)
    
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
    
    let alertController = UIAlertController(title: "Cancelar Evaluación", message: "¿Estás seguro de que cancelaron este pitch?", preferredStyle: UIAlertControllerStyle.Alert)
    
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
      
      
    }
    
    let okAction = UIAlertAction(title: "Sí", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
      
      self.requestToArchivePitchEvaluation(params)
      
    }
    
    alertController.addAction(cancelAction)
    alertController.addAction(okAction)
    self.presentViewController(alertController, animated: true, completion: nil)
    
  }
  
  private func requestToArchivePitchEvaluationFromDraggingDown() {
    
    
    self.disabledSearchAndFilterButtons()
    
    UtilityManager.sharedInstance.showLoader()
    
    RequestToServerManager.sharedInstance.requestToArchivePitchEvaluation(self.archivePitchEvaluationParams) { (pitchEvaluationArchived) in
    
      self.mainCarousel.scrollEnabled = false
      self.mainCarousel.userInteractionEnabled = false
      UtilityManager.sharedInstance.hideLoader()
      self.simulateDragDownFrontCard()
      
    }
    
  }
  
  private func simulateDragDownFrontCard() {
    
    if frontCard != nil {
      
      let newFrameForFrontCard = CGRect.init(x: frontCard.frame.origin.x,
                                             y: frontCard.frame.origin.y + UIScreen.mainScreen().bounds.size.height,
                                         width: frontCard.frame.size.width,
                                        height: frontCard.frame.size.height)
      
      UIView.animateWithDuration(0.45,
        animations: {
          
          self.frontCard.frame = newFrameForFrontCard
          
        }, completion: { (finished) in
          if finished == true {
            
            UIView.animateWithDuration(0.2,
              animations: {
                
                self.archivedButton.alpha = 0.0
                self.archivedLabel.alpha = 0.0
                
              }, completion: { (finished) in
                if finished == true {
                  
                  let actualIndex = self.mainCarousel.currentItemIndex
                  self.arrayOfPitchesByUserWithoutModifications.removeAtIndex(actualIndex)
                  self.arrayOfPitchesByUser.removeAtIndex(actualIndex)
                  self.mainCarousel.removeItemAtIndex(actualIndex, animated: true)
                  self.mainCarousel.scrollEnabled = true
                  self.mainCarousel.userInteractionEnabled = true
                  self.enableSearchAndFilterButtons()
                  self.navigationItem.rightBarButtonItem?.enabled = true
                  self.addPitchButton.userInteractionEnabled = true
                  self.isShowingAMessageCard = false
                  
                }
            })
            
          }
      })
      
    }
    
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
  
  func doCancelLookForCard() {
    
    self.onlyRemoveLookForCardView()
    self.showAddPitchButton()
    
  }
  
  func lookForThisPitch(params: [String : AnyObject], sender: LookForPitchCardView) {
    
    UtilityManager.sharedInstance.showLoader()
    
    RequestToServerManager.sharedInstance.requestToSearchPitch(params) { (allPitches) in
    
      sender.setArrayOfAllProjectsPitches(allPitches)
      
      UtilityManager.sharedInstance.hideLoader()
      
    }
    
  }
  
  func lookForThisPitchID(pitchIDToLookFor: String) {
    
    for i in 0..<arrayOfPitchesByUserWithoutModifications.count {
      
      let pitchData = arrayOfPitchesByUserWithoutModifications[i]
      if pitchData.pitchId == pitchIDToLookFor {
        
        self.removeLookForPitchCardView()
        mainCarousel.reloadData()
        mainCarousel.scrollToItemAtIndex(i, animated: true)

        self.showAddPitchButton()
        
        return
        
      }
      
    }
    
    if addPitchButton.alpha == 0 {
      
      self.showAddPitchButton()
      
    }
    
  }
  
  private func onlyRemoveLookForCardView() {
    
    if arrayOfPitchesByUser.count == 1 {
      
      self.arrayOfPitchesByUser.removeAtIndex(0)
      mainCarousel.removeItemAtIndex(0, animated: true)
      searchButton.userInteractionEnabled = true
      searchButton.enabled = true
      filterButton.userInteractionEnabled = true
      filterButton.enabled = true
      mainCarousel.scrollEnabled = true
      
      isShowingAMessageCard = false
      
      self.createAndAddNoPitchesAssignedView()
      
    }else{
      
      for i in 0..<arrayOfPitchesByUser.count - 1 {
        
        if arrayOfPitchesByUser[i].pitchId == "-9999" {
          
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
  
  private func hideNoPitchesView() {
    
    if noPitchesAssignedView != nil && noPitchesAssignedView.alpha != 0.0 {
      
      UIView.animateWithDuration(0.2) {
        
        self.noPitchesAssignedView.alpha = 0.0
        
      }
      
    }
    
  }
  
  private func hideNoFilterResultsView() {
    
    if noFilterResultsView != nil && noFilterResultsView.alpha != 0.0 {
      
      UIView.animateWithDuration(0.2) {
        
        self.noFilterResultsView.alpha = 0.0
        
      }
      
    }
    
  }
  
  @objc private func removeFilterPitchCardView(paramsToFilter: [String: AnyObject]) {
    
    if arrayOfPitchesByUser.count == 1 {
      
      self.arrayOfPitchesByUser.removeAtIndex(0)
      mainCarousel.removeItemAtIndex(0, animated: true)
      searchButton.userInteractionEnabled = true
      searchButton.enabled = true
      filterButton.userInteractionEnabled = true
      filterButton.enabled = true
      mainCarousel.scrollEnabled = true
      
      isShowingAMessageCard = false
      
    }else{
      
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
    
        UtilityManager.sharedInstance.showLoader()
        
        RequestToServerManager.sharedInstance.requestToFilterPitchEvaluations(paramsToFilter, actionsToMakeWhenReceiveElements: { (arrayFiltered) in
          
          self.arrayOfPitchesByUser = arrayFiltered
          self.arrayOfPitchesByUserWithoutModifications = arrayFiltered
          
          if self.arrayOfPitchesByUser.count == 0 {
            
            self.searchButton.userInteractionEnabled = false
            self.searchButton.enabled = false
            
            if self.mainCarousel != nil {
              
              UIView.animateWithDuration(0.125){
                
                self.mainCarousel.alpha = 0.0
                
              }
              
              self.mainCarousel.reloadData()
              
            }
            
            self.createAndAddNoFilterResultsView()
            
          } else {
            
            self.hideNoPitchesView()
            self.hideNoFilterResultsView()
            
            if self.mainCarousel.alpha == 0.0 {
              
              UIView.animateWithDuration(0.125) {
                
                self.mainCarousel.alpha = 1.0
                
              }
              
            }
            
            if self.mainCarousel == nil {
              
              self.createCarousel()
              
            }
            
            if self.arrayOfPitchesByUser.count == 1 {
              
              self.mainCarousel.scrollEnabled = false
              
            }else{
              
              self.mainCarousel.scrollEnabled = true
              
            }
            
            self.mainCarousel.reloadData()
            
            self.searchButton.userInteractionEnabled = true
            self.searchButton.enabled = true
            //          if self.pitchEvaluationIDToLookForAfterCreated != "-1" && Int(self.pitchEvaluationIDToLookForAfterCreated) > 0 {
            //
            //            self.lookForThisPitchID(self.pitchEvaluationIDToLookForAfterCreated)
            //            self.pitchEvaluationIDToLookForAfterCreated = "-1"
            //
            //          }
          }
          
          
          UtilityManager.sharedInstance.hideLoader()
          
        })
        
    
    
  }
  
  //MARK: - PendingEvaluationCardViewDelegate
  
  func nextButtonPressedFromPendingEvaluationCardView(pitchData: PitchEvaluationByUserModelData) {
    
    let justNameOfBrand = BrandModelData.init(newId: "",
                                            newName: pitchData.brandName,
                                     newContactName: "",
                                    newContactEMail: "",
                                 newContactPosition: "",
                              newProprietaryCompany: "")
    
    let justNameOfCompany = CompanyModelData.init(newId: "",
                                              newName: pitchData.companyName,
                                            newBrands: [BrandModelData]())
    
    
    let projectPitchData = ProjectPitchModelData.init(newId: pitchData.pitchId,
      newName: pitchData.pitchName,
      newBrandId: "-1",
      newBriefDate: pitchData.briefDate,
      newBrieEMailContact: "",
      newArrayOfPitchCategories: Array<PitchSkillCategory>())
    
    projectPitchData.brandData = justNameOfBrand
    projectPitchData.companyData = justNameOfCompany
    
    projectPitchData.voidPitchEvaluationId = pitchData.pitchEvaluationId
    
    
    let evaluatePitch = EvaluatePitchViewController(newPitchData: projectPitchData,
                                                    creatingANewPitchEvaluation: false,
                                                    updatingAPreviousPitchEvaluation: true)
    self.navigationController?.pushViewController(evaluatePitch, animated: true)
    
  }
  
  //MARK: - YouWonThisPitchViewDelegate
  
  func nextButtonPressedFromYouWonThisPitchView(pitchData: PitchEvaluationByUserModelData) {
    
    isComingFromAddResultsController = true
    
    let addResultsController = AddResultViewController.init(newPitchEvaluationDataByUser: pitchData,
                                                          initDirectlyInPitchSurveyPitch: true)
    addResultsController.delegate = self
    
    self.navigationController?.pushViewController(addResultsController, animated: true)
    
  }
  
  //MARK: - AddResultViewControllerDelegate
  
  func doActionsWhenDisappear(newPitchResult: PitchResultsModelData?) {
    
    if newPitchResult != nil {
      
      mainDetailPitchView.pastInfoFromAddResults = newPitchResult!
      mainDetailPitchView.pitchEvaluationData.hasResults = true
      mainDetailPitchView.pitchEvaluationData.pitchResultsId = newPitchResult!.pitchResultsId
      self.mainDetailPitchView.lookForAddResultsData()
      
    } else {
      
      let alertController = UIAlertController(title: "ERROR DE CONEXIÓN CON EL SERVIDOR",
                                              message: "Error al salvar tu encuesta, inténtalo nuevamente",
                                              preferredStyle: UIAlertControllerStyle.Alert)
      
      let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { (result : UIAlertAction) -> Void in
        
      }
      
      alertController.addAction(okAction)
      self.presentViewController(alertController, animated: true, completion: nil)

      
    }
    
  }
  
}
