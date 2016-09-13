//
//  DetailedPartPitchCardView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/12/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class DetailedPartPitchCardView: UIView {
  
  private var dateString: String! = nil
  private var projectNameString: String! = nil
  private var brandNameString: String! = nil
  private var companyNameString: String! = nil
  
  private var dateLabel: UILabel! = nil
  private var projectNameLabel: UILabel! = nil
  private var brandNameLabel: UILabel! = nil
  private var companyNameLabel: UILabel! = nil
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newProjectName: String!, newBrandName: String!, newCompanyName: String!) {
    projectNameString = newProjectName
    brandNameString = newBrandName
    companyNameString = newCompanyName
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    
    self.createDateLabel()
    self.createProjectNameLabel()
    self.createBrandNameLabel()
    self.createCompanyNameLabel()
    
  }
  
  private func createDateLabel() {
    
    let date = NSDate()
    let formatter = NSDateFormatter()
    formatter.locale = NSLocale(localeIdentifier: "es_MX")
    formatter.dateFormat = "dd/MM/yyyy"
    dateString = formatter.stringFromDate(date)
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 271.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    dateLabel = UILabel.init(frame: frameForLabel)
    dateLabel.numberOfLines = 0
    dateLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 9.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: dateString,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    dateLabel.attributedText = stringWithFormat
    dateLabel.sizeToFit()
    let newFrame = CGRect.init(x: 12.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 12.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: dateLabel.frame.size.width,
                               height: dateLabel.frame.size.height)
    
    dateLabel.frame = newFrame
    
    self.addSubview(dateLabel)
    
  }
  
  private func createProjectNameLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 271.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    projectNameLabel = UILabel.init(frame: frameForLabel)
    projectNameLabel.numberOfLines = 1
    projectNameLabel.lineBreakMode = .ByTruncatingTail
    
    let font = UIFont(name: "SFUIDisplay-Semibold",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: projectNameString,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    projectNameLabel.attributedText = stringWithFormat
    projectNameLabel.sizeToFit()
    let newFrame = CGRect.init(x: 12.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 29.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: projectNameLabel.frame.size.width,
                               height: projectNameLabel.frame.size.height)
    
    projectNameLabel.frame = newFrame
    
    self.addSubview(projectNameLabel)
    
  }
  
  private func createBrandNameLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 271.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    brandNameLabel = UILabel.init(frame: frameForLabel)
    brandNameLabel.numberOfLines = 1
    brandNameLabel.lineBreakMode = .ByTruncatingTail
    
    let font = UIFont(name: "SFUIDisplay-Regular",
                      size: 18.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: brandNameString,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    brandNameLabel.attributedText = stringWithFormat
    brandNameLabel.sizeToFit()
    let newFrame = CGRect.init(x: 12.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 54.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: brandNameLabel.frame.size.width,
                               height: brandNameLabel.frame.size.height)
    
    brandNameLabel.frame = newFrame
    
    self.addSubview(brandNameLabel)
    
  }
  
  private func createCompanyNameLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 271.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    companyNameLabel = UILabel.init(frame: frameForLabel)
    companyNameLabel.numberOfLines = 1
    companyNameLabel.lineBreakMode = .ByTruncatingTail
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 12.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: companyNameString,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    companyNameLabel.attributedText = stringWithFormat
    companyNameLabel.sizeToFit()
    let newFrame = CGRect.init(x: 12.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 54.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: companyNameLabel.frame.size.width,
                               height: companyNameLabel.frame.size.height)
    
    companyNameLabel.frame = newFrame
    
    self.addSubview(companyNameLabel)
    
  }
  
}
