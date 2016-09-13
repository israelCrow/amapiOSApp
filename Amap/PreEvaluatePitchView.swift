//
//  PreEvaluatePitchView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/13/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol PreEvaluatePitchViewDelegate {
  
  func savePitchAndFlipCard()
  
}

class PreEvaluatePitchView: UIView {
  
  private var writeNameAgencyOrBrandView: CustomTextFieldWithTitleView! = nil
  private var writeDateOfCreationOfPitchView: CustomTextFieldWithTitleView! = nil
  private var nextButton: UIButton! = nil
  
  var delegate: PreEvaluatePitchViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    
    self.createWriteNameAgencyBrandView()
    self.createWriteDateOfCreationOfPitchView()
    self.createNextButton()
    
  }
  
  private func createWriteNameAgencyBrandView() {
    
    let frameForView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                   y: 68.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                              height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    writeNameAgencyOrBrandView = CustomTextFieldWithTitleView.init(frame: frameForView,
                                                                   title: VisualizePitchesConstants.PreEvaluatePitchView.descriptionWriteNameLabel,
                                                                   image: nil)
    
    self.addSubview(writeNameAgencyOrBrandView)
    
  }
  
  private func createWriteDateOfCreationOfPitchView() {
    
    let frameForView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                   y: 167.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    writeDateOfCreationOfPitchView = CustomTextFieldWithTitleView.init(frame: frameForView,
                                                                   title: VisualizePitchesConstants.PreEvaluatePitchView.descriptionWriteNameLabel,
                                                                   image: "iconImputCalendar")
    
    self.addSubview(writeDateOfCreationOfPitchView)
    
  }
  
  private func createNextButton() {
    
    nextButton = UIButton.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.AddPitchAndWriteBrandNameView.addButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    nextButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    nextButton.backgroundColor = UIColor.blackColor()
    nextButton.addTarget(self,
                        action: #selector(nextButtonPressed),
                        forControlEvents: .TouchUpInside)
    nextButton.sizeToFit()
    
    let frameForButton = CGRect.init(x: 0.0,
                                     y: self.frame.size.height - (70.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: self.frame.size.width,
                                     height: 70.0 * UtilityManager.sharedInstance.conversionHeight)
    
    nextButton.frame = frameForButton
    nextButton.alpha = 1.0
    
    self.addSubview(nextButton)
    
  }
  
  @objc private func nextButtonPressed() {
    
    self.delegate?.savePitchAndFlipCard()
    
  }

  
}
