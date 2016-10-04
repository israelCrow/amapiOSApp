//
//  PitchCardView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/12/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol PitchCardViewDelegate {
  
  func pushCreateAddNewPitchAndWriteBrandNameViewControllerFromPitchCard()
  
}

class PitchCardView: UIView {
  
  private var contentView: UIView! = nil
  private var addPitchButton: UIButton! = nil
  private var graphPart: GraphPartPitchCardView! = nil
  private var detailedPart: DetailedPartPitchCardView! = nil
  private var pitchEvaluationByUserData: PitchEvaluationByUserModelData! = nil
  
  var delegate: PitchCardViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    
    let frameForView = CGRect.init(x: 0.0,
                                          y: frame.origin.y - (20.0 * UtilityManager.sharedInstance.conversionHeight),
                                          width: frame.size.width,
                                          height: frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight))
    
    super.init(frame: frameForView)
    self.backgroundColor = UIColor.clearColor()
    
    self.createContentView()
    self.createAddPitchButton()
    
  }
  
  private func createContentView() {
    
    let frameForContentView = CGRect.init(x: 0.0,
                                          y: self.frame.origin.y + (40.0 * UtilityManager.sharedInstance.conversionHeight),
                                      width: self.frame.size.width,
                                     height: self.frame.size.height)
    
    contentView = UIView.init(frame: frameForContentView)
    contentView.backgroundColor = UIColor.clearColor()
    self.addSubview(contentView)
    
  }
  
  private func createAddPitchButton() {
    
    let frameForButton = CGRect.init(x: 235.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: -4.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 56.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
    
    addPitchButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "buttonAddPitch") as UIImage?
    addPitchButton.setImage(image, forState: .Normal)
    addPitchButton.tag = 1
    addPitchButton.addTarget(self, action: #selector(addPitchButtonPushed), forControlEvents:.TouchUpInside)
    
    self.addSubview(addPitchButton)
    
  }
  
  private func createGraphPart() {
    
    if graphPart != nil {
      
      graphPart.removeFromSuperview()
      graphPart = nil
      
    }
    
    let frameForGraphPart = CGRect.init(x: 0.0,
                                        y: 0.0,
                                    width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 347.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let arrayOfQualifications: [Int] = [pitchEvaluationByUserData.score]
    let arrayOfAgencyNames: [String] = [AgencyModel.Data.name]
    
    graphPart = GraphPartPitchCardView.init(frame: frameForGraphPart,
                         newArrayOfQualifications: arrayOfQualifications,
                            newArrayOfAgencyNames: arrayOfAgencyNames)
    contentView.addSubview(graphPart)
    contentView.bringSubviewToFront(addPitchButton)
  }
  
  private func createDetailedPart() {
    
    if detailedPart != nil {
      
      detailedPart.removeFromSuperview()
      detailedPart = nil
      
    }
    
    let frameForDetailedPart = CGRect.init(x: 0.0,
                                           y: 347.0 * UtilityManager.sharedInstance.conversionHeight,
                                       width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                                      height: 107.0 * UtilityManager.sharedInstance.conversionHeight)
    
    detailedPart = DetailedPartPitchCardView.init(frame: frameForDetailedPart,
                                         newProjectName: pitchEvaluationByUserData.pitchName,
                                           newBrandName: pitchEvaluationByUserData.brandName,
                                         newCompanyName: pitchEvaluationByUserData.companyName!)
    
    contentView.addSubview(detailedPart)
    
  }
  
  func changePitchData(newPitchByUserData: PitchEvaluationByUserModelData) {
    
    pitchEvaluationByUserData = newPitchByUserData
    self.createGraphPart()
    self.createDetailedPart()
    
  }
  
  func animateGraph() {
    
    graphPart.animateGraph()
    
  }
  
  @objc private func addPitchButtonPushed() {
    
    self.delegate?.pushCreateAddNewPitchAndWriteBrandNameViewControllerFromPitchCard()
    
  }

}
