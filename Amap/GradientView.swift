//
//  GradientView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/2/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class GradientView: UIView {
  
  enum TypeOfInclination{
    case leftToRightInclination
    case rightToLeftInclination
    case horizontal
    case vertical
  }
  
  private var colors: [UIColor]
  private var gradientLayer = CAGradientLayer()
  private var typeOfInclination: TypeOfInclination
  
  override class func layerClass() -> AnyClass {
    return CAGradientLayer.self
  }
  
  init(frame: CGRect, arrayOfcolors:[UIColor], typeOfInclination:TypeOfInclination){
    self.colors = arrayOfcolors
    self.typeOfInclination = typeOfInclination
    super.init(frame: frame)
    self.adaptInterface()
  }
  
  private func adaptInterface(){
    self.backgroundColor = UIColor.whiteColor()
    self.gradientLayer.frame = self.bounds
  
    var arrayOfColorsRef = [CGColorRef]()
    let location = 1.0/Double(colors.count)
    
    for i in 0 ..< colors.count{
      let color = colors[i]
      arrayOfColorsRef.append(color.CGColor)
      self.gradientLayer.locations?.append(location * Double(i))
    }
    self.gradientLayer.colors = arrayOfColorsRef
    
    self.setDirection()
    
    self.layer.insertSublayer(gradientLayer, atIndex: 0)
  }
  
  private func setDirection() {
    switch self.typeOfInclination{
    case .leftToRightInclination:
      self.gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
      self.gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
      break
      
    case .rightToLeftInclination:
      self.gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
      self.gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
      break
      
    case .horizontal:
      self.gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
      self.gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
      break
      
    case .vertical:
      self.gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
      self.gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
      break
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
