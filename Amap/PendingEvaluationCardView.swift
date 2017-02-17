//
//  PendingEvaluationCardView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/27/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol PendingEvaluationCardViewDelegate {
  
  func nextButtonPressedFromPendingEvaluationCardView(pitchData: PitchEvaluationByUserModelData)
  
}

class PendingEvaluationCardView: UIView {

  private var gradientContainerView: GradientView! = nil
  private var cautionImageView: UIImageView! = nil
  private var pendingEvaluationLabel: UILabel! = nil
  private var detailedPartView: DetailedPartPitchCardView! = nil
  private var nextButton: UIButton! = nil
  
  private var pitchData: PitchEvaluationByUserModelData! = nil
  
  var delegate: PendingEvaluationCardViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newPitchData: PitchEvaluationByUserModelData) {
    
    super.init(frame: frame)
    
    pitchData = newPitchData
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.createGradientContainerView()
    self.createCautionImageView()
    self.createPendingEvaluationLabel()
    self.createDetailedPartView()
    self.createNextButton()
    
  }
  
  private func createGradientContainerView() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: 0.0,
                               width: self.frame.size.width,
                              height: 277.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let firstColorGradient = UIColor.init(red: 199.0/255.0, green: 199.0/255.0, blue: 199.0/255.0, alpha: 1.0)
    let secondColorGradient = UIColor.init(red: 101.0/255.0, green: 121.0/255.0, blue: 133.0/255.0, alpha: 1.0)
    let colorsForBackground = [firstColorGradient,secondColorGradient]
    
    gradientContainerView = GradientView.init(frame: frameForView, arrayOfcolors: colorsForBackground, typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
    
    self.addSubview(gradientContainerView)
    
  }
  
  private func createCautionImageView() {
    
    cautionImageView = UIImageView.init(image: UIImage.init(named: "combinedShape"))
    let canceledImageViewFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (cautionImageView.frame.size.width / 2.0),
                                             y: (65.0 * UtilityManager.sharedInstance.conversionHeight),
                                             width: cautionImageView.frame.size.width,
                                             height: cautionImageView.frame.size.height)
    cautionImageView.frame = canceledImageViewFrame
    
    gradientContainerView.addSubview(cautionImageView)
    
  }
  
  private func createPendingEvaluationLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 278.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    pendingEvaluationLabel = UILabel.init(frame: frameForLabel)
    pendingEvaluationLabel.numberOfLines = 0
    pendingEvaluationLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 25.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.PendingEvaluationCardView.pendingEvaluationLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color,
        NSKernAttributeName: CGFloat(1.7)
      ]
    )
    pendingEvaluationLabel.attributedText = stringWithFormat
    pendingEvaluationLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (pendingEvaluationLabel.frame.size.width / 2.0),
                               y: 182.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: pendingEvaluationLabel.frame.size.width,
                               height: pendingEvaluationLabel.frame.size.height)
    
    pendingEvaluationLabel.frame = newFrame
    
    gradientContainerView.addSubview(pendingEvaluationLabel)
    
  }
  
  private func createDetailedPartView() {
    
    let frameForDetailedPartView = CGRect.init(x: 0.0,
                                               y: 277.0 * UtilityManager.sharedInstance.conversionHeight,
                                           width: self.frame.size.width,
                                          height: 107.0 * UtilityManager.sharedInstance.conversionHeight)
    
    detailedPartView = DetailedPartPitchCardView.init(frame: frameForDetailedPartView,
                                              newDateString: pitchData.briefDate,
                                             newProjectName: pitchData.pitchName,
                                               newBrandName: pitchData.brandName,
                                             newCompanyName: pitchData.companyName)
    
    self.addSubview(detailedPartView)
    
  }
  
  private func createNextButton() {
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let colorWhenPressed = UIColor.greenColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.PendingEvaluationCardView.nextButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    let stringWithFormatWhenpressed = NSMutableAttributedString(
      string: VisualizePitchesConstants.PendingEvaluationCardView.nextButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: colorWhenPressed
      ]
    )
    
    let frameForButton = CGRect.init(x: 0.0,
                                     y: self.frame.size.height - (70.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: self.frame.size.width,
                                     height: (70.0 * UtilityManager.sharedInstance.conversionHeight))
    nextButton = UIButton.init(frame: frameForButton)
    nextButton.addTarget(self,
                         action: #selector(nextButtonPressed),
                         forControlEvents: .TouchUpInside)
    nextButton.backgroundColor = UIColor.blackColor()
    nextButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    nextButton.setAttributedTitle(stringWithFormatWhenpressed, forState: .Highlighted)
    
    self.addSubview(nextButton)
    
  }
  
  @objc private func nextButtonPressed() {
    
    self.delegate?.nextButtonPressedFromPendingEvaluationCardView(pitchData)
    
  }
  
}
