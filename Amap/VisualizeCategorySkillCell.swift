//
//  VisualizeCategorySkillCell.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/5/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol VisualizeCategorySkillCellDelegate {
  
  func showSkillsOfThisCategory(arrayOfSkills: [Skill], nameSkillCategory: String)
  
}

class VisualizeCategorySkillCell: UICollectionViewCell {
  
  private var iconOfCell: UIImageView! = nil
  private var titleLabel: UILabel! = nil
  
  private var skillCategory: SkillCategory! = nil
  
  var delegate: VisualizeCategorySkillCellDelegate?
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  func setImage(imageName: String) {
    
    if iconOfCell != nil {
      
      iconOfCell.removeFromSuperview()
      iconOfCell = nil
      
    }
    
    iconOfCell = UIImageView.init(image: UIImage.init(named: imageName))
    
    let frameForIcon = CGRect.init(x: (self.frame.size.width / 2.0) - (iconOfCell.frame.size.width / 2.0),
      y: (self.frame.size.height / 2.0) - (iconOfCell.frame.size.height * 0.6),
      width: iconOfCell.frame.size.width,
      height: iconOfCell.frame.size.height)
    
    iconOfCell.frame = frameForIcon
    
    self.addSubview(iconOfCell)
    
    self.createGesture()
    
  }
  
  private func createGesture() {
    
    let gesture = UITapGestureRecognizer.init(target: self, action: #selector(showSkills))
    gesture.numberOfTapsRequired = 1
    
    self.userInteractionEnabled = true
    self.addGestureRecognizer(gesture)
    
  }
  
  func setCategorySkill(newCategorySkill: SkillCategory) {
    
    self.skillCategory = newCategorySkill
    
    self.reloadLabel(skillCategory.name)
    
  }
  
  private func reloadLabel(titleString: String) {
    
    if titleLabel != nil {
      
      titleLabel.removeFromSuperview()
      titleLabel = nil
      
    }
    
    titleLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 11.0 * UtilityManager.sharedInstance.conversionWidth)
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
  
  @objc private func showSkills() {
    
    var arrayOfSkillsQualifiedByUser = [Skill]()
    
    if AgencyModel.Data.skillsLevel != nil {
      
      for skillLevel in AgencyModel.Data.skillsLevel! {
        
        if skillLevel.skillCategoryId != nil && skillLevel.skillCategoryId == Int(skillCategory.id) {
          
          arrayOfSkillsQualifiedByUser.append(skillLevel)
          
        }
        
      }
      
    } else {  //This will happen when an agency doesn't have any skill evaluated
      
      arrayOfSkillsQualifiedByUser = skillCategory.arrayOfSkills
      
    }
    

  
    self.delegate?.showSkillsOfThisCategory(arrayOfSkillsQualifiedByUser, nameSkillCategory: skillCategory.name)
  
  }
  
}
