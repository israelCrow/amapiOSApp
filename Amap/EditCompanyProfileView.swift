//
//  EditCompanyProfileView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 12/9/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol EditCompanyProfileViewDelegate {
  
  func selectProfileImageFromLibrary()
  
  func asKForDeleteProfileImage()
  
  func saveChangesFromEditCompanyProfileView(parameters: [String:AnyObject], actionsToMakeAfterExecution: () -> Void)

  func showMessageOfMandatoryInfo()
  
}

class EditCompanyProfileView: UIView, UITextFieldDelegate {
  
  private var mainScrollView: UIScrollView! = nil
  private var profileLabel: UILabel! = nil
  private var profileImageView: UIImageView! = nil
  private var changeProfileImageButton: UIButton! = nil
  private var deleteProfileImageButton: UIButton! = nil
  
  private var newImage: UIImage! = nil
  
  private var companyNameView: CustomTextFieldWithTitleView! = nil
  private var companyEMailView: CustomTextFieldWithTitleView! = nil
  private var companyContactView: CustomTextFieldWithTitleView! = nil
  private var companyPositionView: CustomTextFieldWithTitleView! = nil
  
  var thereAreChanges: Bool = false
  
  var delegate: EditCompanyProfileViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    self.addSomeGestures()
    self.initInterface()
    
  }
  
  private func addSomeGestures() {
    
    let tapToDismissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                              action: #selector(dismissKeyboard))
    tapToDismissKeyboard.numberOfTapsRequired = 1
    self.addGestureRecognizer(tapToDismissKeyboard)
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    
    self.createMainScrollView()
    self.createProfileLabel()
    self.createProfileImageView()
    self.createChangeProfileImageButton()
    self.createDeleteProfileImageButton()

    self.createCompanyNameView()
    self.createCompanyEMailView()
    self.createCompanyContactView()
    self.createCompanyPositionView()
    
  }
  
  private func createMainScrollView() {
    
    let frameForMainScrollView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                             y: 86.0 * UtilityManager.sharedInstance.conversionHeight,
                                             width: 235.0 * UtilityManager.sharedInstance.conversionWidth,
                                             height: 374.0 * UtilityManager.sharedInstance.conversionHeight)//Value that I considered
    let sizeForContentScrollView = CGSize.init(width: frameForMainScrollView.size.width,
                                               height: frameForMainScrollView.size.height + (60.0 * UtilityManager.sharedInstance.conversionHeight))//Value that i considered
    
    mainScrollView = UIScrollView.init(frame: frameForMainScrollView)
    mainScrollView.backgroundColor = UIColor.clearColor()
    mainScrollView.contentSize = sizeForContentScrollView
    mainScrollView.directionalLockEnabled = true
    mainScrollView.scrollEnabled = false
