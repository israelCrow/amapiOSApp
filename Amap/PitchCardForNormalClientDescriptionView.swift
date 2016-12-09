//
//  PitchCardForNormalClientDescriptionView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 12/7/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class PitchCardForNormalClientDescriptionView: UIView {
  
  private var mailBriefString: String! = nil
  private var projectNameString: String! = nil
  private var winnerString: String! = nil
  private var companyNameString: String! = nil
  
  private var mailBriefLabel: UILabel! = nil
  private var projectNameLabel: UILabel! = nil
  private var winnerLabel: UILabel! = nil
  private var companyNameLabel: UILabel! = nil
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newMailBrief: String!, newProjectName: String!, newWinnerName: String!, newCompanyName: String!) {
    mailBriefString = newMailBrief
    projectNameString = newProjectName
    winnerString = newWinnerName
    companyNameString = newCompanyName
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    
    self.createMailBriefLabel()
    self.createProjectNameLabel()
    self.createCompanyNameLabel()
    self.createWinnerLabel()
    
  }
  
  private func createMailBriefLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 255.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    mailBriefLabel = UILabel.init(frame: frameForLabel)
    mailBriefLabel.numberOfLines = 0
    mailBriefLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 11.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.init(white: 0.0, alpha: 0.5)
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: mailBriefString,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    mailBriefLabel.attributedText = stringWithFormat
    mailBriefLabel.sizeToFit()
    let newFrame = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 0.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: mailBriefLabel.frame.size.width,
                               height: mailBriefLabel.frame.size.height)
    
    mailBriefLabel.frame = newFrame
    
    self.addSubview(mailBriefLabel)
    
  }
  
  private func createProjectNameLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 255.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: 28.0 * UtilityManager.sharedInstance.conversionHeight)
    
    projectNameLabel = UILabel.init(frame: frameForLabel)
    projectNameLabel.numberOfLines = 1
    projectNameLabel.adjustsFontSizeToFitWidth = true
    
    let font = UIFont(name: "SFUIDisplay-Light",
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
    //    projectNameLabel.sizeToFit()
    let newFrame = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 12.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: projectNameLabel.frame.size.width,
                               height: projectNameLabel.frame.size.height)
    
    projectNameLabel.frame = newFrame
    
    self.addSubview(projectNameLabel)
    
  }
  
  private func createCompanyNameLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 255.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    companyNameLabel = UILabel.init(frame: frameForLabel)
    companyNameLabel.numberOfLines = 1
    companyNameLabel.adjustsFontSizeToFitWidth = true
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
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
    let newFrame = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 41.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: companyNameLabel.frame.size.width,
                               height: companyNameLabel.frame.size.height)
    
    companyNameLabel.frame = newFrame
    
    self.addSubview(companyNameLabel)
    
  }
  
  private func createWinnerLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 255.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    winnerLabel = UILabel.init(frame: frameForLabel)
    winnerLabel.numberOfLines = 1
    projectNameLabel.adjustsFontSizeToFitWidth = true
    
    let font = UIFont(name: "SFUIDisplay-Regular",
                      size: 11.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.init(white: 0.0, alpha: 0.5)
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: winnerString,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    winnerLabel.attributedText = stringWithFormat
    winnerLabel.sizeToFit()
    let newFrame = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 64.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: winnerLabel.frame.size.width,
                               height: winnerLabel.frame.size.height)
    
    winnerLabel.frame = newFrame
    
    self.addSubview(winnerLabel)
    
  }
  
}
