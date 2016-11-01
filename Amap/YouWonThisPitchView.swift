//
//  YouWonThisPitchView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/31/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol YouWonThisPitchViewDelegate {
  
  func nextButtonPressedFromYouWonThisPitchView(pitchData: PitchEvaluationByUserModelData)
  
}

class YouWonThisPitchView: UIView {
  
  private var gradientContainerView: GradientView! = nil
  private var okeyImageView: UIImageView! = nil
  private var youWonThisPitchLabel: UILabel! = nil
  private var detailedLabel: UILabel! = nil
  private var detailedPartView: DetailedPartPitchCardView! = nil
  private var nextButton: UIButton! = nil
  
  private var pitchData: PitchEvaluationByUserModelData! = nil
  
  var delegate: YouWonThisPitchViewDelegate?
  
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
    self.createOkeyImageView()
    self.createYouWonThisPitchLabel()
    self.createDetailedLabel()
    self.createDetailedPartView()
    self.createNextButton()
    
  }
  
  private func createGradientContainerView() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: 0.0,
                                   width: self.frame.size.width,
                                   height: 277.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let firstColorGradient = UIColor.init(red: 45.0/255.0, green: 252.0/255.0, blue: 197.0/255.0, alpha: 1.0)
    let secondColorGradient = UIColor.init(red: 21.0/255.0, green: 91.0/255.0, blue: 138.0/255.0, alpha: 1.0)
    let colorsForBackground = [firstColorGradient,secondColorGradient]
    
    gradientContainerView = GradientView.init(frame: frameForView, arrayOfcolors: colorsForBackground, typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
    
    self.addSubview(gradientContainerView)
    
  }
  
  private func createOkeyImageView() {
    
    okeyImageView = UIImageView.init(image: UIImage.init(named: "whiteIconOkey"))
    let canceledImageViewFrame = CGRect.init(x: (15.0 * UtilityManager.sharedInstance.conversionWidth),
                                             y: (61.0 * UtilityManager.sharedInstance.conversionHeight),
                                             width: okeyImageView.frame.size.width,
                                             height: okeyImageView.frame.size.height)
    okeyImageView.frame = canceledImageViewFrame
    
    gradientContainerView.addSubview(okeyImageView)
    
  }
  
  private func createYouWonThisPitchLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 157.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    youWonThisPitchLabel = UILabel.init(frame: frameForLabel)
    youWonThisPitchLabel.numberOfLines = 0
    youWonThisPitchLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 38.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.YouWonThisPitchView.youWonThisPitchLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    youWonThisPitchLabel.attributedText = stringWithFormat
    youWonThisPitchLabel.sizeToFit()
    let newFrame = CGRect.init(x: 123.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 64.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: youWonThisPitchLabel.frame.size.width,
                               height: youWonThisPitchLabel.frame.size.height)
    
    youWonThisPitchLabel.frame = newFrame
    
    gradientContainerView.addSubview(youWonThisPitchLabel)
    
  }
  
  private func createDetailedLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 231.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    detailedLabel = UILabel.init(frame: frameForLabel)
    detailedLabel.numberOfLines = 0
    detailedLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.YouWonThisPitchView.detailedLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    detailedLabel.attributedText = stringWithFormat
    detailedLabel.sizeToFit()
    let newFrame = CGRect.init(x: 33.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 178.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: detailedLabel.frame.size.width,
                               height: detailedLabel.frame.size.height)
    
    detailedLabel.frame = newFrame
    
    gradientContainerView.addSubview(detailedLabel)
    
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
      string: VisualizePitchesConstants.YouWonThisPitchView.nextButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    let stringWithFormatWhenpressed = NSMutableAttributedString(
      string: VisualizePitchesConstants.YouWonThisPitchView.nextButtonText,
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
    
    self.delegate?.nextButtonPressedFromYouWonThisPitchView(pitchData)
    
  }
  

  
  
  
}
