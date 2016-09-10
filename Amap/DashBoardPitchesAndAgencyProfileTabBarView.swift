//
//  DashBoardPitchesAndAgencyProfileTabBarView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/31/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol DashBoardPitchesAndAgencyProfileTabBarViewDelegate {
  
  func dashBoardButtonFromTabBarPressed()
  func pitchesButtonFromTabBarPressed()
  func agencyProfileButtonFromTabBarPressed()
  
}

class DashBoardPitchesAndAgencyProfileTabBarView: UIView{
  
  private var dashBoardButton: UIButton! = nil
  private var pitchesButton: UIButton! = nil
  private var agencyProfileButton: UIButton! = nil
  
  var delegate: DashBoardPitchesAndAgencyProfileTabBarViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(atPoint: CGPoint) {
    let tabWidth = UIScreen.mainScreen().bounds.size.width
    let tabHeight = 60.0 * UtilityManager.sharedInstance.conversionHeight
    
    let frameForProfileTab = CGRect.init(x: atPoint.x,
                                         y: atPoint.y,
                                         width: tabWidth,
                                         height: tabHeight)
    
    super.init(frame: frameForProfileTab)
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    let widthOfButtons = self.frame.size.width / 3.0
    self.createButtons(widthOfButtons)
    
  }
  
