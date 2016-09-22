//
//  EvaluatePitchViewController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/18/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class EvaluatePitchViewController: UIViewController, EvaluatePitchViewDelegate {
  
  private var flipCard: FlipCardView! = nil
  private var evaluatePitch: EvaluatePitchView! = nil
  private var detailedNavigation: DetailedNavigationEvaluatPitchView! = nil
  
  private var pitchData: ProjectPitchModelData! = nil
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(newPitchData: ProjectPitchModelData) {
    
    pitchData = newPitchData
    
    super.init(nibName: nil, bundle: nil)
    
  }
  
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
    self.createFlipCard()
    
  }
  
  private func editNavigationController() {
    
    self.changeBackButtonItem()
    self.changeNavigationBarTitle()
    self.changeNavigationRigthButtonItem()
    
    self.addDetailNavigationController()
    
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
      string: VisualizePitchesConstants.PreEvaluatePitchViewController.navigationBarTitleText,
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
  
  private func addDetailNavigationController() {
    
    let frameForDetailedNav = CGRect.init(x: self.view.frame.size.width,
                                          y: 51.0 * UtilityManager.sharedInstance.conversionHeight,
                                          width: self.view.frame.size.width,
                                          height: 108.0 * UtilityManager.sharedInstance.conversionHeight)
    
    detailedNavigation = DetailedNavigationEvaluatPitchView.init(frame: frameForDetailedNav,
      newProjectName: pitchData.name,
      newBrandName: (pitchData.brandData != nil ? pitchData.brandData!.name : "Marca"),
      newCompanyName: (pitchData.companyData != nil ? pitchData.companyData!.name : "Compañía"),
      newDateString: pitchData.briefDate)
    
    detailedNavigation.alpha = 0.0
    self.navigationController?.navigationBar.addSubview(detailedNavigation)
    
    
    //    self.view.addSubview(detailedNavigation)
    
    
  }
  
  private func createFlipCard() {
    
    let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
    let heightOfCard = self.view.frame.size.height - (292.0 * UtilityManager.sharedInstance.conversionHeight)
    let frameForCard = CGRect.init(x: (40.0 * UtilityManager.sharedInstance.conversionWidth),
                                   y: (216.0 * UtilityManager.sharedInstance.conversionHeight),
                                   width: widthOfCard,
                                   height: heightOfCard)
    
    let frameForBackAndFrontOfCard = CGRect.init(x: 0.0,
                                                 y: 0.0,
                                                 width: widthOfCard,
                                                 height: heightOfCard)
    
    let blankAndBackView = UIView.init(frame: frameForBackAndFrontOfCard)
    self.createEvaluatePitch(frameForBackAndFrontOfCard)
    
    flipCard = FlipCardView.init(frame: frameForCard,
                                 viewOne: evaluatePitch,
                                 viewTwo: blankAndBackView)
    
    self.view.addSubview(flipCard)
    
  }
  
  private func createEvaluatePitch(frameForPreEvaluatePitchView: CGRect) {
    
    evaluatePitch = EvaluatePitchView.init(frame: frameForPreEvaluatePitchView)
    evaluatePitch.delegate = self
    
  }
  
  private func createGradientView() -> GradientView{
    
    let frameForView = CGRect.init(x: 0.0, y: 60.0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height - 60.0)
    
    let firstColorGradient = UIColor.init(red: 213.0/255.0, green: 240.0/255.0, blue: 96.0/255.0, alpha: 1.0)
    let secondColorGradient = UIColor.init(red: 41.0/255.0, green: 255.0/255.0, blue: 141.0/255.0, alpha: 1.0)
    let colorsForBackground = [firstColorGradient,secondColorGradient]
    
    return GradientView.init(frame: frameForView, arrayOfcolors: colorsForBackground, typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.animateDetailedNavigationView()
    
  }
  
  private func animateDetailedNavigationView() {
    
    let newFrameForDetailNavigation = CGRect.init(x: 0.0,
                                                  y: detailedNavigation.frame.origin.y,
                                                  width: detailedNavigation.frame.size.width,
                                                  height: detailedNavigation.frame.size.height)
    
    UIView.animateWithDuration(0.25){
      
      self.detailedNavigation.alpha = 1.0
      self.detailedNavigation.frame = newFrameForDetailNavigation
      
    }
    
  }
  
  @objc private func navigationRightButtonPressed() {
    
    let newFrameForDetailedNavigation = CGRect.init(x: detailedNavigation.frame.size.width,
                                                    y: detailedNavigation.frame.origin.y,
                                                    width: detailedNavigation.frame.size.width,
                                                    height: detailedNavigation.frame.size.height)
    
    UIView.animateWithDuration(0.20){
      
      self.detailedNavigation.frame = newFrameForDetailedNavigation
      
    }
    
    self.navigationController?.popToRootViewControllerAnimated(true)
    
  }
  
  private func popMyself() {
    
    self.navigationController?.popViewControllerAnimated(true)
    
  }
  
  //MARK: - PreEvaluatePitchViewDelegate
  
  func savePitchAndFlipCard() {
    
    //Send Info to server, if is correct flipCard
    
//    let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
//    let heightOfCard = self.view.frame.size.height - (292.0 * UtilityManager.sharedInstance.conversionHeight)
//    let frameForBackAndFrontOfCard = CGRect.init(x: 0.0,
//                                                 y: 0.0,
//                                                 width: widthOfCard,
//                                                 height: heightOfCard)
    
//    let backOfTheCard = SuccessfullyCreationOfPitchView.init(frame: frameForBackAndFrontOfCard)
//    backOfTheCard.hidden = true
//    backOfTheCard.delegate = self
//    flipCard.setSecondView(backOfTheCard)
    
    flipCard.flip()
    
  }
  
  //MARK: - EvaluatePitchVideDelegate
  
  func createEvaluatePitch() {
    
    self.navigationRightButtonPressed()
    
  }
  
  //MARK: - SuccessfullyCreationOfPitchViewDelegate
  
  func nextButtonPressedFromSuccessfullyCreationOfPitch() {
    
    
    
  }
  
  @objc private func dismissKeyboard(sender:AnyObject) {
    
    self.view.endEditing(true)
    
  }
  
}