//
//  VisualizeMainCardsDashboardViewController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/28/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol VisualizeMainCardsDashboardViewControllerShowAndHideDelegate {
  
  func requestToHideTabBarFromVisualizeMainCardsDashboardViewController()
  func requestToShowTabBarFromVisualizeMainCardsDashboardViewController()
  
}

class VisualizeMainCardsDashboardViewController: UIViewController {
  
  private let kNumberOfCards = 3
  
  private var mainScrollView: UIScrollView! = nil
  private var gralPerformanceCardView: GeneralPerformanceCardView! = nil
  
  //JUST FOR TEST
  private var firstCard: GraphAccordingToUserView! = nil
  private var thirdCard: GraphOfAgencyVSIndustryView! = nil

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
    
    self.createMainScrollView()
    self.createCards()
    
  }
  
  private func changeNavigationBarTitle() {
    
    let titleLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 17.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizeDashboardConstants.VisualizeMainCardsDashboardViewController.navigationBarTitleText,
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
    
    let rightButton = UIBarButtonItem(title:"",
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
  
  private func createMainScrollView() {
    
    let firstCardPoint = CGPoint.init(x: UIScreen.mainScreen().bounds.width,
                                      y: 0.0)
    
    mainScrollView = UIScrollView.init(frame: UIScreen.mainScreen().bounds)
    mainScrollView.backgroundColor = UIColor.clearColor()
    mainScrollView.contentSize = CGSize.init(width: UIScreen.mainScreen().bounds.width * CGFloat(kNumberOfCards),
                                            height: UIScreen.mainScreen().bounds.height)
    mainScrollView.pagingEnabled = true
    mainScrollView.setContentOffset(firstCardPoint, animated: false)
    
    self.view.addSubview(mainScrollView)
    
  }
  
  private func createCards() {
    
    self.createGeneralPerformanceCard()
    
  }
  
  
  private func createGeneralPerformanceCard() {
    
    let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
    let heightOfCard = self.view.frame.size.height - (168.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let frameForFirstCard = CGRect.init(x: (40.0 * UtilityManager.sharedInstance.conversionWidth),
                                        y: (108.0 * UtilityManager.sharedInstance.conversionHeight),
                                    width: widthOfCard,
                                   height: heightOfCard - (51.0 * UtilityManager.sharedInstance.conversionHeight))
    
    let frameForSecondCard = CGRect.init(x: (40.0 * UtilityManager.sharedInstance.conversionWidth) + (mainScrollView.frame.size.width * CGFloat(kNumberOfCards - 2)),
                                         y: (108.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: widthOfCard,
                                    height: heightOfCard)
    
    let frameForThirdCard  = CGRect.init(x: (40.0 * UtilityManager.sharedInstance.conversionWidth) + (mainScrollView.frame.size.width * CGFloat(kNumberOfCards - 1)),
                                         y: (108.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: widthOfCard,
                                    height: heightOfCard - (51.0 * UtilityManager.sharedInstance.conversionHeight))
    
    firstCard = GraphAccordingToUserView.init(frame: frameForFirstCard)
    mainScrollView.addSubview(firstCard)
    
    gralPerformanceCardView = GeneralPerformanceCardView.init(frame: frameForSecondCard)
    mainScrollView.addSubview(gralPerformanceCardView)
    
    thirdCard = GraphOfAgencyVSIndustryView.init(frame: frameForThirdCard)
    mainScrollView.addSubview(thirdCard)
    
  }
  
  private func createGradientView() -> GradientView{
    
    let frameForView = CGRect.init(x: 0.0, y: 60.0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height - 60.0)
    
    let firstColorGradient = UIColor.init(red: 195.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    let secondColorGradient = UIColor.init(red: 117.0/255.0, green: 236.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    let colorsForBackground = [firstColorGradient,secondColorGradient]
    
    return GradientView.init(frame: frameForView, arrayOfcolors: colorsForBackground, typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
    
  }
  
}