  private func createButtons(widthOfButtons: CGFloat) {
    
    self.createDashBoardButton(widthOfButtons)
    self.createPitchesButton(widthOfButtons)
    self.createAgencyProfileButton(widthOfButtons)
    
  }
  
  
  private func createDashBoardButton(width: CGFloat) {
    
    let frameForButton = CGRect.init(x: 0.0,
                                     y: 0.0,
                                     width: width,
                                     height: self.frame.size.height)
    
    
    dashBoardButton = UIButton.init(frame: frameForButton)
    dashBoardButton.setImage(UIImage(named:"iconDashboardMedium"), forState: UIControlState.Normal)
    dashBoardButton.setImage(UIImage(named:"iconDashboardWhite"), forState: UIControlState.Selected)
    
    dashBoardButton.imageEdgeInsets = UIEdgeInsets(top: 10.0 * UtilityManager.sharedInstance.conversionHeight,
                                                   left: 50.0 * UtilityManager.sharedInstance.conversionWidth,
                                                   bottom: 25.0 * UtilityManager.sharedInstance.conversionHeight,
                                                   right: 50.0 * UtilityManager.sharedInstance.conversionWidth)
    
    dashBoardButton.titleEdgeInsets = UIEdgeInsets(top: 39.0 * UtilityManager.sharedInstance.conversionHeight,
                                                   left: -18.0 * UtilityManager.sharedInstance.conversionWidth,
                                                   bottom: 9.0 * UtilityManager.sharedInstance.conversionHeight,
                                                   right: 10.0)
    
    let colorForTextWhenNotPressed = UIColor.init(red: 255.0/255.0,
                                                  green: 255.0/255.0,
                                                  blue: 255.0/255.0,
                                                  alpha: 0.4)
    
    let colorForTextWhenPressed = UIColor.init(red: 255.0/255.0,
                                               green: 255.0/255.0,
                                               blue: 255.0/255.0,
                                               alpha: 1.0)
    
    dashBoardButton.setTitle(AgencyProfileVisualizeConstants.TabBarView.dashBoardButtonText,
                             forState: UIControlState.Normal)
    dashBoardButton.titleLabel?.font = UIFont(name: "SFUIText-Regular",
                                              size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
    dashBoardButton.setTitleColor(colorForTextWhenNotPressed,
                                  forState: .Normal)
    dashBoardButton.setTitleColor(colorForTextWhenPressed,
                                  forState: .Selected)
    dashBoardButton.backgroundColor = UIColor.blackColor()
    dashBoardButton.addTarget(self, action: #selector(dashBoardButtonPressed),
                              forControlEvents: UIControlEvents.TouchUpInside)
    self.addSubview(dashBoardButton)
    
  }
  
  private func createPitchesButton(width: CGFloat) {
    
    let frameForButton = CGRect.init(x: width,
                                     y: 0.0,
                                     width: width,
                                     height: self.frame.size.height)
    
    
    pitchesButton = UIButton.init(frame: frameForButton)
    pitchesButton.setImage(UIImage(named:"iconPitchesMedium"), forState: UIControlState.Normal)
    pitchesButton.setImage(UIImage(named:"iconPitchesWhite"), forState: UIControlState.Selected)
    
    pitchesButton.imageEdgeInsets = UIEdgeInsets(top: 10.0 * UtilityManager.sharedInstance.conversionHeight,
                                                 left: 50.0 * UtilityManager.sharedInstance.conversionWidth,
                                                 bottom: 25.0 * UtilityManager.sharedInstance.conversionHeight,
                                                 right: 50.0 * UtilityManager.sharedInstance.conversionWidth)
    
    pitchesButton.titleEdgeInsets = UIEdgeInsets(top: 39.0 * UtilityManager.sharedInstance.conversionHeight,
                                                 left: -17.0 * UtilityManager.sharedInstance.conversionWidth,
                                                 bottom: 9.0 * UtilityManager.sharedInstance.conversionHeight,
                                                 right: 10.0)
    
    let colorForTextWhenNotPressed = UIColor.init(red: 255.0/255.0,
                                                  green: 255.0/255.0,
                                                  blue: 255.0/255.0,
                                                  alpha: 0.4)
    
    let colorForTextWhenPressed = UIColor.init(red: 255.0/255.0,
                                               green: 255.0/255.0,
                                               blue: 255.0/255.0,
                                               alpha: 1.0)
    
    pitchesButton.setTitle(AgencyProfileVisualizeConstants.TabBarView.pitchesButtonText,
                           forState: UIControlState.Normal)
    pitchesButton.titleLabel?.font = UIFont(name: "SFUIText-Regular",
                                            size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
    pitchesButton.setTitleColor(colorForTextWhenNotPressed,
                                forState: .Normal)
    pitchesButton.setTitleColor(colorForTextWhenPressed,
                                forState: .Selected)
    pitchesButton.backgroundColor = UIColor.blackColor()
    pitchesButton.addTarget(self, action: #selector(pitchesButtonPressed),
                            forControlEvents: UIControlEvents.TouchUpInside)
    self.addSubview(pitchesButton)
    
  }
  
  private func createAgencyProfileButton(width: CGFloat) {
    
    let frameForButton = CGRect.init(x: width * 2.0,
                                     y: 0.0,
                                     width: width,
                                     height: self.frame.size.height)
    
    
    agencyProfileButton = UIButton.init(frame: frameForButton)
    agencyProfileButton.setImage(UIImage(named:"iconAgencyMedium"), forState: UIControlState.Normal)
    agencyProfileButton.setImage(UIImage(named:"iconAgencyWhite"), forState: UIControlState.Selected)
    
    agencyProfileButton.imageEdgeInsets = UIEdgeInsets(top: 10.0 * UtilityManager.sharedInstance.conversionHeight,
                                                       left: 50.0 * UtilityManager.sharedInstance.conversionWidth,
                                                       bottom: 25.0 * UtilityManager.sharedInstance.conversionHeight,
                                                       right: 50.0 * UtilityManager.sharedInstance.conversionWidth)
    
    agencyProfileButton.titleEdgeInsets = UIEdgeInsets(top: 39.0 * UtilityManager.sharedInstance.conversionHeight,
                                                       left: -14.0 * UtilityManager.sharedInstance.conversionWidth,
                                                       bottom: 9.0 * UtilityManager.sharedInstance.conversionHeight,
                                                       right: 10.0)
    
    let colorForTextWhenNotPressed = UIColor.init(red: 255.0/255.0,
                                                  green: 255.0/255.0,
                                                  blue: 255.0/255.0,
                                                  alpha: 0.4)
    
    let colorForTextWhenPressed = UIColor.init(red: 255.0/255.0,
                                               green: 255.0/255.0,
                                               blue: 255.0/255.0,
                                               alpha: 1.0)
    
    agencyProfileButton.setTitle(AgencyProfileVisualizeConstants.TabBarView.agencyProfileButtonText,
                                 forState: UIControlState.Normal)
    agencyProfileButton.titleLabel?.font = UIFont(name: "SFUIText-Regular",
                                                  size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
    agencyProfileButton.setTitleColor(colorForTextWhenNotPressed,
                                      forState: .Normal)
    agencyProfileButton.setTitleColor(colorForTextWhenPressed,
                                      forState: .Selected)
    agencyProfileButton.backgroundColor = UIColor.blackColor()
    agencyProfileButton.addTarget(self, action: #selector(agencyProfileButtonPressed),
                                  forControlEvents: UIControlEvents.TouchUpInside)
    self.addSubview(agencyProfileButton)
    
  }
  
  
  @objc private func dashBoardButtonPressed(sender: AnyObject) {
    
    dashBoardButton.selected = true
    pitchesButton.selected = false
    agencyProfileButton.selected = false
    
    self.delegate?.dashBoardButtonFromTabBarPressed()
    
  }
  
  @objc private func pitchesButtonPressed(sender: AnyObject) {
    
    dashBoardButton.selected = false
    pitchesButton.selected = true
    agencyProfileButton.selected = false
    
    self.delegate?.pitchesButtonFromTabBarPressed()
    
  }
  
  @objc private func agencyProfileButtonPressed(sender: AnyObject) {
    
    dashBoardButton.selected = false
    pitchesButton.selected = false
    agencyProfileButton.selected = true
    
    self.delegate?.agencyProfileButtonFromTabBarPressed()
    
  }
  
  
  
  
}
