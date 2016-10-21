//
//  LookForPitchCardView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/18/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

//
//  LookForPitchCard.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/17/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol LookForPitchCardViewDelegate {
  
  func lookForThisPitchID(pitchIDToLookFor: String)
  
}

class LookForPitchCardView: UIView, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
  
  private var searchView: CustomTextFieldWithTitleView! = nil
  private var mainTableView: UITableView! = nil
  private var arrayOfFilteredProjects = Array<PitchEvaluationByUserModelData>()
  
  private var arrayOfAllProjects = Array<PitchEvaluationByUserModelData>()
  
  var delegate: LookForPitchCardViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newArrayOfPitchesToFilter: [PitchEvaluationByUserModelData]) {
    
    arrayOfAllProjects = newArrayOfPitchesToFilter
    super.init(frame: frame)
    
    self.initInterface()
  }
  
  private func initInterface() {
    
    self.adaptMyself()
    self.createSearchView()
    self.createMainTableView()
    
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
  
  private func createSearchView() {
    
    let frameForSearchView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: 25.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                         height: 60.0 * UtilityManager.sharedInstance.conversionHeight)
    
    searchView = CustomTextFieldWithTitleView.init(frame: frameForSearchView,
                                                   title: nil,
                                                   image: "smallSearchIcon")
    searchView.mainTextField.addTarget(self,
                                       action: #selector(textDidChange),
                                       forControlEvents: UIControlEvents.EditingChanged)
    searchView.mainTextField.delegate = self
    
    self.addSubview(searchView)
    
  }
  
  private func createMainTableView() {
    
    let frameForTableView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                        y: 81.0 * UtilityManager.sharedInstance.conversionHeight,
                                        width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 335.0 * UtilityManager.sharedInstance.conversionHeight)
    
    mainTableView = UITableView.init(frame: frameForTableView)
    mainTableView.delegate = self
    mainTableView.dataSource = self
    mainTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    mainTableView.alpha = 1.0
    mainTableView.reloadData()
    
    self.addSubview(mainTableView)
    
  }
  
  func setArrayOfAllProjectsPitches(newArrayOfAllProjectsPitches: [PitchEvaluationByUserModelData]) {
    
//    if newArrayOfAllProjectsPitches.count == 0 {
//      
//      self.hideMainTableView()
//      //      self.showAskPermissionLabel()
//      //      self.showAddButton()
//      
//    } else {
    
      self.showMainTableView()
      
      arrayOfAllProjects = newArrayOfAllProjectsPitches
      arrayOfFilteredProjects = arrayOfAllProjects
      mainTableView.reloadData()
      
//    }
    
  }
  
  //MARK: - ViewTableDelegate
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arrayOfFilteredProjects.count
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 56.0 * UtilityManager.sharedInstance.conversionHeight
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    self.cellPressed(arrayOfFilteredProjects[indexPath.row].pitchId)
    
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
    
    self.changeAttributedTextOfNormalCell(cell, subSkillText: arrayOfFilteredProjects[indexPath.row].pitchName)
    cell.selectionStyle = UITableViewCellSelectionStyle.None
    
    return cell
  }
  
  private func changeAttributedTextOfNormalCell(cellToChangeText: UITableViewCell, subSkillText: String) {
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
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
  
  @objc private func textDidChange(textField: UITextField) {
    
    if textField.text! == "" || textField.text == nil || textField.text! == " " {
      
      //CHANGE ARRAY OF ALL PROJECTS
      arrayOfFilteredProjects = arrayOfAllProjects
      
      self.showMainTableView()
      //      self.hideAskPermissionLabel()
      //      self.hideAddButton()
      
      mainTableView.reloadData()
      //      self.hideMainTableView()
      
    } else {
      
      self.filterCompaniesWithText(textField.text!)
      
    }
    
  }
  
  private func filterCompaniesWithText(filterText: String) {
    
    arrayOfFilteredProjects = arrayOfAllProjects.filter({ (projectData) -> Bool in
      return projectData.pitchName.rangeOfString(filterText) != nil
    })
    
    
    mainTableView.reloadData()
    
    if arrayOfFilteredProjects.count == 0 {
      
      self.hideMainTableView()
      //      self.showAskPermissionLabel()
      //      self.showAddButton()
      
    } else {
      
      self.showMainTableView()
      //      self.hideAskPermissionLabel()
      //      self.hideAddButton()
      
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
  //
  //  private func showAskPermissionLabel() {
  //
  //    UIView.animateWithDuration(0.25){
  //
  //      self.askPermissionLabel.alpha = 1.0
  //
  //    }
  //
  //  }
  //
  //  private func hideAskPermissionLabel() {
  //
  //    UIView.animateWithDuration(0.25){
  //
  //      self.askPermissionLabel.alpha = 0.0
  //
  //    }
  //
  //  }
  //
  //  private func showAddButton() {
  //
  //    UIView.animateWithDuration(0.25){
  //
  //      self.addButton.alpha = 1.0
  //
  //    }
  //
  //  }
  //
  //  private func hideAddButton() {
  //
  //    UIView.animateWithDuration(0.25){
  //
  //      self.addButton.alpha = 0.0
  //
  //    }
  //
  //  }
  
  
  //  @objc private func addButtonPressed() {
  //
  //    let newProjectPitchData = ProjectPitchModelData(newName: searchView.mainTextField.text!,
  //                                                    newBrandId: brandData.id,
  //                                                    newBriefDate: "",
  //                                                    newBrieEMailContact: "",
  //                                                    newArrayOfPitchCategories: [PitchSkillCategory]())
  //
  //
  //    self.delegate?.pushCreateAddNewPitchAndWhichCategoryIsViewController(newProjectPitchData,
  //                                                                         selectedProjectPitchData: nil)
  //
  //  }
  
  private func cellPressed(pitchIDToLookFor: String) {
    
    self.delegate?.lookForThisPitchID(pitchIDToLookFor)
    
  }
  
  //  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
  //    if arrayOfProjectNames.count >= 1 {
  //
  //      arrayOfProjectNames.removeLast()
  //      mainTableView.reloadData()
  //
  //    } else {
  //
  //      UIView.animateWithDuration(0.25,
  //                                 animations: {
  //
  //                                  self.mainTableView.alpha = 0.0
  //                                  self.askPermissionLabel.alpha = 1.0
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
  
  @objc private func dismissKeyboard(sender:AnyObject) {
    
    self.endEditing(true)
    
  }
  
}