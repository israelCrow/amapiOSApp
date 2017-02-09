//
//  FacesEvaluationsView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/28/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class FacesEvaluationsView: UIView {

  private var valuesToShow: [String: Int]! = nil
  private var arrayOfFrames: [CGRect]! = nil
  private var showPercentageSymbol: Bool = false
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, facesToShow: [String: Int]) {
    
    valuesToShow = facesToShow
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  init(frame: CGRect, facesToShow: [String: Int], withPercentage: Bool) {
    
    showPercentageSymbol = withPercentage
    valuesToShow = facesToShow
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    self.createFrames()
    self.createFaces()
    
  }
  
  private func createFrames() {
    
    let firstFrame = CGRect.init(x: 0.0,
                                 y: 0.0,
                             width: 42.0 * UtilityManager.sharedInstance.conversionWidth,
                            height: 40.5 * UtilityManager.sharedInstance.conversionHeight)
    
    let secondFrame = CGRect.init(x: 58.0 * UtilityManager.sharedInstance.conversionWidth,
                                 y: 0.0,
                             width: 42.0 * UtilityManager.sharedInstance.conversionWidth,
                            height: 40.5 * UtilityManager.sharedInstance.conversionHeight)
    
    let thirdFrame = CGRect.init(x: 116.0 * UtilityManager.sharedInstance.conversionWidth,
                                 y: 0.0,
                             width: 42.0 * UtilityManager.sharedInstance.conversionWidth,
                            height: 40.5 * UtilityManager.sharedInstance.conversionHeight)
    
    let fourthFrame = CGRect.init(x: 177.0 * UtilityManager.sharedInstance.conversionWidth,
                                  y: 0.0,
                              width: 42.0 * UtilityManager.sharedInstance.conversionWidth,
                             height: 40.5 * UtilityManager.sharedInstance.conversionHeight)
    
    arrayOfFrames = [firstFrame, secondFrame, thirdFrame, fourthFrame]
    
  }
  
  private func createFaces() {
    
    var numberOfFrame = 0
    
    if valuesToShow[VisualizeDashboardConstants.Faces.kGold] != nil {
      
      self.createGoldFace(arrayOfFrames[numberOfFrame],
                          withValue: valuesToShow[VisualizeDashboardConstants.Faces.kGold]!)
      
      numberOfFrame += 1
      
    }
    
    if valuesToShow[VisualizeDashboardConstants.Faces.kSilver] != nil {
      
      self.createSilverFace(arrayOfFrames[numberOfFrame],
                          withValue: valuesToShow[VisualizeDashboardConstants.Faces.kSilver]!)
      
      numberOfFrame += 1
      
    }

    if valuesToShow[VisualizeDashboardConstants.Faces.kMedium] != nil {
      
      self.createMediumFace(arrayOfFrames[numberOfFrame],
                            withValue: valuesToShow[VisualizeDashboardConstants.Faces.kMedium]!)
      
      numberOfFrame += 1
      
    }
    
    if valuesToShow[VisualizeDashboardConstants.Faces.kBad] != nil {
      
      self.createHighRiskFace(arrayOfFrames[numberOfFrame],
                            withValue: valuesToShow[VisualizeDashboardConstants.Faces.kBad]!)
      
    }
    
  }
  
  
  private func createGoldFace(newFrame: CGRect, withValue: Int) {
    
    let face = UIImageView.init(image: UIImage.init(named: "color_bigger_fill1"))
    face.frame = newFrame
    
    self.addSubview(face)
    
    self.createValueLabel(newFrame, valueToShow: "Happitch\n" + String(withValue))
    
  }
  
  private func createSilverFace(newFrame: CGRect, withValue: Int) {
    
    let face = UIImageView.init(image: UIImage.init(named: "color_bigger_fill3"))
    face.frame = newFrame
    
    self.addSubview(face)
    
    self.createValueLabel(newFrame, valueToShow: "Happy\n" + String(withValue))
    
  }
  
  private func createMediumFace(newFrame: CGRect, withValue: Int) {
    
    let face = UIImageView.init(image: UIImage.init(named: "color_bigger_fill5"))
    face.frame = newFrame
    
    self.addSubview(face)
    
    self.createValueLabel(newFrame, valueToShow: "Unhappy\n" + String(withValue))
    
  }
  
  private func createHighRiskFace(newFrame: CGRect, withValue: Int) {
    
    let face = UIImageView.init(image: UIImage.init(named: "color_bigger_fill7"))
    face.frame = newFrame
    
    self.addSubview(face)
    
    self.createValueLabel(newFrame, valueToShow: "Badpitch\n" + String(withValue))
    
  }
  
  private func createValueLabel(baseFrame: CGRect, valueToShow: String) {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: baseFrame.size.width + (5.0 * UtilityManager.sharedInstance.conversionWidth),
                                    height: CGFloat.max)
    
    let valueLabel = UILabel.init(frame: frameForLabel)
    valueLabel.numberOfLines = 2
    valueLabel.lineBreakMode = .ByWordWrapping
    
    var finalString = String(valueToShow)
    
    if showPercentageSymbol == true {
      
      finalString = finalString + "%"
      
    }
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: finalString,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    valueLabel.attributedText = stringWithFormat
    valueLabel.sizeToFit()
    let newFrame = CGRect.init(x: baseFrame.origin.x + (baseFrame.size.width / 2.0) - (valueLabel.frame.size.width / 2.0),
                               y: baseFrame.origin.y + baseFrame.size.height + (2.5 * UtilityManager.sharedInstance.conversionHeight),
                               width: valueLabel.frame.size.width,
                               height: valueLabel.frame.size.height)
    
    valueLabel.frame = newFrame
    
    self.addSubview(valueLabel)
    
  }
  
}
