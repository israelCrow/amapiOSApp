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
  private var backViewForEvaluatePitchView: UIView! = nil
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
    backViewForEvaluatePitchView = UIView.init(frame: frameForBackAndFrontOfCard)
    backViewForEvaluatePitchView.backgroundColor = UIColor.whiteColor()
    
    self.createEvaluatePitch(frameForBackAndFrontOfCard)
    backViewForEvaluatePitchView.addSubview(self.evaluatePitch)
    
    flipCard = FlipCardView.init(frame: frameForCard,
                                 viewOne: backViewForEvaluatePitchView,
                                 viewTwo: blankAndBackView)
    
    self.view.addSubview(flipCard)
    
  }
  
  private func createEvaluatePitch(frameForPreEvaluatePitchView: CGRect) {
    
    evaluatePitch = EvaluatePitchView.init(frame: frameForPreEvaluatePitchView)
    evaluatePitch.delegate = self
    
  }
  
  private func createGradientView() -> GradientView {
    
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
  
  func createEvaluatePitch(params: [String : AnyObject]) {
    
    UtilityManager.sharedInstance.showLoader()
    
    var paramsWithPitchID = params
    paramsWithPitchID["pitch_id"] = pitchData.id
    let finalParams: [String: AnyObject] = [
                                              "auth_token": UserSession.session.auth_token,
                                              "pitch_evaluation" : paramsWithPitchID
                                           ]
    
    RequestToServerManager.sharedInstance.requestToCreateEvaluationOfProjectPitch(finalParams) { (newEvaluationPitchCreated) in
      print(newEvaluationPitchCreated)
      UtilityManager.sharedInstance.hideLoader()
      self.dismissDetailedNavigation()
      self.navigationController?.popToRootViewControllerAnimated(true)
      
    }
    
  }
  
  private func makeAnimationOfCreationOfEvaluationOfPitch() {
    
    self.view.endEditing(true)
    self.dismissDetailedNavigation()
    self.dismissFrontOfCard()
    self.animateCardSize()
    
  }
  
  private func dismissDetailedNavigation() {
    
    let newFrameForDetailedNavigation = CGRect.init(x: detailedNavigation.frame.size.width,
                                                    y: detailedNavigation.frame.origin.y,
                                                    width: detailedNavigation.frame.size.width,
                                                    height: detailedNavigation.frame.size.height)
    
    UIView.animateWithDuration(0.20){
      
      self.detailedNavigation.frame = newFrameForDetailedNavigation
      
    }
    
  }
  
  private func dismissFrontOfCard() {
    
    UIView.animateWithDuration(0.25) {
      
      self.evaluatePitch.alpha = 0.0
      
    }
    
  }
  
  private func animateCardSize() {
    
    let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
    let heightOfCard = self.view.frame.size.height - (184.0 * UtilityManager.sharedInstance.conversionHeight)
    let newFrameForCard = CGRect.init(x: (40.0 * UtilityManager.sharedInstance.conversionWidth),
                                   y: (108.0 * UtilityManager.sharedInstance.conversionHeight),
                                   width: widthOfCard,
                                   height: heightOfCard)
    
    let frameForBackAndFrontOfCard = CGRect.init(x: 0.0,
                                                 y: 0.0,
                                                 width: widthOfCard,
                                                 height: heightOfCard)
    
    let blankAndBackView = UIView.init(frame: frameForBackAndFrontOfCard)
    blankAndBackView.backgroundColor = UIColor.whiteColor()
    blankAndBackView.hidden = true
    self.createEvaluatePitch(frameForBackAndFrontOfCard)
    
    UIView.animateWithDuration(0.25,
      animations: { 
        
        self.flipCard.frame = newFrameForCard
        
      }) { (finished) in
        if finished == true {
          
         self.animateFlipCard(blankAndBackView)
          
        }
    }
    
  }
  
  private func animateFlipCard(backViewOfClipCard: UIView) {
    
//    if UtilityManager.sharedInstance.loaderImageView != nil {
//    
//      let frameOfCard = backViewOfClipCard.frame
//      let newLoaderImageView = UtilityManager.sharedInstance.loaderImageView
//      let newFrameForLoaderImagerView = CGRect.init(x: (frameOfCard.size.width / 2.0) - (newLoaderImageView.frame.size.width / 2.0),
//                                                    y: (frameOfCard.size.height / 2.0) - (newLoaderImageView.frame.size.height / 2.0),
//                                                width: newLoaderImageView.frame.size.width,
//                                               height: newLoaderImageView.frame.size.height)
//      newLoaderImageView.frame = newFrameForLoaderImagerView
//      
//      backViewOfClipCard.addSubview(newLoaderImageView)
//    
//    }
    
    let loadingView = UIView.init(frame: backViewOfClipCard.frame)
    loadingView.backgroundColor = UIColor.init(white: 1, alpha: 0.8)
    
    let frameForImageView = CGRect.init(x: (loadingView.frame.size.width / 2.0) - (75.0 * UtilityManager.sharedInstance.conversionWidth) ,
                                        y: (loadingView.frame.size.height / 2.0) - (75.0 * UtilityManager.sharedInstance.conversionHeight),
                                        width: 245.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 245.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let loaderImageView = UIImageView.init(frame: frameForImageView)
    loaderImageView.backgroundColor = UIColor.clearColor()
    loaderImageView.animationImages = UtilityManager.sharedInstance.arrayOfImagesForLoader
    loaderImageView.startAnimating()
    loadingView.addSubview(loaderImageView)
    
    let genericLabel = self.createGenericLabel(backViewOfClipCard.frame, stringOfLabel: "Estamos calculando tus resultados")
    backViewOfClipCard.addSubview(genericLabel)
    backViewOfClipCard.addSubview(loadingView)
    
    self.flipCard.setSecondView(backViewOfClipCard)
    
    self.flipCard.flip()
    
  }
  
  private func createGenericLabel(frameOfCard: CGRect, stringOfLabel: String) -> UILabel{
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 149.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    let newLabel = UILabel.init(frame: frameForLabel)
    newLabel.numberOfLines = 0
    newLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: stringOfLabel,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    newLabel.attributedText = stringWithFormat
    newLabel.sizeToFit()
    let newFrame = CGRect.init(x: (frameOfCard.size.width / 2.0) - (newLabel.frame.size.width / 2.0),
                               y: 365.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: newLabel.frame.size.width,
                               height: newLabel.frame.size.height)
    
    newLabel.frame = newFrame
    
    return newLabel
    
  }
  
  //MARK: - SuccessfullyCreationOfPitchViewDelegate
  
  func nextButtonPressedFromSuccessfullyCreationOfPitch() {
    
    
    
  }
  
  @objc private func dismissKeyboard(sender:AnyObject) {
    
    self.view.endEditing(true)
    
  }
  
}