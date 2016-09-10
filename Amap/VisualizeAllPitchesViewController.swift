//
//  VisualizeAllPitchesViewController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/8/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol VisualizeAllPitchesViewControllerShowAndHideDelegate {
  
  func requestToHideTabBarFromVisualizeAllPitchesViewControllerDelegate()
  func requestToShowTabBarFromVisualizeAllPitchesViewControllerDelegate()
  
}

class VisualizeAllPitchesViewController: UIViewController, NoPitchAssignedViewDelegate, CreateAddNewPitchAndWriteBrandNameViewControllerDelegate {
  
  private var searchButton: UIButton! = nil
  private var filterButton: UIButton! = nil
  private var arrayOfPitches = [AnyObject]()
  
  
  
  var delegateForShowAndHideTabBar: VisualizeAllPitchesViewControllerShowAndHideDelegate?
  
  override func loadView() {
    
    self.view = UIView.init(frame: UIScreen.mainScreen().bounds)
    self.view.backgroundColor = UIColor.blackColor()

    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.view.addSubview(self.createGradientView())
    self.changeNavigationRigthButtonItem()
    self.createSearchButton()
    self.createFilterButton()
    
    if arrayOfPitches.count == 0 {
      
      self.createAndAddNoPitchesAssignedView()
      
    }
    
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
  
  
  @objc private func searchButtonPressed() {
  
  
  }
  
  @objc private func filterButtonPressed() {
        
  }
  
  @objc private func showInfo() {
    
    
  }
  
  //MARK: - NoPitchAssignedViewDelegate
  
  func pushCreateAddNewPitchAndWriteBranNameViewController() {
    
    self.delegateForShowAndHideTabBar?.requestToHideTabBarFromVisualizeAllPitchesViewControllerDelegate()
    
    let createAddNewPitch = CreateAddNewPitchAndWriteBrandNameViewController()
    createAddNewPitch.delegateForShowTabBar = self
    self.navigationController?.pushViewController(createAddNewPitch, animated: true)
    
  }
  
  //MARK: - CreateAddNewPitchAndWriteBrandNameViewControllerDelegate
  
  func requestToShowTabBarFromCreateAddNewPitchAndWriteBrandNameViewControllerDelegate() {
    
    self.delegateForShowAndHideTabBar?.requestToShowTabBarFromVisualizeAllPitchesViewControllerDelegate()
    
  }
  
  
}