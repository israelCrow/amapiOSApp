//
//  BasicCustomTextField.swift
//  Amap
//
//  Created by Mac on 8/15/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class BasicCustomTextField: UITextField {
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.editInterface()
  }
  
  private func editInterface() {
    
    self.clearButtonMode = .WhileEditing
    
    let border = CALayer()
    let width = CGFloat(1)
    border.borderColor = UIColor.darkGrayColor().CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: -4.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: self.frame.size.height - (2.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: self.frame.size.width + (4.0 * UtilityManager.sharedInstance.conversionWidth),
                               height: 1.0)
    self.layer.addSublayer(border)
    self.layer.masksToBounds = false
    
  }
  
  
}
