//
//  CreateAddNewPitchAndWriteCategoryTypeViewController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/12/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol CreateAddNewPitchAndWriteCategoryTypeViewControllerDelegate {
  
  func requestToShowTabBarFromCreateAddNewPitchAndWriteProjectNameViewControllerDelegate()
  
}

class CreateAddNewPitchAndWriteCategoryTypeViewController: UIViewController, AddPitchAndWriteWhichCategoryIsViewDelegate {
  
  private var addPitchWriteWhichCategoryIsView: AddPitchAndWriteWhichCategoryIsView! = nil
  
  var delegateForShowTabBar: CreateAddNewPitchAndWriteCategoryTypeViewControllerDelegate?
  
  override func loadView() {
    
    self.view = UIView.init(frame: UIScreen.mainScreen().bounds)
    self.view.backgroundColor = UIColor.blackColor()
    
    self.initInterface()
    self.addGestures()
    
  }
  
  private func addGestures() {
    
    let tapToDismissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                              action: #selector(dismissKeyboard))
    tapToDismissKeyboard.numberOfTapsRequired = 1
    self.view.addGestureRecognizer(tapToDismissKeyboard)
    
  }
  
  private func initInterface() {
    
    self.view.addSubview(self.createGradientView())
    
    self.editNavigationController()
    self.createAddPitchWriteWhichCategoryIsView()
    
  }
  
  private func editNavigationController() {
    
    self.changeBackButtonItem()
    self.changeNavigationRigthButtonItem()
    
  }
  
  private func changeBackButtonItem() {
    
    let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: navigationController, action: nil)
    navigationItem.leftBarButtonItem = backButton
    
  }
  
  private func changeNavigationRigthButtonItem() {
    
    let rightButton = UIBarButtonItem(title: VisualizePitchesConstants.CreateAddNewPitchAndWriteBrandNameViewController.navigationRightButtonText,
                                      style: UIBarButtonItemStyle.Plain,
                                      target: self,
                                      action: #selector(navigationRightButtonPressed))
    
    let fontForButtonItem =  UIFont(name: "SFUIText-Regular",
                                    size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    
    let attributesDict: [String:AnyObject] = [NSFontAttributeName: fontForButtonItem!,
                                              NSForegroundColorAttributeName: UIColor.whiteColor()
    ]
    
    rightButton.setTitleTextAttributes(attributesDict, forState: .Normal)
    
    self.navigationItem.rightBarButtonItem = rightButton
    
  }
  
  private func createAddPitchWriteWhichCategoryIsView() {
    
    let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
    let heightOfCard = self.view.frame.size.height - (184.0 * UtilityManager.sharedInstance.conversionHeight)
    let frameForCard = CGRect.init(x: (40.0 * UtilityManager.sharedInstance.conversionWidth),
                                   y: (108.0 * UtilityManager.sharedInstance.conversionHeight),
                                   width: widthOfCard,
                                   height: heightOfCard)
    
    
    
    addPitchWriteWhichCategoryIsView = AddPitchAndWriteWhichCategoryIsView.init(frame: frameForCard)
    addPitchWriteWhichCategoryIsView.delegate = self
    
    self.view.addSubview(addPitchWriteWhichCategoryIsView)
    
  }
  
  private func createGradientView() -> GradientView{
    
    let frameForView = CGRect.init(x: 0.0, y: 60.0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height - 60.0)
    
    let firstColorGradient = UIColor.init(red: 187.0/255.0, green: 145.0/255.0, blue: 2555.0/255.0, alpha: 1.0)
    let secondColorGradient = UIColor.init(red: 255.0/255.0, green: 117.0/255.0, blue: 218.0/255.0, alpha: 1.0)
    let colorsForBackground = [firstColorGradient,secondColorGradient]
    
    return GradientView.init(frame: frameForView, arrayOfcolors: colorsForBackground, typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  @objc private func navigationRightButtonPressed() {
    
    self.popMyself()
    
  }
  
  private func popMyself() {
    
    self.delegateForShowTabBar?.requestToShowTabBarFromCreateAddNewPitchAndWriteProjectNameViewControllerDelegate()
    self.navigationController?.popViewControllerAnimated(true)
    
  }
  
  //MARK: - AddPitchAndWriteWhichCategoryIsViewDelegate
  
  func createAndAddPitch() {
    
    //after pitch is created
    
    self.navigationController?.popToRootViewControllerAnimated(true)
    
  }
  
  @objc private func dismissKeyboard(sender:AnyObject) {
    
    self.view.endEditing(true)
    
  }
  
  
}

