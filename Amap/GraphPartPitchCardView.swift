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
    
    var firstColor = UIColor.whiteColor()
    var secondColor = UIColor.whiteColor()
    
    if arrayOfQualifications.count > 0 {
    
      let myQualification = arrayOfQualifications[0]
      
      if myQualification > 70 {
        
        firstColor = UIColor.init(red: 237.0/255.0, green: 237.0/255.0, blue: 24.0/255.0, alpha: 1.0)
        secondColor = UIColor.init(red: 255.0/255.0, green: 85.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        
      }else
        if myQualification >= 59 && myQualification <= 69 {
          
          firstColor = UIColor.init(red: 45.0/255.0, green: 252.0/255.0, blue: 197.0/255.0, alpha: 1.0)
          secondColor = UIColor.init(red: 21.0/255.0, green: 91.0/255.0, blue: 138.0/255.0, alpha: 1.0)
          
        }else
        if myQualification >= 45 && myQualification <= 58 {
            
            firstColor = UIColor.init(red: 48.0/255.0, green: 196.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            secondColor = UIColor.init(red: 242.0/255.0, green: 10.0/255.0, blue: 172.0/255.0, alpha: 1.0)
            
        }else
        if myQualification <= 44 {
            
            firstColor = UIColor.init(red: 190.0/255.0, green: 81.0/255.0, blue: 237.0/255.0, alpha: 1.0)
            secondColor = UIColor.init(red: 255.0/255.0, green: 25.0/255.0, blue: 33.0/255.0, alpha: 1.0)
            
        }
  
    }
    
    let colorsForBackground = [firstColor, secondColor]

    containerAndGradientView = GradientView.init(frame: frameForGradient, arrayOfcolors: colorsForBackground, typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
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
  
}
