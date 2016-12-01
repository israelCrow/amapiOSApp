//
//  DetailedNavigationEvaluatPitchView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/13/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class DetailedNavigationEvaluatPitchView: UIView {
  
  private var projectNameString: String! = nil
  private var brandNameString: String! = nil
  private var companyNameString: String! = nil
  private var dateString: String?
  
  private var projectNameLabel: UILabel! = nil
  private var brandNameLabel: UILabel! = nil
  private var companyNameLabel: UILabel! = nil
  private var dateCreationLabel: UILabel! = nil
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newProjectName: String!, newBrandName: String!, newCompanyName: String!, newDateString: String?){
    
    projectNameString = newProjectName
    brandNameString = newBrandName
    companyNameString = newCompanyName
    dateString = newDateString
    
    super.init(frame: frame)
    
    self.initInterface()
  }
  

  private func initInterface() {
    
    self.backgroundColor = UIColor.init(red: 23.0/255.0,
                                      green: 21.0/255.0,
                                       blue: 23.0/255.0,
                                      alpha: 0.998)
    
    self.layer.borderWidth = 0.0
    
    
    self.createProjectNameLabel()
    self.createBrandNameLabel()
    self.createCompanyNameLabel()
    
    if dateString != nil {
      self.createDateCreationLabel()
    }
    
  }
  
  private func createProjectNameLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: self.frame.size.width,
                                    height: CGFloat.max)
    
    projectNameLabel = UILabel.init(frame: frameForLabel)
    projectNameLabel.numberOfLines = 1
    projectNameLabel.lineBreakMode = .ByTruncatingTail
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
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
    let newFrame = CGRect.init(x: 40.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 4.0 * UtilityManager.sharedInstance.conversionHeight,
                           width: projectNameLabel.frame.size.width,
                          height: projectNameLabel.frame.size.height)
    
    projectNameLabel.backgroundColor = UIColor.clearColor()
    projectNameLabel.frame = newFrame
    
    self.addSubview(projectNameLabel)
    
  }
  
  private func createBrandNameLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: self.frame.size.width,
                                    height: CGFloat.max)
    
    brandNameLabel = UILabel.init(frame: frameForLabel)
    brandNameLabel.numberOfLines = 1
    brandNameLabel.lineBreakMode = .ByTruncatingTail
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
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
    let newFrame = CGRect.init(x: 40.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 40.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: brandNameLabel.frame.size.width,
                               height: brandNameLabel.frame.size.height)
    
    brandNameLabel.backgroundColor = UIColor.clearColor()
    brandNameLabel.frame = newFrame
    
    self.addSubview(brandNameLabel)
    
  }
  
  private func createCompanyNameLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: self.frame.size.width,
                                    height: CGFloat.max)
    
    companyNameLabel = UILabel.init(frame: frameForLabel)
    companyNameLabel.numberOfLines = 1
    companyNameLabel.lineBreakMode = .ByTruncatingTail
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 11.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.5)
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
    let newFrame = CGRect.init(x: 40.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 80.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: companyNameLabel.frame.size.width,
                               height: companyNameLabel.frame.size.height)
    
    companyNameLabel.backgroundColor = UIColor.clearColor()
    companyNameLabel.frame = newFrame
    
    self.addSubview(companyNameLabel)
    
  }
  
  private func createDateCreationLabel() {
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: self.frame.size.width,
                                    height: CGFloat.max)
    
    dateCreationLabel = UILabel.init(frame: frameForLabel)
    dateCreationLabel.numberOfLines = 0
    dateCreationLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 9.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: dateString!,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    dateCreationLabel.attributedText = stringWithFormat
    dateCreationLabel.sizeToFit()
    let newFrame = CGRect.init(x: 298.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 80.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: dateCreationLabel.frame.size.width,
                               height: dateCreationLabel.frame.size.height)
    
    dateCreationLabel.frame = newFrame
    
    self.addSubview(dateCreationLabel)
    
  }
  
  
}
