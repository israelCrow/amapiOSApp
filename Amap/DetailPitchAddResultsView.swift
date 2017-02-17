//
//  DetailPitchAddResultsView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/13/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol DetailPitchAddResultsViewDelegate {
  
  func pushAddResultsViewController()
  
}

class DetailPitchAddResultsView: UIView {
  
  private var stringForButton: String! = nil
  private var fillTheSurveyLabel: UILabel! = nil
  private var addResultsButton: UIButton! = nil
  
  var delegate: DetailPitchAddResultsViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newStringForButton: String) {
    
    stringForButton = newStringForButton
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.createFillTheSurveyLabel()
    self.createAddResultsButton()
    
  }
  
  private func createFillTheSurveyLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 270.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    fillTheSurveyLabel = UILabel.init(frame: frameForLabel)
    fillTheSurveyLabel.numberOfLines = 0
    fillTheSurveyLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 17.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: EditPitchesConstants.DetailPitchAddResultsView.fillTheSurveyLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    fillTheSurveyLabel.attributedText = stringWithFormat
    fillTheSurveyLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (fillTheSurveyLabel.frame.size.width / 2.0),
                               y: -20.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: fillTheSurveyLabel.frame.size.width,
                               height: fillTheSurveyLabel.frame.size.height)
    
    fillTheSurveyLabel.frame = newFrame
    
    self.addSubview(fillTheSurveyLabel)
    
  }
  
  private func createAddResultsButton() {
    
    addResultsButton = UIButton.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: stringForButton,//EditPitchesConstants.DetailPitchAddResultsView.addResultsButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color,
        NSKernAttributeName: CGFloat(1.5)
      ]
    )
    
    addResultsButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    addResultsButton.backgroundColor = UIColor.blackColor()
    addResultsButton.addTarget(self,
                        action: #selector(addResultsButtonPressed),
                        forControlEvents: .TouchUpInside)
    addResultsButton.sizeToFit()
    
    let frameForButton = CGRect.init(x: 0.0,
                                     y: 90.0 * UtilityManager.sharedInstance.conversionHeight,
                                 width: self.frame.size.width,
                                height: 40.0 * UtilityManager.sharedInstance.conversionHeight)
    
    addResultsButton.frame = frameForButton
//    addResultsButton.layer.cornerRadius = 5.0
    
    self.addSubview(addResultsButton)
    
    //Creation of the separation line
    let border = CALayer()
    let width = CGFloat(1)
    border.borderColor = UIColor.darkGrayColor().CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 0.0,
                               y: self.frame.size.height - (1.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: self.frame.size.width,
                               height: 1.0)
    self.layer.addSublayer(border)
    self.layer.masksToBounds = false
    
  }
  
  @objc private func addResultsButtonPressed() {
    
    self.delegate?.pushAddResultsViewController()
    
  }
  
}
