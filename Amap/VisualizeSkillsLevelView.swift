//
//  VisualizeSkillsLevelView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/6/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol VisualizeSkillsLevelViewDelegate {
  
  func cancelShowSkillsLevelView()
  
}

class VisualizeSkillsLevelView: UIView {
  
  private var cancelShowSkillsLevelButton: UIButton! = nil
  private var agencyNameLabel: UILabel! = nil
  private var agencyProfilePicImageView: UIImageView! = nil
  private var skillCategoryNameLabel: UILabel! = nil
  private var mainScrollView: UIScrollView! = nil
  private var skills = [Skill]()
  private var skillCategoryName: String! = nil
  
  var delegate: VisualizeSkillsLevelViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, skillCategory: String, arrayOfSkills: [Skill]) {
    skillCategoryName = skillCategory
    skills = arrayOfSkills

    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    self.createCancelShowSkillsLevelButton()
    self.createAgencyNameLabel()
    self.createBrandImageView()
    self.createSkillCategoryNameLabel()
    self.createMainScrollView()
    self.createAllSkillsLevel()
    
  }
  
  private func createCancelShowSkillsLevelButton() {
    
    let frameForButton = CGRect.init(x:255.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 0.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 40.0 * UtilityManager.sharedInstance.conversionWidth ,
                                     height: 40.0 * UtilityManager.sharedInstance.conversionHeight)
    
    cancelShowSkillsLevelButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "iconCloseBlack") as UIImage?
    cancelShowSkillsLevelButton.setImage(image, forState: .Normal)
    cancelShowSkillsLevelButton.alpha = 1.0
    cancelShowSkillsLevelButton.addTarget(self, action: #selector(cancelShowSkillsLevel), forControlEvents:.TouchUpInside)
//    cancelShowSkillsLevelButton.contentEdgeInsets = UIEdgeInsets.init(top: -30, left: -30, bottom: -30, right: -30)
    
    self.addSubview(cancelShowSkillsLevelButton)
    
  }
  
  private func createAgencyNameLabel() {
    
    agencyNameLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: AgencyModel.Data.name,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    agencyNameLabel.attributedText = stringWithFormat
    agencyNameLabel.sizeToFit()
    let newFrame = CGRect.init(x: 101.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 64.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: agencyNameLabel.frame.size.width,
                               height: agencyNameLabel.frame.size.height)
    
    agencyNameLabel.frame = newFrame
    
    self.addSubview(agencyNameLabel)
    
  }
  
  private func createBrandImageView() {
    
    let frameForProfileImageView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                               y: 55.0 * UtilityManager.sharedInstance.conversionHeight,
                                               width: 48.0 * UtilityManager.sharedInstance.conversionWidth,
                                               height: 48.0 * UtilityManager.sharedInstance.conversionHeight)
    
    agencyProfilePicImageView = UIImageView.init(frame: frameForProfileImageView)
    agencyProfilePicImageView.backgroundColor = UIColor.lightGrayColor()
    agencyProfilePicImageView.layer.borderWidth = 0.35
    agencyProfilePicImageView.layer.masksToBounds = false
    agencyProfilePicImageView.layer.borderColor = UIColor.blackColor().CGColor
    agencyProfilePicImageView.layer.cornerRadius = agencyProfilePicImageView.frame.size.height / 2.0
    agencyProfilePicImageView.clipsToBounds = true
    agencyProfilePicImageView.userInteractionEnabled = true
    
    if AgencyModel.Data.logo != nil {
      
      agencyProfilePicImageView.imageFromUrl(AgencyModel.Data.logo!)
      
    }
    
    self.addSubview(agencyProfilePicImageView)
    
  }
  
  private func createSkillCategoryNameLabel() {
    
    skillCategoryNameLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: skillCategoryName,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    skillCategoryNameLabel.attributedText = stringWithFormat
    skillCategoryNameLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (skillCategoryNameLabel.frame.size.width / 2.0),
                               y: 133.0 * UtilityManager.sharedInstance.conversionHeight,
                           width: skillCategoryNameLabel.frame.size.width,
                          height: skillCategoryNameLabel.frame.size.height)
    
    skillCategoryNameLabel.frame = newFrame
    
    self.addSubview(skillCategoryNameLabel)
    
  }
  
  private func createMainScrollView() {
    
    let frameForMainScrollView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                             y: 179.0 * UtilityManager.sharedInstance.conversionHeight,
                                             width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                             height: 304.0 * UtilityManager.sharedInstance.conversionHeight)
    let sizeForContentScrollView = CGSize.init(width: frameForMainScrollView.size.width,
                                               height: frameForMainScrollView.size.height + (50.0 * UtilityManager.sharedInstance.conversionHeight))//Value that i considered
    
    mainScrollView = UIScrollView.init(frame: frameForMainScrollView)
    mainScrollView.backgroundColor = UIColor.clearColor()
    mainScrollView.contentSize = sizeForContentScrollView
    mainScrollView.showsVerticalScrollIndicator = false
    self.addSubview(mainScrollView)
    
  }
  
  private func createAllSkillsLevel() {
    
    var frameForEachSkill = CGRect.init(x: 0.0,
                                        y: 0.0,
                                    width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
    
    var numberOfSkills = 0
    
    for skill in skills {
      
      numberOfSkills = numberOfSkills + 1
      
      let newSkillView = SkillLevelView.init(frame: frameForEachSkill,
                                         skillData: skill)
      self.mainScrollView.addSubview(newSkillView)
      
      frameForEachSkill = CGRect.init(x: 0.0,
                                      y: frameForEachSkill.origin.y + (56.0 * UtilityManager.sharedInstance.conversionHeight),
                                  width: frameForEachSkill.size.width,
                                 height: frameForEachSkill.size.height)
      
      if numberOfSkills > 5 {
        
        self.resizeMainScrollViewContentSize()
        
      }
      
    }
    
  }
  
  private func resizeMainScrollViewContentSize() {
    
    let newContentSize = CGSize.init(width: mainScrollView.frame.size.width,
                                    height: mainScrollView.frame.size.height + (56.0 * UtilityManager.sharedInstance.conversionHeight))
    mainScrollView.contentSize = newContentSize
    
  }
  
  @objc private func cancelShowSkillsLevel() {
    
    self.delegate?.cancelShowSkillsLevelView()
    
  }
  
  
}
