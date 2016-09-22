//
//  AddPitchAndWriteWhichCategoryIsView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/12/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol AddPitchAndWriteWhichCategoryIsViewDelegate {
  
  func createAddPitchAndShowPreEvaluatePitch(arrayOfCategoriesSelected: Array<PitchSkillCategory>)
  
}

class AddPitchAndWriteWhichCategoryIsView: UIView, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, PitchCategoryTableViewCellWhenSelectionChangeDelegate {
  
  private var writeWhichCategoryIsName: UILabel! = nil
  private var searchView: CustomTextFieldWithTitleView! = nil
  private var mainTableView: UITableView! = nil
  private var addButton: UIButton! = nil
  
  private var arrayOfAllCategories = [PitchSkillCategory]()
  private var arrayOfFilteredCategories = [PitchSkillCategory]()
  private var arrayOfSelectedCategories = [PitchSkillCategory]()
  
  
  var delegate: AddPitchAndWriteWhichCategoryIsViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.initInterface()
  }
  
  private func initInterface() {
    
    self.adaptMyself()
    self.createSomeData()     //DELETE IN THE FUTURE
    self.createWriteProjectNameLabel()
    self.createSearchView()
    self.createMainTableView()
//    self.createAskPermissionLabel()
    self.createAddButton()
    
  }
  
  private func adaptMyself() {
    self.backgroundColor = UIColor.whiteColor()
    self.layer.shadowColor = UIColor.blackColor().CGColor
    self.layer.shadowOpacity = 0.25
    self.layer.shadowOffset = CGSizeZero
    self.layer.shadowRadius = 5
    
    self.addGestures()
  }
  
  private func addGestures() {
    
    let tapToDismissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                              action: #selector(dismissKeyboard))
    tapToDismissKeyboard.numberOfTapsRequired = 1
    tapToDismissKeyboard.cancelsTouchesInView = false
    self.addGestureRecognizer(tapToDismissKeyboard)
    
  }
  
  private func createSomeData() {
    
//    let firstCategory = PitchCategory(pitchCategoryName: "Categoría 1", isThisCategory: false)
//    let secondCategory = PitchCategory(pitchCategoryName: "Categoría 2", isThisCategory: false)
//    
//    arrayOfAllCategories.append(firstCategory)
//    arrayOfAllCategories.append(secondCategory)
    
    arrayOfFilteredCategories = arrayOfAllCategories
    
  }
  
  private func createWriteProjectNameLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 255.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    writeWhichCategoryIsName = UILabel.init(frame: frameForLabel)
    writeWhichCategoryIsName.numberOfLines = 0
    writeWhichCategoryIsName.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.AddPitchAndWriteWhichCategoryIsView.writeWhichCategoryIsLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    writeWhichCategoryIsName.attributedText = stringWithFormat
    writeWhichCategoryIsName.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (writeWhichCategoryIsName.frame.size.width / 2.0),
                               y: 30.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: writeWhichCategoryIsName.frame.size.width,
                               height: writeWhichCategoryIsName.frame.size.height)
    
    writeWhichCategoryIsName.frame = newFrame
    
    self.addSubview(writeWhichCategoryIsName)
    
  }
  
  private func createSearchView() {
    
    let frameForSearchView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: 155.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                         height: 60.0 * UtilityManager.sharedInstance.conversionHeight)
    
    searchView = CustomTextFieldWithTitleView.init(frame: frameForSearchView,
                                                   title: nil,
                                                   image: "smallSearchIcon")
    searchView.mainTextField.addTarget(self,
                                       action: #selector(textDidChange),
                                       forControlEvents: UIControlEvents.AllEditingEvents)
    searchView.mainTextField.delegate = self
    self.addSubview(searchView)
    
  }
  
  private func createMainTableView() {
    
    let frameForTableView = CGRect.init(x: 20.0 * UtilityManager.sharedInstance.conversionWidth,
                                        y: 217.0 * UtilityManager.sharedInstance.conversionHeight,
                                        width: 240.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 195.0 * UtilityManager.sharedInstance.conversionHeight)
    
    mainTableView = UITableView.init(frame: frameForTableView)
    mainTableView.backgroundColor = UIColor.clearColor()
    mainTableView.delegate = self
    mainTableView.dataSource = self
    mainTableView.registerClass(PitchCategoryTableViewCell.self, forCellReuseIdentifier: "cell")
    
    self.addSubview(mainTableView)
    
  }
  
