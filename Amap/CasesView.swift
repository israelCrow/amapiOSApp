//
//  CasesView.swift
//  Amap
//
//  Created by Mac on 8/17/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit
import YouTubePlayer
import YTVimeoExtractor
import AVKit
import AVFoundation

protocol CasesViewDelegate {
  func flipCardAndShowCreateNewCase()
}

struct Case {
  
  var caseName: String! = nil
  var caseDescription: String! = nil
  var caseWebLink: String! = nil
  var caseImage: UIImage?
  
}

class CasesView: UIView   {
  
  private var casesLabel: UILabel! = nil
  private var mainScrollView: UIScrollView! = nil
  private var creatorOfCasesView: UIView! = nil
  private var arrayOfCases: [Case]! = nil
  
  
  var delegate: CasesViewDelegate?
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    
    self.createCasesLabel()
    self.createMainScrollView()
    self.createCreatorOfCasesView()
    
  }
  
  private func createCasesLabel() {
    
    casesLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: AgencyProfileEditConstants.CasesView.casesLabelText ,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    casesLabel.attributedText = stringWithFormat
    casesLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (casesLabel.frame.size.width / 2.0),
                               y: 30.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: casesLabel.frame.size.width,
                               height: casesLabel.frame.size.height)
    
    casesLabel.frame = newFrame
    
    self.addSubview(casesLabel)
    
  }
  
  private func createMainScrollView() {
    
    let frameForMainScrollView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                             y: 86.0 * UtilityManager.sharedInstance.conversionHeight,
                                             width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                             height: 374.0 * UtilityManager.sharedInstance.conversionHeight)//Value that I considered
    let sizeForContentScrollView = CGSize.init(width: frameForMainScrollView.size.width,
                                               height: frameForMainScrollView.size.height + (25.0 * UtilityManager.sharedInstance.conversionHeight))//Value that i considered
    
    mainScrollView = UIScrollView.init(frame: frameForMainScrollView)
    mainScrollView.backgroundColor = UIColor.clearColor()
    mainScrollView.contentSize = sizeForContentScrollView
    mainScrollView.showsVerticalScrollIndicator = false
    self.addSubview(mainScrollView)
    
  }
  
  private func createCreatorOfCasesView() {
    
    let frameForCreatorOfCases = CGRect.init(x: 0.0,
                                             y: 0.0,
                                         width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 140.0 * UtilityManager.sharedInstance.conversionHeight)
    
    creatorOfCasesView = UIView.init(frame: frameForCreatorOfCases)
    creatorOfCasesView.backgroundColor = UIColor.lightGrayColor()
    self.mainScrollView.addSubview(creatorOfCasesView)
    
    self.cretaeAndAddButtonForCreateNewCase()

  }
  
  private func cretaeAndAddButtonForCreateNewCase() {
    
    let frameForButton = CGRect.init(x: (creatorOfCasesView.frame.size.width / 2.0) - ((110.0 / 2.0) * UtilityManager.sharedInstance.conversionWidth),
                                     y: ((creatorOfCasesView.frame.size.height / 2.0) - (70.0 / 2.0) * UtilityManager.sharedInstance.conversionHeight),
                                     width: 110.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 70.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 72.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: AgencyProfileEditConstants.CasesView.createNewCaseButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    let createAnotherCaseButton = UIButton.init(frame: frameForButton)
    createAnotherCaseButton.addTarget(self,
                                      action: #selector(createAndAddAnotherCase),
                                      forControlEvents: .TouchUpInside)
    
    createAnotherCaseButton.backgroundColor = UIColor.grayColor()
    createAnotherCaseButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    self.creatorOfCasesView.addSubview(createAnotherCaseButton)
    
  }
  
  @objc private func createAndAddAnotherCase() {
    
    self.delegate?.flipCardAndShowCreateNewCase()
    
  }
  
}
