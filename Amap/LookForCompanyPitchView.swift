//
//  LookForCompanyPitchView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 12/16/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol LookForCompanyPitchViewDelegate {
  
  func lookForThisPitchFromCompany(params: [String: AnyObject], sender: LookForCompanyPitchView)
  func lookForThisPitchID(pitchIDToLookFor: String)
  func actionWhenSelectTextField(sender: LookForCompanyPitchView)
  func actionWhenClearTextField(sender: LookForCompanyPitchView)
  
//  func doCancelLookForCard()
  
}

class LookForCompanyPitchView: UIView, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
  
  private var cancelButton: UIButton! = nil
  var searchView: CustomTextFieldWithTitleView! = nil
  private var noResultsLabel: UILabel! = nil
  private var mainTableView: UITableView! = nil
  private var arrayOfFilteredProjects = Array<PitchEvaluationByUserModelDataForCompany>()
  
  private var arrayOfAllProjects = Array<PitchEvaluationByUserModelDataForCompany>()
  
  private var isShowingBackground: Bool = false
  
  var delegate: LookForCompanyPitchViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newArrayOfPitchesToFilter: [PitchEvaluationByUserModelDataForCompany]) {
    
    arrayOfAllProjects = newArrayOfPitchesToFilter
    super.init(frame: frame)
    
    self.initInterface()
  }
  
  private func initInterface() {
    
    self.adaptMyself()
//    self.createCancelButton()
    self.createSearchView()
    self.createNoResultsView()
    self.createMainTableView()
    
  }
  
  private func adaptMyself() {
    
    self.layer.cornerRadius = 5.0
    
    self.backgroundColor = UIColor.clearColor()
    self.layer.shadowColor = UIColor.blackColor().CGColor
    self.layer.shadowOpacity = 0.25
    self.layer.shadowOffset = CGSizeZero
    self.layer.shadowRadius = 5
//    self.addGestures()
  }
  
  private func addGestures() {
    
//    let tapToDismissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
//                                                                              action: #selector(dismissKeyboard))
//    tapToDismissKeyboard.numberOfTapsRequired = 1
//    tapToDismissKeyboard.cancelsTouchesInView = false
//    self.addGestureRecognizer(tapToDismissKeyboard)
    
  }
  
  private func createCancelButton() {
    
    let frameForButton = CGRect.init(x:270.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 10.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 15.0 * UtilityManager.sharedInstance.conversionWidth ,
                                     height: 15.0 * UtilityManager.sharedInstance.conversionHeight)
    
    cancelButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "iconCloseBlack") as UIImage?
    cancelButton.setImage(image, forState: .Normal)
    cancelButton.alpha = 1.0
    cancelButton.addTarget(self, action: #selector(cancelButtonPressed), forControlEvents:.TouchUpInside)
    
    self.addSubview(cancelButton)
    
  }
  
  private func createSearchView() {
    
    let frameForSearchView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: 0.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                         height: 60.0 * UtilityManager.sharedInstance.conversionHeight)
    
    searchView = CustomTextFieldWithTitleView.init(frame: frameForSearchView,
                                                   title: nil,
                                                   image: "smallSearchIcon")
    
    searchView.mainTextField.addTarget(self,
                                       action: #selector(textDidChange),
                                       forControlEvents: UIControlEvents.EditingChanged)
    searchView.mainTextField.delegate = self
    searchView.backgroundColor = UIColor.clearColor()
    
    self.addSubview(searchView)
    
  }
  
  private func createNoResultsView() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 255.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    noResultsLabel = UILabel.init(frame: frameForLabel)
    noResultsLabel.numberOfLines = 0
    noResultsLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: "No se encontraron resultados",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    noResultsLabel.attributedText = stringWithFormat
    noResultsLabel.sizeToFit()
    let newFrame = CGRect.init(x: 10.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 65.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: noResultsLabel.frame.size.width,
                               height: noResultsLabel.frame.size.height)
    
    noResultsLabel.backgroundColor = UIColor.clearColor()
    noResultsLabel.frame = newFrame
    noResultsLabel.alpha = 0.0
    
    self.addSubview(noResultsLabel)
    
  }
  
  private func createMainTableView() {
    
    let frameForTableView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                        y: 81.0 * UtilityManager.sharedInstance.conversionHeight,
                                        width: self.frame.size.width,
                                        height: 335.0 * UtilityManager.sharedInstance.conversionHeight)
    
    mainTableView = UITableView.init(frame: frameForTableView)
    mainTableView.delegate = self
    mainTableView.dataSource = self
    mainTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    mainTableView.alpha = 0.0
    
    self.addSubview(mainTableView)
    
  }
  
  func setArrayOfAllProjectsPitches(newArrayOfAllProjectsPitches: [PitchEvaluationByUserModelDataForCompany]) {
    
    if newArrayOfAllProjectsPitches.count == 0 {
      
      self.hideMainTableView()
      self.showBackground()
      self.showNoResultsLabel()
      
    } else {
      
      self.hideNoResultsLabel()
      self.showMainTableView()
      self.showBackground()
      arrayOfAllProjects = newArrayOfAllProjectsPitches
      arrayOfFilteredProjects = arrayOfAllProjects
      mainTableView.reloadData()
      
    }
    
  }
  
  private func showBackground() {
    
    UIView.animateWithDuration(0.25){
      
      self.backgroundColor = UIColor.whiteColor()
      
    }
    
  }
  
  private func hideBackground() {
    
    self.backgroundColor = UIColor.clearColor()
    
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
      
      self.hideMainTableView()
      self.hideNoResultsLabel()
      self.hideBackground()
      mainTableView.reloadData()
      
      if isShowingBackground == true {
      
        isShowingBackground = false
        self.delegate?.actionWhenClearTextField(self)
        
      }
      
    } else {
      
      
      if isShowingBackground == false {
        
        self.delegate?.actionWhenSelectTextField(self)
        self.showBackground()
        self.showMainTableView()
        isShowingBackground = true
        
      }
      
      self.hideNoResultsLabel()
      self.filterCompaniesWithText(textField.text!)
      self.showBackground()
      self.showMainTableView()
      
      
    }
    
  }
  
  private func filterCompaniesWithText(filterText: String) {
    
    arrayOfFilteredProjects = arrayOfAllProjects.filter({ (projectData) -> Bool in
      return projectData.pitchName.rangeOfString(filterText, options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil, locale: nil) != nil
    })
    
    
    mainTableView.reloadData()
    
    if arrayOfFilteredProjects.count == 0 {
      
      self.hideMainTableView()
      self.showNoResultsLabel()
      
    } else {
      
      self.showBackground()
      self.showMainTableView()
      self.hideNoResultsLabel()
      
    }
    
  }
  
  private func showMainTableView() {
    
    UIView.animateWithDuration(0.25){
      
      self.mainTableView.alpha = 1.0
      
    }
    
  }
  
  private func hideMainTableView() {
    
    self.mainTableView.alpha = 0.0
    
  }
  //
  private func showNoResultsLabel() {
    
    UIView.animateWithDuration(0.25){
      
      self.noResultsLabel.alpha = 1.0
      
    }
    
  }
  
  private func hideNoResultsLabel() {
    
    self.noResultsLabel.alpha = 0.0
    
  }
  
  private func cellPressed(pitchIDToLookFor: String) {
    
    if isShowingBackground == true {
      
      self.hideMainTableView()
      self.hideBackground()
      self.hideNoResultsLabel()
      isShowingBackground = false
      self.delegate?.actionWhenClearTextField(self)
      
    }
    
    self.delegate?.lookForThisPitchID(pitchIDToLookFor)
    
  }
  
  func textFieldShouldClear(textField: UITextField) -> Bool {
    
    if isShowingBackground == true {
      
      self.hideMainTableView()
      self.hideBackground()
      self.hideNoResultsLabel()
      isShowingBackground = false
      self.delegate?.actionWhenClearTextField(self)
      
    }
    
//    self.delegate?.actionWhenClearTextField(self)
    
    return true
    
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    
    self.dismissKeyboard(textField)
    
    let params = ["auth_token": UserSession.session.auth_token,
                  "id": UserSession.session.id,
                  "keyword": searchView.mainTextField.text!
    ]
    
    self.delegate?.lookForThisPitchFromCompany(params, sender: self)
    
    return true
  }
  
  @objc private func dismissKeyboard(sender:AnyObject) {
    
    self.endEditing(true)
    
  }
  
  @objc private func cancelButtonPressed() {
    
    //self.delegate?.doCancelLookForCard()
    
  }
  
}

