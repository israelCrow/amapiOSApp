//
//  SkillLevelView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/7/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class SkillLevelView: UIView {
  
  private var skill: Skill! = nil
  private var skillNameLabel: UILabel! = nil
  private var arrayOfStars = [UIImageView]()
  
  init(frame: CGRect, skillData: Skill) {
    skill = skillData
    
    super.init(frame: frame)
    
    self.initInterface()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func initInterface() {
    
    self.createSkillNameLabel()
    self.createStars()
    self.createBottomLine()
    
  }
  
  private func createSkillNameLabel() {
    
    skillNameLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: skill.name,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    skillNameLabel.attributedText = stringWithFormat
    skillNameLabel.sizeToFit()
    let newFrame = CGRect.init(x: 10.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 20.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: skillNameLabel.frame.size.width,
                               height: skillNameLabel.frame.size.height)
    
    skillNameLabel.frame = newFrame
    
    self.addSubview(skillNameLabel)
    
  }
  
  private func createStars() {
  
    self.createArrayOfStars()
    self.addStars()
  
  }
  
  private func createArrayOfStars() {
    
    if skill.level == 0 || skill.level == nil {
      var frameForHollowStars = CGRect.init(x: 156.0 * UtilityManager.sharedInstance.conversionWidth,
                                            y: 20.0 * UtilityManager.sharedInstance.conversionHeight,
                                        width: 14.4 * UtilityManager.sharedInstance.conversionWidth,
                                       height: 14.4 * UtilityManager.sharedInstance.conversionHeight)
      
      for _ in 0..<3 {
        let hollowStar = UIImageView.init(image: UIImage.init(named: "star"))
        hollowStar.frame = CGRect.init(x: frameForHollowStars.origin.x,
                                       y: frameForHollowStars.origin.y,
                                   width: hollowStar.frame.size.width,
                                  height: hollowStar.frame.size.height)
        
        frameForHollowStars = CGRect.init(x: frameForHollowStars.origin.x + hollowStar.frame.size.width +  (5.6 * UtilityManager.sharedInstance.conversionWidth),
                                          y: frameForHollowStars.origin.y,
                                      width: frameForHollowStars.size.width,
                                     height: frameForHollowStars.size.height)
        
        arrayOfStars.append(hollowStar)
      }
    }else
      if skill.level == 1 {
        
        var frameForHollowStars = CGRect.init(x: 156.0 * UtilityManager.sharedInstance.conversionWidth,
                                              y: 20.0 * UtilityManager.sharedInstance.conversionHeight,
                                          width: 14.4 * UtilityManager.sharedInstance.conversionWidth,
                                         height: 14.4 * UtilityManager.sharedInstance.conversionHeight)
        
        let hollowStar = UIImageView.init(image: UIImage.init(named: "starCopy"))
        hollowStar.frame = CGRect.init(x: frameForHollowStars.origin.x,
                                       y: frameForHollowStars.origin.y,
                                       width: hollowStar.frame.size.width,
                                       height: hollowStar.frame.size.height)
        arrayOfStars.append(hollowStar)
        
        for _ in 1..<3 {
          let lastStar = arrayOfStars.last!
          
          frameForHollowStars = CGRect.init(x: lastStar.frame.origin.x + lastStar.frame.size.width +  (5.6 * UtilityManager.sharedInstance.conversionWidth),
                                            y: frameForHollowStars.origin.y,
                                            width: frameForHollowStars.size.width,
                                            height: frameForHollowStars.size.height)
          
          let hollowStar = UIImageView.init(image: UIImage.init(named: "star"))
          hollowStar.frame = CGRect.init(x: frameForHollowStars.origin.x,
                                         y: frameForHollowStars.origin.y,
                                         width: hollowStar.frame.size.width,
                                         height: hollowStar.frame.size.height)
          
          arrayOfStars.append(hollowStar)
        }
    }else
      if skill.level == 2 {
        var frameForHollowStars = CGRect.init(x: 156.0 * UtilityManager.sharedInstance.conversionWidth,
                                              y: 20.0 * UtilityManager.sharedInstance.conversionHeight,
                                          width: 14.4 * UtilityManager.sharedInstance.conversionWidth,
                                         height: 14.4 * UtilityManager.sharedInstance.conversionHeight)
        
        for _ in 0..<2 {
          let hollowStar = UIImageView.init(image: UIImage.init(named: "starCopy"))
          hollowStar.frame = CGRect.init(x: frameForHollowStars.origin.x,
                                         y: frameForHollowStars.origin.y,
                                         width: hollowStar.frame.size.width,
                                         height: hollowStar.frame.size.height)
          
          frameForHollowStars = CGRect.init(x: frameForHollowStars.origin.x + hollowStar.frame.size.width +  (5.6 * UtilityManager.sharedInstance.conversionWidth),
                                            y: frameForHollowStars.origin.y,
                                            width: frameForHollowStars.size.width,
                                            height: frameForHollowStars.size.height)
          
          arrayOfStars.append(hollowStar)
        }
        
        let hollowStar = UIImageView.init(image: UIImage.init(named: "star"))
        hollowStar.frame = CGRect.init(x: frameForHollowStars.origin.x,
                                       y: frameForHollowStars.origin.y,
                                       width: hollowStar.frame.size.width,
                                       height: hollowStar.frame.size.height)
        
        arrayOfStars.append(hollowStar)
    }else
      if skill.level == 3 {
        var frameForHollowStars = CGRect.init(x: 156.0 * UtilityManager.sharedInstance.conversionWidth,
                                              y: 20.0 * UtilityManager.sharedInstance.conversionHeight,
                                              width: 14.4 * UtilityManager.sharedInstance.conversionWidth,
                                              height: 14.4 * UtilityManager.sharedInstance.conversionHeight)
        
        for _ in 0..<3 {
          let hollowStar = UIImageView.init(image: UIImage.init(named: "starCopy"))
          hollowStar.frame = CGRect.init(x: frameForHollowStars.origin.x,
                                         y: frameForHollowStars.origin.y,
                                         width: hollowStar.frame.size.width,
                                         height: hollowStar.frame.size.height)
          
          frameForHollowStars = CGRect.init(x: frameForHollowStars.origin.x + hollowStar.frame.size.width +  (5.6 * UtilityManager.sharedInstance.conversionWidth),
                                            y: frameForHollowStars.origin.y,
                                            width: frameForHollowStars.size.width,
                                            height: frameForHollowStars.size.height)
          
          arrayOfStars.append(hollowStar)
        }
      }
  }
  
  private func addStars() {
    
    for star in arrayOfStars {
      
      self.addSubview(star)
      
    }
    
  }
  
  private func createBottomLine() {
    
    let border = CALayer()
    let width = CGFloat(0.5)
    border.borderColor = UIColor.darkGrayColor().CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 0.0,
                               y: self.frame.size.height - (2.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                               height: 1.0 )
    self.layer.addSublayer(border)
    
  }
  
}
