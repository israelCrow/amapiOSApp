//
//  DetailedInfoCompanyContactView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 12/9/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol DetailedInfoCompanyContactViewDelegate {
  
  func mailIconPressedFromDetailedInfoView()
  
}

class DetailedInfoCompanyContactView: UIView {
  
  private var companyLogoView: UIImageView! = nil
  private var mailIconButton: UIButton! = nil
  private var companyNameLabel: UILabel! = nil
  private var contactNameLabel: UILabel! = nil
  private var contactPositionLabel: UILabel! = nil
  
  var delegate: DetailedInfoCompanyContactViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.createCompanyLogoView()
    self.createCompanyNameLabel()
    
    if MyCompanyModelData.Data.contactEMail != nil && UtilityManager.sharedInstance.isValidEmail(MyCompanyModelData.Data.contactEMail) == true {
      
      self.createLetterButton()
      
    }
    
    
    self.createContactNameLabel()
    self.createContactPositionLabel()
    
  }
  
  private func createCompanyLogoView() {
    
    if companyLogoView != nil {
      
      companyLogoView.removeFromSuperview()
      companyLogoView = nil
      
    }
    
    let frameForProfileImageView = CGRect.init(x: 0.0,
                                               y: 0.0,
                                               width: 48.0 * UtilityManager.sharedInstance.conversionWidth,
                                               height: 48.0 * UtilityManager.sharedInstance.conversionHeight)
    
    companyLogoView = UIImageView.init(frame: frameForProfileImageView)
    companyLogoView.backgroundColor = UIColor.lightGrayColor()
    companyLogoView.layer.borderWidth = 0.35
    companyLogoView.layer.masksToBounds = false
    companyLogoView.layer.borderColor = UIColor.blackColor().CGColor
    companyLogoView.layer.cornerRadius = companyLogoView.frame.size.height / 2.0
    companyLogoView.clipsToBounds = true
    companyLogoView.userInteractionEnabled = true
    
    if MyCompanyModelData.Data.logoURL != "" {
      
      companyLogoView.imageFromUrl(MyCompanyModelData.Data.logoURL!)
      
    }
    
    self.addSubview(companyLogoView)
    
  }
  
  private func createCompanyNameLabel() {
    
    if companyNameLabel != nil {
      
      companyNameLabel.removeFromSuperview()
      companyNameLabel = nil
      
      
    }
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 156.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    companyNameLabel = UILabel.init(frame: frameForLabel)
    companyNameLabel.numberOfLines = 2
    companyNameLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center

    let stringWithFormat = NSMutableAttributedString(
      string: MyCompanyModelData.Data.name,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    companyNameLabel.attributedText = stringWithFormat
    companyNameLabel.sizeToFit()
    let newFrame = CGRect.init(x: 63.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 9.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: companyNameLabel.frame.size.width,
                               height: companyNameLabel.frame.size.height)
    
    companyNameLabel.frame = newFrame
    
    self.addSubview(companyNameLabel)
    
  }
  
  private func createContactNameLabel() {
    
    if contactNameLabel != nil {
      
      contactNameLabel.removeFromSuperview()
      contactNameLabel = nil
      
    }
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 165.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    contactNameLabel = UILabel.init(frame: frameForLabel)
    contactNameLabel.numberOfLines = 2
    contactNameLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: MyCompanyModelData.Data.contactName,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    contactNameLabel.attributedText = stringWithFormat
    contactNameLabel.sizeToFit()
    let newFrame = CGRect.init(x: 44.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 78.0 * UtilityManager.sharedInstance.conversionHeight,
                           width: contactNameLabel.frame.size.width,
                          height: contactNameLabel.frame.size.height)
    
    contactNameLabel.frame = newFrame
    
    self.addSubview(contactNameLabel)
    
  }
  
  private func createContactPositionLabel() {
    
    if contactPositionLabel != nil {
      
      contactPositionLabel.removeFromSuperview()
      contactPositionLabel = nil
      
    }
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                width: 165.0 * UtilityManager.sharedInstance.conversionWidth,
                               height: CGFloat.max)
    
    contactPositionLabel = UILabel.init(frame: frameForLabel)
    contactPositionLabel.numberOfLines = 2
    contactPositionLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: MyCompanyModelData.Data.contactPosition,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    contactPositionLabel.attributedText = stringWithFormat
    contactPositionLabel.sizeToFit()
    let newFrame = CGRect.init(x: 44.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 111.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: contactPositionLabel.frame.size.width,
                               height: contactPositionLabel.frame.size.height)
    
    contactPositionLabel.frame = newFrame
    
    self.addSubview(contactPositionLabel)
    
  }
  
  private func createLetterButton() {
    
    let frameForButton = CGRect.init(x: 0.0,
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
    self.addSubview(mailIconButton)
    
  }
  
  @objc private func mailIconPressed() {
    
    self.delegate?.mailIconPressedFromDetailedInfoView()
    
  }
  
  func reloadDataToShow(reloadImage: Bool) {
    

    self.createCompanyLogoView()
    self.createCompanyNameLabel()
    self.createContactNameLabel()
    self.createContactPositionLabel()
    
  }
  
}
