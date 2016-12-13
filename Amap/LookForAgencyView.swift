//
//  LookForAgencyView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 12/11/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import Foundation

protocol LookForAgencyViewDelegate {
  
  func requestToServerToLookFor(params: [String: AnyObject])
  func showInfoOfThisSelectedAgency(basicDataOfAgency: GenericAgencyData)
  
}

class LookForAgencyView: UIView, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
  
  private var cancelButton: UIButton! = nil
  private var searchView: CustomTextFieldWithTitleView! = nil
  private var noResultsLabel: UILabel! = nil
  private var mainTableView: UITableView! = nil
  private var arrayOfFilteredAgencies = Array<GenericAgencyData>()
  
  private var arrayOfAllAgencies = Array<GenericAgencyData>()
  
  var delegate: LookForAgencyViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newArrayOfAgenciesToFilter: [GenericAgencyData]) {
    
    arrayOfAllAgencies = newArrayOfAgenciesToFilter
    
    super.init(frame: frame)
    
    self.initInterface()
  }
  
  private func initInterface() {
    
    self.adaptMyself()
    //self.createCancelButton()
    self.createSearchView()
    self.createNoResultsView()
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
    searchView.mainTextField.returnKeyType = .Search
    searchView.mainTextField.delegate = self
    
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
    let newFrame = CGRect.init(x: 45.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 105.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: noResultsLabel.frame.size.width,
                               height: noResultsLabel.frame.size.height)
    
    noResultsLabel.frame = newFrame
    noResultsLabel.alpha = 0.0
    
    self.addSubview(noResultsLabel)
    
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
  
  func setArrayOfAllAgencies(newArrayOfAllAgencies: [GenericAgencyData]) {
    
    //    if newArrayOfAllProjectsPitches.count == 0 {
    //
    //      self.hideMainTableView()
    //      //      self.showAskPermissionLabel()
    //      //      self.showAddButton()
    //
    //    } else {
    
    self.showMainTableView()
    
    arrayOfAllAgencies = newArrayOfAllAgencies
    arrayOfFilteredAgencies = arrayOfAllAgencies
    mainTableView.reloadData()
    
    //    }
    
  }
  
  //MARK: - ViewTableDelegate
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arrayOfFilteredAgencies.count
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 56.0 * UtilityManager.sharedInstance.conversionHeight
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    self.cellPressed(arrayOfFilteredAgencies[indexPath.row])
    
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
    
    self.changeAttributedTextOfNormalCell(cell, subSkillText: arrayOfFilteredAgencies[indexPath.row].name)
    
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
      arrayOfFilteredAgencies = arrayOfAllAgencies
      
      self.showMainTableView()
      self.hideNoResultsLabel()
      //      self.hideAddButton()
      
      mainTableView.reloadData()
      //      self.hideMainTableView()
      
    } else {
      
      self.filterCompaniesWithText(textField.text!)
      
    }
    
  }
  
  private func filterCompaniesWithText(filterText: String) {
    
    arrayOfFilteredAgencies = arrayOfAllAgencies.filter({ (agencyData) -> Bool in
      return agencyData.name.rangeOfString(filterText, options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil, locale: nil) != nil
    })
    
    
    mainTableView.reloadData()
    
    if arrayOfFilteredAgencies.count == 0 {
      
      self.hideMainTableView()
      self.showNoResultsLabel()
      //      self.showAddButton()
      
    } else {
      
      self.showMainTableView()
      self.hideNoResultsLabel()
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
  private func showNoResultsLabel() {
    
    UIView.animateWithDuration(0.25){
      
      self.noResultsLabel.alpha = 1.0
      
    }
    
  }
  
  private func hideNoResultsLabel() {
    
    UIView.animateWithDuration(0.25){
      
      self.noResultsLabel.alpha = 0.0
      
    }
    
  }
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
  
  private func cellPressed(basicDataOfAgency: GenericAgencyData) {
    
    self.delegate?.showInfoOfThisSelectedAgency(basicDataOfAgency)
    
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
    
    let params = ["auth_token": UserSession.session.auth_token,
                  "company_id": MyCompanyModelData.Data.id,
                  "keyword": textField.text!
                  ]
    
    self.delegate?.requestToServerToLookFor(params)
    
    self.dismissKeyboard(textField)
    
    return true
  }
  
  @objc private func dismissKeyboard(sender:AnyObject) {
    
    self.endEditing(true)
    
  }
  
  @objc private func cancelButtonPressed() {
    
    
    
  }
  
  func resetValues() {
    
    arrayOfAllAgencies.removeAll()
    arrayOfFilteredAgencies.removeAll()
    
    mainTableView.reloadData()
    
  }
  
  
}