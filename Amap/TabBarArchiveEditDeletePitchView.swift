//
//  TabBarArchiveEditDeletePitchView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/13/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol TabBarArchiveEditDeletePitchViewDelegate {
  
  func archivePitchEvaluationButtonFromTabBarPressed()
  func editPitchEvaluationButtonFromTabBarPressed()
  func deletePitchEvaluationButtonFromTabBarPressed()
  
}

class TabBarArchiveEditDeletePitchView: UIView{
  
  private var archivePitchEvaluationButton: UIButton! = nil
  private var editPitchEvaluationButton: UIButton! = nil
  private var deletePitchEvaluationButton: UIButton! = nil
  
  var delegate: TabBarArchiveEditDeletePitchViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(atPoint: CGPoint) {
    let tabWidth = UIScreen.mainScreen().bounds.size.width
    let tabHeight = 49.0 * UtilityManager.sharedInstance.conversionHeight
    
    let frameForProfileTab = CGRect.init(x: atPoint.x,
                                         y: atPoint.y,
                                         width: tabWidth,
                                         height: tabHeight)
    
    super.init(frame: frameForProfileTab)
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.blackColor()
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
    
    
    archivePitchEvaluationButton = UIButton.init(frame: frameForButton)
    
    var buttonImage = UIImage.init(named: "archivar")
    let newSize = CGSize.init(width: 25.0 * UtilityManager.sharedInstance.conversionWidth,
                             height: 25.0 * UtilityManager.sharedInstance.conversionHeight)
    buttonImage = UtilityManager.sharedInstance.resizeImage(buttonImage!, newSize: newSize)
    
    
    archivePitchEvaluationButton.setImage(buttonImage, forState: UIControlState.Normal)
    archivePitchEvaluationButton.imageEdgeInsets = UIEdgeInsets(top: 5.0 * UtilityManager.sharedInstance.conversionHeight,
                                                   left: 50.0 * UtilityManager.sharedInstance.conversionWidth,
                                                   bottom: 15.0 * UtilityManager.sharedInstance.conversionHeight,
                                                   right: 50.0 * UtilityManager.sharedInstance.conversionWidth)
    
    archivePitchEvaluationButton.titleEdgeInsets = UIEdgeInsets(top: 39.0 * UtilityManager.sharedInstance.conversionHeight,
                                                   left: -16.0 * UtilityManager.sharedInstance.conversionWidth,
                                                   bottom: 9.0 * UtilityManager.sharedInstance.conversionHeight,
                                                   right: 10.0 * UtilityManager.sharedInstance.conversionWidth)
    
    let colorForTextWhenNotPressed = UIColor.init(red: 255.0/255.0,
                                                  green: 255.0/255.0,
                                                  blue: 255.0/255.0,
                                                  alpha: 1.0)
    
    let colorForTextWhenPressed = UIColor.init(red: 255.0/255.0,
                                               green: 255.0/255.0,
                                               blue: 255.0/255.0,
                                               alpha: 1.0)
    
    archivePitchEvaluationButton.setTitle(EditPitchesConstants.TabBarArchiveEditDeletePitchView.archivePitchButtonText,
                             forState: UIControlState.Normal)
    archivePitchEvaluationButton.titleLabel?.font = UIFont(name: "SFUIText-Regular",
                                              size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
    archivePitchEvaluationButton.setTitleColor(colorForTextWhenNotPressed,
                                  forState: .Normal)
    archivePitchEvaluationButton.setTitleColor(colorForTextWhenPressed,
                                  forState: .Selected)
    archivePitchEvaluationButton.backgroundColor = UIColor.blackColor()
    archivePitchEvaluationButton.addTarget(self, action: #selector(archivePitchEvaluationButtonPressed),
                              forControlEvents: UIControlEvents.TouchUpInside)
    
    archivePitchEvaluationButton.alpha = 1.0
    self.addSubview(archivePitchEvaluationButton)
    
  }
  
  private func createPitchesButton(width: CGFloat) {
    
    let frameForButton = CGRect.init(x: width,
                                     y: 0.0,
                                     width: width,
                                     height: self.frame.size.height)
    
    var buttonImage = UIImage.init(named: "edit")
    let newSize = CGSize.init(width: 25.0 * UtilityManager.sharedInstance.conversionWidth,
                              height: 25.0 * UtilityManager.sharedInstance.conversionHeight)
    buttonImage = UtilityManager.sharedInstance.resizeImage(buttonImage!, newSize: newSize)
    
    editPitchEvaluationButton = UIButton.init(frame: frameForButton)
    editPitchEvaluationButton.setImage(buttonImage, forState: UIControlState.Normal)
    
    editPitchEvaluationButton.imageEdgeInsets = UIEdgeInsets(top: 5.0 * UtilityManager.sharedInstance.conversionHeight,
                                                 left: 50.0 * UtilityManager.sharedInstance.conversionWidth,
                                                 bottom: 15.0 * UtilityManager.sharedInstance.conversionHeight,
                                                 right: 50.0 * UtilityManager.sharedInstance.conversionWidth)
    
    editPitchEvaluationButton.titleEdgeInsets = UIEdgeInsets(top: 39.0 * UtilityManager.sharedInstance.conversionHeight,
                                                 left: -15.0 * UtilityManager.sharedInstance.conversionWidth,
                                                 bottom: 9.0 * UtilityManager.sharedInstance.conversionHeight,
                                                 right: 10.0 * UtilityManager.sharedInstance.conversionWidth)
    
    let colorForTextWhenNotPressed = UIColor.init(red: 255.0/255.0,
                                                  green: 255.0/255.0,
                                                  blue: 255.0/255.0,
                                                  alpha: 1.0)
    
    let colorForTextWhenPressed = UIColor.init(red: 255.0/255.0,
                                               green: 255.0/255.0,
                                               blue: 255.0/255.0,
                                               alpha: 1.0)
    
    editPitchEvaluationButton.setTitle(EditPitchesConstants.TabBarArchiveEditDeletePitchView.editPitchButtonText,
                           forState: UIControlState.Normal)
    editPitchEvaluationButton.titleLabel?.font = UIFont(name: "SFUIText-Regular",
                                            size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
    editPitchEvaluationButton.setTitleColor(colorForTextWhenNotPressed,
                                forState: .Normal)
    editPitchEvaluationButton.setTitleColor(colorForTextWhenPressed,
                                forState: .Selected)
    editPitchEvaluationButton.backgroundColor = UIColor.blackColor()
    editPitchEvaluationButton.addTarget(self, action: #selector(editPitchEvaluationButtonPressed),
                            forControlEvents: UIControlEvents.TouchUpInside)
    editPitchEvaluationButton.alpha = 1.0
    
    self.addSubview(editPitchEvaluationButton)
    
  }
  
  private func createAgencyProfileButton(width: CGFloat) {
    
    let frameForButton = CGRect.init(x: width * 2.0,
                                     y: 0.0,
                                     width: width,
                                     height: self.frame.size.height)
    
    var buttonImage = UIImage.init(named: "eliminar")
    let newSize = CGSize.init(width: 25.0 * UtilityManager.sharedInstance.conversionWidth,
                              height: 25.0 * UtilityManager.sharedInstance.conversionHeight)
    buttonImage = UtilityManager.sharedInstance.resizeImage(buttonImage!, newSize: newSize)
    
    deletePitchEvaluationButton = UIButton.init(frame: frameForButton)
    deletePitchEvaluationButton.setImage(UIImage(named:"eliminar"), forState: UIControlState.Normal)
    
    deletePitchEvaluationButton.imageEdgeInsets = UIEdgeInsets(top: 5.0 * UtilityManager.sharedInstance.conversionHeight,
                                                       left: 50.0 * UtilityManager.sharedInstance.conversionWidth,
                                                       bottom: 15.0 * UtilityManager.sharedInstance.conversionHeight,
                                                       right: 50.0 * UtilityManager.sharedInstance.conversionWidth)
    
    deletePitchEvaluationButton.titleEdgeInsets = UIEdgeInsets(top: 39.0 * UtilityManager.sharedInstance.conversionHeight,
                                                       left: -14.0 * UtilityManager.sharedInstance.conversionWidth,
                                                       bottom: 9.0 * UtilityManager.sharedInstance.conversionHeight,
                                                       right: 10.0)
    
    let colorForTextWhenNotPressed = UIColor.init(red: 255.0/255.0,
                                                  green: 255.0/255.0,
                                                  blue: 255.0/255.0,
                                                  alpha: 1.0)
    
    let colorForTextWhenPressed = UIColor.init(red: 255.0/255.0,
                                               green: 255.0/255.0,
                                               blue: 255.0/255.0,
                                               alpha: 1.0)
    
    deletePitchEvaluationButton.setTitle(EditPitchesConstants.TabBarArchiveEditDeletePitchView.deletePitchButtonText,
                                 forState: UIControlState.Normal)
    deletePitchEvaluationButton.titleLabel?.font = UIFont(name: "SFUIText-Regular",
                                                  size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
    deletePitchEvaluationButton.setTitleColor(colorForTextWhenNotPressed,
                                      forState: .Normal)
    deletePitchEvaluationButton.setTitleColor(colorForTextWhenPressed,
                                      forState: .Selected)
    deletePitchEvaluationButton.backgroundColor = UIColor.blackColor()
    deletePitchEvaluationButton.addTarget(self, action: #selector(deletePitchEvaluationButtonPressed),
                                  forControlEvents: UIControlEvents.TouchUpInside)
    deletePitchEvaluationButton.alpha = 1.0
    
    self.addSubview(deletePitchEvaluationButton)
    
  }
  
  
  @objc private func archivePitchEvaluationButtonPressed(sender: AnyObject) {
    
//    archivePitchEvaluationButton.selected = true
//    editPitchEvaluationButton.selected = false
//    deletePitchEvaluationButton.selected = false
//    
//    self.animateArchiveButtonSelected()
//    self.animateEditButtonUnselected()
//    self.animateDeleteButtonUnselected()
    
    self.delegate?.archivePitchEvaluationButtonFromTabBarPressed()
    
  }
  
  @objc private func editPitchEvaluationButtonPressed(sender: AnyObject) {
    
//    archivePitchEvaluationButton.selected = false
//    editPitchEvaluationButton.selected = true
//    deletePitchEvaluationButton.selected = false
//    
//    self.animateArchiveButtonUnselected()
//    self.animateEditButtonSelected()
//    self.animateDeleteButtonUnselected()
    
    self.delegate?.editPitchEvaluationButtonFromTabBarPressed()
    
  }
  
  @objc private func deletePitchEvaluationButtonPressed(sender: AnyObject) {
    
//    archivePitchEvaluationButton.selected = false
//    editPitchEvaluationButton.selected = false
//    deletePitchEvaluationButton.selected = true
//    
//    self.animateArchiveButtonUnselected()
//    self.animateEditButtonUnselected()
//    self.animateDeleteButtonSelected()
    
    self.delegate?.deletePitchEvaluationButtonFromTabBarPressed()
    
  }
  
  private func animateArchiveButtonSelected() {
    
    let colorForTextWhenPressed = UIColor.init(red: 255.0/255.0,
                                               green: 255.0/255.0,
                                               blue: 255.0/255.0,
                                               alpha: 1.0)
    
    UIView.animateWithDuration(0.15){
      
      self.archivePitchEvaluationButton.alpha = 1.0
      self.archivePitchEvaluationButton.setTitleColor(colorForTextWhenPressed, forState: .Normal)
      
    }
    
  }
  
  private func animateEditButtonSelected() {
    
    let colorForTextWhenPressed = UIColor.init(red: 255.0/255.0,
                                               green: 255.0/255.0,
                                               blue: 255.0/255.0,
                                               alpha: 1.0)
    
    UIView.animateWithDuration(0.15){
      
      self.editPitchEvaluationButton.alpha = 1.0
      self.editPitchEvaluationButton.setTitleColor(colorForTextWhenPressed, forState: .Normal)
      
    }
    
  }
  
  private func animateDeleteButtonSelected() {
    
    let colorForTextWhenPressed = UIColor.init(red: 255.0/255.0,
                                               green: 255.0/255.0,
                                               blue: 255.0/255.0,
                                               alpha: 1.0)
    
    UIView.animateWithDuration(0.15){
      
      self.deletePitchEvaluationButton.alpha = 1.0
      self.deletePitchEvaluationButton.setTitleColor(colorForTextWhenPressed, forState: .Normal)
      
    }
    
  }
  
  private func animateArchiveButtonUnselected() {
    
    let colorForTextWhenNotPressed = UIColor.init(red: 255.0/255.0,
                                                  green: 255.0/255.0,
                                                  blue: 255.0/255.0,
                                                  alpha: 0.4)
    
    UIView.animateWithDuration(0.15){
      
      self.archivePitchEvaluationButton.alpha = 0.7
      self.archivePitchEvaluationButton.setTitleColor(colorForTextWhenNotPressed, forState: .Normal)
      
    }
    
  }
  
  private func animateEditButtonUnselected() {
    
    let colorForTextWhenNotPressed = UIColor.init(red: 255.0/255.0,
                                                  green: 255.0/255.0,
                                                  blue: 255.0/255.0,
                                                  alpha: 0.4)
    
    UIView.animateWithDuration(0.15){
      
      self.editPitchEvaluationButton.alpha = 0.7
      self.editPitchEvaluationButton.setTitleColor(colorForTextWhenNotPressed, forState: .Normal)
      
    }
    
  }
  
  private func animateDeleteButtonUnselected() {
    
    let colorForTextWhenNotPressed = UIColor.init(red: 255.0/255.0,
                                                  green: 255.0/255.0,
                                                  blue: 255.0/255.0,
                                                  alpha: 0.4)
    
    UIView.animateWithDuration(0.15){
      
      self.deletePitchEvaluationButton.alpha = 0.7
      self.deletePitchEvaluationButton.setTitleColor(colorForTextWhenNotPressed, forState: .Normal)
      
    }
    
  }
  
  
  
  
}
