//
//  ExclusiveView.swift
//  Amap
//
//  Created by Mac on 8/12/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class ExclusiveView: UIView, UITextFieldDelegate {
  
  private var mainScrollView: UIScrollView! = nil
  private var exclusiveLabel: UILabel! = nil
  private var explainingLabel: UILabel! = nil
  private var descriptionLabel: UILabel! = nil
  private var arrayOfExclusivesBrandToDelete = [ExclusivityBrandModelData]()
  private var arrayOfExclusivesBrandNames: [ExclusivityBrandModelData]! = nil
  private var arrayOfExclusivesBrandTextFields: [UITextField]! = nil
  private var creatorOfBrandTextField: UITextField! = nil
  
  var thereAreChanges: Bool = false

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.initValues()
    self.addGestureToDismissKeyboard()
    self.initInterface()
  }
  
  private func initValues() {
    
    if AgencyModel.Data.exclusivityBrands != nil && AgencyModel.Data.exclusivityBrands?.count > 0 {
    
      arrayOfExclusivesBrandNames = AgencyModel.Data.exclusivityBrands!
      arrayOfExclusivesBrandTextFields = []
      
    } else {
      
      arrayOfExclusivesBrandNames = []
      arrayOfExclusivesBrandTextFields = []
      
    }

    
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
    self.createExplainingLabel()
    self.createTextFields()
    
  }
  
  private func initMainScrollView() {
    
    
    let frameForMainScrollView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                        y: 135.0 * UtilityManager.sharedInstance.conversionHeight,
                                    width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 344.0 * UtilityManager.sharedInstance.conversionHeight)//Value that I considered
    let sizeForContentScrollView = CGSize.init(width: frameForMainScrollView.size.width,
                                              height: frameForMainScrollView.size.height)
    
    mainScrollView = UIScrollView.init(frame: frameForMainScrollView)
    mainScrollView.backgroundColor = UIColor.clearColor()
    mainScrollView.contentSize = sizeForContentScrollView
