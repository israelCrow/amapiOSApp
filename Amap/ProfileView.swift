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
    self.initInterface()
    
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
                                             width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                             height: 374.0 * UtilityManager.sharedInstance.conversionHeight)//Value that I considered
    let sizeForContentScrollView = CGSize.init(width: frameForMainScrollView.size.width,
                                               height: frameForMainScrollView.size.height + (150.0 * UtilityManager.sharedInstance.conversionHeight))//Value that i considered
    
    mainScrollView = UIScrollView.init(frame: frameForMainScrollView)
    mainScrollView.backgroundColor = UIColor.clearColor()
    mainScrollView.contentSize = sizeForContentScrollView
    mainScrollView.directionalLockEnabled = true
    mainScrollView.alwaysBounceVertical = true
    mainScrollView.showsVerticalScrollIndicator = false
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
                                     y: changeProfileImageButton.frame.origin.y + changeProfileImageButton.frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: 116.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: ((13.0 + 4.0) * UtilityManager.sharedInstance.conversionHeight))
    deleteProfileImageButton = UIButton.init(frame: frameForButton)
    deleteProfileImageButton.addTarget(self,
                                       action: #selector(deleteProfileImage),
                                       forControlEvents: .TouchUpInside)
    deleteProfileImageButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    
    self.mainScrollView.addSubview(deleteProfileImageButton)
    
  }
  
  private func createAgencyNameView() {
    
    let frameForCustomView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                             y: 55.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: self.frame.size.width,
                                        height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
    
    agencyNameView = CustomTextFieldWithTitleView.init(frame: frameForCustomView, title: nil, image: nil)
    agencyNameView.mainTextField.placeholder = "Nombre de la agencia"
    agencyNameView.backgroundColor = UIColor.clearColor()
    agencyNameView.mainTextField.delegate = self
    self.mainScrollView.addSubview(agencyNameView)
    
  }
  
  private func createAgencyPhoneView() {
    
    let frameForCustomView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                             y: agencyNameView.frame.origin.y + agencyNameView.frame.size.height,
                                             width: self.frame.size.width,
                                             height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    agencyPhoneView = CustomTextFieldWithTitleView.init(frame: frameForCustomView,
                                                        title: AgencyProfileEditConstants.ProfileView.agencyPhoneTitleText,
                                                        image: "skill")
    agencyPhoneView.mainTextField.placeholder = "00 00000000"
    agencyPhoneView.backgroundColor = UIColor.clearColor()
    agencyPhoneView.mainTextField.delegate = self
    self.mainScrollView.addSubview(agencyPhoneView)
    
  }
  
  private func createAgencyContactView() {
    
    let frameForCustomView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: agencyPhoneView.frame.origin.y + agencyPhoneView.frame.size.height,
                                         width: self.frame.size.width,
                                         height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    agencyContactView = CustomTextFieldWithTitleView.init(frame: frameForCustomView,
                                                        title: AgencyProfileEditConstants.ProfileView.agencyContactTitleText,
                                                        image: nil)
    agencyContactView.mainTextField.placeholder = "Nombre de contacto"
    agencyContactView.backgroundColor = UIColor.clearColor()
    agencyContactView.mainTextField.delegate = self
    self.mainScrollView.addSubview(agencyContactView)
    
  }
  
  private func createAgencyEMailView() {
  
    let frameForCustomView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: agencyPhoneView.frame.origin.y + agencyPhoneView.frame.size.height,
                                         width: self.frame.size.width,
                                         height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
    
    agencyEMailView = CustomTextFieldWithTitleView.init(frame: frameForCustomView,
                                                          title: nil,
                                                          image: "skill")
    agencyEMailView.mainTextField.placeholder = "Email de contacto"
    agencyEMailView.backgroundColor = UIColor.clearColor()
    agencyEMailView.mainTextField.delegate = self
    self.mainScrollView.addSubview(agencyEMailView)
    
  }
  
  private func createAgencyAddressView() {
    
    let frameForCustomView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: agencyEMailView.frame.origin.y + agencyEMailView.frame.size.height,
                                         width: self.frame.size.width,
                                         height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    agencyAddressView = CustomTextFieldWithTitleView.init(frame: frameForCustomView,
                                                        title: AgencyProfileEditConstants.ProfileView.agencyAddressTitleText,
                                                        image: "skill")
    agencyAddressView.mainTextField.placeholder = "Dirección de contacto"
    agencyAddressView.mainTextField.tag = 9
    agencyAddressView.backgroundColor = UIColor.clearColor()
    agencyAddressView.mainTextField.delegate = self
    self.mainScrollView.addSubview(agencyAddressView)
    
  }
  
  private func createAgencyWebsiteView() {
    
    let frameForCustomView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: agencyAddressView.frame.origin.y + agencyAddressView.frame.size.height,
                                         width: self.frame.size.width,
                                         height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    agencyWebsiteView = CustomTextFieldWithTitleView.init(frame: frameForCustomView,
                                                          title: AgencyProfileEditConstants.ProfileView.agencyWebSiteTitleText,
                                                          image: "skill")
    agencyWebsiteView.mainTextField.placeholder = "Website de contacto"
    agencyWebsiteView.backgroundColor = UIColor.clearColor()
    agencyWebsiteView.mainTextField.delegate = self
    self.mainScrollView.addSubview(agencyWebsiteView)
    
  }
  
  private func createNumberOfEmployeView() {
    
    let frameForCustomView = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: agencyWebsiteView.frame.origin.y + agencyWebsiteView.frame.size.height,
                                         width: self.frame.size.width,
                                         height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    agencyNumberOfEmployees = CustomTextFieldWithTitleView.init(frame: frameForCustomView,
                                                          title: AgencyProfileEditConstants.ProfileView.agencyNumberOfEmployeTitleText,
                                                          image: "skill")
    agencyNumberOfEmployees.mainTextField.placeholder = "888"
    agencyNumberOfEmployees.backgroundColor = UIColor.clearColor()
    agencyNumberOfEmployees.mainTextField.delegate = self
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
                                    y: agencyAddressView.frame.origin.y + agencyAddressView.frame.size.height + (2.5 * UtilityManager.sharedInstance.conversionHeight),
                                    width: agencyAddressView.frame.size.width,
                                    height: 40.0 * UtilityManager.sharedInstance.conversionHeight)
    
    resultText = UITextView(frame: frameForResultText)
    resultText?.attributedText
    resultText?.backgroundColor = UIColor.lightGrayColor()
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
          print("Place latitude: \(place.coordinate.latitude)")
          print("Place longitude: \(place.coordinate.longitude)")
          
          self.agencyLatitude = String(place.coordinate.latitude)
          self.agencyLongitude = String(place.coordinate.longitude)
        } else {
          print("No place details for \(placeID)")
        }
      })
    }
    
  }
  
  func didFailAutocompleteWithError(error: NSError) {
    
    resultText?.text = "No hay conexión con el servidor"
    
  }
  
  func textFieldDidBeginEditing(textField: UITextField) {
    if textField.tag != 9 {
      
      self.hideResultText()
      
    }
  }
  
  @objc private func selectImageFromLibrary() {
    
    delegate?.selectProfileImageFromLibrary()
    
  }
  
  @objc private func deleteProfileImage() {
    
    profileImageView.image = nil
    
  }
  
  func changeProfileImageView(image: UIImage) {
    
    profileImageView.image = image
    
  }
  
  func saveChangesOfAgencyProfile() {
    
    var parameters = [String:AnyObject]()
    
    if agencyLongitude != nil && agencyLatitude != nil {
    
    let parameters = [
        "id" : 181,
        "auth_token": "5uKB2vzUY1vApmkQ9Vg_",
        "agency": [
          "name" : agencyNameView.mainTextField.text!,
          "phone": agencyPhoneView.mainTextField.text!,
          "contact_name": "",
          "contact_email": agencyEMailView.mainTextField.text!,
          "address": agencyAddressView.mainTextField.text!,
          "latitude": agencyLatitude,
          "longitude": agencyLongitude,
          "website_url": agencyWebsiteView.mainTextField.text!,
          "num_employees": agencyNumberOfEmployees.mainTextField.text!,
          "golden_pitch": "0",
          "silver_pitch": "0",
          "high_risk_pitch": "0",
          "medium_risk_pitch": "0"
        ]
      ]
    }else{
      let parameters = [
        "id" : 181,
        "auth_token": "5uKB2vzUY1vApmkQ9Vg_",
        "agency": [
          "name" : agencyNameView.mainTextField.text!,
          "phone": agencyPhoneView.mainTextField.text!,
          "contact_name": "",
          "contact_email": agencyEMailView.mainTextField.text!,
          "address": agencyAddressView.mainTextField.text!,
          "website_url": agencyWebsiteView.mainTextField.text!,
          "num_employees": agencyNumberOfEmployees.mainTextField.text!,
          "golden_pitch": "0",
          "silver_pitch": "0",
          "high_risk_pitch": "0",
          "medium_risk_pitch": "0"
        ]
      ]
      
    }
  }
  
}
