//
//  VisualizePitchInformationForCompanyViewController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 12/8/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class VisualizePitchInformationForCompanyViewController: UIViewController {
  
  private var pitchData: PitchEvaluationByUserModelDataForCompany! = nil
  private var descriptionsBreakDownView: EvaluationBreakDownView! = nil
  private var recommendations: PitchRecommendationsView! = nil
  
  private var containerView: UIView! = nil
  private var mainScrollView: UIScrollView! = nil
  
  private var pitchCard: PitchCardForNormalClientView! = nil
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(newPitchData: PitchEvaluationByUserModelDataForCompany) {
    
    pitchData = newPitchData
    
    super.init(nibName: nil, bundle: nil)
    
  }
  
  override func loadView() {
    
    self.view = UIView.init(frame: UIScreen.mainScreen().bounds)
    self.view.backgroundColor = UIColor.blackColor()
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.addGestures()
    self.editNavigationController()
    self.createContainerView()
    self.createMainScrollView()
    self.createPitchCard()
    self.createEvaluationBreakDown()
    self.createRecommendations()
    self.createSharePitch()
    
  }
  
  private func addGestures() {
    
    let tapToDismissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                              action: #selector(dismissKeyboard))
    tapToDismissKeyboard.numberOfTapsRequired = 1
    tapToDismissKeyboard.cancelsTouchesInView = false
    self.view.addGestureRecognizer(tapToDismissKeyboard)
    
  }
  
  private func editNavigationController() {
    
    self.changeBackButtonItemToNil()
    self.changeNavigationBarTitle()
    self.changeNavigationRigthButtonItem()
    
  }
  
  private func changeBackButtonItemToNil() {
    
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
    
    let rightButton = UIBarButtonItem(title: VisualizePitchesConstants.AddResultViewController.rightButtonItemText,
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

  @objc private func navigationRightButtonPressed() {

    self.navigationController?.popToRootViewControllerAnimated(true)
    
  }
  
  private func createContainerView() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: 0.0,
                               width: UIScreen.mainScreen().bounds.size.width,
                              height: UIScreen.mainScreen().bounds.size.height)
    
    containerView = UIView.init(frame: frameForView)
    containerView.backgroundColor = UIColor.whiteColor()
    
    self.view.addSubview(containerView)
    
  }
  
  private func createMainScrollView() {
    
    let frameForScroll = CGRect.init(x: 0.0,
                                     y: 0.0,
                                     width: containerView.frame.size.width,
                                     height: containerView.frame.size.height)
    
    let sizeForContent = CGSize.init(width: frameForScroll.size.width,
                                     height: frameForScroll.size.height + (1180 * UtilityManager.sharedInstance.conversionHeight))
    
    mainScrollView = UIScrollView.init(frame: frameForScroll)
    mainScrollView.backgroundColor = UIColor.whiteColor()
    mainScrollView.contentSize = sizeForContent
    
    containerView.addSubview(mainScrollView)
    
  }

  private func createPitchCard() {
    
    let frameForNewView = CGRect.init(x: ((mainScrollView.frame.size.width - (375.0 * UtilityManager.sharedInstance.conversionWidth)) / 4.0),
                                      y: 0.0,
                                      width: 375.0 * UtilityManager.sharedInstance.conversionWidth,
                                      height: 454.0 * UtilityManager.sharedInstance.conversionHeight)
    
    pitchCard = PitchCardForNormalClientView.init(frame: frameForNewView,
                                                    newPitchData: pitchData)
    
    mainScrollView.addSubview(pitchCard)
    
    let border = CALayer()
    let width = CGFloat(1)
    border.borderColor = UIColor.grayColor().CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 40.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 442.0 * UtilityManager.sharedInstance.conversionHeight,
                           width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                          height: 1.0 * UtilityManager.sharedInstance.conversionHeight)
    mainScrollView.layer.addSublayer(border)
    mainScrollView.layer.masksToBounds = false
    
  }
  
  private func createEvaluationBreakDown() {
    
    let deliverablesClear = (pitchData.breakDown["deliverables_clear"] as? Int != nil ? String(pitchData.breakDown["deliverables_clear"] as! Int) : "0")
    
    let marketingInvolved = (pitchData.breakDown["marketing_involved"] as? Int != nil ? String(pitchData.breakDown["marketing_involved"] as! Int) : "0")
    
    let objectivesClear = (pitchData.breakDown["objectives_clear"] as? Int != nil ? String(pitchData.breakDown["objectives_clear"] as! Int) : "0")
    
    let budgetKnown = (pitchData.breakDown["budget_known"] as? Int != nil ? String(pitchData.breakDown["budget_known"] as! Int) : "0")
    
    let selectionCriteria = (pitchData.breakDown["selection_criteria"] as? Int != nil ? String(pitchData.breakDown["selection_criteria"] as! Int) : "0")
    
    
    
    let descriptionOne: [String: String] = ["description_text": "Agencias con objetivos claros",
                                             "percentage_text": objectivesClear
                                            ]
    
    let descriptionTwo: [String: String] = ["description_text": "Agencias que cuentan con budget definido",
                                             "percentage_text": budgetKnown
                                            ]
    
    let descriptionThree: [String: String] = ["description_text": "Agencias que saben los criterios de selección",
                                            "percentage_text": selectionCriteria
    ]
    
    let descriptionFour: [String: String] = ["description_text": "Agencias que tienen los entregables claros",
                                            "percentage_text": deliverablesClear
    ]
    
    let descriptionFive: [String: String] = ["description_text": "Agencias involucradas con alguien senior",
                                            "percentage_text": marketingInvolved
    ]
    
    let arrayOfDescriptions: Array<[String: String]> = [descriptionOne,
                                                       descriptionTwo,
                                                       descriptionThree,
                                                       descriptionFour,
                                                       descriptionFive
                                                      ]
    
    let frameForView = CGRect.init(x: 40.0 * UtilityManager.sharedInstance.conversionWidth,
                                   y: 475.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                              height: 0.0)
    
    descriptionsBreakDownView = EvaluationBreakDownView.init(frame: frameForView,
                                                      descriptions: arrayOfDescriptions)
    
    mainScrollView.addSubview(descriptionsBreakDownView)
    
    
    let border = CALayer()
    let width = CGFloat(1)
    border.borderColor = UIColor.grayColor().CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 40.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: descriptionsBreakDownView.frame.origin.y + descriptionsBreakDownView.frame.size.height + (30.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                               height: 1.0 * UtilityManager.sharedInstance.conversionHeight)
    mainScrollView.layer.addSublayer(border)
    mainScrollView.layer.masksToBounds = false
    
    
  }
  
  private func createRecommendations() {
    
    let frameForView = CGRect.init(x: 40.0 * UtilityManager.sharedInstance.conversionWidth,
                                   y: descriptionsBreakDownView.frame.origin.y + descriptionsBreakDownView.frame.size.height + (60.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                              height: 285.0 * UtilityManager.sharedInstance.conversionHeight)
    
    recommendations = PitchRecommendationsView.init(frame: frameForView,
                                           newRecommendations: pitchData.recommendations)
    
    mainScrollView.addSubview(recommendations)
    
    let border = CALayer()
    let width = CGFloat(1)
    border.borderColor = UIColor.grayColor().CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 40.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: recommendations.frame.origin.y + recommendations.getFinalHeight() + (22.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                               height: 1.0 * UtilityManager.sharedInstance.conversionHeight)
    mainScrollView.layer.addSublayer(border)
    mainScrollView.layer.masksToBounds = false
    
  }
  
  private func createSharePitch() {
    
    let frameForView = CGRect.init(x: 40.0 * UtilityManager.sharedInstance.conversionWidth,
                                   y: recommendations.frame.origin.y + recommendations.frame.size.height - (10.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                              height: 345.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let sharePitch = PitchCompanyshareView.init(frame: frameForView)
//    sharePitch.delegate = self
    
    mainScrollView.addSubview(sharePitch)
    
  }
  
  @objc private func dismissKeyboard(sender:AnyObject) {
    
    self.view.endEditing(true)
    
  }
  
}
