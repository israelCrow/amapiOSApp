//
//  ExclusiveView.swift
//  Amap
//
//  Created by Mac on 8/12/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol ExclusiveViewDelegate {
  
  func keyBoardWillAppearFromExclusiveView(distanceToMoveFlipCard: CGFloat)
  
}

class ExclusiveView: UIView, UITextFieldDelegate {
  
  private var mainScrollView: UIScrollView! = nil
  private var exclusiveLabel: UILabel! = nil
  private var arrayOfExclusivesBrandNames: [String]! = nil
  private var arrayOfExclusivesBrandTextFields: [UITextField]! = nil
  private var descriptionLabel: UILabel! = nil
  private var creatorOfBrandTextField: UITextField! = nil
  
  var delegate: ExclusiveViewDelegate?

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.initValues()
    self.addGestureToDismissKeyboard()
    self.initInterface()
  }
  
  private func initValues() {
    
    arrayOfExclusivesBrandNames = []
    arrayOfExclusivesBrandTextFields = []
    
  }
  
  private func addGestureToDismissKeyboard() {
    
    let tapToDismissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                              action: #selector(dismissKeyboard))
    tapToDismissKeyboard.numberOfTapsRequired = 1
    self.addGestureRecognizer(tapToDismissKeyboard)
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    self.initMainScrollView()
    self.createExclusiveLabel()
    self.createTextFields()
    
  }
  
  private func initMainScrollView() {
    
    
    let frameForMainScrollView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                        y: 86.0 * UtilityManager.sharedInstance.conversionHeight,
                                    width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 374.0 * UtilityManager.sharedInstance.conversionHeight)//Value that I considered
    let sizeForContentScrollView = CGSize.init(width: frameForMainScrollView.size.width,
                                              height: frameForMainScrollView.size.height)
    
    mainScrollView = UIScrollView.init(frame: frameForMainScrollView)
    mainScrollView.backgroundColor = UIColor.clearColor()
    mainScrollView.contentSize = sizeForContentScrollView
    mainScrollView.directionalLockEnabled = true
    mainScrollView.alwaysBounceVertical = true
    mainScrollView.showsVerticalScrollIndicator = false
    self.addSubview(mainScrollView)
    
  }
  
  private func createExclusiveLabel() {
    exclusiveLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: AgencyProfileEditConstants.ExclusiveView.exclusiveLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    exclusiveLabel.attributedText = stringWithFormat
    exclusiveLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (exclusiveLabel.frame.size.width / 2.0),
                               y: 30.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: exclusiveLabel.frame.size.width,
                               height: exclusiveLabel.frame.size.height)
    
    exclusiveLabel.frame = newFrame
    
    self.addSubview(exclusiveLabel)
  }
  
  private func createTextFields() {
    
    if arrayOfExclusivesBrandTextFields == nil || arrayOfExclusivesBrandTextFields?.count == 0{
      self.createTextFieldCreatorOfBrands()
    }
    
  }
  
  
  private func createTextFieldCreatorOfBrands() {
    
    let lastExclusiveBrand = arrayOfExclusivesBrandTextFields?.last
    if lastExclusiveBrand == nil {
      
      descriptionLabel = UILabel.init(frame: CGRectZero)
      descriptionLabel.numberOfLines = 2
      
      let font = UIFont(name: "SFUIText-Medium",
                        size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
      let color = UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.25)
      let style = NSMutableParagraphStyle()
      style.alignment = NSTextAlignment.Left
      
      let stringWithFormat = NSMutableAttributedString(
        string: AgencyProfileEditConstants.ExclusiveView.descriptionLabelText,
        attributes:[NSFontAttributeName: font!,
          NSParagraphStyleAttributeName: style,
          NSForegroundColorAttributeName: color
        ]
      )
      
      descriptionLabel.attributedText = stringWithFormat
      descriptionLabel.sizeToFit()
      
      let newFrame = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                 y: 14.0 * UtilityManager.sharedInstance.conversionHeight ,
                                 width: descriptionLabel.frame.size.width,
                                 height: descriptionLabel.frame.size.height)
      
      descriptionLabel.frame = newFrame
      
      self.mainScrollView.addSubview(descriptionLabel)
      
      let frameForTextFieldCreator = CGRect.init(x: 4.0 * UtilityManager.sharedInstance.conversionWidth,
                                               y: descriptionLabel.frame.origin.y + descriptionLabel.frame.size.height + 10.0 * UtilityManager.sharedInstance.conversionHeight,
                                           width: mainScrollView.frame.size.width - (4.0 * UtilityManager.sharedInstance.conversionWidth),
                                          height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
      
      creatorOfBrandTextField = BasicCustomTextField.init(frame: frameForTextFieldCreator)
      creatorOfBrandTextField.tag = 1
      creatorOfBrandTextField.placeholder = "Ejemplo de marca"
      creatorOfBrandTextField.delegate = self
      
      self.mainScrollView.addSubview(creatorOfBrandTextField)
      
    } else {
      
      //CHECK WHEN COMES BRAND NAMES FROM SERVER
      
    }
  
  }
  
  private func createAnotherTextFieldWithBrand(brandName: String) {
    
    let lastExclusiveBrandTextField = arrayOfExclusivesBrandTextFields?.last
    if lastExclusiveBrandTextField == nil {
    
      let frameForTextFieldCreator = CGRect.init(x: 4.0 * UtilityManager.sharedInstance.conversionWidth,
                                                 y: 14.0 * UtilityManager.sharedInstance.conversionHeight,
                                                 width: mainScrollView.frame.size.width - (4.0 * UtilityManager.sharedInstance.conversionWidth),
                                                 height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
      
      let newTextField = BasicCustomTextField.init(frame: frameForTextFieldCreator)
      newTextField.delegate = self
      newTextField.alpha = 0.0
      newTextField.text = brandName
      newTextField.tag = 666
      newTextField.placeholder = "Nombre de marca"
      
      arrayOfExclusivesBrandTextFields.append(newTextField)
      
      self.mainScrollView.addSubview(newTextField)
      
      self.animateNewTextFieldDescriptionLabelAndCreatorOfBrandsTextField(newTextField)
      self.editValueOfMainScrollView()
    
    } else {
      
      let frameForTextFieldCreator = CGRect.init(x: 4.0 * UtilityManager.sharedInstance.conversionWidth,
                                                 y: lastExclusiveBrandTextField!.frame.origin.y + lastExclusiveBrandTextField!.frame.size.height + (14.0 * UtilityManager.sharedInstance.conversionHeight),
                                                 width: mainScrollView.frame.size.width - (4.0 * UtilityManager.sharedInstance.conversionWidth),
                                                 height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
      
      let newTextField = BasicCustomTextField.init(frame: frameForTextFieldCreator)
      newTextField.alpha = 0.0
      newTextField.text = brandName
      newTextField.placeholder = "Nombre de marca"
      newTextField.delegate = self
      
      arrayOfExclusivesBrandTextFields.append(newTextField)
      
      self.mainScrollView.addSubview(newTextField)
      
      self.animateNewTextFieldDescriptionLabelAndCreatorOfBrandsTextField(newTextField)
      self.editValueOfMainScrollView()
    }
    
  }

  private func animateNewTextFieldDescriptionLabelAndCreatorOfBrandsTextField(newTextField: UITextField) {
    
    let newFrameForDescriptionLabel = CGRect.init(x: descriptionLabel.frame.origin.x,
                                                  y: newTextField.frame.origin.y + newTextField.frame.size.height + (14.0 * UtilityManager.sharedInstance.conversionHeight),
                                                  width: descriptionLabel.frame.size.width,
                                                  height: descriptionLabel.frame.size.height)
    
    let newFrameForCreator = CGRect.init(x: creatorOfBrandTextField.frame.origin.x,
                                         y: newFrameForDescriptionLabel.origin.y + newFrameForDescriptionLabel.size.height + (10.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: creatorOfBrandTextField.frame.size.width,
                                    height: creatorOfBrandTextField.frame.size.height)
    
    UIView.animateWithDuration(0.25, animations: {
      self.descriptionLabel.frame = newFrameForDescriptionLabel
      self.creatorOfBrandTextField.frame = newFrameForCreator
      }) { (finished) in
        if finished {
          
          UIView.animateWithDuration(0.25, animations: {
            newTextField.alpha = 1.0
            }, completion: { (finished) in
              if finished {
                //Do something
              }
          })
          
        }
    }
    
  }
  
  
  
  private func accommodateAllElements() {
    
    let firstExclusiveBrandTextField = arrayOfExclusivesBrandTextFields?.first
    if firstExclusiveBrandTextField == nil {
      
      let frameForTextFieldCreator = CGRect.init(x: 4.0 * UtilityManager.sharedInstance.conversionWidth,
                                                 y: 14.0 * UtilityManager.sharedInstance.conversionHeight,
                                                 width: creatorOfBrandTextField.frame.size.width,
                                                 height: creatorOfBrandTextField.frame.size.height)
      
      let frameForDescriptionLabel = CGRect.init(x: descriptionLabel.frame.origin.x,
                                                 y: frameForTextFieldCreator.origin.y - (10.0 * UtilityManager.sharedInstance.conversionHeight),
                                             width: descriptionLabel.frame.size.width,
                                            height: descriptionLabel.frame.size.height)
      
      UIView.animateWithDuration(0.5){
        self.creatorOfBrandTextField.frame = frameForTextFieldCreator
        self.descriptionLabel.frame = frameForDescriptionLabel
      }
    
    } else {
      
      var frameForTextFields = CGRect.init(x: 4.0 * UtilityManager.sharedInstance.conversionWidth,
                                                 y: 14.0 * UtilityManager.sharedInstance.conversionHeight,
                                                 width: firstExclusiveBrandTextField!.frame.size.width,
                                                 height: firstExclusiveBrandTextField!.frame.size.height)
      
      for textField in arrayOfExclusivesBrandTextFields {
        
        UIView.animateWithDuration(0.35){
          
          textField.frame = frameForTextFields
          
        }
        
        frameForTextFields = CGRect.init(x: 4.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: frameForTextFields.origin.y + frameForTextFields.size.height + (14.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: frameForTextFields.size.width,
                                    height: frameForTextFields.size.height)
      }
      
      let frameForCreatorOfBrands = CGRect.init(x: frameForTextFields.origin.x,
                                                y: frameForTextFields.origin.y + (24.0 * UtilityManager.sharedInstance.conversionHeight),
                                            width: frameForTextFields.size.width,
                                           height: frameForTextFields.size.height)
      
      let frameForDescriptionLabel = CGRect.init(x: descriptionLabel.frame.origin.x,
                                                 y: frameForCreatorOfBrands.origin.y - (20.0 * UtilityManager.sharedInstance.conversionHeight),
                                                 width: descriptionLabel.frame.size.width,
                                                 height: descriptionLabel.frame.size.height)
      
      UIView.animateWithDuration(0.5){
        self.creatorOfBrandTextField.frame = frameForCreatorOfBrands
        self.descriptionLabel.frame = frameForDescriptionLabel
      }
      
    }
    
  }
  
  
  
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    if textField.tag == 1 {//when texted in the creatorBrandTextField
      
      if UtilityManager.sharedInstance.isValidText(textField.text!){
      
        self.createAnotherTextFieldWithBrand(textField.text!)
        textField.text = ""
      
      }
      
    }
    return true
  }
  
  private func editValueOfMainScrollView() {
    
    if arrayOfExclusivesBrandTextFields.count > 3 {
      
      let newSizeForScrollView = CGSize.init(width: mainScrollView.frame.size.width,
                                            height: mainScrollView.contentSize.height + (70.0 * UtilityManager.sharedInstance.conversionHeight))
      mainScrollView.contentSize = newSizeForScrollView

      let toTheEnd = CGPoint.init(x: 0.0, y: mainScrollView.contentSize.height - mainScrollView.bounds.size.height)
      mainScrollView.setContentOffset(toTheEnd, animated: true)
      
    }
    
  }
  
  @objc func dismissKeyboard(sender:AnyObject) {
    self.endEditing(true)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - TextFieldDelegate
  
  func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
    
    self.delegate?.keyBoardWillAppearFromExclusiveView(textField.frame.origin.y)
    
    return true
    
  }
  
  func textFieldShouldClear(textField: UITextField) -> Bool {
    
    UIView.animateWithDuration(0.15,
      animations: {
        textField.alpha = 0.0
      }) { (finished) in
        if finished {
          
          let index = self.arrayOfExclusivesBrandTextFields.indexOf(textField)
          if index != nil {
            self.arrayOfExclusivesBrandTextFields.removeAtIndex(index!)
          }
          
          self.accommodateAllElements()
          
        }
    }
    
    return true
    
  }
  
}
