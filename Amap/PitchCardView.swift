//
//  PitchCardView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/12/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit


class PitchCardView: UIView {
  
  private var graphPart: GraphPartPitchCardView! = nil
  private var detailedPart: DetailedPartPitchCardView! = nil
  private var pitchEvaluationByUserData: PitchEvaluationByUserModelData! = nil
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
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
    self.addSubview(graphPart)
    
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
    
    self.addSubview(detailedPart)
    
  }
  
  func changePitchData(newPitchByUserData: PitchEvaluationByUserModelData) {
    
    pitchEvaluationByUserData = newPitchByUserData
    self.createGraphPart()
    self.createDetailedPart()
    
  }
  
  func animateGraph() {
    
    graphPart.animateGraph()
    
  }

}