//  private func createAskPermissionLabel() {
//    
//    let frameForLabel = CGRect.init(x: 0.0,
//                                    y: 0.0,
//                                    width: 201.0 * UtilityManager.sharedInstance.conversionWidth,
//                                    height: CGFloat.max)
//    
//    askPermissionLabel = UILabel.init(frame: frameForLabel)
//    askPermissionLabel.numberOfLines = 0
//    askPermissionLabel.lineBreakMode = .ByWordWrapping
//    
//    let font = UIFont(name: "SFUIText-Light",
//                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
//    let color = UIColor.blackColor()
//    let style = NSMutableParagraphStyle()
//    style.alignment = NSTextAlignment.Center
//    
//    let stringWithFormat = NSMutableAttributedString(
//      string: VisualizePitchesConstants.AddPitchAndWriteProjectNameView.askPermissionLabelText,
//      attributes:[NSFontAttributeName: font!,
//        NSParagraphStyleAttributeName: style,
//        NSForegroundColorAttributeName: color
//      ]
//    )
//    askPermissionLabel.attributedText = stringWithFormat
//    askPermissionLabel.sizeToFit()
//    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (askPermissionLabel.frame.size.width / 2.0),
//                               y: 261.0 * UtilityManager.sharedInstance.conversionHeight,
//                               width: askPermissionLabel.frame.size.width,
//                               height: askPermissionLabel.frame.size.height)
//    
//    askPermissionLabel.frame = newFrame
//    askPermissionLabel.alpha = 0.0
//    
//    self.addSubview(askPermissionLabel)
//    
//  }
  
  private func createAddButton() {
    
    addButton = UIButton.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.AddPitchAndWriteWhichCategoryIsView.addButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    let colorWhenDisabled = UIColor.whiteColor()
    let styleWhenDisabled = NSMutableParagraphStyle()
    styleWhenDisabled.alignment = NSTextAlignment.Center
    
    let stringWithFormatWhenDisabled = NSMutableAttributedString(
      string: VisualizePitchesConstants.AddPitchAndWriteWhichCategoryIsView.addButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: styleWhenDisabled,
        NSForegroundColorAttributeName: colorWhenDisabled
      ]
    )
    
    addButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    addButton.setAttributedTitle(stringWithFormatWhenDisabled, forState: .Disabled)
    addButton.backgroundColor = UIColor.grayColor()
    addButton.addTarget(self,
                        action: #selector(addButtonPressed),
                        forControlEvents: .TouchUpInside)
    addButton.sizeToFit()
    
    let frameForButton = CGRect.init(x: 0.0,
                                     y: self.frame.size.height - (70.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: self.frame.size.width,
                                     height: 70.0 * UtilityManager.sharedInstance.conversionHeight)
    
    addButton.frame = frameForButton
    addButton.enabled = false
    
    self.addSubview(addButton)
    
  }
  
  //MARK: - ViewTableDelegate
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arrayOfFilteredCategories.count
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 56.0 * UtilityManager.sharedInstance.conversionHeight
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! PitchCategoryTableViewCell
    
    cell.changePitchCategoryData(arrayOfFilteredCategories[indexPath.row])
    cell.delegateWhenSelectionChange = self
    cell.selectionStyle = UITableViewCellSelectionStyle.None
    
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    self.cellPressed(arrayOfFilteredCategories[indexPath.row])
    
  }
  
  @objc private func textDidChange(textField: UITextField) {
    
    if textField.text! == "" || textField.text == nil || textField.text! == " " {
      
      //CHANGE ARRAY OF ALL PROJECTS
      arrayOfFilteredCategories = arrayOfAllCategories

      self.showMainTableView()
      
      mainTableView.reloadData()
      //      self.hideMainTableView()
      
    } else {
      
      self.filterCompaniesWithText(textField.text!)
      
    }
    
  }
  
  private func filterCompaniesWithText(filterText: String) {
    
    arrayOfFilteredCategories = arrayOfAllCategories.filter({ (pitchSkillCategoryData) -> Bool in
      return pitchSkillCategoryData.pitchSkillCategoryName.rangeOfString(filterText) != nil
    })
    
    mainTableView.reloadData()
    
    if arrayOfFilteredCategories.count == 0 {
      
      self.hideMainTableView()
      //self.showAddButton()
      
    } else {
      
      self.showMainTableView()
      //self.hideAddButton()
      
    }
    
  }
  
  private func showMainTableView() {
    
    UIView.animateWithDuration(0.25){
      
      self.mainTableView.alpha = 1.0
      
    }
    
  }
  
  private func hideMainTableView() {
    
    UIView.animateWithDuration(0.25){
      
      self.mainTableView.alpha = 0.0
      
    }
    
  }
  
  private func showAddButton() {
    
    UIView.animateWithDuration(0.25){
      
      self.addButton.alpha = 1.0
      
    }
    
  }
  
  private func hideAddButton() {
    
    UIView.animateWithDuration(0.25){
      
      self.addButton.alpha = 0.0
      
    }
    
  }
  
  @objc private func addButtonPressed() {
    
    self.getAllCategoriesSelected()
    
    self.delegate?.createAddPitchAndShowPreEvaluatePitch(arrayOfSelectedCategories)
    
  }
  
  private func getAllCategoriesSelected() {
    
    arrayOfSelectedCategories.removeAll()
    
    for category in arrayOfAllCategories {
      
      if category.isThisCategory == true {
        
        arrayOfSelectedCategories.append(category)
        
      }
      
    }
    
  }
  
  private func cellPressed(categorySelected: PitchSkillCategory) {  //IN FUTURE CHANGE TO CATEGORY MODEL DATA
    
    //self.delegate?.createAddPitchAndShowPreEvaluatePitch()
    
  }
  
