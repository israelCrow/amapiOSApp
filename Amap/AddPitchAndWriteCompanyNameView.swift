//
//  AddPitchAndWriteCompanyNameView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/9/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class AddPitchAndWriteCompanyNameView: UIView, UITableViewDelegate, UITableViewDataSource {
  
  private var writeCompanyName: UILabel! = nil
  private var searchView: CustomTextFieldWithTitleView! = nil
  private var mainTableView: UITableView! = nil
  private var arrayOfBrandNames = ["Compañía 1","Compañía 2", "Compañía 3"]
  private var askPermissionLabel: UILabel! = nil
  private var addButton: UIButton! = nil
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.initInterface()
  }
  
  private func initInterface() {
    
    self.adaptMyself()
    self.createwriteCompanyNameLabel()
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
  }
  
  private func createwriteCompanyNameLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 255.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    writeCompanyName = UILabel.init(frame: frameForLabel)
    writeCompanyName.numberOfLines = 0
    writeCompanyName.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.AddPitchAndWriteCompanyNameView.writeCompanyNameLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    writeCompanyName.attributedText = stringWithFormat
    writeCompanyName.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (writeCompanyName.frame.size.width / 2.0),
                               y: 30.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: writeCompanyName.frame.size.width,
                               height: writeCompanyName.frame.size.height)
    
    writeCompanyName.frame = newFrame
    
    self.addSubview(writeCompanyName)
    
  }
  
  private func createSearchView() {
    
    let frameForSearchView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: 155.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                         height: 60.0 * UtilityManager.sharedInstance.conversionHeight)
    
    searchView = CustomTextFieldWithTitleView.init(frame: frameForSearchView,
                                                   title: nil,
                                                   image: "smallSearchIcon")
    
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
      string: VisualizePitchesConstants.AddPitchAndWriteCompanyNameView.askPermissionLabelText,
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
    addButton.backgroundColor = UIColor.greenColor()
    addButton.addTarget(self,
                        action: #selector(addBrandName),
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
    return arrayOfBrandNames.count
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 56.0 * UtilityManager.sharedInstance.conversionHeight
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
    
    self.changeAttributedTextOfNormalCell(cell, subSkillText: arrayOfBrandNames[indexPath.row])
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
  
  @objc private func addBrandName() {
    
    
    
  }
  
}
