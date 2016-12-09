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
    
    self.editNavigationController()
    self.createContainerView()
    self.createMainScrollView()
    self.createPitchCard()
    self.createEvaluationBreakDown()
    
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
                                     height: frameForScroll.size.height + (450 * UtilityManager.sharedInstance.conversionHeight))
    
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
    
    let descriptionOne: [String: String] = ["description_text": "Agencias con objetivos claros",
                                             "percentage_text": "45"
                                            ]
    
    let descriptionTwo: [String: String] = ["description_text": "Agencias que cuentan con budget definido",
                                             "percentage_text": "33"
                                            ]
    
    let descriptionThree: [String: String] = ["description_text": "Agencias que saben los criterios de selección",
                                            "percentage_text": "56"
    ]
    
    let descriptionFour: [String: String] = ["description_text": "Agencias que tienen los entregables claros",
                                            "percentage_text": "76"
    ]
    
    let descriptionFive: [String: String] = ["description_text": "Agencias involucradas con alguien senior",
                                            "percentage_text": "29"
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
    
    
  }
  
}