//  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
//    if arrayOfCategories.count >= 1 {
//      
//      arrayOfCategories.removeLast()
//      mainTableView.reloadData()
//      
//    } else {
//      
//      UIView.animateWithDuration(0.25,
//                                 animations: {
//                                  
//                                  self.mainTableView.alpha = 0.0
////                                  self.askPermissionLabel.alpha = 1.0
//                                  self.addButton.alpha = 1.0
//                                  
//        }, completion: { (finished) in
//          if finished == true {
//            
//            //DO SOMETHING
//            
//          }
//      })
//      
//    }
//    
//    return true
//  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    
    self.dismissKeyboard(textField)
    
    return true
  }
  
  func textFieldShouldClear(textField: UITextField) -> Bool {
    
    arrayOfFilteredCategories = arrayOfAllCategories
    mainTableView.reloadData()
    
    return true
    
  }
  
  @objc private func dismissKeyboard(sender:AnyObject) {
    
    self.endEditing(true)
    
  }
  
  func getAllSkillsFromServer() {
    
    UtilityManager.sharedInstance.showLoader()
    
    RequestToServerManager.sharedInstance.requestToGetAllSkillsCategories {
      jsonOfSkills in
      
      let json = jsonOfSkills as? [String:AnyObject]
      
      if json != nil {
        
        let categories = json!["skill_categories"] as? Array<[String:AnyObject]>
        
        if categories != nil {
          
          var positionInOriginalArray = 0
          
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
              
              let newSkill = Skill.init(id: skillId, nameSkill: skillName!, levelSkill: skillLevel)
              newArrayOfSkills.append(newSkill)
              
            }
            
            var newPitchSkillCategory = PitchSkillCategory.init(newPitchSkillCategoryId: categoryId,
              newSkillCategoryName: categoryName,
              newIsThisCategory: false,
              newSkills: newArrayOfSkills)
            
            newPitchSkillCategory.positionInOriginalArray = positionInOriginalArray
            self.arrayOfAllCategories.append(newPitchSkillCategory)
            
            positionInOriginalArray = positionInOriginalArray + 1
            
          }
          
          self.arrayOfFilteredCategories = self.arrayOfAllCategories
          self.mainTableView.reloadData()
          
        }
        
      }
      
      UtilityManager.sharedInstance.hideLoader()
      
    }
    
  }
  
  private func checkIfThereAreSelectedCatefories() {
    
    for category in arrayOfAllCategories {
      
      if category.isThisCategory == true {
      
        self.setButtonToEnabled()
        return
        
      }
      
    }
    
    self.setButtonToDisabled()

  }
  
  private func setButtonToEnabled() {
    
    UIView.animateWithDuration(0.25,
      animations: {
      
        self.addButton.backgroundColor = UIColor.blackColor()
      
      }) { (finished) in
        if finished == true {
          
          self.addButton.enabled = true
          
        }
    }
    
  }
  
  private func setButtonToDisabled() {
    
    addButton.enabled = false
    
    UIView.animateWithDuration(0.25) {
      
      self.addButton.backgroundColor = UIColor.grayColor()
      
    }
    
  }
  
  //MARK: - PitchCategoryTableViewCellWhenSelectionChangeDelegate
  
  func valueOfPitchSkillCategoryChanged(cellWhoMadeChanges: PitchCategoryTableViewCell, newValueOfSelection: Bool) {
    
    arrayOfAllCategories[cellWhoMadeChanges.pitchCategoryData.positionInOriginalArray!].isThisCategory = newValueOfSelection
    
    self.checkIfThereAreSelectedCatefories()
  
  }
  
}
