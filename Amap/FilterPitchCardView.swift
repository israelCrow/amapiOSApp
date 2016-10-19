//
//  FilterPitchCardView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/18/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol FilterPitchCardViewDelegate {
  
  func doCancelFilteringPitches()
  
}

class FilterPitchCardView: UIView {
  
  private var cancelButton: UIButton! = nil
  private var mainScrollView: UIScrollView! = nil
  private var happitchCriterion: CriterionWithImageView! = nil
  private var silverCriterion: CriterionWithImageView! = nil
  private var mediumCriterion: CriterionWithImageView! = nil
  private var highRiskCriterion: CriterionWithImageView! = nil
  private var archivedPitchCriterion: CriterionView! = nil
  private var declinedPitchCriterion: CriterionView! = nil
  private var canceledPitchCriterion: CriterionView! = nil
  
  var delegate: FilterPitchCardViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    
    self.createCancelButton()
    self.createMainScrollView()
    self.createHappitchCriterion()
    self.createSilverCriterion()
    self.createMediumCriterion()
    self.createHighRiskCriterion()
    self.createArchivedPitch()
    self.createDeclinedPitch()
    self.createCanceledPitch()
    
  }
  
  private func createCancelButton() {
    
    let frameForButton = CGRect.init(x:270.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 10.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 15.0 * UtilityManager.sharedInstance.conversionWidth ,
                                     height: 15.0 * UtilityManager.sharedInstance.conversionHeight)
    
    cancelButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "iconCloseBlack") as UIImage?
    cancelButton.setImage(image, forState: .Normal)
    cancelButton.alpha = 1.0
    cancelButton.addTarget(self, action: #selector(cancelButtonPressed), forControlEvents:.TouchUpInside)
    
    self.addSubview(cancelButton)
    
  }
  
  private func createMainScrollView() {
    
    let frameForMainScrollView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                             y: 15.0 * UtilityManager.sharedInstance.conversionHeight,
                                             width: 235.0 * UtilityManager.sharedInstance.conversionWidth,
                                             height: 415.0 * UtilityManager.sharedInstance.conversionHeight)//Value that I considered
    let sizeForContentScrollView = CGSize.init(width: frameForMainScrollView.size.width,
                                               height: frameForMainScrollView.size.height + (10.0 * UtilityManager.sharedInstance.conversionHeight))//Value that i considered
    
    mainScrollView = UIScrollView.init(frame: frameForMainScrollView)
    mainScrollView.backgroundColor = UIColor.clearColor()
    mainScrollView.contentSize = sizeForContentScrollView
    mainScrollView.showsVerticalScrollIndicator = true
    self.addSubview(mainScrollView)
    
  }
  
  private func createHappitchCriterion() {
    
    let frameForCriterion = CGRect.init(x: 0.0,
                                        y: 17.0 * UtilityManager.sharedInstance.conversionHeight,
                                    width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
    
    happitchCriterion = CriterionWithImageView.init(frame: frameForCriterion,
                                                nameImage: "color_fill1",
                                            valueOfSwitch: false)
    mainScrollView.addSubview(happitchCriterion)
    
  }
  
  private func createSilverCriterion() {
    
    let frameForCriterion = CGRect.init(x: 0.0,
                                        y: 73.0 * UtilityManager.sharedInstance.conversionHeight,
                                        width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
    
    silverCriterion = CriterionWithImageView.init(frame: frameForCriterion,
                                                    nameImage: "color_fill3",
                                                    valueOfSwitch: false)
    mainScrollView.addSubview(silverCriterion)
    
  }
  
  private func createMediumCriterion() {
    
    let frameForCriterion = CGRect.init(x: 0.0,
                                        y: 129.0 * UtilityManager.sharedInstance.conversionHeight,
                                        width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
    
    mediumCriterion = CriterionWithImageView.init(frame: frameForCriterion,
                                                  nameImage: "color_fill5",
                                                  valueOfSwitch: false)
    mainScrollView.addSubview(mediumCriterion)
    
  }
  
  private func createHighRiskCriterion() {
    
    let frameForCriterion = CGRect.init(x: 0.0,
                                        y: 185.0 * UtilityManager.sharedInstance.conversionHeight,
                                        width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
    
    highRiskCriterion = CriterionWithImageView.init(frame: frameForCriterion,
                                                  nameImage: "color_fill7",
                                                  valueOfSwitch: false)
    mainScrollView.addSubview(highRiskCriterion)
    
  }
  
  private func createArchivedPitch() {
    
    let frameForCriterion = CGRect.init(x: 0.0,
                                        y: 258.0 * UtilityManager.sharedInstance.conversionHeight,
                                        width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
    
    archivedPitchCriterion = CriterionView.init(frame: frameForCriterion,
                                   textLabel: VisualizePitchesConstants.FilterPitchCardView.archivedCriterionText,
                               valueOfSwitch: false)
    archivedPitchCriterion.adaptSize()
    mainScrollView.addSubview(archivedPitchCriterion)
    
  }
  
  private func createDeclinedPitch() {
    
    let frameForCriterion = CGRect.init(x: 0.0,
                                        y: 314.0 * UtilityManager.sharedInstance.conversionHeight,
                                        width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
    
    declinedPitchCriterion = CriterionView.init(frame: frameForCriterion,
                                       textLabel: VisualizePitchesConstants.FilterPitchCardView.declinedCriterionText,
                                       valueOfSwitch: false)
    declinedPitchCriterion.adaptSize()
    mainScrollView.addSubview(declinedPitchCriterion)
    
  }
  
  private func createCanceledPitch() {
    
    let frameForCriterion = CGRect.init(x: 0.0,
                                        y: 370.0 * UtilityManager.sharedInstance.conversionHeight,
                                        width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
    
    canceledPitchCriterion = CriterionView.init(frame: frameForCriterion,
                                       textLabel: VisualizePitchesConstants.FilterPitchCardView.canceledCriterionText,
                                       valueOfSwitch: false)
    canceledPitchCriterion.adaptSize()
    mainScrollView.addSubview(canceledPitchCriterion)
    
  }
  
  @objc private func cancelButtonPressed() {
    
    self.delegate?.doCancelFilteringPitches()
    
  }
  
  func getHappitchCriterionValue() -> Bool {
    
    return happitchCriterion.getValueOfSwitch()
    
  }
  
  func getSilverCriterionValue() -> Bool {
    
    return silverCriterion.getValueOfSwitch()
    
  }
  
  func getMediumCriterionValue() -> Bool {
   
    return mediumCriterion.getValueOfSwitch()
    
  }
  
  func getHighRiskCriterionValue() -> Bool {
   
    return highRiskCriterion.getValueOfSwitch()
    
  }
  
  func getArchivedPitchValue() -> Bool {
    
    return archivedPitchCriterion.getValueOfSwitch()
    
  }
  
  func getDeclinedPitchValue() -> Bool {
    
    return declinedPitchCriterion.getValueOfSwitch()
    
  }
  
  func getCanceledPitchValue()  -> Bool {
   
    return canceledPitchCriterion.getValueOfSwitch()
    
  }
  
}
