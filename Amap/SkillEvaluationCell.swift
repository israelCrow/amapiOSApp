//
//  SkillEvaluationCell.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/12/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class SkillEvaluationCell: UICollectionViewCell {
  
  private var iconOfCell: UIImageView! = nil
  private var titleLabel: UILabel! = nil
  
  private var evaluationPitchSkillCategoryData: EvaluationPitchSkillCategoryModelData! = nil
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.createIconCell()
  }
  
  func createIconCell() {
    
    if iconOfCell == nil {
    
      iconOfCell = UIImageView.init(image: UIImage.init(named: "goldenPitch_star"))
    
      let frameForIcon = CGRect.init(x: (self.frame.size.width / 2.0) - (34.0 * UtilityManager.sharedInstance.conversionWidth),
                                     y: (self.frame.size.height / 2.0) - (33.0 * UtilityManager.sharedInstance.conversionHeight),
                                 width: 34.0 * UtilityManager.sharedInstance.conversionWidth,
                                height: 33.0 * UtilityManager.sharedInstance.conversionWidth)
    
      iconOfCell.frame = frameForIcon
    
      self.addSubview(iconOfCell)
    
      
    }
    
  }
  
  func setEvaluationPitchSkillCategoryData(newEvaluationPitchSkillCategoryData: EvaluationPitchSkillCategoryModelData) {
    
    self.evaluationPitchSkillCategoryData = newEvaluationPitchSkillCategoryData
    
    self.reloadLabel(evaluationPitchSkillCategoryData.evaluationSkillCategoryName)
    
  }
  
  private func reloadLabel(titleString: String) {
    
    if titleLabel != nil {
      
      titleLabel.removeFromSuperview()
      titleLabel = nil
      
    }
    
    titleLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: titleString,
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    
    titleLabel.attributedText = stringWithFormat
    titleLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (titleLabel.frame.size.width / 2.0),
                               y: self.frame.size.height - (titleLabel.frame.size.height + 2.0),
                               width: titleLabel.frame.size.width,
                               height: titleLabel.frame.size.height)
    
    titleLabel.frame = newFrame
    self.addSubview(titleLabel)
    
  }

}


