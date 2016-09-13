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
  private var pitchData: PitchModelData! = nil
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.initInterface()
  }
  
  private func initInterface() {
    
    self.createGraphPart()
    self.createDetailedPart()
    
  }
  
  private func createGraphPart() {
    
    let frameForGraphPart = CGRect.init(x: 0.0,
                                        y: 0.0,
                                    width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 347.0 * UtilityManager.sharedInstance.conversionHeight)
    
    graphPart = GraphPartPitchCardView.init(frame: frameForGraphPart,
                         newArrayOfQualifications: [0],
                            newArrayOfAgencyNames: ["test"])
    self.addSubview(graphPart)
    
  }
  
  private func createDetailedPart() {
    
    let frameForDetailedPart = CGRect.init(x: 0.0,
                                           y: 347.0 * UtilityManager.sharedInstance.conversionHeight,
                                       width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                                      height: 107.0 * UtilityManager.sharedInstance.conversionHeight)
    
    detailedPart = DetailedPartPitchCardView.init(frame: frameForDetailedPart,
                                         newProjectName: "Nombre de Proyecto",
                                           newBrandName: "Nombre de Marca",
                                         newCompanyName: "Nombre compañía")
    
    self.addSubview(detailedPart)
    
  }
  

}
