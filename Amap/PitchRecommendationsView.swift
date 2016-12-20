//
//  PitchRecommendationsView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 12/9/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class PitchRecommendationsView: UIView {
  
  private var titleLabel: UILabel! = nil
  private var framesForRecommendations = Array<CGRect>()
  private var recommendations: [RecommendationModelData]! = nil
  private var recommendationsView = [UIView]()
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newRecommendations: [RecommendationModelData]) {
    
    recommendations = newRecommendations
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.createTitleLabel()
    self.createFrames()
    self.createRecommendations()
    
  }
  
  private func createFrames() {
    
    let firstFrame = CGRect.init(x: 0.0,
                                 y: titleLabel.frame.origin.y + titleLabel.frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight),
                             width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                            height: 25.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let secondFrame = CGRect.init(x: 0.0,
                                  y: titleLabel.frame.origin.y + titleLabel.frame.size.height + (64.0 * UtilityManager.sharedInstance.conversionHeight),
                              width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                             height: 25.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let thirdFrame = CGRect.init(x: 0.0,
                                 y: titleLabel.frame.origin.y + titleLabel.frame.size.height + (108.0 * UtilityManager.sharedInstance.conversionHeight),
                             width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                            height: 25.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let fourthFrame = CGRect.init(x: 0.0,
                                  y: titleLabel.frame.origin.y + titleLabel.frame.size.height + (152.0 * UtilityManager.sharedInstance.conversionHeight),
                              width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                             height: 25.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let fifthrame = CGRect.init(x: 0.0,
                                y: titleLabel.frame.origin.y + titleLabel.frame.size.height + (196.0 * UtilityManager.sharedInstance.conversionHeight),
                            width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                           height: 25.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let sixthFrame = CGRect.init(x: 0.0,
                                 y: titleLabel.frame.origin.y + titleLabel.frame.size.height + (240.0 * UtilityManager.sharedInstance.conversionHeight),
                             width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                            height: 25.0 * UtilityManager.sharedInstance.conversionHeight)
    
//    let firstFrame = CGRect.init(x: 0.0,
//                                 y: titleLabel.frame.origin.y + titleLabel.frame.size.height + (32.0 * UtilityManager.sharedInstance.conversionHeight),
//                             width: 95.0 * UtilityManager.sharedInstance.conversionWidth,
//                            height: 80.0 * UtilityManager.sharedInstance.conversionHeight)
//    
//    let secondFrame = CGRect.init(x: 111.0 * UtilityManager.sharedInstance.conversionWidth,
//                                  y: titleLabel.frame.origin.y + titleLabel.frame.size.height + (32.0 * UtilityManager.sharedInstance.conversionHeight),
//                                 width: 95.0 * UtilityManager.sharedInstance.conversionWidth,
//                                 height: 80.0 * UtilityManager.sharedInstance.conversionHeight)
//    
//    let thirdFrame = CGRect.init(x: 222.0 * UtilityManager.sharedInstance.conversionWidth,
//                                 y: titleLabel.frame.origin.y + titleLabel.frame.size.height + (32.0 * UtilityManager.sharedInstance.conversionHeight),
//                                 width: 95.0 * UtilityManager.sharedInstance.conversionWidth,
//                                 height: 80.0 * UtilityManager.sharedInstance.conversionHeight)
//    
//    let fourthFrame = CGRect.init(x: 0.0,
//                                 y: titleLabel.frame.origin.y + titleLabel.frame.size.height + (129.0 * UtilityManager.sharedInstance.conversionHeight),
//                                 width: 95.0 * UtilityManager.sharedInstance.conversionWidth,
//                                 height: 80.0 * UtilityManager.sharedInstance.conversionHeight)
//    
//    let fifthrame = CGRect.init(x: 111.0 * UtilityManager.sharedInstance.conversionWidth,
//                                 y: titleLabel.frame.origin.y + titleLabel.frame.size.height + (129.0 * UtilityManager.sharedInstance.conversionHeight),
//                                 width: 95.0 * UtilityManager.sharedInstance.conversionWidth,
//                                 height: 80.0 * UtilityManager.sharedInstance.conversionHeight)
//    
//    let sixthFrame = CGRect.init(x: 222.0 * UtilityManager.sharedInstance.conversionWidth,
//                                 y: titleLabel.frame.origin.y + titleLabel.frame.size.height + (129.0 * UtilityManager.sharedInstance.conversionHeight),
//                                 width: 95.0 * UtilityManager.sharedInstance.conversionWidth,
//                                 height: 80.0 * UtilityManager.sharedInstance.conversionHeight)
    
    framesForRecommendations = [firstFrame, secondFrame, thirdFrame, fourthFrame, fifthrame, sixthFrame]
    
  }
  
  private func createTitleLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 287.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    titleLabel = UILabel.init(frame: frameForLabel)
    titleLabel.numberOfLines = 0
    titleLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Recomendaciones",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    titleLabel.attributedText = stringWithFormat
    titleLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (titleLabel.frame.size.width / 2.0),
                               y: 0.0,
                               width: titleLabel.frame.size.width,
                               height: titleLabel.frame.size.height)
    
    titleLabel.frame = newFrame
    
    self.addSubview(titleLabel)
    
  }
  
  private func createRecommendations() {
    
    var recommendationsFrame = framesForRecommendations[0]
    
    for recommendation in recommendations {
      
      let recommendationView = PitchRecommendationImageLabelView.init(frame: recommendationsFrame,
        newIconName: recommendation.iconName,
        newRecommendationText: recommendation.body)
      
      self.addSubview(recommendationView)
      self.recommendationsView.append(recommendationView)
      
      recommendationsFrame = CGRect.init(x: recommendationsFrame.origin.x,
                                         y: recommendationView.frame.origin.y + recommendationView.frame.size.height + (8.0 * UtilityManager.sharedInstance.conversionHeight) ,
                                     width: recommendationsFrame.size.width,
                                    height: recommendationsFrame.size.height)
      
    }
    
    
//    let firstRecommendation = PitchRecommendationImageLabelView.init(frame: framesForRecommendations[0],
//        newIconName: "communication",
//        newRecommendationText: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis nat")
//    
//    self.addSubview(firstRecommendation)
//    
//    let secondRecommendation = PitchRecommendationImageLabelView.init(frame: framesForRecommendations[1],
//        newIconName: "list",
//        newRecommendationText: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis nat")
//    
//    self.addSubview(secondRecommendation)
//    
//    let thirdRecommendation = PitchRecommendationImageLabelView.init(frame: framesForRecommendations[2],
//        newIconName: "budget",
//        newRecommendationText: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis nat")
//    
//    self.addSubview(thirdRecommendation)
//    
//    let fourthRecommendation = PitchRecommendationImageLabelView.init(frame: framesForRecommendations[3],
//        newIconName: "criteria",
//        newRecommendationText: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis nat")
//    
//    self.addSubview(fourthRecommendation)
//    
//    let fifthRecommendation = PitchRecommendationImageLabelView.init(frame: framesForRecommendations[4],
//        newIconName: "moreTime",
//        newRecommendationText: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis nat")
//    
//    self.addSubview(fifthRecommendation)
    
//    let firstRecommendation = PitchRecommendationView.init(frame: framesForRecommendations[0],
//                                                      imageName: "group",
//                                                      textLabel: "Reduce el número de agencias participantes")
//    
//    self.addSubview(firstRecommendation)
//    
//    let secondRecommendation = PitchRecommendationView.init(frame: framesForRecommendations[1],
//                                                           imageName: "",
//                                                           textLabel: "Aumenta el tiempo para presentar las ideas")
//    
//    self.addSubview(secondRecommendation)
//    
//    let thirdRecommendation = PitchRecommendationView.init(frame: framesForRecommendations[2],
//                                                           imageName: "",
//                                                           textLabel: "Reduce el número de agencias participantes")
//    
//    self.addSubview(thirdRecommendation)
//    
//    let fourthRecommendation = PitchRecommendationView.init(frame: framesForRecommendations[3],
//                                                           imageName: "",
//                                                           textLabel: "Presenta feedback de las ideas en máximo 2 semanas")
//    
//    self.addSubview(fourthRecommendation)
//    
//    let fifthRecommendation = PitchRecommendationView.init(frame: framesForRecommendations[4],
//                                                           imageName: "",
//                                                           textLabel: "Permite que las agencias conserven la propiedad intelectual")
//    
//    self.addSubview(fifthRecommendation)
//    
//    let sixthRecommendation = PitchRecommendationView.init(frame: framesForRecommendations[5],
//                                                           imageName: "",
//                                                           textLabel: "De preferencia paga el pitch a las agencias por su trabajo")
//    
//    self.addSubview(sixthRecommendation)
    
  }
  
  func getFinalHeight() -> CGFloat {
    
    var finalHeight: CGFloat = titleLabel.frame.origin.y + titleLabel.frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight)
    
    for recommendationView in recommendationsView {
      
      finalHeight = finalHeight + recommendationView.frame.size.height + (8.0 * UtilityManager.sharedInstance.conversionHeight)
      
    }
    
    return finalHeight
    
  }
  
}
