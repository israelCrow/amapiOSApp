//
//  VisualizeNumberOfEmployeesView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/2/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class VisualizeNumberOfEmployeesView: UIView {
  
  private var employeesLabel: UILabel! = nil
  private var mainScrollView: UIScrollView! = nil
  private var numberOfEmployeesLabel: UILabel! = nil
  private var arrayOfImageViews = Array<UIImageView>()

  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    
    self.createInterface()
    
  }
  
  private func createInterface() {
    
    self.createEmployeesLabel()
    self.createMainScrollView()
    self.createAllImageViews()
    
  }
  
  private func createEmployeesLabel() {
    
    employeesLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: AgencyProfileVisualizeConstants.VisualizeNumberOfEmployessView.numberOfEmployeesLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    employeesLabel.attributedText = stringWithFormat
    employeesLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (employeesLabel.frame.size.width / 2.0),
                               y: 0.0,
                               width: employeesLabel.frame.size.width,
                               height: employeesLabel.frame.size.height)
    
    employeesLabel.frame = newFrame
    
    self.addSubview(employeesLabel)
    
  }
  
  private func createMainScrollView() {
    
    let frameForMainScrollView = CGRect.init(x: 34.0 * UtilityManager.sharedInstance.conversionWidth,
                                             y: 46.0 * UtilityManager.sharedInstance.conversionHeight,
                                             width: 235.0 * UtilityManager.sharedInstance.conversionWidth,
                                             height: 270.0 * UtilityManager.sharedInstance.conversionHeight)
    
    //Change the value of the next 'size' to make scrollViewAnimate
    //let sizeOfScrollViewContent = CGSize.init(width: frameForMainScrollView.size.width, height: frameForMainScrollView.size.height + (50.0 * UtilityManager.sharedInstance.conversionHeight))
    
    mainScrollView = UIScrollView.init(frame: frameForMainScrollView)
    mainScrollView.backgroundColor = UIColor.clearColor()
    //mainScrollView.contentSize = sizeOfScrollViewContent
    mainScrollView.showsVerticalScrollIndicator = true
    
    self.addSubview(mainScrollView)
    
  }
  
  private func createAllImageViews() {
    
    self.createImageOfEmployees()
    self.createNumberOfEmployeesLabel()
    
  }
  
  private func createImageOfEmployees() {
    
    let frameForImageView = CGRect.init(x: 56.0 * UtilityManager.sharedInstance.conversionWidth,
                                        y: 56.0 * UtilityManager.sharedInstance.conversionHeight,
                                        width: 115.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 110.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let imageView = UIImageView.init(image: UIImage.init(named: "group"))
    imageView.frame = frameForImageView
    
    arrayOfImageViews.append(imageView)
    mainScrollView.addSubview(imageView)
    
  }
  
  private func createNumberOfEmployeesLabel() {
    
    var numberOfEmployeesText: String
    
    if AgencyModel.Data.num_employees != nil {
      
      numberOfEmployeesText = "\(AgencyModel.Data.num_employees!) Empleados"
      
    } else {
      
      numberOfEmployeesText = "Empleados"
      
    }
    
    let employeesLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: numberOfEmployeesText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    employeesLabel.attributedText = stringWithFormat
    employeesLabel.sizeToFit()
    let newFrame = CGRect.init(x: (mainScrollView.frame.size.width / 2.0) - (employeesLabel.frame.size.width / 2.0),
                               y: 187.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: employeesLabel.frame.size.width,
                               height: employeesLabel.frame.size.height)
    
    employeesLabel.frame = newFrame
    
    mainScrollView.addSubview(employeesLabel)
    
  }
  
}
