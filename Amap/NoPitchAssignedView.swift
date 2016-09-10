//
//  NoPitchAssignedView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/8/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol NoPitchAssignedViewDelegate {
  
  func pushCreateAddNewPitchAndWriteBranNameViewController()
  
}

class NoPitchAssignedView: UIView {
  
  private var addPitchButton: UIButton! = nil
  private var warningImageView: UIImageView! = nil
  private var noPitchAssignedLabel: UILabel! = nil
  
  var delegate: NoPitchAssignedViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(position: CGPoint){
    
    let frameForThisView = CGRect.init(x: position.x,
                                       y: position.y,
                                   width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                                  height: 454.0 * UtilityManager.sharedInstance.conversionHeight)
    super.init(frame: frameForThisView)
      
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.adaptMyself()
    self.createGradient()
    self.createAddPitchButton()
    self.createWarningImageView()
    self.createNoPitchAssignedLabel()
    
  }
  
  private func adaptMyself() {
    
    self.layer.shadowColor = UIColor.blackColor().CGColor
    self.layer.shadowOpacity = 0.25
    self.layer.shadowOffset = CGSizeZero
    self.layer.shadowRadius = 5
    
  }
  
  private func createGradient() {
    
    let frameForGradient = CGRect.init(x: 0.0,
                                       y: 0.0,
                                   width: self.frame.size.width,
                                  height: self.frame.size.height)
    
    let colorOne = UIColor.init(red: 199.0/255.0, green: 199.0/255.0, blue: 199.0/255.0, alpha: 1.0)
    let colorTwo = UIColor.init(red: 101.0/255.0, green: 121.0/255.0, blue: 133.0/255.0, alpha: 1.0)
    let arrayColors = [colorOne, colorTwo]
    
    let gradienteView = GradientView.init(frame: frameForGradient,
                                  arrayOfcolors: arrayColors,
                              typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
    
    self.addSubview(gradienteView)
    
  }
  
  private func createAddPitchButton() {
    
    let frameForButton = CGRect.init(x: 243.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: -20.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 40.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 40.0 * UtilityManager.sharedInstance.conversionHeight)
    
    addPitchButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "buttonAddPitch") as UIImage?
    addPitchButton.setImage(image, forState: .Normal)
    addPitchButton.tag = 1
    addPitchButton.addTarget(self, action: #selector(addPitchButtonPushed), forControlEvents:.TouchUpInside)
    
    self.addSubview(addPitchButton)
    
  }
  
  private func createWarningImageView() {
    
    warningImageView = UIImageView.init(image: UIImage.init(named: "combinedShape"))
    
    let frameForWarningImage = CGRect.init(x: 99.0 * UtilityManager.sharedInstance.conversionWidth,
                                           y: 127.0 * UtilityManager.sharedInstance.conversionHeight,
                                       width: warningImageView.frame.size.width,
                                      height: warningImageView.frame.size.height)
    
    warningImageView.frame = frameForWarningImage
    
    self.addSubview(warningImageView)
    
  }
  
  private func createNoPitchAssignedLabel() {
    
    noPitchAssignedLabel = UILabel.init(frame: CGRectZero)
    noPitchAssignedLabel.numberOfLines = 4
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 38.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.NoPitchesAssignedView.warningNoPitchesText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    noPitchAssignedLabel.attributedText = stringWithFormat
    noPitchAssignedLabel.sizeToFit()
    let newFrame = CGRect.init(x: 20.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 238.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: noPitchAssignedLabel.frame.size.width,
                               height: noPitchAssignedLabel.frame.size.height)
    
    noPitchAssignedLabel.frame = newFrame
    
    self.addSubview(noPitchAssignedLabel)
    
  }
  
  @objc private func addPitchButtonPushed() {
    
    self.delegate?.pushCreateAddNewPitchAndWriteBranNameViewController()
    
  }
  

  
}