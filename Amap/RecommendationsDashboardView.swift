//
//  RecommendationsDashboardView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/29/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class RecommendationsDashboardsView: UIView {
  
  private var recommentationsLabel: UILabel! = nil
  private var arrayOfRecommendations: [String]! = nil
  
  required init?(coder aDecoder: NSCoder) {
   
    fatalError("init(coder:) has not been implemented")
    
  }
  
  init(frame: CGRect, newArrayOfRecommendations: [String]) {
    
    arrayOfRecommendations = newArrayOfRecommendations
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.createReccomendationsLabel()
    self.createRecommendationsView()
    
  }
  
  private func createReccomendationsLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    recommentationsLabel = UILabel.init(frame: frameForLabel)
    recommentationsLabel.numberOfLines = 0
    recommentationsLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 25.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Recomendaciones",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    recommentationsLabel.attributedText = stringWithFormat
    recommentationsLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (recommentationsLabel.frame.size.width / 2.0),
                               y: 0.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: recommentationsLabel.frame.size.width,
                               height: recommentationsLabel.frame.size.height)
    
    recommentationsLabel.frame = newFrame
    
    self.addSubview(recommentationsLabel)
    
  }
  
  private func createRecommendationsView() {
    
    var frameForRecommendations = CGRect.init(x: 0.0,
              y: recommentationsLabel.frame.origin.y + recommentationsLabel.frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight),
          width: 193.0 * UtilityManager.sharedInstance.conversionWidth,
         height: 26.0 * UtilityManager.sharedInstance.conversionHeight)
    
    for recommendation in arrayOfRecommendations {
      
      let newRecommendation = SimpleIconLabelView.init(frame: frameForRecommendations,
                                              newTextOfLabel: recommendation,
                                               newNameOfIcon: "smallGroup")
      
      self.addSubview(newRecommendation)
      
      frameForRecommendations = CGRect.init(x: 0.0,
             y: newRecommendation.frame.origin.y + newRecommendation.frame.size.height + (3.0 * UtilityManager.sharedInstance.conversionHeight),
         width: frameForRecommendations.size.width,
        height: frameForRecommendations.size.height)
      
    }
    
  }
  

  
}
