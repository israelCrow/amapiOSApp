//
//  CircleGraphView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/28/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class CircleGraphView: UIView {
  
  private var containerViewForGraph: UIView! = nil
  private var percentageLabel: UILabel! = nil
  private var descriptionLabel: UILabel! = nil
  private var circleLayer: CAShapeLayer!
  private var secondCircleLayer: CAShapeLayer!

  private var percentageOfRate: CGFloat! = nil
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, toPercentage: CGFloat) {
  
    percentageOfRate = toPercentage
    
    super.init(frame: frame)
    
    self.initInterface()
  
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    
    self.createContainerView()
    self.createPercentageLabel()
    self.createDescriptionLabel()
    self.createGraph()
    self.createElements()
    
  }
  
  private func createContainerView() {
    
    let frameForContainerView = CGRect.init(x: 20.0 * UtilityManager.sharedInstance.conversionWidth,
                                            y: 0.0,
                                        width: 181.0 * UtilityManager.sharedInstance.conversionWidth,
                                       height: 181.0 * UtilityManager.sharedInstance.conversionHeight)
    
    containerViewForGraph = UIView.init(frame: frameForContainerView)
    containerViewForGraph.backgroundColor = UIColor.clearColor()
    
    self.addSubview(containerViewForGraph)
    
  }
  
  private func createPercentageLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 255.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    percentageLabel = UILabel.init(frame: frameForLabel)
    percentageLabel.numberOfLines = 0
    percentageLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: String(format: "%.1f", percentageOfRate*100.0) + "%",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    percentageLabel.attributedText = stringWithFormat
    percentageLabel.sizeToFit()
    let newFrame = CGRect.init(x: (containerViewForGraph.frame.size.width / 2.0) - (percentageLabel.frame.size.width / 2.0),
                               y: 60.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: percentageLabel.frame.size.width,
                               height: percentageLabel.frame.size.height)
    
    percentageLabel.frame = newFrame
    percentageLabel.alpha = 0.0
    
    containerViewForGraph.addSubview(percentageLabel)
    
  }
  
  private func createDescriptionLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 255.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    descriptionLabel = UILabel.init(frame: frameForLabel)
    descriptionLabel.numberOfLines = 0
    descriptionLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Rate de bateo",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    descriptionLabel.attributedText = stringWithFormat
    descriptionLabel.sizeToFit()
    let newFrame = CGRect.init(x: (containerViewForGraph.frame.size.width / 2.0) - (descriptionLabel.frame.size.width / 2.0),
                               y: percentageLabel.frame.origin.y + percentageLabel.frame.size.height + (5.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: descriptionLabel.frame.size.width,
                               height: descriptionLabel.frame.size.height)
    
    descriptionLabel.frame = newFrame
    descriptionLabel.alpha = 0.0
    
    containerViewForGraph.addSubview(descriptionLabel)
    
  }
  
  private func createGraph() {
    
    if percentageOfRate == 0.0 {
      
      percentageOfRate = -1.0
      
    }
  
    let circlePath = UIBezierPath(arcCenter: CGPoint(x: containerViewForGraph.frame.size.width / 2.0, y: containerViewForGraph.frame.size.height / 2.0),
                                  radius: (containerViewForGraph.frame.size.width - (10.0 * UtilityManager.sharedInstance.conversionWidth))/2,
                                  startAngle: -(CGFloat(M_PI * 0.5)),
                                  endAngle: (CGFloat(M_PI * 2.0 * Double(percentageOfRate))) - CGFloat(M_PI * 0.5),
                                  clockwise: true)
    
    // Setup the CAShapeLayer with the path, colors, and line width
    circleLayer = CAShapeLayer()
    circleLayer.path = circlePath.CGPath
    circleLayer.fillColor = UIColor.clearColor().CGColor
    circleLayer.strokeColor = UIColor.init(red: 180.0/255.0, green: 236.0/255.0, blue: 81.0/255.0, alpha: 1.0).CGColor
    circleLayer.lineWidth = 10.0;
    
    // Don't draw the circle initially
    circleLayer.strokeEnd = 0.0
    
    // Add the circleLayer to the view's layer's sublayers
    containerViewForGraph.layer.addSublayer(circleLayer)

  
  }
  
  
  private func animateShowLabels() {
    
    UIView.animateWithDuration(1.0) { 
      
      self.percentageLabel.alpha = 1.0
      self.descriptionLabel.alpha = 1.0
      
    }
    
  }
  
  func animateCircle(duration: NSTimeInterval) {
    
    self.animateShowLabels()
    
    CATransaction.begin()
    
    CATransaction.setCompletionBlock { 
      
      self.createSecondGraph()
      self.animateCreationOfSecondPart(0.5)
      
    }
    
    self.animateCreationFirstPart(duration)
    CATransaction.commit()
    
    
  }
  
  private func animateCreationFirstPart(duration: NSTimeInterval) {
    
    // We want to animate the strokeEnd property of the circleLayer
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    
    // Set the animation duration appropriately
    animation.duration = duration
    
    // Animate from 0 (no circle) to 1 (full circle)
    animation.fromValue = 0
    animation.toValue = 1
    
    // Do a linear animation (i.e. the speed of the animation stays the same)
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    
    // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
    // right value when the animation ends.
    circleLayer.strokeEnd = 1
    
    // Do the actual animation
    circleLayer.addAnimation(animation, forKey: "animateCircle")
    
  }
  
  private func createSecondGraph() {
    
    let circlePath = UIBezierPath(arcCenter: CGPoint(x: containerViewForGraph.frame.size.width / 2.0, y: containerViewForGraph.frame.size.height / 2.0),
                                  radius: (containerViewForGraph.frame.size.width - (10.0 * UtilityManager.sharedInstance.conversionWidth))/2,
                                  startAngle: (CGFloat(M_PI * 2.0 * Double(percentageOfRate))) - CGFloat(M_PI * 0.5),
                                  endAngle:  -(CGFloat(M_PI * 0.5)),
                                  clockwise: true)
    
    // Setup the CAShapeLayer with the path, colors, and line width
    secondCircleLayer = CAShapeLayer()
    secondCircleLayer.path = circlePath.CGPath
    secondCircleLayer.fillColor = UIColor.clearColor().CGColor
    secondCircleLayer.strokeColor = UIColor.redColor().CGColor
    secondCircleLayer.lineWidth = 10;
    
    // Don't draw the circle initially
    secondCircleLayer.strokeEnd = 0.0
    
    // Add the circleLayer to the view's layer's sublayers
    containerViewForGraph.layer.addSublayer(secondCircleLayer)
    
    
  }
  
  private func animateCreationOfSecondPart(duration: NSTimeInterval) {
    
    // We want to animate the strokeEnd property of the circleLayer
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    
    // Set the animation duration appropriately
    animation.duration = duration
    
    // Animate from 0 (no circle) to 1 (full circle)
    animation.fromValue = 0
    animation.toValue = 1
    
    // Do a linear animation (i.e. the speed of the animation stays the same)
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    
    // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
    // right value when the animation ends.
    secondCircleLayer.strokeEnd = 1
    
    // Do the actual animation
    secondCircleLayer.addAnimation(animation, forKey: "animateCircle")
    
  }
  
  
  private func createElements() {
  
    self.createCircles()
    self.createLabelsOfElements()
    self.createLine()
    
  }
  
  private func createCircles() {
    
    let frameForGreenCircle = CGRect.init(x: 0.0,
                                          y: 206.0 * UtilityManager.sharedInstance.conversionHeight,
                                          width: 15.0 * UtilityManager.sharedInstance.conversionWidth,
                                          height: 15.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let frameForRedCircle = CGRect.init(x: 137.0 * UtilityManager.sharedInstance.conversionWidth,
                                        y: 206.0 * UtilityManager.sharedInstance.conversionHeight,
                                        width: 15.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 15.0 * UtilityManager.sharedInstance.conversionHeight)
    
    
    let redCircle = UIView.init(frame: frameForRedCircle)
    redCircle.backgroundColor = UIColor.redColor()
    redCircle.layer.cornerRadius = redCircle.frame.size.width / 2.0
    self.addSubview(redCircle)
    
    let greenCircle = UIView.init(frame: frameForGreenCircle)
    greenCircle.backgroundColor = UIColor.init(red: 180.0/255.0, green: 236.0/255.0, blue: 81.0/255.0, alpha: 1.0)
    greenCircle.layer.cornerRadius = greenCircle.frame.size.width / 2.0
    self.addSubview(greenCircle)
    
  }
  
  private func createLabelsOfElements() {
    
    self.createWonLabel()
    self.createLostLabel()

  }
  
  private func createWonLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 255.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    let wonLabel = UILabel.init(frame: frameForLabel)
    wonLabel.numberOfLines = 0
    wonLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Ganado",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    wonLabel.attributedText = stringWithFormat
    wonLabel.sizeToFit()
    let newFrame = CGRect.init(x: 25.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 206.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: wonLabel.frame.size.width,
                               height: wonLabel.frame.size.height)
    
    wonLabel.frame = newFrame
    
    self.addSubview(wonLabel)
    
  }
  
  private func createLostLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 255.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    let lostLabel = UILabel.init(frame: frameForLabel)
    lostLabel.numberOfLines = 0
    lostLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Perdido",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    lostLabel.attributedText = stringWithFormat
    lostLabel.sizeToFit()
    let newFrame = CGRect.init(x: 158.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 206.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: lostLabel.frame.size.width,
                               height: lostLabel.frame.size.height)
    
    lostLabel.frame = newFrame
    
    self.addSubview(lostLabel)
    
  }
  
  private func createLine() {
    
    let border = CALayer()
    let width = CGFloat(1)
    border.borderColor = UIColor.lightGrayColor().CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 0.0,
                               y: self.frame.size.height - (2.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: self.frame.size.width,
                               height: 1.0)
    self.layer.addSublayer(border)
    self.layer.masksToBounds = false
    
  }

  
}

