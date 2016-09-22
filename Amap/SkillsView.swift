//
//  SkillsView.swift
//  Amap
//
//  Created by Mac on 8/15/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class SkillsView: UIView, UITableViewDelegate, UITableViewDataSource{
  
  private var skillsLabel: UILabel! = nil
  private var collapsibleTableView: UITableView! = nil
  private var skillCategories: [SkillCategory]! = nil
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.initInterface()
    self.initValues()
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    self.addGestureToDismissKeyboard()
    self.createSkillsLabel()
    self.createCollapsibleTableView()
    
  }
  
  private func addGestureToDismissKeyboard() {
    
    let tapToDismissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                              action: #selector(dismissKeyboard))
    tapToDismissKeyboard.numberOfTapsRequired = 1
    self.addGestureRecognizer(tapToDismissKeyboard)
    
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
                               y: 30.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: skillsLabel.frame.size.width,
                               height: skillsLabel.frame.size.height)
    
    skillsLabel.frame = newFrame
    
    self.addSubview(skillsLabel)
    
  }
  
  private func createCollapsibleTableView() {
    
    let frameForCollpasibleTable = CGRect.init(x: 34.0 * UtilityManager.sharedInstance.conversionWidth,
                                               y: 106.0 * UtilityManager.sharedInstance.conversionHeight,
                                               width: 235.0 * UtilityManager.sharedInstance.conversionWidth,
                                               height: 355.0 * UtilityManager.sharedInstance.conversionHeight)
    
    collapsibleTableView = UITableView.init(frame: frameForCollpasibleTable)
    collapsibleTableView.backgroundColor = UIColor.whiteColor()
    collapsibleTableView.delegate = self
    collapsibleTableView.dataSource = self
    collapsibleTableView.showsVerticalScrollIndicator = true
    collapsibleTableView.registerClass(CollapsibleTableViewHeader.self, forCellReuseIdentifier: "header")
    collapsibleTableView.registerClass(CustomSkillTableViewCell.self, forCellReuseIdentifier: "cell")
    self.addSubview(collapsibleTableView)
  }
  
  private func initValues() {

    skillCategories = []
    
    for section in 0..<collapsibleTableView.numberOfSections {
      let rowCount = collapsibleTableView.numberOfRowsInSection(section)
      var list = [CustomSkillTableViewCell]()
      
      for row in 0 ..< rowCount {
        let cell = collapsibleTableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: section)) as! CustomSkillTableViewCell
        list.append(cell)
      }
    }
    
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return skillCategories.count
  }
  
  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 56.0 * UtilityManager.sharedInstance.conversionHeight
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (skillCategories[section].collapsed!) ? 0 : skillCategories[section].arrayOfSkills.count
  }

  func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = tableView.dequeueReusableCellWithIdentifier("header") as! CollapsibleTableViewHeader
    
    let frameForButtonHeader = CGRect.init(x: 0.0,
                                           y: 0.0,
                                       width: header.frame.size.width - (40.0 * UtilityManager.sharedInstance.conversionWidth),
                                      height: header.frame.size.height)
    
    let buttonForHeader = UIButton.init(frame: frameForButtonHeader)
    buttonForHeader.backgroundColor = UIColor.clearColor()
    buttonForHeader.tag = section
    buttonForHeader.addTarget(self, action: #selector(toggleCollapse), forControlEvents: .TouchUpInside)
    
    
    header.toggleButton.tag = section
    header.setMutableAttributedStringOfNameOfSkillLabel(skillCategories[section].name)
    header.toggleButton.rotate(skillCategories[section].collapsed! ? 0.0 : CGFloat(M_PI_2))
    header.toggleButton.addTarget(self, action: #selector(toggleCollapse), forControlEvents: .TouchUpInside)
    
    header.contentView.addSubview(buttonForHeader)
    
    return header.contentView
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! CustomSkillTableViewCell!
    
    self.changeAttributedTextOfNormalCell(cell, subSkillText: skillCategories[indexPath.section].arrayOfSkills[indexPath.row].name)
    cell.setSkillData(skillCategories[indexPath.section].arrayOfSkills[indexPath.row])
    
    cell.selectionStyle = UITableViewCellSelectionStyle.None
    
    return cell
  }
  
  private func changeAttributedTextOfNormalCell(cellToChangeText: UITableViewCell, subSkillText: String) {
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.init(red: 143.0/255.0, green: 142.0/255.0, blue: 148.0/255.0, alpha: 1.0)
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: subSkillText,
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    cellToChangeText.textLabel?.attributedText = stringWithFormat
    
  }
  
  @objc func dismissKeyboard(sender:AnyObject) {
    self.endEditing(true)
  }
  
  // MARK: - Event Handlers
  func toggleCollapse(sender: UIButton) {
    let section = sender.tag
    let collapsed = skillCategories[section].collapsed
    
    // Toggle collapse
    skillCategories[section].collapsed = !collapsed
    
    // Reload section
    collapsibleTableView.reloadSections(NSIndexSet(index: section), withRowAnimation: .Automatic)
  }
  
  func getAllSkillsFromServer() {
    
    UtilityManager.sharedInstance.showLoader()
    
    RequestToServerManager.sharedInstance.requestToGetAllSkillsCategories {
      jsonOfSkills in
      
      let json = jsonOfSkills as? [String:AnyObject]
      
      if json != nil {
        
        let categories = json!["skill_categories"] as? Array<[String:AnyObject]>
        
        if categories != nil {
          
          for category in categories! {
            
            var categoryId:String!
            if category["id"] as? Int != nil {
              categoryId = String(category["id"] as? Int)
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
              
              let newSkill = Skill.init(id: skillId, nameSkill: skillName!, levelSkill: skillLevel)
              newArrayOfSkills.append(newSkill)
              
            }
            
            let newCategory = SkillCategory.init(id: categoryId,
              name: categoryName,
              arrayOfSkills: newArrayOfSkills,
              isCollapsed: true)
            
            self.skillCategories.append(newCategory)
            
          }
          
          self.collapsibleTableView.reloadData()
          
        }
        
      }
      
      UtilityManager.sharedInstance.hideLoader()
      
    }
    
  }
  
  private func getAllTheCells() -> [CustomSkillTableViewCell] {
    
    var list = [CustomSkillTableViewCell]()
    
    for section in 0..<collapsibleTableView.numberOfSections {
      let rowCount = collapsibleTableView.numberOfRowsInSection(section)
      
      for row in 0 ..< rowCount {
        let cell = collapsibleTableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: section)) as! CustomSkillTableViewCell
        list.append(cell)
      }
    }
    
    return list
    
  }
  
  func getParamsToSaveDataOfSkills() -> [String:AnyObject]{
    
    let listOfCells = self.getAllTheCells()
    
    var arrayOfEditedSkills = Array<[String:String]>()
    
    for cell in listOfCells {
      
      arrayOfEditedSkills.append(["id":cell.skillData.id , "level":cell.scoreTextField.text!])
      
    }
    
    let params: [String:AnyObject] = [
      "auth_token" : UserSession.session.auth_token,
      "id" : UserSession.session.agency_id,
      "skills" : arrayOfEditedSkills
    ]

   return params
  }
  
  
}
