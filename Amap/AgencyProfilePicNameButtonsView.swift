//
//  AgencyProfilePicNameButtons.swift
//  Amap
//
//  Created by Alejandro Aristi C on 8/31/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol AgencyProfilePicNameButtonsViewDelegate {
  
  func mailIconButtonPressed()
  func telephoneIconButtonPressed()
  func weblinkIconButtonPressed()
  func locationIconButtonPressed()
  
}

class AgencyProfilePicNameButtonsView: UIView {
  
  private var containerView: UIView! = nil
  private var agencyProfilePicImageView: UIImageView! = nil
  private var agencyNameLabel: UILabel! = nil
  private var mailIconButton: UIButton! = nil
  private var telephoneIconButton: UIButton! = nil
  private var websiteIconButton: UIButton! = nil
  private var locationIconButton: UIButton! = nil
  
  private var arrayOfExistingButtons = [UIButton]()
  
  var delegate: AgencyProfilePicNameButtonsViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.initInterface()
  }
  
  private func initInterface() {
    
    self.createContainerView()
    self.createAgencyProfilePicImageView()
    self.createAgencyNameLabel()
    
    if AgencyModel.Data.contact_email != nil && UtilityManager.sharedInstance.isValidEmail(AgencyModel.Data.contact_email!){
    
      self.createMailIconButton()
      
    }
    
    if AgencyModel.Data.phone != nil && UtilityManager.sharedInstance.isValidText(AgencyModel.Data.phone){
      
      self.createTelephoneIconButton()
      
    }
    
    if AgencyModel.Data.website_url != nil && UIApplication.sharedApplication().canOpenURL(NSURL.init(string: AgencyModel.Data.website_url!)!) {
     
      self.createWebsiteIconButton()
      
    }
    
    if AgencyModel.Data.longitude != nil && AgencyModel.Data.latitude != nil && AgencyModel.Data.address != nil && UtilityManager.sharedInstance.isValidText(AgencyModel.Data.address!) && AgencyModel.Data.address != "" {
      
      self.createLocationIconButton()
      
    }
    
    self.addAllExistingButtons()
    
    self.createLineOfBottom()
    
  }
  
  private func createContainerView() {
    
    let frameForContainer = CGRect.init(x: 0.0,
                                        y: 0.0,
                                    width: self.frame.size.width,
                                   height: self.frame.size.height)
    
    containerView = UIView.init(frame: frameForContainer)
    containerView.backgroundColor = UIColor.clearColor()
    self.addSubview(containerView)
    
  }
  
  private func createAgencyProfilePicImageView() {
    
    let frameForProfileImageView = CGRect.init(x: 0.0,
                                               y: 0.0,
                                               width: 48.0 * UtilityManager.sharedInstance.conversionWidth,
                                               height: 48.0 * UtilityManager.sharedInstance.conversionHeight)
    
    agencyProfilePicImageView = UIImageView.init(frame: frameForProfileImageView)
    agencyProfilePicImageView.backgroundColor = UIColor.lightGrayColor()
    agencyProfilePicImageView.layer.borderWidth = 0.35
    agencyProfilePicImageView.layer.masksToBounds = false
    agencyProfilePicImageView.layer.borderColor = UIColor.blackColor().CGColor
    agencyProfilePicImageView.layer.cornerRadius = agencyProfilePicImageView.frame.size.height / 2.0
    agencyProfilePicImageView.clipsToBounds = true
    agencyProfilePicImageView.userInteractionEnabled = true
    
    if AgencyModel.Data.logo != nil {
      
      agencyProfilePicImageView.imageFromUrl(AgencyModel.Data.logo!)
      
    }
    
    containerView.addSubview(agencyProfilePicImageView)
    
  }
  
  private func createAgencyNameLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 156.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    agencyNameLabel = UILabel.init(frame: frameForLabel)
    agencyNameLabel.numberOfLines = 2
    agencyNameLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    var agencyName: String
    if AgencyModel.Data.name != nil {
      agencyName = AgencyModel.Data.name!
    }else{
      agencyName = "Nombre de Agencia"
    }
    
    let stringWithFormat = NSMutableAttributedString(
      string: agencyName,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    agencyNameLabel.attributedText = stringWithFormat
    agencyNameLabel.sizeToFit()
    let newFrame = CGRect.init(x: 63.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 9.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: agencyNameLabel.frame.size.width,
                               height: agencyNameLabel.frame.size.height)
    
    agencyNameLabel.frame = newFrame
    
    containerView.addSubview(agencyNameLabel)
    
  }
  
  private func createMailIconButton() {
    
    let frameForButton = CGRect.init(x: 7.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 82.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 24.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 16.0 * UtilityManager.sharedInstance.conversionHeight)
    
    mailIconButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "iconMailBlack") as UIImage?
    mailIconButton.setImage(image, forState: .Normal)
    
    mailIconButton.backgroundColor = UIColor.clearColor()
    mailIconButton.tag = 1
    mailIconButton.addTarget(self, action: #selector(mailIconPressed), forControlEvents:.TouchUpInside)
    
    //containerView.addSubview(mailIconButton)
    arrayOfExistingButtons.append(mailIconButton)
    
  }
  
  private func createTelephoneIconButton() {
    
    let frameForButton = CGRect.init(x: 71.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 78.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 24.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 24.0 * UtilityManager.sharedInstance.conversionHeight)
    
    telephoneIconButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "iconPhoneBlack") as UIImage?
    telephoneIconButton.setImage(image, forState: .Normal)
    telephoneIconButton.tag = 2
    telephoneIconButton.addTarget(self, action: #selector(telephoneIconPressed), forControlEvents:.TouchUpInside)
    
//    containerView.addSubview(telephoneIconButton)
    arrayOfExistingButtons.append(telephoneIconButton)
    
  }
  
  private func createWebsiteIconButton() {
    
    let frameForButton = CGRect.init(x: 135.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 79.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 24.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 19.0 * UtilityManager.sharedInstance.conversionHeight)
    
    websiteIconButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "iconWebsiteBlack") as UIImage?
    websiteIconButton.setImage(image, forState: .Normal)
    websiteIconButton.tag = 3
    websiteIconButton.addTarget(self, action: #selector(websiteIconPressed), forControlEvents:.TouchUpInside)
    
//    containerView.addSubview(websiteIconButton)
    arrayOfExistingButtons.append(websiteIconButton)
    
  }
  
  private func createLocationIconButton() {
    
    let frameForButton = CGRect.init(x: 199.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 78.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 15.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 24.0 * UtilityManager.sharedInstance.conversionHeight)
    
    locationIconButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "iconLocationBlack") as UIImage?
    locationIconButton.setImage(image, forState: .Normal)
    locationIconButton.tag = 4
    locationIconButton.addTarget(self, action: #selector(locationIconPressed), forControlEvents:.TouchUpInside)
    
//    containerView.addSubview(locationIconButton)
    arrayOfExistingButtons.append(locationIconButton)
    
  }
  
  private func addAllExistingButtons() {
    
    var frameForButton = CGRect.init(x: 7.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 0.0,
                                     width: 0.0,
                                     height: 0.0)
    
    for index in 0..<(arrayOfExistingButtons.count - 1) {
      
      
      let actualButton = arrayOfExistingButtons[index]
      
      frameForButton = CGRect.init(x: frameForButton.origin.x,
                                   y: actualButton.frame.origin.y,
                                   width: actualButton.frame.size.width,
                                   height: actualButton.frame.size.height)
      
      actualButton.frame = frameForButton
      containerView.addSubview(actualButton)
  
      frameForButton = CGRect.init(x: frameForButton.origin.x + (64.0 * UtilityManager.sharedInstance.conversionWidth),
                                   y: 0.0,
                               width: 0.0,
                              height: 0.0)
      
    }
    
    if arrayOfExistingButtons.last != nil {
      
      let actualButton = arrayOfExistingButtons.last!
      
      frameForButton = CGRect.init(x: frameForButton.origin.x,
                                   y: actualButton.frame.origin.y,
                                   width: actualButton.frame.size.width,
                                   height: actualButton.frame.size.height)
      
      actualButton.frame = frameForButton
      containerView.addSubview(actualButton)
      
    }
    
  }
  
  private func createLineOfBottom() {
    
    let border = CALayer()
    let width = CGFloat(1)
    border.borderColor = UIColor.darkGrayColor().CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 0.0,
                               y: self.frame.size.height - (2.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: self.frame.size.width,
                               height: 1.0)
    containerView.layer.addSublayer(border)
    containerView.layer.masksToBounds = false
    
  }
  
  @objc private func mailIconPressed() {
    
    self.delegate?.mailIconButtonPressed()
    
  }
  
  @objc private func telephoneIconPressed() {
    
    self.delegate?.telephoneIconButtonPressed()
    
  }
  
  @objc private func websiteIconPressed() {
    
    self.delegate?.weblinkIconButtonPressed()
    
  }
  
  @objc private func locationIconPressed() {
    
    self.delegate?.locationIconButtonPressed()
    
  }
  
  
}
