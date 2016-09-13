//
//  GraphPartPitchCardView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/12/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class GraphPartPitchCardView: UIView {
  
  private var containerAndGradientView: UIView! = nil
  private var arrayOfQualifications = [Int]()
  private var arrayOfAgencyNames = [String]()
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newArrayOfQualifications: [Int], newArrayOfAgencyNames: [String]) {
    
    arrayOfQualifications = newArrayOfQualifications
    arrayOfAgencyNames = newArrayOfAgencyNames
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.createContainerAndGradientView()
    self.createLinesOfGraph()
    
  }
  
  private func createContainerAndGradientView() {
    
    let frameForGradient = CGRect.init(x: 0.0,
                                       y: 0.0,
                                   width: self.frame.size.width,
                                  height: self.frame.size.height)

    containerAndGradientView = self.createGradientView(frameForGradient)
    self.addSubview(containerAndGradientView)
    
  }
  
  private func createLinesOfGraph() {
    
    var border = CALayer()
    let width = CGFloat(0.5)
    border.borderColor = UIColor.init(red: 0/255.0,
                                    green: 63.0/255.0,
                                     blue: 89.0/255.0,
                                    alpha: 0.25).CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 12.0,
                               y: 45.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: 271 * UtilityManager.sharedInstance.conversionWidth,
                               height: 1.0 * UtilityManager.sharedInstance.conversionHeight)
    containerAndGradientView.layer.addSublayer(border)

    border = CALayer()
    border.borderColor = UIColor.init(red: 0/255.0,
                                      green: 63.0/255.0,
                                      blue: 89.0/255.0,
                                      alpha: 0.25).CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 12.0,
                               y: 93.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: 271 * UtilityManager.sharedInstance.conversionWidth,
                               height: 1.0 * UtilityManager.sharedInstance.conversionHeight)
    containerAndGradientView.layer.addSublayer(border)

    border = CALayer()
    border.borderColor = UIColor.init(red: 0/255.0,
                                      green: 63.0/255.0,
                                      blue: 89.0/255.0,
                                      alpha: 0.25).CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 12.0,
                               y: 141.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: 271 * UtilityManager.sharedInstance.conversionWidth,
                               height: 1.0 * UtilityManager.sharedInstance.conversionHeight)
    containerAndGradientView.layer.addSublayer(border)

    border = CALayer()
    border.borderColor = UIColor.init(red: 0/255.0,
                                      green: 63.0/255.0,
                                      blue: 89.0/255.0,
                                      alpha: 0.25).CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 12.0,
                               y: 179.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: 271 * UtilityManager.sharedInstance.conversionWidth,
                               height: 1.0 * UtilityManager.sharedInstance.conversionHeight)
    containerAndGradientView.layer.addSublayer(border)

    border = CALayer()
    border.borderColor = UIColor.init(red: 0/255.0,
                                      green: 63.0/255.0,
                                      blue: 89.0/255.0,
                                      alpha: 0.45).CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 12.0,
                               y: 292.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: 271 * UtilityManager.sharedInstance.conversionWidth,
                               height: 1.0 * UtilityManager.sharedInstance.conversionHeight)
    containerAndGradientView.layer.addSublayer(border)

    containerAndGradientView.layer.masksToBounds = true
    
  }
  
  
  private func createGradientView(frameForGradientView: CGRect) -> GradientView{
    
    let firstColorGradient = UIColor.init(red: 45.0/255.0, green: 252.0/255.0, blue: 197.0/255.0, alpha: 1.0)
    let secondColorGradient = UIColor.init(red: 21.0/255.0, green: 91.0/255.0, blue: 138.0/255.0, alpha: 1.0)
    let colorsForBackground = [firstColorGradient,secondColorGradient]
    return GradientView.init(frame: frameForGradientView, arrayOfcolors: colorsForBackground, typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
    
  }
  
}
