//
//  ExtensionView.swift
//  Amap
//
//  Created by Mac on 8/15/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

extension UIView {
  func rotate(toValue: CGFloat, duration: CFTimeInterval = 0.2, completionDelegate: AnyObject? = nil) {
    let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
    rotateAnimation.toValue = toValue
    rotateAnimation.duration = duration
    rotateAnimation.removedOnCompletion = false
    rotateAnimation.fillMode = kCAFillModeForwards
    
    if let delegate: AnyObject = completionDelegate {
      rotateAnimation.delegate = delegate
    }
    self.layer.addAnimation(rotateAnimation, forKey: nil)
  }
}