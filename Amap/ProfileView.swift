//
//  ProfileView.swift
//  Amap
//
//  Created by Mac on 8/16/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit
import GooglePlaces

protocol ProfileViewDelegate {
  func selectProfileImageFromLibrary()
  func saveChangesFromEditProfileView(parameters: [String:AnyObject], actionsToMakeAfterExecution: () -> Void)
  func asKForDeleteProfileImage()
}

class ProfileView: UIView, UITextFieldDelegate, GMSAutocompleteFetcherDelegate {
  
  private var mainScrollView: UIScrollView! = nil
  private var profileLabel: UILabel! = nil
  private var profileImageView: UIImageView! = nil
  private var changeProfileImageButton: UIButton! = nil
  private var deleteProfileImageButton: UIButton! = nil
  
  private var agencyNameView: CustomTextFieldWithTitleView! = nil
  private var agencyPhoneView: CustomTextFieldWithTitleView! = nil
  private var agencyContactView: CustomTextFieldWithTitleView! = nil
  private var agencyEMailView: CustomTextFieldWithTitleView! = nil
  private var agencyAddressView: CustomTextFieldWithTitleView! = nil
  private var agencyWebsiteView: CustomTextFieldWithTitleView! = nil
  private var agencyNumberOfEmployees: CustomTextFieldWithTitleView! = nil
  private var agencyLatitude: String?
  private var agencyLongitude: String?
  
  var thereAreChanges: Bool = false
  var delegate: ProfileViewDelegate?
  
  //Google places
  private var fetcher: GMSAutocompleteFetcher?
  private var resultText: UITextView?
  private var lastPredictionPlaceFromGoogle: GMSAutocompletePrediction?
  
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
    self.createAgencyNameView()
    self.createAgencyPhoneView()
//    self.createAgencyContactView()
    self.createAgencyEMailView()
    self.createAgencyAddressView()
    self.createAgencyWebsiteView()
    self.createNumberOfEmployeView()
    
    self.initGooglePlaces()
    
  }
  
  private func createMainScrollView() {
    
    let frameForMainScrollView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                             y: 86.0 * UtilityManager.sharedInstance.conversionHeight,
                                             width: 235.0 * UtilityManager.sharedInstance.conversionWidth,
                                             height: 374.0 * UtilityManager.sharedInstance.conversionHeight)//Value that I considered
    let sizeForContentScrollView = CGSize.init(width: frameForMainScrollView.size.width,
                                               height: frameForMainScrollView.size.height + (290.0 * UtilityManager.sharedInstance.conversionHeight))//Value that i considered
    
    mainScrollView = UIScrollView.init(frame: frameForMainScrollView)
    mainScrollView.backgroundColor = UIColor.clearColor()
    mainScrollView.contentSize = sizeForContentScrollView
    mainScrollView.directionalLockEnabled = true
    mainScrollView.alwaysBounceVertical = true
    mainScrollView.showsVerticalScrollIndicator = true
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
    
    if AgencyModel.Data.logo != nil {
      
      profileImageView.imageFromUrl(AgencyModel.Data.logo!)
      
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
  
  private func createAgencyNameView() {
    
    let frameForCustomView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                             y: 55.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: self.frame.size.width,
                                        height: 64.0 * UtilityManager.sharedInstance.conversionHeight)
    
    agencyNameView = CustomTextFieldWithTitleView.init(frame: frameForCustomView, title: nil, image: nil)
    agencyNameView.mainTextField.placeholder = "Nombre de la agencia"
    agencyNameView.mainTextField.tag = 1
    
    if AgencyModel.Data.name != nil {
      
      agencyNameView.mainTextField.text = AgencyModel.Data.name
      
    }
    
    agencyNameView.backgroundColor = UIColor.clearColor()
    agencyNameView.mainTextField.delegate = self
    
    self.mainScrollView.addSubview(agencyNameView)
    
  }
  
  private func createAgencyPhoneView() {
    
    let frameForCustomView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                             y: agencyNameView.frame.origin.y + agencyNameView.frame.size.height + (16.0 * UtilityManager.sharedInstance.conversionHeight),
                                             width: self.frame.size.width,
                                             height: 78.0 * UtilityManager.sharedInstance.conversionHeight)
    
    agencyPhoneView = CustomTextFieldWithTitleView.init(frame: frameForCustomView,
                                                        title: AgencyProfileEditConstants.ProfileView.agencyPhoneTitleText,
                                                        image: "iconPhone")
    agencyPhoneView.mainTextField.placeholder = "00 00000000"
    agencyPhoneView.mainTextField.tag = 2
    
    if AgencyModel.Data.phone != nil {
      
      agencyPhoneView.mainTextField.text = AgencyModel.Data.phone
      
    }
    
    agencyPhoneView.mainTextField.keyboardType = .PhonePad
    agencyPhoneView.backgroundColor = UIColor.clearColor()
    agencyPhoneView.mainTextField.delegate = self
    self.mainScrollView.addSubview(agencyPhoneView)
    
  }
  
