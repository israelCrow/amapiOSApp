//
//  CustomSwitchView.swift
//  Amap
//
//  Created by Mac on 8/12/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class CustomSwitchView: UIView {
  
  private var containerView: UIView! = nil
  private var circleView: UIView! = nil
  var isOn: Bool = false

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.initShape()
    self.addActions()
    self.initCircle()
    
  }
  
  private func initShape() {
    self.backgroundColor = UIColor.clearColor()
    
    let frameForContainer = CGRect.init(x: 4.0,
                                        y: 4.0,
                                    width: 28.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 14.0 * UtilityManager.sharedInstance.conversionHeight)
    containerView = UIView.init(frame: frameForContainer)
    containerView.backgroundColor = UIColor.blackColor()
    containerView.layer.cornerRadius = containerView.frame.size.width / 4.0
    self.addSubview(containerView)
    
  }
  
  private func addActions() {
    
    let tapForMoveCircle = UITapGestureRecognizer.init(target: self, action: #selector(animateCircle))
    tapForMoveCircle.numberOfTapsRequired = 1
    
    self.userInteractionEnabled = true
    self.addGestureRecognizer(tapForMoveCircle)
    
  }
  
  private func initCircle() {
    
    let frameForCircle = CGRect.init(x: 4.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 3.0 * UtilityManager.sharedInstance.conversionHeight,
                                 width: 8.0 * UtilityManager.sharedInstance.conversionWidth,
                                height: 8.0 * UtilityManager.sharedInstance.conversionHeight)
    
    circleView = UIView.init(frame: frameForCircle)
    circleView.backgroundColor = UIColor.init(red: 252.0/255.0, green: 23.0/255.0, blue: 69.0/255.0, alpha: 1.0)
    circleView.layer.cornerRadius = circleView.frame.size.width / 2.0
    
    containerView.addSubview(circleView)
    
  }
  
  @objc private func animateCircle() {
    
    if isOn == false {
      
      self.userInteractionEnabled = false
      
      UIView.animateWithDuration(0.25,
        animations: {
          
          self.circleView.frame = CGRect.init(x: self.circleView.frame.origin.x + (12.0 * UtilityManager.sharedInstance.conversionWidth),
            y: self.circleView.frame.origin.y,
            width: self.circleView.frame.size.width,
            height: self.circleView.frame.size.height)
          self.circleView.backgroundColor = UIColor.init(red: 129.0/255.0, green: 209.0/255.0, blue: 48.0/255.0, alpha: 1.0)
          
        }, completion: { (finished) in
          if finished {
            
            self.userInteractionEnabled = true
            self.isOn = true
            
          }
      })
    } else {
      
      self.userInteractionEnabled = false
      
      UIView.animateWithDuration(0.25,
                                 animations: {
                                  
                                  self.circleView.frame = CGRect.init(x: self.circleView.frame.origin.x - (12.0 * UtilityManager.sharedInstance.conversionWidth),
                                    y: self.circleView.frame.origin.y,
                                    width: self.circleView.frame.size.width,
                                    height: self.circleView.frame.size.height)
                                  self.circleView.backgroundColor = UIColor.init(red: 252.0/255.0, green: 23.0/255.0, blue: 69.0/255.0, alpha: 1.0)
                                  
        }, completion: { (finished) in
          if finished {
            
            self.userInteractionEnabled = true
            self.isOn = false
            
          }
      })
      
      
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}