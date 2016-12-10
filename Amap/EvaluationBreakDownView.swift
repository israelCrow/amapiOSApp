//
//  EvaluationBreakDownView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 12/8/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class EvaluationBreakDownView: UIView {
  
  private var evaluationBreakdownLabel: UILabel! = nil
  private var arrayOfDescriptions = Array<[String: String]>()
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, descriptions: Array<[String: String]>) {
    
    arrayOfDescriptions = descriptions
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    self.createEvaluationBreakDownLabel()
    self.createAllDescriptions()
    
  }
  
  private func createEvaluationBreakDownLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 206.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    evaluationBreakdownLabel = UILabel.init(frame: frameForLabel)
    evaluationBreakdownLabel.numberOfLines = 0
    evaluationBreakdownLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Desglose de la evaluación",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    evaluationBreakdownLabel.attributedText = stringWithFormat
    evaluationBreakdownLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (evaluationBreakdownLabel.frame.size.width / 2.0),
                               y: 0.0,
                               width: evaluationBreakdownLabel.frame.size.width,
                               height: evaluationBreakdownLabel.frame.size.height)
    
    evaluationBreakdownLabel.frame = newFrame
    
    self.addSubview(evaluationBreakdownLabel)
    
  }
  
  private func createAllDescriptions() {
    
    var frameForDescriptions = CGRect.init(x: 0.0,
                                           y: evaluationBreakdownLabel.frame.origin.y + evaluationBreakdownLabel.frame.size.height + (33.0 * UtilityManager.sharedInstance.conversionHeight),
                                       width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                                      height: 0.0)
    
    for description in arrayOfDescriptions {
      
      let descriptionText = description["description_text"]
      let percentageText = description["percentage_text"]
      
      let descriptionView = BreakDownDescription.init(frame: frameForDescriptions,
                                         newDescriptionText: descriptionText!,
                                          newPercentageText: percentageText!)
      
      self.addSubview(descriptionView)
      
      frameForDescriptions = CGRect.init(x: 0.0,
                                         y: frameForDescriptions.origin.y + descriptionView.frame.size.height + (30.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: frameForDescriptions.size.width,
                                    height: 0.0)
      
    }
    
    self.frame = CGRect.init(x: self.frame.origin.x,
                             y: self.frame.origin.y,
                         width: self.frame.size.width,
                        height: frameForDescriptions.origin.y)
    
  }
  
  
}