//    mainScrollView.alwaysBounceVertical = true
//    mainScrollView.showsVerticalScrollIndicator = true
    self.addSubview(mainScrollView)
    
  }
  
  private func createProfileLabel() {
    
    profileLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: AgencyProfileEditConstants.ProfileView.profileLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    profileLabel.attributedText = stringWithFormat
    profileLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (profileLabel.frame.size.width / 2.0),
                               y: 30.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: profileLabel.frame.size.width,
                               height: profileLabel.frame.size.height)
    
    profileLabel.frame = newFrame
    
    self.addSubview(profileLabel)
    
  }
  
  private func createProfileImageView() {
    
    let frameForProfileImageView = CGRect.init(x: 0.0,
                                               y: 0.0,
                                               width: 48.0 * UtilityManager.sharedInstance.conversionWidth,
                                               height: 48.0 * UtilityManager.sharedInstance.conversionHeight)
    
    profileImageView = UIImageView.init(frame: frameForProfileImageView)
    profileImageView.backgroundColor = UIColor.lightGrayColor()
    profileImageView.layer.borderWidth = 0.35
    profileImageView.layer.masksToBounds = false
    profileImageView.layer.borderColor = UIColor.blackColor().CGColor
    profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2.0
    profileImageView.clipsToBounds = true
    profileImageView.userInteractionEnabled = true
    
    let tapToChangeProfileImage = UITapGestureRecognizer.init(target: self, action: #selector(selectImageFromLibrary))
    tapToChangeProfileImage.numberOfTapsRequired = 1
    
    profileImageView.addGestureRecognizer(tapToChangeProfileImage)
    
    if MyCompanyModelData.Data.logoURL != nil && MyCompanyModelData.Data.logoURL != "" {
      
      profileImageView.imageFromUrl(MyCompanyModelData.Data.logoURL)

    }
    
    mainScrollView.addSubview(profileImageView)
    
  }
  
  private func createChangeProfileImageButton() {
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 11.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: AgencyProfileEditConstants.ProfileView.changeProfilePictureButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color,
      ]
    )
    
    stringWithFormat.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: NSMakeRange(0, AgencyProfileEditConstants.ProfileView.changeProfilePictureButtonText.characters.count))
    
    
    let frameForButton = CGRect.init(x: 78.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 0.0,
                                     width: 116.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: ((13.0 + 4.0) * UtilityManager.sharedInstance.conversionHeight))
    changeProfileImageButton = UIButton.init(frame: frameForButton)
    changeProfileImageButton.addTarget(self,
                                       action: #selector(selectImageFromLibrary),
                                       forControlEvents: .TouchUpInside)
    changeProfileImageButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    
    self.mainScrollView.addSubview(changeProfileImageButton)
    
  }
  
  private func createDeleteProfileImageButton() {
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 11.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: AgencyProfileEditConstants.ProfileView.deleteProfilePictureButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color,
      ]
    )
    
    stringWithFormat.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: NSMakeRange(0, AgencyProfileEditConstants.ProfileView.deleteProfilePictureButtonText.characters.count))
    
    
    let frameForButton = CGRect.init(x: 78.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: changeProfileImageButton.frame.origin.y + changeProfileImageButton.frame.size.height + (16.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: 116.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: ((13.0 + 4.0) * UtilityManager.sharedInstance.conversionHeight))
    deleteProfileImageButton = UIButton.init(frame: frameForButton)
    deleteProfileImageButton.addTarget(self,
                                       action: #selector(askForDeleteProfileImage),
                                       forControlEvents: .TouchUpInside)
    deleteProfileImageButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    
    self.mainScrollView.addSubview(deleteProfileImageButton)
    
  }
  
  private func createCompanyNameView() {
    
    let frameForCustomView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: 55.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: self.frame.size.width,
                                         height: 64.0 * UtilityManager.sharedInstance.conversionHeight)
    
    companyNameView = CustomTextFieldWithTitleView.init(frame: frameForCustomView, title: nil, image: nil)
    companyNameView.mainTextField.placeholder = "Nombre"
    companyNameView.mainTextField.tag = 1
    companyNameView.mainTextField.delegate = self
    companyNameView.mainTextField.userInteractionEnabled = false
    
    if MyCompanyModelData.Data.name != nil {
      
      companyNameView.mainTextField.text = MyCompanyModelData.Data.name
      
    }
    
    companyNameView.backgroundColor = UIColor.clearColor()
