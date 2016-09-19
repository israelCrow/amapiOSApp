//
//  AddPitchAndWriteBrandNameView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/9/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol AddPitchAndWriteBrandNameViewDelegate {
  
  func pushAddPitchAndWriteProjectNameViewController(companyData: CompanyModelData, brandDataSelected: BrandModelData?, nameOfNewBrand: String?)
  
}


class AddPitchAndWriteBrandNameView: UIView, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
  
  private var writeBrandName: UILabel! = nil
  private var searchView: CustomTextFieldWithTitleView! = nil
  private var mainTableView: UITableView! = nil
  private var arrayOfFilteredBrands = [BrandModelData]()
  private var askPermissionLabel: UILabel! = nil
  private var addButton: UIButton! = nil
  
  private var companyData: CompanyModelData! = nil
  
  var delegate: AddPitchAndWriteBrandNameViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newCompanyData: CompanyModelData) {
    
    companyData = newCompanyData
    arrayOfFilteredBrands = companyData.brands
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.initInterface()
  }
  
  private func initInterface() {
    
    self.adaptMyself()
    self.createWriteBrandNameLabel()
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
  
  private func createWriteBrandNameLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                width: 255.0 * UtilityManager.sharedInstance.conversionWidth,
                               height: CGFloat.max)
    
    writeBrandName = UILabel.init(frame: frameForLabel)
    writeBrandName.numberOfLines = 0
    writeBrandName.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.AddPitchAndWriteBrandNameView.writeBrandNameLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    writeBrandName.attributedText = stringWithFormat
    writeBrandName.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (writeBrandName.frame.size.width / 2.0),
                               y: 30.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: writeBrandName.frame.size.width,
                               height: writeBrandName.frame.size.height)
    
    writeBrandName.frame = newFrame
    
    self.addSubview(writeBrandName)
    
  }
  
  private func createSearchView() {
    
    let frameForSearchView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: 155.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: 60.0 * UtilityManager.sharedInstance.conversionHeight)
    
    searchView = CustomTextFieldWithTitleView.init(frame: frameForSearchView,
                                                   title: nil,
                                                   image: "smallSearchIcon")
    searchView.mainTextField.delegate = self
    searchView.mainTextField.addTarget(self,
                                       action: #selector(textDidChange),
                                       forControlEvents: UIControlEvents.EditingChanged)
    
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
      string: VisualizePitchesConstants.AddPitchAndWriteBrandNameView.askPermissionLabelText,
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
      string: VisualizePitchesConstants.AddPitchAndWriteBrandNameView.addButtonText,
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
    return arrayOfFilteredBrands.count
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 56.0 * UtilityManager.sharedInstance.conversionHeight
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    self.cellPressed(arrayOfFilteredBrands[indexPath.row])
    
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
    
    self.changeAttributedTextOfNormalCell(cell, subSkillText: arrayOfFilteredBrands[indexPath.row].name)
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
  
  @objc private func addButtonPressed() {
    
    self.delegate?.pushAddPitchAndWriteProjectNameViewController(companyData, brandDataSelected: nil, nameOfNewBrand: searchView.mainTextField.text!)
    
  }
  
  private func cellPressed(selectedBrandData: BrandModelData) {
    
    
    self.delegate?.pushAddPitchAndWriteProjectNameViewController(companyData, brandDataSelected: selectedBrandData, nameOfNewBrand: nil)

    
  }
  
  private func filterCompaniesWithText(filterText: String) {
    
    arrayOfFilteredBrands = companyData.brands.filter({ (brandData) -> Bool in
      return brandData.name.rangeOfString(filterText) != nil
    })
    
    mainTableView.reloadData()
    
    if arrayOfFilteredBrands.count == 0 {
      
      self.hideMainTableView()
      self.showAskPermissionLabel()
      self.showAddButton()
      
    } else {
      
      self.showMainTableView()
      self.hideAskPermissionLabel()
      self.hideAddButton()
      
    }
    
  }
  
  @objc private func textDidChange(textField: UITextField) {
    
    if textField.text! == "" || textField.text == nil {
      
      arrayOfFilteredBrands = companyData.brands
      mainTableView.reloadData()
//      self.hideMainTableView()
      
    } else {
      
      self.filterCompaniesWithText(textField.text!)
      
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
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    
    self.dismissKeyboard(textField)
    
    return true
  }
  
  @objc private func dismissKeyboard(sender:AnyObject) {
    
    self.endEditing(true)
    
  }
  
}