//    mainScrollView.directionalLockEnabled = true
    mainScrollView.alwaysBounceVertical = true
    mainScrollView.showsVerticalScrollIndicator = true
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
  
  private func createExplainingLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    explainingLabel = UILabel.init(frame: frameForLabel)
    explainingLabel.numberOfLines = 0
    explainingLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: AgencyProfileEditConstants.ExclusiveView.explainingLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    explainingLabel.attributedText = stringWithFormat
    explainingLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (explainingLabel.frame.size.width / 2.0),
                               y: 90.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: explainingLabel.frame.size.width,
                               height: explainingLabel.frame.size.height)
    
    explainingLabel.frame = newFrame
    
    self.addSubview(explainingLabel)

  }
  
  private func createTextFields() {
    
    if arrayOfExclusivesBrandNames == nil || arrayOfExclusivesBrandNames?.count == 0{
    
      self.createTextFieldCreatorOfBrands()
    
    }else{
      
      self.createAllBrandsInTextFields()
      self.createTextFieldCreatorOfBrands()
      
    }
    
  }
  
  private func createAllBrandsInTextFields() {
    
    var frameForBrands = CGRect.init(x: 4.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 14.0 * UtilityManager.sharedInstance.conversionHeight,
                                 width: mainScrollView.frame.size.width - (4.0 * UtilityManager.sharedInstance.conversionWidth),
                                height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
    
    for brand in arrayOfExclusivesBrandNames {
      
      let newTextField = BasicCustomTextField.init(frame: frameForBrands, newExclusiveData: brand)
      newTextField.delegate = self
      newTextField.alpha = 1.0
      newTextField.text = brand.name
      newTextField.tag = Int(brand.id)!
      newTextField.placeholder = "Nombre de marca"
      
      arrayOfExclusivesBrandTextFields.append(newTextField)
      
      self.mainScrollView.addSubview(newTextField)
      mainScrollView.showsVerticalScrollIndicator = true
      
      frameForBrands = CGRect.init(x: frameForBrands.origin.x,
                                   y: frameForBrands.origin.y + frameForBrands.size.height + (5.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: frameForBrands.size.width,
                              height: frameForBrands.size.height)
      
      self.editValueOfMainScrollView()
      
    }
    
    
    
  }
  
  private func createTextFieldCreatorOfBrands() {
    
    let lastExclusiveBrand = arrayOfExclusivesBrandTextFields?.last
    if lastExclusiveBrand == nil {
      
      let frameForLabel = CGRect.init(x: 0.0,
                                      y: 0.0,
                                      width: 90.0 * UtilityManager.sharedInstance.conversionWidth,
                                      height: CGFloat.max)
      
      descriptionLabel = UILabel.init(frame: frameForLabel)
      descriptionLabel.numberOfLines = 2
      
      let font = UIFont(name: "SFUIText-Medium",
                        size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
      let color = UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.25)
      let style = NSMutableParagraphStyle()
      style.alignment = NSTextAlignment.Left
      
      let stringWithFormat = NSMutableAttributedString(
        string: "",//AgencyProfileEditConstants.ExclusiveView.descriptionLabelText,
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
      mainScrollView.showsVerticalScrollIndicator = true
      
      let frameForTextFieldCreator = CGRect.init(x: 4.0 * UtilityManager.sharedInstance.conversionWidth,
                                               y: descriptionLabel.frame.origin.y + descriptionLabel.frame.size.height + 15.0 * UtilityManager.sharedInstance.conversionHeight,
                                           width: mainScrollView.frame.size.width - (4.0 * UtilityManager.sharedInstance.conversionWidth),
                                          height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
      
      let fictitiousBrandForCreator = ExclusivityBrandModelData.init(newId: "-1234567890",
                                                                   newName: "creator")
      
      
      creatorOfBrandTextField = BasicCustomTextField.init(frame: frameForTextFieldCreator,
                                               newExclusiveData: fictitiousBrandForCreator)
      creatorOfBrandTextField.tag = -1234567890
      creatorOfBrandTextField.placeholder = "Escribe el nombre del anunciante y presiona aceptar"
      creatorOfBrandTextField.delegate = self
      creatorOfBrandTextField.returnKeyType = .Done
      
      let attributes = [
        NSForegroundColorAttributeName: UIColor.init(white: 0.0, alpha: 0.35),
        NSFontAttributeName : UIFont(name: "SFUIText-Medium", size: 8.5 * UtilityManager.sharedInstance.conversionWidth)!
      ]
      creatorOfBrandTextField.attributedPlaceholder = NSAttributedString(string: "Escribe el nombre del anunciante y presiona aceptar", attributes: attributes)
      
      self.mainScrollView.addSubview(creatorOfBrandTextField)
      mainScrollView.showsVerticalScrollIndicator = true
      
    } else {
      
      let frameForLabel = CGRect.init(x: 0.0,
                                      y: 0.0,
                                      width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                      height: CGFloat.max)
      
      descriptionLabel = UILabel.init(frame: frameForLabel)
      descriptionLabel.numberOfLines = 2
      
      let font = UIFont(name: "SFUIText-Medium",
                        size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
      let color = UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
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
                                 y: lastExclusiveBrand!.frame.origin.y + lastExclusiveBrand!.frame.size.height + (15.0 * UtilityManager.sharedInstance.conversionHeight),
                             width: descriptionLabel.frame.size.width,
                            height: descriptionLabel.frame.size.height)
      
      descriptionLabel.frame = newFrame
      
      self.mainScrollView.addSubview(descriptionLabel)
      mainScrollView.showsVerticalScrollIndicator = true
      
      let frameForTextFieldCreator = CGRect.init(x: 4.0 * UtilityManager.sharedInstance.conversionWidth,
                                                 y: lastExclusiveBrand!.frame.origin.y + lastExclusiveBrand!.frame.size.height + (24.0 * UtilityManager.sharedInstance.conversionHeight),
                                             width: mainScrollView.frame.size.width - (4.0 * UtilityManager.sharedInstance.conversionWidth),
                                            height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
      
      let fictitiousBrandForCreator = ExclusivityBrandModelData.init(newId: "-1234567890",
                                                                     newName: "creator")
      
      
      creatorOfBrandTextField = BasicCustomTextField.init(frame: frameForTextFieldCreator,
                                                          newExclusiveData: fictitiousBrandForCreator)
      creatorOfBrandTextField.tag = -1234567890
      creatorOfBrandTextField.placeholder = "Marca"
      creatorOfBrandTextField.delegate = self
      creatorOfBrandTextField.returnKeyType = .Done
      
      let attributes = [
        NSForegroundColorAttributeName: UIColor.init(white: 0.0, alpha: 0.25),
        NSFontAttributeName : UIFont(name: "SFUIText-Medium", size: 14.0 * UtilityManager.sharedInstance.conversionWidth)!
      ]
      creatorOfBrandTextField.attributedPlaceholder = NSAttributedString(string: "Marca", attributes: attributes) //"Agrega presionando Aceptar"
      
      self.mainScrollView.addSubview(creatorOfBrandTextField)
      mainScrollView.showsVerticalScrollIndicator = true
      
    }
  
  }
  
  private func createAnotherTextFieldWithBrand(brand: ExclusivityBrandModelData) {
    
    let lastExclusiveBrandTextField = arrayOfExclusivesBrandTextFields?.last
    if lastExclusiveBrandTextField == nil {
    
      let frameForTextFieldCreator = CGRect.init(x: 4.0 * UtilityManager.sharedInstance.conversionWidth,
                                                 y: 14.0 * UtilityManager.sharedInstance.conversionHeight,
                                                 width: mainScrollView.frame.size.width - (4.0 * UtilityManager.sharedInstance.conversionWidth),
                                                 height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
      
      let newTextField = BasicCustomTextField.init(frame: frameForTextFieldCreator, newExclusiveData: brand)
      newTextField.delegate = self
      newTextField.alpha = 0.0
      newTextField.text = brand.name
      newTextField.tag = Int(brand.id)!
      newTextField.placeholder = "Nombre de marca"
      
      arrayOfExclusivesBrandTextFields.append(newTextField)
      
      self.mainScrollView.addSubview(newTextField)
      mainScrollView.showsVerticalScrollIndicator = true
      
      self.animateNewTextFieldDescriptionLabelAndCreatorOfBrandsTextField(newTextField)
      self.editValueOfMainScrollView()
    
    } else {

      let frameForTextFieldCreator = CGRect.init(x: 4.0 * UtilityManager.sharedInstance.conversionWidth,
                                                 y: lastExclusiveBrandTextField!.frame.origin.y + lastExclusiveBrandTextField!.frame.size.height + (14.0 * UtilityManager.sharedInstance.conversionHeight) ,
                                                 width: mainScrollView.frame.size.width - (4.0 * UtilityManager.sharedInstance.conversionWidth),
                                                 height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
      
      let newTextField = BasicCustomTextField.init(frame: frameForTextFieldCreator, newExclusiveData: brand)
      newTextField.delegate = self
      newTextField.alpha = 0.0
      newTextField.text = brand.name
      newTextField.tag = Int(brand.id)!
      newTextField.placeholder = "Nombre de marca"
      
      arrayOfExclusivesBrandTextFields.append(newTextField)
      
      self.mainScrollView.addSubview(newTextField)
      mainScrollView.showsVerticalScrollIndicator = true
      
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
    
    thereAreChanges = true
    
    let attributes = [
      NSForegroundColorAttributeName: UIColor.init(white: 0.0, alpha: 0.35),
      NSFontAttributeName : UIFont(name: "SFUIText-Medium", size: 10.0 * UtilityManager.sharedInstance.conversionWidth)!
    ]
    creatorOfBrandTextField.attributedPlaceholder = NSAttributedString(string: "Escribe el nombre de la marca que falta", attributes: attributes)
    
    if textField.tag == -1234567890 {//when texted in the creatorBrandTextField
      
      if UtilityManager.sharedInstance.isValidText(textField.text!){
      
        let newBrand = ExclusivityBrandModelData.init(newId: "-1",
                                                    newName: textField.text!)
        
        
        self.createAnotherTextFieldWithBrand(newBrand)
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
  
  @objc private func dismissKeyboard(sender:AnyObject) {
    self.endEditing(true)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - TextFieldDelegate
  
  func textFieldShouldClear(textField: UITextField) -> Bool {
    
    self.thereAreChanges = true
    
    UIView.animateWithDuration(0.15,
      animations: {
        textField.alpha = 0.0
      }) { (finished) in
        if finished == true {
          
          if textField as? BasicCustomTextField != nil {
            
            let brandTextField = textField as! BasicCustomTextField
            let brandToDelete = brandTextField.getExclusiveBrandData()
            
            if brandToDelete.id != "-1" {
            
              self.arrayOfExclusivesBrandToDelete.append(brandToDelete)
              self.thereAreChanges = true
              
            }
            
          }
          
          let index = self.arrayOfExclusivesBrandTextFields.indexOf(textField)
          if index != nil {
            self.arrayOfExclusivesBrandTextFields.removeAtIndex(index!)
          }
          
          self.accommodateAllElements()
          
        }
    }
    
    return true
    
  }
  
  func requestToSaveNewBrands() {
    
    var arrayOfBrandsToCreate = [String]()
    
    for textField in arrayOfExclusivesBrandTextFields {
      
      if textField as? BasicCustomTextField != nil {
        
        let brandTextField = textField as! BasicCustomTextField
      
        if UtilityManager.sharedInstance.isValidText(brandTextField.text!) { //== true && brandTextField.getExclusiveBrandData().id == "-1" {
        
          arrayOfBrandsToCreate.append(textField.text!)
      
        }
     
      }
      
    }

    let params: [String: AnyObject] = [
    
      "auth_token": UserSession.session.auth_token,
      "id": AgencyModel.Data.id,
      "brands": arrayOfBrandsToCreate
    
    ]
    
    UtilityManager.sharedInstance.showLoader()
    
    RequestToServerManager.sharedInstance.requestToSaveExclusiveBrands(params) { (jsonSentFromServerWhenSaveExclusiveData) in
      
      print(jsonSentFromServerWhenSaveExclusiveData)
      print()
//      UtilityManager.sharedInstance.hideLoader()
      
      
      
      
      var idBrandsToDelete = [String]()
      
      for brandToDelete in self.arrayOfExclusivesBrandToDelete {
        
        idBrandsToDelete.append(brandToDelete.id)
        
      }
      
      let paramsToDelete: [String: AnyObject] = [
        
        "auth_token": UserSession.session.auth_token,
        "id": AgencyModel.Data.id,
        "brands": idBrandsToDelete
        
      ]
      
      UtilityManager.sharedInstance.showLoader()
      
      RequestToServerManager.sharedInstance.requestToDeleteExclusiveBrands(paramsToDelete) { (jsonSentFromServerWhenDeleteExclusiveBrandsData) in
        
        print(jsonSentFromServerWhenDeleteExclusiveBrandsData)
        print()
        
        UtilityManager.sharedInstance.hideLoader()
        
      }
      
      
    }
    
//    var idBrandsToDelete = [String]()
//    
//    for brandToDelete in self.arrayOfExclusivesBrandToDelete {
//      
//      idBrandsToDelete.append(brandToDelete.id)
//      
//    }
//    
//    let paramsToDelete: [String: AnyObject] = [
//      
//      "auth_token": UserSession.session.auth_token,
//      "id": AgencyModel.Data.id,
//      "brands": idBrandsToDelete
//      
//    ]
//    
//    UtilityManager.sharedInstance.showLoader()
//    
//    RequestToServerManager.sharedInstance.requestToDeleteExclusiveBrands(paramsToDelete) { (jsonSentFromServerWhenDeleteExclusiveBrandsData) in
//      
//      print(jsonSentFromServerWhenDeleteExclusiveBrandsData)
//      print()
//      
//      UtilityManager.sharedInstance.hideLoader()
//      
//    }
    
  }
  
}
