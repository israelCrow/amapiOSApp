//
//  DidSignContractPitchSurveyView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/26/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol DidSignContractPitchSurveyViewDelegate {
  
  func didSignContractPitchSurveyNextButtonPressedSoShowScreenWithTag(valueSelected: String, nextScreenToShowWithTag: Int)
  
}

class DidSignContractPitchSurveyView: UIView, CustomSegmentedControlWithTitleViewDelegate {
  
  private var thumbsUpImageView: UIImageView! = nil
  private var titleLabel: UILabel! = nil
  private var didSignContractView: CustomSegmentedControlWithTitleView! = nil
  private var nextButton: UIButton! = nil
  var regionPosition: PositionOfCardsAddResults! = nil
  
  private let ifAnswerIsYesGoTo = 11
  private let ifAnswerIsNoGoTo = 13
  
  var delegate: DidSignContractPitchSurveyViewDelegate?
  
  let kSpaceInSegments = 36.0 * UtilityManager.sharedInstance.conversionWidth
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    
    self.initValues()
    self.initInterface()
    
  }
  
  private func initValues() {
    
    self.tag = 10
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    
    self.createThumbsUpImageView()
    self.createTitleLabel()
    self.createDidYouShowYourProposalView()
    self.createNextButton()
  }
  
  private func createThumbsUpImageView() {
    
    thumbsUpImageView = UIImageView.init(image: UIImage.init(named: "thumbsUp")!)
    let iconImageViewFrame = CGRect.init(x: 18.0 * UtilityManager.sharedInstance.conversionWidth,
                                         y: 10.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: thumbsUpImageView!.frame.size.width,
                                         height: thumbsUpImageView!.frame.size.height)
    
    thumbsUpImageView!.frame = iconImageViewFrame
    
    self.addSubview(thumbsUpImageView!)
    
  }
  
  private func createTitleLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 182.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    titleLabel = UILabel.init(frame: frameForLabel)
    titleLabel.numberOfLines = 0
    titleLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: EditPitchesConstants.DidSignContactPitchSurveyView.titleLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    titleLabel.attributedText = stringWithFormat
    titleLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (titleLabel.frame.size.width / 2.0),
                               y: 30.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: titleLabel.frame.size.width,
                               height: titleLabel.frame.size.height)
    
    titleLabel.frame = newFrame
    
    self.addSubview(titleLabel)
    
  }
  
  private func createDidYouShowYourProposalView() {
    
    let frameForView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                   y: 164.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let segmentsArray = ["Sí", "", "No"]
    
    didSignContractView = CustomSegmentedControlWithTitleView.init(frame: frameForView,
                                                                          title: "¿Firmaste contrato?",
                                                                          image: nil,
                                                                          segmentsText: segmentsArray)
    let originalSegmentControlFrame = didSignContractView.mainSegmentedControl.frame
    let newFrame = CGRect.init(x: originalSegmentControlFrame.origin.x + (20.0 * UtilityManager.sharedInstance.conversionWidth),
                               y: originalSegmentControlFrame.origin.y,
                               width: originalSegmentControlFrame.size.width,
                               height: originalSegmentControlFrame.size.height)
    didSignContractView.mainSegmentedControl.frame = newFrame
    didSignContractView.mainSegmentedControl.setWidth(kSpaceInSegments, forSegmentAtIndex: 1)
    didSignContractView.mainSegmentedControl.setEnabled(false, forSegmentAtIndex: 1)
    didSignContractView.delegate = self
    
    self.addSubview(didSignContractView)
    
  }
  
  private func createNextButton() {
    
    nextButton = UIButton.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: EditPitchesConstants.DidSignContactPitchSurveyView.nextButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    let colorWhenDisabled = UIColor.whiteColor()
    let styleWhenDisabled = NSMutableParagraphStyle()
    styleWhenDisabled.alignment = NSTextAlignment.Center
    
    let stringWithFormatWhenDisabled = NSMutableAttributedString(
      string: EditPitchesConstants.DidSignContactPitchSurveyView.nextButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: styleWhenDisabled,
        NSForegroundColorAttributeName: colorWhenDisabled
      ]
    )
    
    nextButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    nextButton.setAttributedTitle(stringWithFormatWhenDisabled, forState: .Disabled)
    nextButton.backgroundColor = UIColor.grayColor()
    nextButton.addTarget(self,
                         action: #selector(nextButtonPressed),
                         forControlEvents: .TouchUpInside)
    nextButton.sizeToFit()
    
    let frameForButton = CGRect.init(x: 0.0,
                                     y: self.frame.size.height - (70.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: self.frame.size.width,
                                     height: 70.0 * UtilityManager.sharedInstance.conversionHeight)
    
    nextButton.frame = frameForButton
    nextButton.enabled = false
    
    self.addSubview(nextButton)
    
  }
  
  @objc private func nextButtonPressed() {
    
    let selectedAnswer = didSignContractView.returnValueSelectedFromSegmentControl()
    
    if selectedAnswer == "Sí" {
      
      self.delegate?.didSignContractPitchSurveyNextButtonPressedSoShowScreenWithTag(selectedAnswer, nextScreenToShowWithTag: ifAnswerIsYesGoTo)
      
    } else {
      
      self.delegate?.didSignContractPitchSurveyNextButtonPressedSoShowScreenWithTag(selectedAnswer, nextScreenToShowWithTag: ifAnswerIsNoGoTo)
      
    }
    
  }
  
  //MARK: - CustomSegmentedControlWithTitleViewDelegate
  
  func customSegmentedControlWithTitleViewDidBeginEditing(sender: AnyObject) {
    
    self.changeNextButtonToEnabled()
    
  }
  
  private func changeNextButtonToEnabled() {
    
    UIView.animateWithDuration(0.35,
                               animations: {
                                
                                self.nextButton.backgroundColor = UIColor.blackColor()
                                
    }) { (finished) in
      if finished == true {
        
        self.nextButton.enabled = true
        
      }
    }
    
  }
  
}
