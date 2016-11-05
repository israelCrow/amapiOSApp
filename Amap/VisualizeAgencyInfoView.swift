//
//  VisualizeAgencyInfoView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/6/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class VisualizeAgencyInfoView: UIView {
  
  private var infoLabel: UILabel! = nil
  
  private var mailIconButton: UIButton! = nil
  private var telephoneIconButton: UIButton! = nil
  private var websiteIconButton: UIButton! = nil
  private var locationIconButton: UIButton! = nil
  private var employeesIconButton: UIButton! = nil
  
  private var mailLabel: UILabel! = nil
  private var telephoneLabel: UILabel! = nil
  private var websiteLabel: UILabel! = nil
  private var locationLabel: UILabel! = nil
  private var employeesLabel: UILabel! = nil
  
  private var arrayOfExistingButtons = [UIButton]()
  private var arrayOfExistingLabels = [UILabel]()
  
  var delegate: AgencyProfilePicNameButtonsViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.initInterface()
  }

  private func initInterface() {
    
    self.createInfoLabel()
    
    if AgencyModel.Data.contact_email != nil && UtilityManager.sharedInstance.isValidEmail(AgencyModel.Data.contact_email!){
      
      self.createMailIconButton()
      self.createMailLabel()
      
    }
    
    if AgencyModel.Data.phone != nil && UtilityManager.sharedInstance.isValidText(AgencyModel.Data.phone){
      
      self.createTelephoneIconButton()
      self.createTelephoneLabel()
      
    }
    
    if AgencyModel.Data.website_url != nil && UIApplication.sharedApplication().canOpenURL(NSURL.init(string: AgencyModel.Data.website_url!)!) {
      
      self.createWebsiteIconButton()
      self.createWebsiteLabel()
      
    }
    
    if AgencyModel.Data.longitude != nil && AgencyModel.Data.latitude != nil && AgencyModel.Data.address != nil && UtilityManager.sharedInstance.isValidText(AgencyModel.Data.address!) && AgencyModel.Data.address != "" {
      
      self.createLocationIconButton()
      self.createLocationLabel()
      
    }
    
    if AgencyModel.Data.num_employees != nil && UtilityManager.sharedInstance.isValidText(AgencyModel.Data.num_employees!){
      
      self.createEmployeesIconButton()
      self.createEmployeesLabel()
      
    }
    
    self.addAllExistingButtons()
    
  }
  
  private func createInfoLabel() {
    
    infoLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Info",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    infoLabel.attributedText = stringWithFormat
    infoLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (infoLabel.frame.size.width / 2.0),
                               y: 0.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: infoLabel.frame.size.width,
                               height: infoLabel.frame.size.height)
    
    infoLabel.frame = newFrame
    
    self.addSubview(infoLabel)
    
  }
  
  private func createMailIconButton() {
  
    let frameForButton = CGRect.init(x: 25.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 0.0,
                                     width: 24.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 16.0 * UtilityManager.sharedInstance.conversionHeight)
    
    mailIconButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "iconMailBlack") as UIImage?
    mailIconButton.setImage(image, forState: .Normal)
    
    mailIconButton.backgroundColor = UIColor.clearColor()
    mailIconButton.tag = 1
    mailIconButton.addTarget(self, action: #selector(mailIconPressed), forControlEvents:.TouchUpInside)
    
    arrayOfExistingButtons.append(mailIconButton)
    
  }
  
  private func createMailLabel() {
    
    let frameForLabel = CGRect.init(x: 66.0 * UtilityManager.sharedInstance.conversionWidth,
                                    y: 0.0,
                                    width: 200.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    mailLabel = UILabel.init(frame: frameForLabel)
    mailLabel.adjustsFontSizeToFitWidth = true
//    mailLabel.numberOfLines = 0
//    mailLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: AgencyModel.Data.contact_email!,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    mailLabel.attributedText = stringWithFormat
    mailLabel.sizeToFit()
    let newFrame = CGRect.init(x: 66.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 0.0,
                               width: mailLabel.frame.size.width,
                               height: mailLabel.frame.size.height)
    
    mailLabel.frame = newFrame
    
    let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(mailIconPressed))
    tapGesture.numberOfTapsRequired = 1
    mailLabel.userInteractionEnabled = true
    mailLabel.addGestureRecognizer(tapGesture)
    
    arrayOfExistingLabels.append(mailLabel)
    
  }
  
  private func createTelephoneIconButton() {
    
    let frameForButton = CGRect.init(x: 25.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 0.0,
                                     width: 24.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 24.0 * UtilityManager.sharedInstance.conversionHeight)
    
    telephoneIconButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "iconPhoneBlack") as UIImage?
    telephoneIconButton.setImage(image, forState: .Normal)
    telephoneIconButton.tag = 2
    telephoneIconButton.addTarget(self, action: #selector(telephoneIconPressed), forControlEvents:.TouchUpInside)
    
    arrayOfExistingButtons.append(telephoneIconButton)
    
  }
  
  private func createTelephoneLabel() {
    
    let frameForLabel = CGRect.init(x: 66.0 * UtilityManager.sharedInstance.conversionWidth,
                                    y: 0.0,
                                    width: 200.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    telephoneLabel = UILabel.init(frame: frameForLabel)
    telephoneLabel.adjustsFontSizeToFitWidth = true
//    telephoneLabel.numberOfLines = 0
//    telephoneLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: AgencyModel.Data.phone,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    telephoneLabel.attributedText = stringWithFormat
    telephoneLabel.sizeToFit()
    let newFrame = CGRect.init(x: 66.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 0.0,
                               width: telephoneLabel.frame.size.width,
                               height: telephoneLabel.frame.size.height)
    
    telephoneLabel.frame = newFrame
    
    let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(telephoneIconPressed))
    tapGesture.numberOfTapsRequired = 1
    telephoneLabel.userInteractionEnabled = true
    telephoneLabel.addGestureRecognizer(tapGesture)
    
    arrayOfExistingLabels.append(telephoneLabel)
    
  }
  
  private func createWebsiteIconButton() {
    
    let frameForButton = CGRect.init(x: 25.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 0.0,
                                     width: 24.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 19.0 * UtilityManager.sharedInstance.conversionHeight)
    
    websiteIconButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "iconWebsiteBlack") as UIImage?
    websiteIconButton.setImage(image, forState: .Normal)
    websiteIconButton.tag = 3
    websiteIconButton.addTarget(self, action: #selector(websiteIconPressed), forControlEvents:.TouchUpInside)
    
    arrayOfExistingButtons.append(websiteIconButton)
    
  }
  
  private func createWebsiteLabel() {
    
    let frameForLabel = CGRect.init(x: 66.0 * UtilityManager.sharedInstance.conversionWidth,
                                    y: 0.0,
                                    width: 200.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: 23.0 * UtilityManager.sharedInstance.conversionHeight)
    
    websiteLabel = UILabel.init(frame: frameForLabel)
    websiteLabel.adjustsFontSizeToFitWidth = true
//    websiteLabel.numberOfLines = 0
//    websiteLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: AgencyModel.Data.website_url!,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    websiteLabel.attributedText = stringWithFormat
//    websiteLabel.sizeToFit()
    let newFrame = CGRect.init(x: 66.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 0.0,
                               width: websiteLabel.frame.size.width,
                               height: websiteLabel.frame.size.height)
    
    websiteLabel.frame = newFrame
    
    let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(websiteIconPressed))
    tapGesture.numberOfTapsRequired = 1
    websiteLabel.userInteractionEnabled = true
    websiteLabel.addGestureRecognizer(tapGesture)
    
    arrayOfExistingLabels.append(websiteLabel)
    
  }
  
  private func createLocationIconButton() {
    
    let frameForButton = CGRect.init(x: 25.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 0.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 15.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 24.0 * UtilityManager.sharedInstance.conversionHeight)
    
    locationIconButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "iconLocationBlack") as UIImage?
    locationIconButton.setImage(image, forState: .Normal)
    locationIconButton.tag = 4
    locationIconButton.addTarget(self, action: #selector(locationIconPressed), forControlEvents:.TouchUpInside)
    
    arrayOfExistingButtons.append(locationIconButton)
    
  }
  
  private func createLocationLabel() {
    
    let frameForLabel = CGRect.init(x: 66.0 * UtilityManager.sharedInstance.conversionWidth,
                                    y: 0.0,
                                    width: 200.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: 46.0 * UtilityManager.sharedInstance.conversionHeight)
    
    locationLabel = UILabel.init(frame: frameForLabel)
    locationLabel.adjustsFontSizeToFitWidth = true
    locationLabel.numberOfLines = 0
    locationLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 13.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: AgencyModel.Data.address!,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    locationLabel.attributedText = stringWithFormat
    locationLabel.sizeToFit()
    let newFrame = CGRect.init(x: 66.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 0.0,
                               width: locationLabel.frame.size.width,
                               height: locationLabel.frame.size.height)
    
    locationLabel.frame = newFrame
    
    let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(locationIconPressed))
    tapGesture.numberOfTapsRequired = 1
    locationLabel.userInteractionEnabled = true
    locationLabel.addGestureRecognizer(tapGesture)
    
    arrayOfExistingLabels.append(locationLabel)
    
  }
  
  private func createEmployeesIconButton() {
    
    let frameForButton = CGRect.init(x: 25.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 0.0,
                                     width: 28.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 23.0 * UtilityManager.sharedInstance.conversionHeight)
    
    employeesIconButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "smallGroup") as UIImage?
    employeesIconButton.setImage(image, forState: .Normal)
    employeesIconButton.tag = 5
    employeesIconButton.addTarget(self, action: #selector(websiteIconPressed), forControlEvents:.TouchUpInside)
    
    arrayOfExistingButtons.append(employeesIconButton)
    
  }
  
  private func createEmployeesLabel() {
    
    let frameForLabel = CGRect.init(x: 66.0 * UtilityManager.sharedInstance.conversionWidth,
                                    y: 0.0,
                                    width: 200.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: 23.0 * UtilityManager.sharedInstance.conversionHeight)
    
    employeesLabel = UILabel.init(frame: frameForLabel)
    employeesLabel.adjustsFontSizeToFitWidth = true
    //    websiteLabel.numberOfLines = 0
    //    websiteLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: AgencyModel.Data.num_employees!,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    employeesLabel.attributedText = stringWithFormat
    //    websiteLabel.sizeToFit()
    let newFrame = CGRect.init(x: 66.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 0.0,
                               width: employeesLabel.frame.size.width,
                               height: employeesLabel.frame.size.height)
    
    employeesLabel.frame = newFrame
    
    let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: nil)
    tapGesture.numberOfTapsRequired = 1
    employeesLabel.userInteractionEnabled = true
    employeesLabel.addGestureRecognizer(tapGesture)
    
    arrayOfExistingLabels.append(employeesLabel)
    
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
  
  private func addAllExistingButtons() {
    
    var frameForButton = CGRect.init(x: 0.0,
                                     y: 61.0,
                                     width: 0.0,
                                     height: 0.0)
    
    var frameForLabel = CGRect.init(x: 0.0,
                                    y: 61.0,
                                    width: 0.0,
                                    height: 0.0)
    
      
    for index in 0..<(arrayOfExistingButtons.count - 1) {
      
      
      let actualButton = arrayOfExistingButtons[index]
      let actualLabel = arrayOfExistingLabels[index]
      
      frameForButton = CGRect.init(x: actualButton.frame.origin.x,
                                   y: frameForButton.origin.y,
                                   width: actualButton.frame.size.width,
                                   height: actualButton.frame.size.height)
      
      frameForLabel = CGRect.init(x: actualLabel.frame.origin.x,
                                  y: frameForLabel.origin.y,
                              width: actualLabel.frame.size.width,
                             height: actualLabel.frame.size.height)
      
      actualButton.frame = frameForButton
      actualLabel.frame = frameForLabel
      
      self.addSubview(actualButton)
      self.addSubview(actualLabel)
      
      frameForButton = CGRect.init(x: 0.0,
                                   y: frameForButton.origin.y + actualButton.frame.size.height + (32.33 * UtilityManager.sharedInstance.conversionHeight),
                                   width: 0.0,
                                   height: 0.0)
      
      frameForLabel = CGRect.init(x: 0.0,
                                  y: frameForLabel.origin.y + actualLabel.frame.size.height + (30.25 * UtilityManager.sharedInstance.conversionHeight),
                                  width: 0.0,
                                  height: 0.0)
      
    }
    
    if arrayOfExistingButtons.last != nil {
      
      let actualButton = arrayOfExistingButtons.last!
      let actualLabel = arrayOfExistingLabels.last!
      
      frameForButton = CGRect.init(x: actualButton.frame.origin.x,
                                   y: frameForButton.origin.y,
                                   width: actualButton.frame.size.width,
                                   height: actualButton.frame.size.height)
      
      frameForLabel = CGRect.init(x: actualLabel.frame.origin.x,
                                  y: frameForLabel.origin.y,
                                  width: actualLabel.frame.size.width,
                                  height: actualLabel.frame.size.height)

      
      actualButton.frame = frameForButton
      actualLabel.frame = frameForLabel
      
      self.addSubview(actualButton)
      self.addSubview(actualLabel)
      
    }
    
  }
  
}