//
//  AddPitchAndWriteProjectNameView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/12/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol AddPitchAndWriteProjectNameViewDelegate {
  
  func pushCreateAddNewPitchAndWhichCategoryIsViewController()
  
}

class AddPitchAndWriteProjectNameView: UIView, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
  
  private var writeProjectName: UILabel! = nil
  private var searchView: CustomTextFieldWithTitleView! = nil
  private var mainTableView: UITableView! = nil
  private var arrayOfFilteredProjects = ["Proyecto 1","Proyecto 2", "Proyecto 3"]
  private var askPermissionLabel: UILabel! = nil
  private var addButton: UIButton! = nil
  
  //IMPROVISE THE MAIN ARRAY
  private var arrayOfAllProjects = ["Proyecto 1","Proyecto 2", "Proyecto 3"]
  //DELETE IN FUTURE
  
  
  private var companyData: CompanyModelData! = nil
  private var brandData: BrandModelData! = nil
  
  var delegate: AddPitchAndWriteProjectNameViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newCompanyData: CompanyModelData, newBrandData: BrandModelData) {
    
    companyData = newCompanyData
    brandData = newBrandData
    super.init(frame: frame)
    
    self.initInterface()
  }
  
  private func initInterface() {
    
    self.adaptMyself()
    self.createWriteProjectNameLabel()
    self.createSearchView()
    self.createMainTableView()
    self.createAskPermissionLabel()
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
  
  private func createWriteProjectNameLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 255.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    writeProjectName = UILabel.init(frame: frameForLabel)
    writeProjectName.numberOfLines = 0
    writeProjectName.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.AddPitchAndWriteProjectNameView.writeProjectNameLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    writeProjectName.attributedText = stringWithFormat
    writeProjectName.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (writeProjectName.frame.size.width / 2.0),
                               y: 30.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: writeProjectName.frame.size.width,
                               height: writeProjectName.frame.size.height)
    
    writeProjectName.frame = newFrame
    
    self.addSubview(writeProjectName)
    
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
                                       forControlEvents: UIControlEvents.EditingChanged)
    searchView.mainTextField.delegate = self
    
    self.addSubview(searchView)
    
  }
  
  private func createMainTableView() {
    
    let frameForTableView = CGRect.init(x: 20.0 * UtilityManager.sharedInstance.conversionWidth,
                                        y: 217.0 * UtilityManager.sharedInstance.conversionHeight,
                                        width: 240.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 222.0 * UtilityManager.sharedInstance.conversionHeight)
    
    mainTableView = UITableView.init(frame: frameForTableView)
    mainTableView.delegate = self
    mainTableView.dataSource = self
    mainTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    
    self.addSubview(mainTableView)
    
  }
  
  private func createAskPermissionLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 201.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    askPermissionLabel = UILabel.init(frame: frameForLabel)
    askPermissionLabel.numberOfLines = 0
    askPermissionLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.AddPitchAndWriteProjectNameView.askPermissionLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    askPermissionLabel.attributedText = stringWithFormat
    askPermissionLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (askPermissionLabel.frame.size.width / 2.0),
                               y: 261.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: askPermissionLabel.frame.size.width,
                               height: askPermissionLabel.frame.size.height)
    
    askPermissionLabel.frame = newFrame
    askPermissionLabel.alpha = 0.0
    
    self.addSubview(askPermissionLabel)
    
  }
  
  private func createAddButton() {
    
    addButton = UIButton.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.AddPitchAndWriteCompanyNameView.addButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    addButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    addButton.backgroundColor = UIColor.blackColor()
    addButton.addTarget(self,
                        action: #selector(addButtonPressed),
                        forControlEvents: .TouchUpInside)
    addButton.sizeToFit()
    
    let frameForButton = CGRect.init(x: 0.0,
                                     y: self.frame.size.height - (70.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: self.frame.size.width,
                                     height: 70.0 * UtilityManager.sharedInstance.conversionHeight)
    
    addButton.frame = frameForButton
    addButton.alpha = 0.0
    
    self.addSubview(addButton)
    
  }
  
  //MARK: - ViewTableDelegate
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arrayOfFilteredProjects.count
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 56.0 * UtilityManager.sharedInstance.conversionHeight
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    self.cellPressed(arrayOfFilteredProjects[indexPath.row])
    
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
    
    self.changeAttributedTextOfNormalCell(cell, subSkillText: arrayOfFilteredProjects[indexPath.row])
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
    
    if textField.text! == "" || textField.text == nil {
      
      //CHANGE ARRAY OF ALL PROJECTS
      arrayOfFilteredProjects = arrayOfAllProjects
      mainTableView.reloadData()
      //      self.hideMainTableView()
      
    } else {
      
      self.filterCompaniesWithText(textField.text!)
      
    }
    
  }
  
  private func filterCompaniesWithText(filterText: String) {
    
    arrayOfFilteredProjects = arrayOfAllProjects.filter{ $0.rangeOfString(filterText) != nil }
    
    mainTableView.reloadData()
    
    if arrayOfFilteredProjects.count == 0 {
      
      self.hideMainTableView()
      self.showAskPermissionLabel()
      self.showAddButton()
      
    } else {
      
      self.showMainTableView()
      self.hideAskPermissionLabel()
      self.hideAddButton()
      
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
  
  private func showAskPermissionLabel() {
    
    UIView.animateWithDuration(0.25){
      
      self.askPermissionLabel.alpha = 1.0
      
    }
    
  }
  
  private func hideAskPermissionLabel() {
    
    UIView.animateWithDuration(0.25){
      
      self.askPermissionLabel.alpha = 0.0
      
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
    
    self.delegate?.pushCreateAddNewPitchAndWhichCategoryIsViewController()
    
  }
  
  private func cellPressed(selectedProjectData: String) {  //IN FUTURE CHANGE TO PROJECT MODEL DATA
    
    self.delegate?.pushCreateAddNewPitchAndWhichCategoryIsViewController()
    
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
