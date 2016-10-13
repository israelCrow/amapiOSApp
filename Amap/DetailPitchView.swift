//
//  DetailPitchView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/12/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class DetailPitchView: UIView {
  
  private var pitchData: PitchEvaluationByUserModelData! = nil
  

  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newPitchData: PitchEvaluationByUserModelData) {
  
    pitchData = newPitchData
    super.init(frame: frame)
    
    self.backgroundColor = UIColor.clearColor()
    
  }
  
  
  
  
  
  
}
