//
//  CustomTextFieldWithTitleAndPickerView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/19/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class CustomTextFieldWithTitleAndPickerView: UIView {
  
  private var titleLabel: UILabel! = nil
  private var imageOfArrow: UIImage! = nil
  private var mainPickerView: UIPickerView! = nil
  var mainTextField: UITextField! = nil
  
  private var titleOfLabelString: String! = nil
  private var nameOfImageString: String?
  private var optionsOfPicker = [String]()
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, titleOfView: String!, nameOfImage: String?, newOptionsOfPicker: [String]!) {
    
    if nameOfImage != nil {
      
      nameOfImageString = nameOfImage!
      
    }
    
    optionsOfPicker = newOptionsOfPicker
    titleOfLabelString = titleOfView
    
    
    super.init(frame: frame)
    
  }
  

  
  
  
  
}
