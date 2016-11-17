//
//  DetailPitchCanceledDeclinedButtons.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/13/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol DetailPitchCanceledDeclinedButtonsDelegate {
  
  func doCanceledPitchFunction()
  func doDeclinedPitchFunction()
  
}

class DetailPitchCanceledDeclinedButtons: UIView {
  
  private var canceledPitchButton: UIButton! = nil
  private var declinedPitchButton: UIButton! = nil
  
  var delegate: DetailPitchCanceledDeclinedButtonsDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.clearColor()
    self.createCanceledPitchButton()
    self.createDeclinedPitchButton()
    
  }
  
  private func createCanceledPitchButton() {
    
//    let frameForLabel = CGRect.init(x: 0.0,
//                                    y: 0.0,
//                                    width: 92.0 * UtilityManager.sharedInstance.conversionWidth,
//                                    height: CGFloat.max)
//    
//    let buttonLabel = UILabel.init(frame: frameForLabel)
//    buttonLabel.numberOfLines = 0
//    buttonLabel.lineBreakMode = .ByWordWrapping
//    
//    let font = UIFont(name: "SFUIDisplay-Regular",
//                      size: 18.0 * UtilityManager.sharedInstance.conversionWidth)
//    let color = UIColor.blackColor()
//    let style = NSMutableParagraphStyle()
//    style.alignment = NSTextAlignment.Center
//    
//    let stringWithFormat = NSMutableAttributedString(
//      string: EditPitchesConstants.DetailPitchCanceledDeclinedButtones.pitchCanceledButtonText,
//      attributes:[NSFontAttributeName: font!,
//        NSParagraphStyleAttributeName: style,
//        NSForegroundColorAttributeName: color
//      ]
//    )
//    buttonLabel.attributedText = stringWithFormat
//    buttonLabel.sizeToFit()
//    let newFrame = CGRect.init(x: (68.5 * UtilityManager.sharedInstance.conversionWidth) - (buttonLabel.frame.size.width / 2.0),
//                               y: (35.0 * UtilityManager.sharedInstance.conversionHeight) - (buttonLabel.frame.size.height / 2.0),
//                           width: buttonLabel.frame.size.width,
//                          height: buttonLabel.frame.size.height)
//    
//    buttonLabel.frame = newFrame
    
    
    canceledPitchButton = UIButton.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: EditPitchesConstants.DetailPitchCanceledDeclinedButtones.pitchCanceledButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    canceledPitchButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    canceledPitchButton.titleLabel?.numberOfLines = 0
    canceledPitchButton.titleLabel?.lineBreakMode = .ByWordWrapping
    canceledPitchButton.addTarget(self,
                               action: #selector(canceledPitchButtonPressed),
                               forControlEvents: .TouchUpInside)
    canceledPitchButton.sizeToFit()
    
    let frameForButton = CGRect.init(x: 0.0,
                                     y: 0.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 144.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 43.0 * UtilityManager.sharedInstance.conversionHeight)
    
    canceledPitchButton.frame = frameForButton
    canceledPitchButton.layer.borderColor = UIColor.blackColor().CGColor
    canceledPitchButton.layer.borderWidth = 2.0 * UtilityManager.sharedInstance.conversionWidth
    
    self.addSubview(canceledPitchButton)
    
  }
  
  private func createDeclinedPitchButton() {
    
    declinedPitchButton = UIButton.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: EditPitchesConstants.DetailPitchCanceledDeclinedButtones.pitchDeclinedButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    declinedPitchButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    declinedPitchButton.titleLabel?.numberOfLines = 0
    declinedPitchButton.titleLabel?.lineBreakMode = .ByWordWrapping
    declinedPitchButton.addTarget(self,
                                  action: #selector(declinedPitchButtonPressed),
                                  forControlEvents: .TouchUpInside)
    declinedPitchButton.sizeToFit()
    
    let frameForButton = CGRect.init(x: 151.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 0.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 144.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 43.0 * UtilityManager.sharedInstance.conversionHeight)
    
    declinedPitchButton.frame = frameForButton
    
    declinedPitchButton.layer.borderColor = UIColor.blackColor().CGColor
    declinedPitchButton.layer.borderWidth = 2.0 * UtilityManager.sharedInstance.conversionWidth
    
    self.addSubview(declinedPitchButton)
    
  }
  
  @objc private func canceledPitchButtonPressed() {
    
    self.delegate?.doCanceledPitchFunction()
    
  }
  
  @objc private func declinedPitchButtonPressed() {
    
    self.delegate?.doDeclinedPitchFunction()
    
  }
  
}
