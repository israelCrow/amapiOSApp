//
//  BasicCustomTextField.swift
//  Amap
//
//  Created by Mac on 8/15/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class BasicCustomTextField: UITextField {
  
  private var exclusiveBrandData: ExclusivityBrandModelData! = nil
  var borderLayer: CALayer! = nil
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newExclusiveData: ExclusivityBrandModelData) {
    
    exclusiveBrandData = newExclusiveData
    
    super.init(frame: frame)
    
    self.editInterface()
    
  }
  
  private func editInterface() {
    
    self.clearButtonMode = .WhileEditing
    
    borderLayer = CALayer()
    let width = CGFloat(1)
    borderLayer.borderColor = UIColor.darkGrayColor().CGColor
    borderLayer.borderWidth = width
    borderLayer.frame = CGRect.init(x: -4.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: self.frame.size.height - (2.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: self.frame.size.width + (4.0 * UtilityManager.sharedInstance.conversionWidth),
                               height: 1.0)
    self.layer.addSublayer(borderLayer)
    self.layer.masksToBounds = false
    
  }
  
  func getExclusiveBrandData() -> ExclusivityBrandModelData {
    
    return self.exclusiveBrandData
    
  }
  
  
}
