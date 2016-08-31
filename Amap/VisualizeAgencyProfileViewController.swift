//
//  VisualizeAgencyProfileViewController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/30/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class VisualizeAgencyProfileViewController: UIViewController {
  
  private var mainTabBar: DashBoardPitchesAndAgencyProfileTabBarView! = nil
  private var flipCard: FlipCardView! = nil
  private var frontViewOfClipCard: UIView! = nil
  private var profilePicNameButtonsView: AgencyProfilePicNameButtonsView! = nil
  private var mainScrollView: UIScrollView! = nil
  
  override func loadView() {
    
    self.view = UIView.init(frame: UIScreen.mainScreen().bounds)
    self.view.backgroundColor = UIColor.blackColor()
    self.view.addSubview(self.createGradientView())
    self.editNavigationBar()
    self.createBottomTabBar()
    self.initInterface()
    
  }
  
  private func editNavigationBar() {
    
    self.navigationController?.navigationBarHidden = false
    
    self.changeBackButtonItem()
    self.changeNavigationBarTitle()
    self.changeRigthButtonItem()
    
  }
  
  private func changeBackButtonItem() {
    
    let backButton = UIBarButtonItem(title: AgencyProfileVisualizeConstants.VisualizeAgencyProfileViewController.backButtonText,
      style: UIBarButtonItemStyle.Plain,
      target: self,
      action: #selector(pushEditAgencyProfile))
    
    let fontForButtonItem =  UIFont(name: "SFUIText-Regular",
                                    size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    
    let attributesDict: [String:AnyObject] = [NSFontAttributeName: fontForButtonItem!,
                                              NSForegroundColorAttributeName: UIColor.whiteColor()
                                              ]
    
    backButton.setTitleTextAttributes(attributesDict, forState: .Normal)
  
    self.navigationItem.leftBarButtonItem = backButton
    
  }
  
  private func changeNavigationBarTitle() {
    
    let titleLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 17.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: AgencyProfileVisualizeConstants.VisualizeAgencyProfileViewController.navigationBarText,
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    titleLabel.attributedText = stringWithFormat
    titleLabel.sizeToFit()
    self.navigationItem.titleView = titleLabel
    
  }
  
  private func changeRigthButtonItem() {
    
    let rightButton = UIBarButtonItem(title: AgencyProfileVisualizeConstants.VisualizeAgencyProfileViewController.rightButtonText,
      style: UIBarButtonItemStyle.Plain,
      target: self,
      action: #selector(logOutAndPopThis))
    
    let fontForButtonItem =  UIFont(name: "SFUIText-Regular",
                                    size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    
    let attributesDict: [String:AnyObject] = [NSFontAttributeName: fontForButtonItem!,
                                              NSForegroundColorAttributeName: UIColor.whiteColor()
                                              ]
    
    rightButton.setTitleTextAttributes(attributesDict, forState: .Normal)
    
    self.navigationItem.rightBarButtonItem = rightButton
    
  }
  
  private func createBottomTabBar() {
    
    let pointYForTabBar = UIScreen.mainScreen().bounds.size.height - (60.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let pointToAddTabBar = CGPoint.init(x: 0.0,
                                        y: pointYForTabBar)
    
    mainTabBar = DashBoardPitchesAndAgencyProfileTabBarView.init(atPoint: pointToAddTabBar)
    self.view.addSubview(mainTabBar)
  }
  
  private func initInterface() {
    
    self.createAndAddFlipCard()
    
  }
  
  private func createGradientView() -> GradientView{
    
    let frameForView = CGRect.init(x: 0.0, y: 60.0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height - 60.0)
    
    let firstColorGradient = UIColor.init(red: 239.0/255.0, green: 255.0/255.0, blue: 145.0/255.0, alpha: 1.0)
    let secondColorGradient = UIColor.init(red: 250.0/255.0, green: 117.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    let colorsForBackground = [firstColorGradient,secondColorGradient]
    
    return GradientView.init(frame: frameForView, arrayOfcolors: colorsForBackground, typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
    
  }
  
  
  private func createAndAddFlipCard() {
    
    let widthOfCard = self.view.frame.size.width - (80.0 * UtilityManager.sharedInstance.conversionWidth)
    let heightOfCard = self.view.frame.size.height - (168.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let frameForFlipCard = CGRect.init(x: (40.0 * UtilityManager.sharedInstance.conversionWidth),
                                       y: (108.0 * UtilityManager.sharedInstance.conversionHeight),
                                       width: widthOfCard,
                                       height: heightOfCard)
    
    let frameForViewsOfCard = CGRect.init(x: 0.0, y: 0.0, width: widthOfCard, height: heightOfCard)

    //createTheFrontCard
    self.createFrontViewForFlipCard(frameForViewsOfCard)

    //createTheBackCard
    let blankView = UIView.init(frame:frameForViewsOfCard)
//
    flipCard = FlipCardView.init(frame: frameForFlipCard, viewOne: frontViewOfClipCard, viewTwo: blankView)
    self.view.addSubview(flipCard)
    
  }
  
  private func createFrontViewForFlipCard(frameForCards: CGRect) {
    
    frontViewOfClipCard = UIView.init(frame: frameForCards)
    frontViewOfClipCard.backgroundColor = UIColor.whiteColor()
    
    self.createProfilePicNameButtonsView()
    self.createMainScrollView()
    
  }
  
  private func createProfilePicNameButtonsView() {
    
    let frameForProfilePicStuff = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                              y: 30.0 * UtilityManager.sharedInstance.conversionHeight,
                                          width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                         height: 123.0 * UtilityManager.sharedInstance.conversionHeight)
    
    profilePicNameButtonsView = AgencyProfilePicNameButtonsView.init(frame: frameForProfilePicStuff)

    frontViewOfClipCard.addSubview(profilePicNameButtonsView)
    
  }
  
  private func createMainScrollView() {
    
    
    //    self.createButtonsForFlipCard()

  }
  
  @objc private func pushEditAgencyProfile() {
  
    let editStuffAgency = EditAgencyProfileViewController()
    self.navigationController?.pushViewController(editStuffAgency, animated: true)
    
  }
  
  @objc private func logOutAndPopThis() {
    
    RequestToServerManager.sharedInstance.logOut(){
      self.navigationController?.popViewControllerAnimated(true)
    }
    
  }
  
  
  
}
