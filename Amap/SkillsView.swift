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
  private var sections: [Section]! = nil
  
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
    collapsibleTableView.registerClass(CollapsibleTableViewHeader.self, forCellReuseIdentifier: "header")
    collapsibleTableView.registerClass(CustomSkillTableViewCell.self, forCellReuseIdentifier: "cell")
    self.addSubview(collapsibleTableView)
  }
  
  private func initValues() {
    
    let subSkillsForSkillOne = [
      Skill.init(nameSkill: "Sub-skill 1", scoreSkill: 0),
      Skill.init(nameSkill: "Sub-skill 1", scoreSkill: 0),
      Skill.init(nameSkill: "Sub-skill 1", scoreSkill: 0),
      Skill.init(nameSkill: "Sub-skill 1", scoreSkill: 0)
    ]
    
    let subSkillsForSkillTwo = [
      Skill.init(nameSkill: "Sub-skill 2", scoreSkill: 1),
      Skill.init(nameSkill: "Sub-skill 2", scoreSkill: 1),
      Skill.init(nameSkill: "Sub-skill 2", scoreSkill: 1)
    ]
    
    let subSkillsForSkillThree = [
      Skill.init(nameSkill: "Sub-skill 3", scoreSkill: 2),
      Skill.init(nameSkill: "Sub-skill 3", scoreSkill: 2),
      Skill.init(nameSkill: "Sub-skill 3", scoreSkill: 2)
    ]
    
    let subSkillsForSkillFour = [
      Skill.init(nameSkill: "Sub-skill 4", scoreSkill: 0),
      Skill.init(nameSkill: "Sub-skill 4", scoreSkill: 1),
      Skill.init(nameSkill: "Sub-skill 4", scoreSkill: 2),
      Skill.init(nameSkill: "Sub-skill 4", scoreSkill: 3),
      Skill.init(nameSkill: "Sub-skill 4", scoreSkill: 2),
      Skill.init(nameSkill: "Sub-skill 4", scoreSkill: 1)
    ]
    
    let subSkillsForSkillFive = [
      Skill.init(nameSkill: "Sub-skill 5", scoreSkill: 1),
      Skill.init(nameSkill: "Sub-skill 5", scoreSkill: 0)
    ]
    
    let subSkillsForSkillSix = [
      Skill.init(nameSkill: "Sub-skill 6", scoreSkill: 0)
    ]
    
    sections = [
      Section(name: "Skill 1", skills: subSkillsForSkillOne),
      Section(name: "Skill 2", skills: subSkillsForSkillTwo),
      Section(name: "Skill 3", skills: subSkillsForSkillThree),
      Section(name: "Skill 4", skills: subSkillsForSkillFour),
      Section(name: "Skill 5", skills: subSkillsForSkillFive),
      Section(name: "Skill 6", skills: subSkillsForSkillSix)
    ]
    
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return sections.count
  }
  
  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 56.0 * UtilityManager.sharedInstance.conversionHeight
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (sections[section].collapsed!) ? 0 : sections[section].skills.count
  }

  func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = tableView.dequeueReusableCellWithIdentifier("header") as! CollapsibleTableViewHeader
    
    header.toggleButton.tag = section
    header.setMutableAttributedStringOfNameOfSkillLabel(sections[section].name)
    header.toggleButton.rotate(sections[section].collapsed! ? 0.0 : CGFloat(M_PI_2))
    header.toggleButton.addTarget(self, action: #selector(toggleCollapse), forControlEvents: .TouchUpInside)
    
    return header.contentView
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! CustomSkillTableViewCell!
    
    self.changeAttributedTextOfNormalCell(cell, subSkillText: sections[indexPath.section].skills[indexPath.row].nameOfSkill)
    
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
    let collapsed = sections[section].collapsed
    
    // Toggle collapse
    sections[section].collapsed = !collapsed
    
    // Reload section
    collapsibleTableView.reloadSections(NSIndexSet(index: section), withRowAnimation: .Automatic)
  }
}
