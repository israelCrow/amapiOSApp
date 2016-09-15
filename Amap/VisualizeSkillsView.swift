//
//  VisualizeSkillsView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/5/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol VisualizeSkillsViewDelegate {
  
  func flipCardToShowSkillsOfCategory(skills: [Skill], skillCategoryName: String)
  
}

class VisualizeSkillsView: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, VisualizeCategorySkillCellDelegate {
  
  private var mainCollectionView: UICollectionView! = nil
  private var skillsLabel: UILabel! = nil
  private var skillCategories = [SkillCategory]()
//  private var categorySkillButtons
  
  var delegate: VisualizeSkillsViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.initInterface()
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    
    self.createMainCollectionView()
    self.createSkillsLabel()
    
  }
  
  private func createMainCollectionView() {
    
    let sizeOfItems = CGSize(width: 85.0 * UtilityManager.sharedInstance.conversionWidth,
                              height: 95.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let frameForMainCollectionView = CGRect.init(x: 34.0 * UtilityManager.sharedInstance.conversionWidth,
                                             y: 46.0 * UtilityManager.sharedInstance.conversionHeight,
                                             width: 235.0 * UtilityManager.sharedInstance.conversionWidth,
                                             height: 270.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    layout.itemSize = sizeOfItems
    
    mainCollectionView = UICollectionView(frame: frameForMainCollectionView,
                           collectionViewLayout: layout)
    mainCollectionView.dataSource = self
    mainCollectionView.delegate = self
    mainCollectionView.registerClass(VisualizeCategorySkillCell.self ,forCellWithReuseIdentifier: "Cell")
    mainCollectionView.backgroundColor = UIColor.whiteColor()
    self.addSubview(mainCollectionView)
    
  }
  
  private func createSkillsLabel() {
    
    skillsLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: AgencyProfileEditConstants.SkillsView.skillsLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    skillsLabel.attributedText = stringWithFormat
    skillsLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (skillsLabel.frame.size.width / 2.0),
                               y: 0.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: skillsLabel.frame.size.width,
                               height: skillsLabel.frame.size.height)
    
    skillsLabel.frame = newFrame
    
    self.addSubview(skillsLabel)
    
  }
  
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return skillCategories.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! VisualizeCategorySkillCell
    
    cell.setImage("mediumFace")
    cell.setCategorySkill(skillCategories[indexPath.row])
    cell.delegate = self

    return cell
  }
  
  func getAllSkillsFromServer() {
    
    RequestToServerManager.sharedInstance.requestToGetAllSkillsCategories {
      jsonOfSkills in
      
      let json = jsonOfSkills as? [String:AnyObject]
      
      if json != nil {
        
        let categories = json!["skill_categories"] as? Array<[String:AnyObject]>
        
        if categories != nil {
          
          for category in categories! {
            
            var categoryId:String!
            if category["id"] as? Int != nil {
              categoryId = String(category["id"] as! Int)
            }
            let categoryName = category["name"] as! String
            
            let skillsOfCategorie = category["skills"] as? Array<[String:AnyObject]>
            
            var newArrayOfSkills = [Skill]()
            
            for skillOfCategories in skillsOfCategorie! {
              
              let skillName = skillOfCategories["name"] as? String
              var skillId: String!
              if skillOfCategories["id"] as? Int != nil {
                skillId = String(skillOfCategories["id"] as! Int)
              }
              let skillLevel = skillOfCategories["level"] as? Int
              
              let newSkill = Skill.init(id: skillId, nameSkill: skillName!, levelSkill: skillLevel, skill_category_id: categoryId)
              newArrayOfSkills.append(newSkill)
              
            }
            
            let newCategory = SkillCategory.init(id: categoryId,
              name: categoryName,
              arrayOfSkills: newArrayOfSkills,
              isCollapsed: true)
            
            self.skillCategories.append(newCategory)
            
          }
          
          self.mainCollectionView.reloadData()
          
        }
        
      }
      
    }
    
  }
  
  //MARK: - VisualizeCategorySkillCellDelegate
  
  func showSkillsOfThisCategory(arrayOfSkills: [Skill], nameSkillCategory: String) {
    
    self.delegate?.flipCardToShowSkillsOfCategory(arrayOfSkills, skillCategoryName: nameSkillCategory)
  }

}

