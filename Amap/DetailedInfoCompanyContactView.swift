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
  private var companyNameLabel: UILabel! = nil
  
  private var contactNameLabel: UILabel! = nil
  private var contactPositionLabel: UILabel! = nil
  private var mailLabel: UILabel! = nil
  private var mailIconButton: UIButton! = nil
  private var toolBoxCompanyButton: UIButton! = nil
  private var faceCompanyButton: UIButton! = nil
  
  private var arrayOfButtons = [UIButton]()
  
  var delegate: DetailedInfoCompanyContactViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.deleteAllElements()
    
    self.createCompanyLogoView()
    self.createCompanyNameLabel()
    
    arrayOfButtons.removeAll()
    
    if MyCompanyModelData.Data.contactName != nil && MyCompanyModelData.Data.contactName != "" {
      
      self.createFaceCompanyButton()
      self.createContactNameLabel()
      
    }
    
    if MyCompanyModelData.Data.contactPosition != nil && MyCompanyModelData.Data.contactPosition != "" {
      
      self.createToolBoxButton()
      self.createContactPositionLabel()
      
    }
    
    var finalMail = ""
    
    if MyCompanyModelData.Data.contactEMail != nil {
      
      finalMail = MyCompanyModelData.Data.contactEMail!
      let whiteSpace = NSCharacterSet.whitespaceAndNewlineCharacterSet()
      finalMail = finalMail.stringByTrimmingCharactersInSet(whiteSpace)
      
    }
    
    if MyCompanyModelData.Data.contactEMail != nil && UtilityManager.sharedInstance.isValidEmail(finalMail) == true {
      
      self.createLetterButton()
      self.createMailLabel()
      
    }
    
  }
  
  private func createCompanyLogoView() {
    
    if companyLogoView != nil {
      
      companyLogoView.removeFromSuperview()
      companyLogoView = nil
      
    }
    
    let frameForProfileImageView = CGRect.init(x: 88.0 * UtilityManager.sharedInstance.conversionWidth,
                                               y: 0.0,
                                               width: 70.0 * UtilityManager.sharedInstance.conversionWidth,
                                               height: 70.0 * UtilityManager.sharedInstance.conversionHeight)
    
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
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
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
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (companyNameLabel.frame.size.width / 2.0),
                               y: companyLogoView.frame.origin.y + companyLogoView.frame.size.height + (10.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: companyNameLabel.frame.size.width,
                               height: companyNameLabel.frame.size.height)
    
    companyNameLabel.frame = newFrame
    
    self.addSubview(companyNameLabel)
    
    let border = CALayer()
    let width = CGFloat(1)
    border.borderColor = UIColor.darkGrayColor().CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 12.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: companyNameLabel.frame.origin.y + companyNameLabel.frame.size.height + (6.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                               height: 1.0)
    self.layer.addSublayer(border)
    
  }
  
  private func createFaceCompanyButton() {
  
    var frameForButton = CGRect.init(x: 0.0,
                                     y: companyNameLabel.frame.origin.y + companyNameLabel.frame.size.height + (37.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: 24.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 26.0 * UtilityManager.sharedInstance.conversionHeight)
    
    if arrayOfButtons.last != nil {
      
      frameForButton = CGRect.init(x: 0.0,
                                   y: arrayOfButtons.last!.frame.origin.y + arrayOfButtons.last!.frame.size.height + (32.0 * UtilityManager.sharedInstance.conversionHeight),
                                  width: 24.0 * UtilityManager.sharedInstance.conversionWidth,
                                  height: 26.0 * UtilityManager.sharedInstance.conversionHeight)
      
    }
    
    faceCompanyButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "faceCompany") as UIImage?
    faceCompanyButton.setImage(image, forState: .Normal)
    
    faceCompanyButton.backgroundColor = UIColor.clearColor()
    faceCompanyButton.tag = 1
    faceCompanyButton.addTarget(self, action:nil, forControlEvents:.TouchUpInside)
    
    //containerView.addSubview(mailIconButton)
    self.addSubview(faceCompanyButton)
    
    arrayOfButtons.append(faceCompanyButton)
  
  }
  
  private func createContactNameLabel() {
    
    if contactNameLabel != nil {
      
      contactNameLabel.removeFromSuperview()
      contactNameLabel = nil
      
    }
    
    let frameForLabel = CGRect.init(x: faceCompanyButton.frame.origin.x + faceCompanyButton.frame.size.width + (18.5 * UtilityManager.sharedInstance.conversionWidth),
                                    y: faceCompanyButton.frame.origin.y + (1.0 * UtilityManager.sharedInstance.conversionHeight),
                                    width: self.frame.size.width - (50.0 * UtilityManager.sharedInstance.conversionWidth),
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
    let newFrame = CGRect.init(x: faceCompanyButton.frame.origin.x + faceCompanyButton.frame.size.width + (18.5 * UtilityManager.sharedInstance.conversionWidth),
                               y: faceCompanyButton.frame.origin.y + (1.0 * UtilityManager.sharedInstance.conversionHeight),
                           width: contactNameLabel.frame.size.width,
                          height: contactNameLabel.frame.size.height)
    
    contactNameLabel.frame = newFrame
    
    self.addSubview(contactNameLabel)
    
  }
  
  private func createToolBoxButton() {
    
    var frameForButton = CGRect.init(x: 0.0,
                                     y: companyNameLabel.frame.origin.y + companyNameLabel.frame.size.height + (37.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: 24.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 26.0 * UtilityManager.sharedInstance.conversionHeight)
    
    if arrayOfButtons.last != nil {
      
      frameForButton = CGRect.init(x: 0.0,
                                   y: arrayOfButtons.last!.frame.origin.y + arrayOfButtons.last!.frame.size.height + (32.0 * UtilityManager.sharedInstance.conversionHeight),
                                   width: 24.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 26.0 * UtilityManager.sharedInstance.conversionHeight)
      
    }
    
    toolBoxCompanyButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "toolBoxCompany") as UIImage?
    toolBoxCompanyButton.setImage(image, forState: .Normal)
    
    toolBoxCompanyButton.backgroundColor = UIColor.clearColor()
    toolBoxCompanyButton.tag = 2
    toolBoxCompanyButton.addTarget(self, action:nil, forControlEvents:.TouchUpInside)
    
    //containerView.addSubview(mailIconButton)
    self.addSubview(toolBoxCompanyButton)
    
    arrayOfButtons.append(toolBoxCompanyButton)
    
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
    let newFrame = CGRect.init(x: toolBoxCompanyButton.frame.origin.x + toolBoxCompanyButton.frame.size.width + (18.5 * UtilityManager.sharedInstance.conversionWidth),
                               y: toolBoxCompanyButton.frame.origin.y + (5.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: contactPositionLabel.frame.size.width,
                               height: contactPositionLabel.frame.size.height)
    
    contactPositionLabel.frame = newFrame
    
    self.addSubview(contactPositionLabel)
    
  }
  
  private func createLetterButton() {
    
    var frameForButton = CGRect.init(x: 0.0,
                                     y: companyNameLabel.frame.origin.y + companyNameLabel.frame.size.height + (37.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: 24.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 26.0 * UtilityManager.sharedInstance.conversionHeight)
    
    if arrayOfButtons.last != nil {
      
      frameForButton = CGRect.init(x: 0.0,
                                   y: arrayOfButtons.last!.frame.origin.y + arrayOfButtons.last!.frame.size.height + (32.0 * UtilityManager.sharedInstance.conversionHeight),
                                   width: 24.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 26.0 * UtilityManager.sharedInstance.conversionHeight)
      
    }
    
    mailIconButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "iconMailBlack") as UIImage?
    mailIconButton.setImage(image, forState: .Normal)
    
    mailIconButton.backgroundColor = UIColor.clearColor()
    mailIconButton.tag = 1
    mailIconButton.addTarget(self, action: #selector(mailIconPressed), forControlEvents:.TouchUpInside)
    
    //containerView.addSubview(mailIconButton)
    self.addSubview(mailIconButton)
    
    arrayOfButtons.append(mailIconButton)
    
  }
  
  private func createMailLabel() {
    
    if mailLabel != nil {
      
      mailLabel.removeFromSuperview()
      mailLabel = nil
      
    }
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 165.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    mailLabel = UILabel.init(frame: frameForLabel)
    mailLabel.numberOfLines = 2
    mailLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: MyCompanyModelData.Data.contactEMail,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    mailLabel.attributedText = stringWithFormat
    mailLabel.sizeToFit()
    let newFrame = CGRect.init(x: mailIconButton.frame.origin.x + mailIconButton.frame.size.width + (18.5 * UtilityManager.sharedInstance.conversionWidth),
                               y: mailIconButton.frame.origin.y + (3.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: mailLabel.frame.size.width,
                               height: mailLabel.frame.size.height)
    
    mailLabel.frame = newFrame
    
    self.addSubview(mailLabel)
    
  }
  
  @objc private func mailIconPressed() {
    
    self.delegate?.mailIconPressedFromDetailedInfoView()
    
  }
  
  func reloadDataToShow(reloadImage: Bool) {

    self.initInterface()
    
//    if MyCompanyModelData.Data.contactName != nil && MyCompanyModelData.Data.contactName != "" {
//      
//      self.createFaceCompanyButton()
//      self.createContactNameLabel()
//      
//    }
//    
//    if MyCompanyModelData.Data.contactPosition != nil && MyCompanyModelData.Data.contactPosition != "" {
//      
//      self.createToolBoxButton()
//      self.createContactPositionLabel()
//      
//    }
//    
//    var finalMail = ""
//    
//    if MyCompanyModelData.Data.contactEMail != nil && MyCompanyModelData.Data.contactEMail != "" {
//      
//      finalMail = MyCompanyModelData.Data.contactEMail!
//      let whiteSpace = NSCharacterSet.whitespaceAndNewlineCharacterSet()
//      finalMail = finalMail.stringByTrimmingCharactersInSet(whiteSpace)
//      
//    }
//    
//    if MyCompanyModelData.Data.contactEMail != nil  {
//      
//      self.createLetterButton()
//      self.createMailLabel()
//      
//    }
    
    
//    self.createCompanyLogoView()
//    self.createCompanyNameLabel()
//    self.createContactNameLabel()
//    self.createContactPositionLabel()
    
  }
  
  private func deleteAllElements() {
    
    if companyLogoView != nil {
      
      companyLogoView.removeFromSuperview()
      companyLogoView = nil
      
    }
    
    if companyNameLabel != nil {
      
      companyNameLabel.removeFromSuperview()
      companyNameLabel = nil
      
    }
    
    if contactNameLabel != nil {
      
      contactNameLabel.removeFromSuperview()
      contactNameLabel = nil
      
    }

    if contactPositionLabel != nil {
      
      contactPositionLabel.removeFromSuperview()
      contactPositionLabel = nil
      
    }

    if mailLabel != nil {
      
      mailLabel.removeFromSuperview()
      mailLabel = nil
      
    }

    if mailIconButton != nil {
      
      mailIconButton.removeFromSuperview()
      mailIconButton = nil
      
    }

    
    if toolBoxCompanyButton != nil {
      
      toolBoxCompanyButton.removeFromSuperview()
      toolBoxCompanyButton = nil
      
    }

    if faceCompanyButton != nil {
      
      faceCompanyButton.removeFromSuperview()
      faceCompanyButton = nil
      
    }
    
  }
  
}
