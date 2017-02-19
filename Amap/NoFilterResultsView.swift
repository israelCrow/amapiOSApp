//
//  NoFilterResultsView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 12/5/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class NoFilterResultsView: UIView {
  
  private var gradienteView: UIView! = nil
  private var addPitchButton: UIButton! = nil
  private var warningImageView: UIImageView! = nil
  private var noPitchAssignedLabel: UILabel! = nil
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(position: CGPoint){
    
    let frameForThisView = CGRect.init(x: position.x,
                                       y: position.y - (20.0 * UtilityManager.sharedInstance.conversionHeight),
                                       width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                                       height: 454.0 * UtilityManager.sharedInstance.conversionHeight)
    super.init(frame: frameForThisView)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.clearColor()
    self.adaptMyself()
    self.createGradient()
    //    self.createAddPitchButton()
//    self.createWarningImageView()
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
                                       y: 20.0 * UtilityManager.sharedInstance.conversionHeight,
                                       width: self.frame.size.width,
                                       height: self.frame.size.height)
    
    let colorOne = UIColor.init(red: 199.0/255.0, green: 199.0/255.0, blue: 199.0/255.0, alpha: 1.0)
    let colorTwo = UIColor.init(red: 101.0/255.0, green: 121.0/255.0, blue: 133.0/255.0, alpha: 1.0)
    let arrayColors = [colorOne, colorTwo]
    
    gradienteView = GradientView.init(frame: frameForGradient,
                                      arrayOfcolors: arrayColors,
                                      typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
    
    self.addSubview(gradienteView)
    
  }
  
  private func createAddPitchButton() {
    
    let frameForButton = CGRect.init(x: 235.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: -5.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 56.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 56.0 * UtilityManager.sharedInstance.conversionHeight)
    
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
    
    gradienteView.addSubview(warningImageView)
    
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
      string: VisualizePitchesConstants.NoFilterResultsView.warningNoPitchesText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    noPitchAssignedLabel.attributedText = stringWithFormat
    noPitchAssignedLabel.sizeToFit()
    let newFrame = CGRect.init(x: (gradienteView.frame.size.width / 2.0) - ( noPitchAssignedLabel.frame.size.width / 2.0),
                               y: 150.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: noPitchAssignedLabel.frame.size.width,
                               height: noPitchAssignedLabel.frame.size.height)
    
    noPitchAssignedLabel.frame = newFrame
    
    gradienteView.addSubview(noPitchAssignedLabel)
    
  }
  
  @objc private func addPitchButtonPushed() {
    
//    self.delegate?.pushCreateAddNewPitchAndWriteBrandNameViewController()
    
  }
  
  
  
}
