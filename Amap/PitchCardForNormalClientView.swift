//
//  PitchCardForNormalClientView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 12/7/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class PitchCardForNormalClientView: UIView {
  
  private var descriptionView: PitchCardForNormalClientDescriptionView! = nil
  
  //circular graph
  
  private var facesView: FacesEvaluationsView! = nil
  private var pitchData: PitchEvaluationByUserModelData! = nil
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newPitchData: PitchEvaluationByUserModelData) {
    
    pitchData = newPitchData
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    self.createDescriptionView()
    self.createFaces()
    
  }
  
  private func createDescriptionView() {
    
    let frameForView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                   y: 30.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: 255.0 * UtilityManager.sharedInstance.conversionWidth,
                              height: 80.0 * UtilityManager.sharedInstance.conversionHeight)
    
    descriptionView = PitchCardForNormalClientDescriptionView.init(frame: frameForView,
                                                            newMailBrief: "contactbrief@company.com",
                                                          newProjectName: pitchData.pitchName,
                                                           newWinnerName: "Ganador: Por definir",
                                                          newCompanyName: pitchData.companyName)
    
    self.addSubview(descriptionView)
    
  }
  
  private func createFaces() {
    
    if facesView != nil {
      
      facesView.removeFromSuperview()
      facesView = nil
      
    }
    
    let facesToShow: [String: Int] = [
      VisualizeDashboardConstants.Faces.kGold:   0,
      VisualizeDashboardConstants.Faces.kSilver: 0,
      VisualizeDashboardConstants.Faces.kMedium: 0,
      VisualizeDashboardConstants.Faces.kBad:    0
    ]
    
    let frameForFacesView = CGRect.init(x: 38.0,
                                        y: 340.0 * UtilityManager.sharedInstance.conversionHeight,
                                    width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 43.0 * UtilityManager.sharedInstance.conversionHeight)
    
    facesView = FacesEvaluationsView.init(frame: frameForFacesView,
                                          facesToShow: facesToShow)
    facesView.clipsToBounds = true
    
    self.addSubview(facesView)
    
  }
  

  
}
