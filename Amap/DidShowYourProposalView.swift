//
//  DidShowYourProposalView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/20/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

enum PositionOfCardsAddResults {
  case left
  case right
  case center
}

protocol DidYouShowYourProposalViewDelegate {
  
  func didYouShowYourProposalNextButtonPressedSoShowScreenWithTag(valueSelected: String, nextScreenToShowWithTag: Int)
  
}

class DidYouShowYourProposalView: UIView, CustomSegmentedControlWithTitleViewDelegate {
  
  private var titleLabel: UILabel! = nil
  var didYouShowYourProposalView: CustomSegmentedControlWithTitleView! = nil
  private var nextButton: UIButton! = nil
  var regionPosition: PositionOfCardsAddResults! = nil
  
  private let ifAnswerIsYesGoTo = 2
  private let ifAnswerIsNoGoTo = 9
  
  var delegate: DidYouShowYourProposalViewDelegate?
  
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
    
    self.tag = 1
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    
    self.createTitleLabel()
    self.createDidYouShowYourProposalView()
    self.createNextButton()
  }
  
  private func createTitleLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    titleLabel = UILabel.init(frame: frameForLabel)
    titleLabel.numberOfLines = 0
    titleLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 20.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "¿Presentaste tu propuesta?",//EditPitchesConstants.DidYouShowYourProposalView.titleLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color,
        NSKernAttributeName: CGFloat(1.4)
      ]
    )
    titleLabel.attributedText = stringWithFormat
    titleLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (titleLabel.frame.size.width / 2.0),
                               y: 100.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: titleLabel.frame.size.width,
                               height: titleLabel.frame.size.height)
    
    titleLabel.frame = newFrame
    
    self.addSubview(titleLabel)
    
  }
  
  private func createDidYouShowYourProposalView() {
    
    let frameForView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                   y: 148.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let segmentsArray = ["Sí", "", "No"]
    
    didYouShowYourProposalView = CustomSegmentedControlWithTitleView.init(frame: frameForView,
                                                                   title: "",//"¿Presentaste tu propuesta?",
                                                                   image: nil,
                                                                   segmentsText: segmentsArray)
    let originalSegmentControlFrame = didYouShowYourProposalView.mainSegmentedControl.frame
    let newFrame = CGRect.init(x: originalSegmentControlFrame.origin.x + (20.0 * UtilityManager.sharedInstance.conversionWidth),
                               y: originalSegmentControlFrame.origin.y,
                               width: originalSegmentControlFrame.size.width,
                               height: originalSegmentControlFrame.size.height)
    didYouShowYourProposalView.mainSegmentedControl.frame = newFrame
    didYouShowYourProposalView.mainSegmentedControl.setWidth(kSpaceInSegments, forSegmentAtIndex: 1)
    didYouShowYourProposalView.mainSegmentedControl.setEnabled(false, forSegmentAtIndex: 1)
    didYouShowYourProposalView.delegate = self
    
    self.addSubview(didYouShowYourProposalView)
    
  }
  
  private func createNextButton() {
    
    
    nextButton = UIButton.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: EditPitchesConstants.DidYouShowYourProposalView.nextButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    let colorWhenDisabled = UIColor.whiteColor()
    let styleWhenDisabled = NSMutableParagraphStyle()
    styleWhenDisabled.alignment = NSTextAlignment.Center
    
    let stringWithFormatWhenDisabled = NSMutableAttributedString(
      string: EditPitchesConstants.DidYouShowYourProposalView.nextButtonText,
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
    
    let selectedAnswer = didYouShowYourProposalView.returnValueSelectedFromSegmentControl()
    
    if selectedAnswer == "Sí" {
      
      self.delegate?.didYouShowYourProposalNextButtonPressedSoShowScreenWithTag(selectedAnswer, nextScreenToShowWithTag: ifAnswerIsYesGoTo)
      
    } else {
      
      self.delegate?.didYouShowYourProposalNextButtonPressedSoShowScreenWithTag(selectedAnswer, nextScreenToShowWithTag: ifAnswerIsNoGoTo)
      
    }
    
  }
  
  //MARK: - CustomSegmentedControlWithTitleViewDelegate
  
  func customSegmentedControlWithTitleViewDidBeginEditing(sender: AnyObject) {
    
    self.changeNextButtonToEnabled()
    
  }
  
  func changeNextButtonToEnabled() {
    
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