//  private func createAgencyContactView() {
//    
//    let frameForCustomView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
//                                         y: agencyPhoneView.frame.origin.y + agencyPhoneView.frame.size.height + (16.0 * UtilityManager.sharedInstance.conversionHeight),
//                                         width: self.frame.size.width,
//                                         height: 78.0 * UtilityManager.sharedInstance.conversionHeight)
//    
//    agencyContactView = CustomTextFieldWithTitleView.init(frame: frameForCustomView,
//                                                        title: AgencyProfileEditConstants.ProfileView.agencyContactTitleText,
//                                                        image: nil)
//    agencyContactView.mainTextField.placeholder = "Nombre de contacto"
//    
//    if AgencyModel.Data.contact_name != nil {
//      
//      agencyContactView.mainTextField.text = AgencyModel.Data.contact_name!
//      
//    }
//    
//    agencyContactView.backgroundColor = UIColor.clearColor()
//    agencyContactView.mainTextField.delegate = self
//    self.mainScrollView.addSubview(agencyContactView)
//    
//  }
  
  private func createAgencyEMailView() {
  
    let frameForCustomView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: agencyPhoneView.frame.origin.y + agencyPhoneView.frame.size.height + (16.0 * UtilityManager.sharedInstance.conversionHeight),
                                         width: self.frame.size.width,
                                         height: 78.0 * UtilityManager.sharedInstance.conversionHeight)
    
    agencyEMailView = CustomTextFieldWithTitleView.init(frame: frameForCustomView,
                                                          title: AgencyProfileEditConstants.ProfileView.agencyMailContactTitleText,
                                                          image: "iconMail")
    agencyEMailView.mainTextField.placeholder = "Email de contacto"
    agencyEMailView.mainTextField.tag = 3
    
    if AgencyModel.Data.contact_email != nil {
      
      agencyEMailView.mainTextField.text = AgencyModel.Data.contact_email!
      
    }
    
    agencyEMailView.backgroundColor = UIColor.clearColor()
    agencyEMailView.mainTextField.delegate = self
    self.mainScrollView.addSubview(agencyEMailView)
    
  }
  
  private func createAgencyAddressView() {
    
    let frameForCustomView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: agencyEMailView.frame.origin.y + agencyEMailView.frame.size.height + (16.0 * UtilityManager.sharedInstance.conversionHeight),
                                         width: self.frame.size.width,
                                         height: 78.0 * UtilityManager.sharedInstance.conversionHeight)
    
    agencyAddressView = CustomTextFieldWithTitleView.init(frame: frameForCustomView,
                                                        title: AgencyProfileEditConstants.ProfileView.agencyAddressTitleText,
                                                        image: "iconLocation")
    agencyAddressView.mainTextField.placeholder = "Dirección de contacto"
    agencyAddressView.mainTextField.tag = 4
    
    if AgencyModel.Data.address != nil {
      
      agencyAddressView.mainTextField.text = AgencyModel.Data.address!
      
    }
    
    agencyAddressView.backgroundColor = UIColor.clearColor()
    agencyAddressView.mainTextField.delegate = self
    self.mainScrollView.addSubview(agencyAddressView)
    
  }
  
  private func createAgencyWebsiteView() {
    
    let frameForCustomView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: agencyAddressView.frame.origin.y + agencyAddressView.frame.size.height + (16.0 * UtilityManager.sharedInstance.conversionHeight),
                                         width: self.frame.size.width,
                                         height: 78.0 * UtilityManager.sharedInstance.conversionHeight)
    
    agencyWebsiteView = CustomTextFieldWithTitleView.init(frame: frameForCustomView,
                                                          title: AgencyProfileEditConstants.ProfileView.agencyWebSiteTitleText,
                                                          image: "iconWebsite")
    agencyWebsiteView.mainTextField.placeholder = "http://www.ejemplo.com"
    agencyWebsiteView.mainTextField.tag = 5
    
    if AgencyModel.Data.website_url != nil {
      
      agencyWebsiteView.mainTextField.text = AgencyModel.Data.website_url!
      
    }
    
    agencyWebsiteView.backgroundColor = UIColor.clearColor()
    agencyWebsiteView.mainTextField.delegate = self
    self.mainScrollView.addSubview(agencyWebsiteView)
    
  }
  
  private func createNumberOfEmployeView() {
    
    let frameForCustomView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: agencyWebsiteView.frame.origin.y + agencyWebsiteView.frame.size.height + (16.0 * UtilityManager.sharedInstance.conversionHeight),
                                         width: self.frame.size.width,
                                         height: 78.0 * UtilityManager.sharedInstance.conversionHeight)
    
    agencyNumberOfEmployees = CustomTextFieldWithTitleView.init(frame: frameForCustomView,
                                                          title: AgencyProfileEditConstants.ProfileView.agencyNumberOfEmployeTitleText,
                                                          image: "smallGroup")
    agencyNumberOfEmployees.mainTextField.placeholder = "888"
    agencyNumberOfEmployees.mainTextField.tag = 6
    
    if AgencyModel.Data.num_employees != nil {
      
      agencyNumberOfEmployees.mainTextField.text = AgencyModel.Data.num_employees!
      
    }
    
    agencyNumberOfEmployees.mainTextField.keyboardType = .NumberPad
    agencyNumberOfEmployees.backgroundColor = UIColor.clearColor()
    agencyNumberOfEmployees.mainTextField.delegate = self
    
    let keyboardDoneButtonView = UIToolbar.init()
    keyboardDoneButtonView.sizeToFit()
    
    let doneButton = UIBarButtonItem(title: "Ok", style: UIBarButtonItemStyle.Done, target: self, action: #selector(dismissKeyboard))
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 20.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    doneButton.setTitleTextAttributes([NSFontAttributeName: font!,
                                      NSParagraphStyleAttributeName: style,
                                      NSForegroundColorAttributeName: color],
                                      forState: .Normal)
    
    keyboardDoneButtonView.items = [doneButton]
    agencyNumberOfEmployees.mainTextField.inputAccessoryView = keyboardDoneButtonView
    
    
    self.mainScrollView.addSubview(agencyNumberOfEmployees)
    
  }
  
  private func initGooglePlaces() {

    // Set up the autocomplete filter.
    let filter = GMSAutocompleteFilter()
    filter.type = .Address
    
    //Create the fetcher
    fetcher = GMSAutocompleteFetcher(bounds: nil, filter: filter)
    fetcher?.delegate = self
    
    agencyAddressView.mainTextField.addTarget(self,
                                              action: #selector(addressFieldDidChange),
                                    forControlEvents: .EditingChanged)
    
    let frameForResultText = CGRect(x: agencyAddressView.frame.origin.x,
                                    y: agencyAddressView.frame.origin.y + agencyAddressView.frame.size.height - (19.0 * UtilityManager.sharedInstance.conversionHeight),
                                    width: agencyAddressView.frame.size.width,
                                    height: 45.0 * UtilityManager.sharedInstance.conversionHeight)
    
    resultText = UITextView(frame: frameForResultText)
    resultText?.attributedText
    resultText?.backgroundColor = UIColor.whiteColor()
    resultText?.alpha = 0.0
    resultText?.editable = false
    
    let tapForResultText = UITapGestureRecognizer.init(target: self, action: #selector(selectDirectionFromGoogle))
    tapForResultText.numberOfTapsRequired = 1
    
    resultText?.addGestureRecognizer(tapForResultText)
    resultText?.userInteractionEnabled = true
    
    self.mainScrollView.addSubview(resultText!)
    
  }
  
  @objc private func addressFieldDidChange(textField: UITextField) {
    
    if resultText?.alpha == 0.0 {
      self.showResultText()
    } else {
    }
    
    fetcher?.sourceTextHasChanged(textField.text!)
    
  }
  
  private func showResultText() {
    
    UIView.animateWithDuration(0.35){
      
      self.resultText?.alpha = 1.0
      
    }
    
  }
  
  private func hideResultText() {
    
    UIView.animateWithDuration(0.35){
      
      self.resultText?.alpha = 0.0
      
    }
    
  }
  
  @objc private func selectDirectionFromGoogle() {
   
    agencyAddressView.mainTextField.text = resultText?.text
    
    if resultText?.alpha == 1.0 {
      
      self.hideResultText()
      
    }
    
    self.getCoordinates()
    
  }
  
  func didAutocompleteWithPredictions(predictions: [GMSAutocompletePrediction]) {
    
    resultText?.attributedText = predictions.first?.attributedFullText
    
    lastPredictionPlaceFromGoogle = predictions.first
    
  }
  
  private func getCoordinates() {
    
    let placesClient = GMSPlacesClient()
    
    let placeID = lastPredictionPlaceFromGoogle?.placeID
    if lastPredictionPlaceFromGoogle != nil {
      placesClient.lookUpPlaceID(placeID!, callback: { (place: GMSPlace?, error: NSError?) -> Void in
        if let error = error {
          print("lookup place id query error: \(error.localizedDescription)")
          return
        }
      
        if let place = place {
//          print("Place latitude: \(place.coordinate.latitude)")
//          print("Place longitude: \(place.coordinate.longitude)")
          
          self.agencyLatitude = String(place.coordinate.latitude)
          self.agencyLongitude = String(place.coordinate.longitude)
        } else {
          print("No place details for \(placeID)")
        }
      })
    }
    
  }
  
  @objc func dismissKeyboard(sender:AnyObject) {
    self.endEditing(true)
  }
  
  func didFailAutocompleteWithError(error: NSError) {
    
    resultText?.text = "No hay conexión con el servidor"
    
  }
  
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    
    if textField.tag == 2 {
      
      let  char = string.cStringUsingEncoding(NSUTF8StringEncoding)!
      let isBackSpace = strcmp(char, "\\b")
      
      if (isBackSpace == -92) {
        return true
      }
      
      if textField.text!.characters.count == 1 {
        
        textField.text = "+" + textField.text!
        
      }
      
      if textField.text!.characters.count == 3 {
        
        textField.text = textField.text! + " "
        
      }
      
      if textField.text!.characters.count == 4 {
        
        textField.text = textField.text! + "("
        
      }
      
      if textField.text!.characters.count == 7 {
        
        textField.text = textField.text! + ") "
        
      }
      
      if textField.text!.characters.count == 13 {
        
        textField.text = textField.text! + "."
        
      }
      
      if textField.text!.characters.count > 17 {
        
        return false
        
      }
      
    }
    
    return true
    
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
    
    thereAreChanges = true
    
    if textField.tag != 4 {
      
      self.hideResultText()
      
    }
  }
  
  @objc private func selectImageFromLibrary() {
    
    delegate?.selectProfileImageFromLibrary()
    
  }
  
  @objc private func askForDeleteProfileImage() {
    
    self.delegate?.asKForDeleteProfileImage()
    
  }
  
  func deleteProfileImage() {
    
    profileImageView.image = nil
    
  }
  
  func changeProfileImageView(image: UIImage) {
    
    profileImageView.image = image
    
  }
  
  func saveChangesOfAgencyProfile(valuesSelectedFromParticipateInView: [String:Bool], actionsToMakeAfterExecution: () -> Void) {
    
    let golden_pitch: String = (valuesSelectedFromParticipateInView["golden_pitch"] == true ? "1" : "0")
    let silver_pitch: String = (valuesSelectedFromParticipateInView["silver_pitch"] == true ? "1" : "0")
    let high_risk_pitch: String = (valuesSelectedFromParticipateInView["high_risk_pitch"] == true ? "1" : "0")
    let medium_risk_pitch: String = (valuesSelectedFromParticipateInView["medium_risk_pitch"] == true ? "1" : "0")
    
    var finalWebsiteURL = ""
    
    if UtilityManager.sharedInstance.isValidText(agencyWebsiteView.mainTextField.text!) {
      
      finalWebsiteURL = self.transformURL(agencyWebsiteView.mainTextField.text!)
      
    }
  
    var parameters: [String:AnyObject]
    
    if agencyLongitude != nil && agencyLatitude != nil {
    
      if profileImageView.image != nil {
        
        let profileImage = profileImageView.image!
        let profileDataImage = UIImagePNGRepresentation(profileImage)

//    DELETE IN FUTURE
//        print(agencyNameView.mainTextField.text!)
//        print(agencyPhoneView.mainTextField.text!)
//        print(agencyAddressView.mainTextField.text!)
//        print(agencyLatitude!)
//        print(agencyLongitude!)
//        print(agencyWebsiteView.mainTextField.text!)
//        print(agencyNumberOfEmployees.mainTextField.text!)
        
        var imageName: String
        
        if AgencyModel.Data.name != nil && AgencyModel.Data.name != "" {
          
          imageName = "\(AgencyModel.Data.name)Image.png"
          
        } else {
         
          imageName = "AgencyImage.png"
          
        }
        
        parameters = [
          "id" : UserSession.session.agency_id,
          "auth_token": UserSession.session.auth_token,
          "filename" : imageName,
          "agency": [
            "name": agencyNameView.mainTextField.text!,
            "case_image": profileDataImage!,
            "phone": agencyPhoneView.mainTextField.text!,
            "contact_name": "",
            "contact_email": agencyEMailView.mainTextField.text!,
            "address": agencyAddressView.mainTextField.text!,
            "latitude": agencyLatitude!,
            "longitude": agencyLongitude!,
            "website_url": finalWebsiteURL,
            "num_employees": agencyNumberOfEmployees.mainTextField.text!,
            "golden_pitch": golden_pitch,
            "silver_pitch": silver_pitch,
            "high_risk_pitch": high_risk_pitch,
            "medium_risk_pitch": medium_risk_pitch
          ]
        ]
      } else {
        
        parameters = [
          "id" : UserSession.session.agency_id,
          "auth_token": UserSession.session.auth_token,
          "agency": [
            "name" : agencyNameView.mainTextField.text!,
            "phone": agencyPhoneView.mainTextField.text!,
            "contact_name": "",
            "contact_email": agencyEMailView.mainTextField.text!,
            "address": agencyAddressView.mainTextField.text!,
            "latitude": agencyLatitude!,
            "longitude": agencyLongitude!,
            "website_url": finalWebsiteURL,
            "num_employees": agencyNumberOfEmployees.mainTextField.text!,
            "golden_pitch": golden_pitch,
            "silver_pitch": silver_pitch,
            "high_risk_pitch": high_risk_pitch,
            "medium_risk_pitch": medium_risk_pitch
          ]
        ]
      }

      delegate?.saveChangesFromEditProfileView(parameters, actionsToMakeAfterExecution: actionsToMakeAfterExecution)
      
    }else{
      
      if profileImageView.image != nil {
        
        let profileImage = profileImageView.image!
        let profileDataImage = UIImagePNGRepresentation(profileImage)
        
        var imageName: String
        
        if AgencyModel.Data.name != nil && AgencyModel.Data.name != "" {
          
          imageName = "\(AgencyModel.Data.name)Image.png"
          
        } else {
          
          imageName = "AgencyImage.png"
          
        }
        
        parameters = [
          "id" : UserSession.session.agency_id,
          "auth_token": UserSession.session.auth_token,
          "filename" : imageName,
          "agency": [
            "name": agencyNameView.mainTextField.text!,
            "case_image": profileDataImage!,
            "phone": agencyPhoneView.mainTextField.text!,
            "contact_name": "",
            "contact_email": agencyEMailView.mainTextField.text!,
            "address": agencyAddressView.mainTextField.text!,
            "website_url": finalWebsiteURL,
            "num_employees": agencyNumberOfEmployees.mainTextField.text!,
            "golden_pitch": golden_pitch,
            "silver_pitch": silver_pitch,
            "high_risk_pitch": high_risk_pitch,
            "medium_risk_pitch": medium_risk_pitch
          ]
        ]
      } else {
        
        parameters = [
          "id" : UserSession.session.agency_id,
          "auth_token": UserSession.session.auth_token,
          "agency": [
            "name" : agencyNameView.mainTextField.text!,
            "phone": agencyPhoneView.mainTextField.text!,
            "contact_name": "",
            "contact_email": agencyEMailView.mainTextField.text!,
            "address": agencyAddressView.mainTextField.text!,
            "website_url": finalWebsiteURL,
            "num_employees": agencyNumberOfEmployees.mainTextField.text!,
            "golden_pitch": golden_pitch,
            "silver_pitch": silver_pitch,
            "high_risk_pitch": high_risk_pitch,
            "medium_risk_pitch": medium_risk_pitch
          ]
        ]
      }
      
      self.delegate?.saveChangesFromEditProfileView(parameters, actionsToMakeAfterExecution: actionsToMakeAfterExecution)
      
    }
  }
  
  private func transformURL(urlToCheck: String) -> String {
    
    let isURLOk = UIApplication.sharedApplication().canOpenURL(NSURL.init(string: urlToCheck)!)
    
    var finalURL = urlToCheck
    
    if isURLOk == false {
      
      if finalURL.rangeOfString("www.") == nil {
        
        finalURL = "www." + finalURL
        
      }
      if finalURL.rangeOfString("http://") == nil {
        
        finalURL = "http://" + finalURL
        
      }
      
    }
    
    return finalURL
    
  }
  
}
