//
//  CircleGraphView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/28/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class CircleGraphView: UIView {
  
  var circleLayer: CAShapeLayer!
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    self.initInterface()
  
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.clearColor()
    
    let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0),
                                  radius: (frame.size.width - (10.0 * UtilityManager.sharedInstance.conversionWidth))/2,
                                  startAngle: 0.0,
                                  endAngle: CGFloat(M_PI * 2.0),
                                  clockwise: true)
    
    // Setup the CAShapeLayer with the path, colors, and line width
    circleLayer = CAShapeLayer()
    circleLayer.path = circlePath.CGPath
    circleLayer.fillColor = UIColor.clearColor().CGColor
    circleLayer.strokeColor = UIColor.init(red: 66.0/255.0, green: 147.0/255.0, blue: 33.0/255.0, alpha: 1.0).CGColor
    circleLayer.lineWidth = 10.0;
    
    // Don't draw the circle initially
    circleLayer.strokeEnd = 0.0
    
    // Add the circleLayer to the view's layer's sublayers
    layer.addSublayer(circleLayer)
    
  }
  
  func animateCircle(duration: NSTimeInterval, toPercentage: CGFloat) {
    // We want to animate the strokeEnd property of the circleLayer
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    
    // Set the animation duration appropriately
    animation.duration = duration
    
    // Animate from 0 (no circle) to 1 (full circle)
    animation.fromValue = 0
    animation.toValue = toPercentage
    
    // Do a linear animation (i.e. the speed of the animation stays the same)
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    
    // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
    // right value when the animation ends.
    circleLayer.strokeEnd = toPercentage
    
    // Do the actual animation
    circleLayer.addAnimation(animation, forKey: "animateCircle")
  }
  
  
}