//    companyNameView.mainTextField.delegate = self
    
    self.mainScrollView.addSubview(companyNameView)
    
  }
  
  private func createCompanyEMailView() {
    
    let frameForCustomView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: companyNameView.frame.origin.y + companyNameView.frame.size.height + (10.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: self.frame.size.width,
                                    height: 78.0 * UtilityManager.sharedInstance.conversionHeight)
    
    companyEMailView = CustomTextFieldWithTitleView.init(frame: frameForCustomView, title: "Escribe tus datos de contacto", image: "iconMailClient")
    companyEMailView.mainTextField.placeholder = "mail@mail.com"
    companyEMailView.mainTextField.tag = 2
    companyEMailView.mainTextField.delegate = self
    
    if MyCompanyModelData.Data.contactEMail != nil {
      
      companyEMailView.mainTextField.text = MyCompanyModelData.Data.contactEMail
      
    }
    
    companyEMailView.backgroundColor = UIColor.clearColor()
    //    companyNameView.mainTextField.delegate = self
    
    self.mainScrollView.addSubview(companyEMailView)
    
  }
  
  private func createCompanyContactView() {
    
    let frameForCustomView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: companyEMailView.frame.origin.y + companyEMailView.frame.size.height + (-5.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: self.frame.size.width,
                                    height: 78.0 * UtilityManager.sharedInstance.conversionHeight)
    
    companyContactView = CustomTextFieldWithTitleView.init(frame: frameForCustomView, title: nil, image: "iconUser")
    companyContactView.mainTextField.placeholder = "Nombre"
    companyContactView.mainTextField.tag = 3
    companyContactView.mainTextField.delegate = self
    
    if MyCompanyModelData.Data.contactName != nil {
      
      companyContactView.mainTextField.text = MyCompanyModelData.Data.contactName
      
    }
    
    companyContactView.backgroundColor = UIColor.clearColor()
    //    companyNameView.mainTextField.delegate = self
    
    self.mainScrollView.addSubview(companyContactView)
    
  }
  
  private func createCompanyPositionView() {
    
    let frameForCustomView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: companyContactView.frame.origin.y + companyContactView.frame.size.height + (-15.0 * UtilityManager.sharedInstance.conversionHeight),
                                         width: self.frame.size.width,
                                         height: 78.0 * UtilityManager.sharedInstance.conversionHeight)
    
    companyPositionView = CustomTextFieldWithTitleView.init(frame: frameForCustomView, title: nil, image: "icon-briefcase")
    companyPositionView.mainTextField.placeholder = "Puesto"
    companyPositionView.mainTextField.tag = 4
    companyPositionView.mainTextField.delegate = self
    
    if MyCompanyModelData.Data.contactPosition != nil {
      
      companyPositionView.mainTextField.text = MyCompanyModelData.Data.contactPosition
      
    }
    
    companyContactView.backgroundColor = UIColor.clearColor()
    //    companyNameView.mainTextField.delegate = self
    
    self.mainScrollView.addSubview(companyPositionView)
    
  }

  func textFieldShouldReturn(textField: UITextField) -> Bool {
    
    let nextTag: NSInteger = textField.tag + 1;
    // Try to find next responder
    if let nextResponder: UIResponder! = textField.superview?.superview?.viewWithTag(nextTag){
      
      nextResponder.becomeFirstResponder()
      
    } else {
      // Not found, so remove keyboard.
      self.dismissKeyboard(textField)
      
    }
    
    return false
    
  }
  
  func textFieldDidBeginEditing(textField: UITextField) {
    
    mainScrollView.scrollEnabled = true
    
    if textField.tag == 3 || textField.tag == 4{
      
      self.moveUpMainScrollView(CGPoint.init(x: 0.0, y: textField.superview!.frame.origin.y))
      
    }
    
    thereAreChanges = true
    
  }
  
  private func moveUpMainScrollView(toPoint: CGPoint) {
    
    mainScrollView.setContentOffset(toPoint, animated: true)
    
  }
  
  private func moveDownMainScrollView() {
    
    let pointToMove = CGPoint.init(x: 0.0, y: 0.0)
    
    mainScrollView.setContentOffset(pointToMove, animated: true)
    
  }
  
  @objc func dismissKeyboard(sender:AnyObject) {
    
    mainScrollView.scrollEnabled = false
    self.moveDownMainScrollView()
   
    self.endEditing(true)
    
  }
  
  @objc private func selectImageFromLibrary() {
    
    delegate?.selectProfileImageFromLibrary()
    
  }
  
  @objc private func askForDeleteProfileImage() {
    
    self.delegate?.asKForDeleteProfileImage()
    
  }
  
  func deleteProfileImage() {
    
    thereAreChanges = true
    profileImageView.image = nil
    newImage = nil
    
  }
  
  func changeProfileImageView(image: UIImage) {
    
    thereAreChanges = true
    profileImageView.image = image
    newImage = image
    
  }
  
  
  func saveChangesOfCompanyProfile(actionsToMakeAfterExecution: () -> Void) {
    
    var parameters: [String:AnyObject]
    
    if newImage != nil {
      
      var fileName: String = ""
      
      if MyCompanyModelData.Data.name != nil && MyCompanyModelData.Data.name != "" {
        
        fileName = MyCompanyModelData.Data.name + "_img.png"
        
      } else {
        
        fileName = "Company_img.png"
        
      }
      
      let profileImage = newImage
      let profileDataImage = UIImagePNGRepresentation(profileImage)
      
      parameters = [
        "auth_token"       : UserSession.session.auth_token,
        "id"               : UserSession.session.company_id,
        "filename"         : fileName,
        "logo"             : profileDataImage!,
        "delete_image"     : false,
        "company"          :
          [
            "name"             : companyNameView.mainTextField.text!,
            "contact_name"     : companyContactView.mainTextField.text!,
            "contact_email"    : companyEMailView.mainTextField.text!,
            "contact_position" : companyPositionView.mainTextField.text!]
      ]
      
    } else {
      
      var deleteImage = false
      
      if profileImageView.image == nil {
        
        deleteImage = true
        
      }
      
      parameters = [
        "auth_token"       : UserSession.session.auth_token,
        "id"               : UserSession.session.company_id,
        "delete_image"     : deleteImage,
        "company"          :
          [
            "name"             : companyNameView.mainTextField.text!,
            "contact_name"     : companyContactView.mainTextField.text!,
            "contact_email"    : companyEMailView.mainTextField.text!,
            "contact_position" : companyPositionView.mainTextField.text!]
      ]
      
    }
    
    delegate?.saveChangesFromEditCompanyProfileView(parameters, actionsToMakeAfterExecution: actionsToMakeAfterExecution)
    
  }
  
  
}
