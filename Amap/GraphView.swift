//
//  GraphView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/28/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

//Create GraphView with height = 287.5 and width = 50.0

class GraphView: UIView {

  private var agencyNameString: String! = nil
  private var agencyQualificationInt: Int! = nil
  private var agencyNameLabel: UILabel! = nil
  private var agencyQualificationLabel: UILabel! = nil
  private var circleView: UIView! = nil
  private var barOfGraphView: GradientView! = nil
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newAgencyName: String, newAgencyQualification: Int) {
    
    agencyNameString = newAgencyName
    agencyQualificationInt = newAgencyQualification
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.createAgencyNameLabel()
    self.createCircleView()
    self.createAgencyQualificationLabel()
    self.createBarOfGraphView()
    
    
  }
  
  private func createAgencyNameLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 267.5 * UtilityManager.sharedInstance.conversionHeight,
                                    width: 50.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    agencyNameLabel = UILabel.init(frame: frameForLabel)
    agencyNameLabel.numberOfLines = 0
    agencyNameLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Regular",
                      size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: agencyNameString,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    agencyNameLabel.attributedText = stringWithFormat
    agencyNameLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (agencyNameLabel.frame.size.width / 2.0),
                               y: 267.5 * UtilityManager.sharedInstance.conversionHeight,
                               width: agencyNameLabel.frame.size.width,
                               height: agencyNameLabel.frame.size.height)
    
    agencyNameLabel.frame = newFrame
    
    self.addSubview(agencyNameLabel)
    
  }
  
  private func createCircleView() {
    
    let frameForCircleView = CGRect.init(x: 8.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: 233.5 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 26.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: 26.0 * UtilityManager.sharedInstance.conversionHeight)
    
    circleView = UIView.init(frame: frameForCircleView)
    
    circleView.layer.cornerRadius = circleView.frame.size.height / 2.0
    circleView.backgroundColor = UIColor.whiteColor()
    self.addSubview(circleView)
    
  }
  
  private func createAgencyQualificationLabel() {
    
    let frameForLabel = CGRect.init(x: 4.3 * UtilityManager.sharedInstance.conversionWidth,
                                    y: 4.7 * UtilityManager.sharedInstance.conversionHeight,
                                    width: 50.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    agencyQualificationLabel = UILabel.init(frame: frameForLabel)
    agencyQualificationLabel.numberOfLines = 0
    agencyQualificationLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: String(agencyQualificationInt),
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    agencyQualificationLabel.attributedText = stringWithFormat
    agencyQualificationLabel.sizeToFit()
    let newFrame = CGRect.init(x: frameForLabel.origin.x,
                               y: frameForLabel.origin.y,
                               width: agencyQualificationLabel.frame.size.width,
                               height: agencyQualificationLabel.frame.size.height)
    
    agencyQualificationLabel.frame = newFrame
    
    circleView.addSubview(agencyQualificationLabel)
    
  }
  
  private func createBarOfGraphView() {
    
    let frameForFirstAppearanceOfBarView = CGRect.init(x: circleView.center.x - (4.0 * UtilityManager.sharedInstance.conversionWidth),
                                                       y: circleView.center.y,
                                                   width: 8.0 * UtilityManager.sharedInstance.conversionWidth,
                                                  height: 0.1 * UtilityManager.sharedInstance.conversionWidth)
    
    let firstColor = UIColor.whiteColor()
    let secondColor = UIColor.init(red: 255.0/255.0,
                                 green: 255.0/255.0,
                                  blue: 255.0/255.0, alpha: 0.4)
    
    barOfGraphView = GradientView.init(frame: frameForFirstAppearanceOfBarView,
                               arrayOfcolors: [firstColor, secondColor],
                           typeOfInclination: GradientView.TypeOfInclination.vertical)
    barOfGraphView.backgroundColor = UIColor.whiteColor()
    self.addSubview(barOfGraphView)
    
    
  }
  
  func animateBar() {
    
    let frameForBarView = CGRect.init(x: barOfGraphView.frame.origin.x,
                                      y: barOfGraphView.frame.origin.y,
                                      width: barOfGraphView.frame.size.width,
                                      height: (CGFloat(agencyQualificationInt) / 100.0) * (246.0 * UtilityManager.sharedInstance.conversionHeight))
    
    UIView.animateWithDuration(0.25){
     
      self.barOfGraphView.frame = frameForBarView
      
    }
    
  }

  
}
