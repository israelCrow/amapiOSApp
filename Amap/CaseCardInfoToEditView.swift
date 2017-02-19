//
//  CaseCardInfoToEditView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 20/01/17.
//  Copyright © 2017 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol CaseCardInfoToEditViewDelegate {
  
  func flipCardAndShowPreviewCaseFromCaseCardInfoToEdit(caseData: Case)
  func deleteCaseFromPreviewPlayerFromCaseCardInfoToEdit(dataCase: Case)
  
}

class CaseCardInfoToEditView: UIView {
  
  private var caseData: Case! = nil

  private var caseNameLabel: UILabel! = nil
  private var descriptionLabel: UILabel! = nil
  private var editButton: UIButton! = nil
  private var deleteButton: UIButton! = nil
  private var showButtonsOfEdition: Bool = true
  
  var delegate: CaseCardInfoToEditViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, dataFromCase: Case) {
    
    caseData = dataFromCase
    super.init(frame: frame)
    self.initInterface()
    
  }
  
  init(frame: CGRect, dataFromCase: Case, showButtonsOfEdition: Bool) {

    self.showButtonsOfEdition = showButtonsOfEdition
    caseData = dataFromCase
    super.init(frame: frame)
    self.initInterface()
    
  }
  
  private func initInterface() {
    self.backgroundColor = UIColor.clearColor()
    
    self.createCaseNameLabel()
    self.createDescriptionLabel()
    self.createEditButton()
    self.createDeleteButton()
    
  }
  
  private func createCaseNameLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 208.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: 20.0 * UtilityManager.sharedInstance.conversionHeight)
    
    caseNameLabel = UILabel.init(frame: frameForLabel)
    caseNameLabel.numberOfLines = 1
    caseNameLabel.backgroundColor = UIColor.clearColor()
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    style.lineBreakMode = .ByTruncatingTail
    
    let stringWithFormat = NSMutableAttributedString(
      string: caseData.name,
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    caseNameLabel.attributedText = stringWithFormat
    let newFrame = CGRect.init(x: 2.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 0.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: caseNameLabel.frame.size.width,
                               height: caseNameLabel.frame.size.height)
    
    caseNameLabel.frame = newFrame
    self.addSubview(caseNameLabel)
    
  }
  
  private func createDescriptionLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: 77.7 * UtilityManager.sharedInstance.conversionHeight)
    
    descriptionLabel = UILabel.init(frame: frameForLabel)
    descriptionLabel.numberOfLines = 4
    descriptionLabel.backgroundColor = UIColor.clearColor()
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    style.lineBreakMode = .ByTruncatingTail
    
    let stringWithFormat = NSMutableAttributedString(
      string: caseData.description,
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    
    descriptionLabel.attributedText = stringWithFormat
    descriptionLabel.sizeToFit()
    
    let newFrame = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 29.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: descriptionLabel.frame.size.width,
                               height: descriptionLabel.frame.size.height)
    
    descriptionLabel.frame = newFrame
    self.addSubview(descriptionLabel)
    
  }
  
  private func createEditButton() {
    
    var frameForButton = CGRect.init(x: 0.0,
                                     y: 0.0,
                                 width: 105.0 * UtilityManager.sharedInstance.conversionWidth,
                                height: 30.0 * UtilityManager.sharedInstance.conversionHeight)
    
    editButton = UIButton.init(frame: frameForButton)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Editar",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    editButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    editButton.addTarget(self,
                              action: #selector(editSelectedCase),
                              forControlEvents: .TouchUpInside)
    
    frameForButton = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                 y: descriptionLabel.frame.origin.y + descriptionLabel.frame.size.height + (8.0 * UtilityManager.sharedInstance.conversionHeight),
                             width: editButton.frame.size.width,
                            height: editButton.frame.size.height)
    
    editButton.frame = frameForButton
    editButton.backgroundColor = UIColor.whiteColor()
    editButton.layer.borderWidth = 2.0
    editButton.layer.borderColor = UIColor.blackColor().CGColor
    
    self.addSubview(editButton)
    
  }
  
  private func createDeleteButton() {
    
    var frameForButton = CGRect.init(x: 0.0,
                                     y: 0.0,
                                     width: 105.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 30.0 * UtilityManager.sharedInstance.conversionHeight)
    
    deleteButton = UIButton.init(frame: frameForButton)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Borrar",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    deleteButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    deleteButton.addTarget(self,
                         action: #selector(deleteSelectedCase),
                         forControlEvents: .TouchUpInside)
    
    frameForButton = CGRect.init(x: 115.0 * UtilityManager.sharedInstance.conversionWidth,
                                 y: descriptionLabel.frame.origin.y + descriptionLabel.frame.size.height + (8.0 * UtilityManager.sharedInstance.conversionHeight),
                             width: deleteButton.frame.size.width,
                            height: deleteButton.frame.size.height)
    
    deleteButton.frame = frameForButton
    deleteButton.backgroundColor = UIColor.whiteColor()
    deleteButton.layer.borderWidth = 2.0
    deleteButton.layer.borderColor = UIColor.blackColor().CGColor
    
    self.addSubview(deleteButton)
    
  }
  
  @objc private func deleteSelectedCase() {
    
    self.delegate?.deleteCaseFromPreviewPlayerFromCaseCardInfoToEdit(self.caseData)
    
  }
  
  @objc private func editSelectedCase() {

    self.delegate?.flipCardAndShowPreviewCaseFromCaseCardInfoToEdit(self.caseData)
  
  }
  
  func getFinalHeight() -> CGFloat {
    
    if deleteButton != nil {
      
      return deleteButton.frame.origin.y + deleteButton.frame.size.height + (5.0 * UtilityManager.sharedInstance.conversionHeight)
      
    } else {
      
      return 0.0
      
    }
    
  }
  
  
}
