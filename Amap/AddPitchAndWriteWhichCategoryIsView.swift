//
//  AddPitchAndWriteWhichCategoryIsView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/12/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol AddPitchAndWriteWhichCategoryIsViewDelegate {
  
  func createAndAddPitch()
  
}

class AddPitchAndWriteWhichCategoryIsView: UIView, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
  
  private var writeWhichCategoryIsName: UILabel! = nil
  private var searchView: CustomTextFieldWithTitleView! = nil
  private var mainTableView: UITableView! = nil
  private var arrayOfCategories = [PitchCategory]()
//  private var askPermissionLabel: UILabel! = nil
  private var addButton: UIButton! = nil
  
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
    self.addGestureRecognizer(tapToDismissKeyboard)
    
  }
  
  
  
  private func createSomeData() {
    
    let firstCategory = PitchCategory(pitchCategoryName: "Categoría 1", isThisCategory: false)
    let secondCategory = PitchCategory(pitchCategoryName: "Categoría 2", isThisCategory: false)
    
    arrayOfCategories.append(firstCategory)
    arrayOfCategories.append(secondCategory)
    
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
    return arrayOfCategories.count
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 56.0 * UtilityManager.sharedInstance.conversionHeight
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! PitchCategoryTableViewCell
    
    cell.changePitchCategoryData(arrayOfCategories[indexPath.row])
    cell.selectionStyle = UITableViewCellSelectionStyle.None
    
    return cell
  }
  
  @objc private func addButtonPressed() {
    
    self.delegate?.createAndAddPitch()
    
  }
  
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    if arrayOfCategories.count >= 1 {
      
      arrayOfCategories.removeLast()
      mainTableView.reloadData()
      
    } else {
      
      UIView.animateWithDuration(0.25,
                                 animations: {
                                  
                                  self.mainTableView.alpha = 0.0
//                                  self.askPermissionLabel.alpha = 1.0
                                  self.addButton.alpha = 1.0
                                  
        }, completion: { (finished) in
          if finished == true {
            
            //DO SOMETHING
            
          }
      })
      
    }
    
    return true
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    
    self.dismissKeyboard(textField)
    
    return true
  }
  
  @objc private func dismissKeyboard(sender:AnyObject) {
    
    self.endEditing(true)
    
  }
  
}
