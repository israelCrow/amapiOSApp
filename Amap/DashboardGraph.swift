//
//  DashboardGraph.swift
//  Amap
//
//  Created by Alejandro Aristi C on 11/7/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class DashboardGraph: UIView {
  
  private var arrayAgencyStats: [Int]! = nil
  private var arrayUserStats: [Int]! = nil
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newArrayOfAgencyStats: [Int], newArrayOfUserStats: [Int]) {
    
    arrayAgencyStats = newArrayOfAgencyStats
    arrayUserStats = newArrayOfUserStats
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.createBackground()
    
  }
  
  private func createBackground() {
    
    self.createBackgroundLines()
    self.createBackgroundText()
    
  }
  
  private func createBackgroundLines() {
    
    self.createXAxis()
    
    if arrayUserStats.count == arrayAgencyStats.count {
    
      self.createYAxis(arrayAgencyStats.count)
      
    } else {
      
      self.createYAxis(12)
      
    }
    
  }
  
  private func createXAxis() {
    
    
    //bottom line
    let border = CALayer()
    let width = CGFloat(1)
    border.borderColor = UIColor.darkGrayColor().CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 12.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 210.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: 283.0 * UtilityManager.sharedInstance.conversionWidth,
                               height: 1.0)
    self.layer.addSublayer(border)
    
    //
    let border2 = CALayer()
    border2.borderColor = UIColor.darkGrayColor().CGColor
    border2.borderWidth = width
    border2.frame = CGRect.init(x: 12.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 133.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: 283.0 * UtilityManager.sharedInstance.conversionWidth,
                               height: 1.0)
    self.layer.addSublayer(border2)
    
    //
    let border3 = CALayer()
    border3.borderColor = UIColor.darkGrayColor().CGColor
    border3.borderWidth = width
    border3.frame = CGRect.init(x: 12.0 * UtilityManager.sharedInstance.conversionWidth,
                                y: 95.0 * UtilityManager.sharedInstance.conversionHeight,
                                width: 283.0 * UtilityManager.sharedInstance.conversionWidth,
                                height: 1.0)
    self.layer.addSublayer(border3)
    
    //
    let border4 = CALayer()
    border4.borderColor = UIColor.darkGrayColor().CGColor
    border4.borderWidth = width
    border4.frame = CGRect.init(x: 12.0 * UtilityManager.sharedInstance.conversionWidth,
                                y: 47.0 * UtilityManager.sharedInstance.conversionHeight,
                                width: 283.0 * UtilityManager.sharedInstance.conversionWidth,
                                height: 1.0)
    self.layer.addSublayer(border4)
    
  }
  
  private func createYAxis(quantityOfLines: Int) {
    
    let distanceBetweenLines: CGFloat = (207.0 / CGFloat(quantityOfLines)) * UtilityManager.sharedInstance.conversionWidth
    
    var frameForLines = CGRect.init(x: 53.0 * UtilityManager.sharedInstance.conversionWidth,
                                    y: 13.0 * UtilityManager.sharedInstance.conversionHeight,
                                width: 1.0 * UtilityManager.sharedInstance.conversionWidth,
                               height: 198.0 * UtilityManager.sharedInstance.conversionHeight)
    
    var border: CALayer
    let width = CGFloat(1)
    
    for i in 1...quantityOfLines {
      
      border = CALayer()
      border.borderColor = UIColor.darkGrayColor().CGColor
      border.borderWidth = width
      border.frame = frameForLines
      self.layer.addSublayer(border)
      
      self.createLabelForYAxis(String(i), baseFrame: frameForLines)
      frameForLines = CGRect.init(x: frameForLines.origin.x + distanceBetweenLines,
                                  y: frameForLines.origin.y,
                              width: frameForLines.size.width,
                             height: frameForLines.size.height)
      
      
    }
    
  }
  
  private func createLabelForYAxis(stringLabel: String, baseFrame: CGRect) {
    
    let label = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.darkGrayColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: stringLabel ,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    label.attributedText = stringWithFormat
    label.sizeToFit()
    let newFrame = CGRect.init(x: baseFrame.origin.x,
                               y: 0.0,
                               width: label.frame.size.width,
                               height: label.frame.size.height)
    
    label.frame = newFrame
    
    self.addSubview(label)
    
  }
  
  private func createBackgroundText() {
    
    
    
  }
  
  
}
