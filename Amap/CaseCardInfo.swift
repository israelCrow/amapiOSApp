//
//  CaseCardInfo.swift
//  Amap
//
//  Created by Mac on 8/18/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol CaseCardInfoViewDelegate {
  
  func flipCardAndShowPreviewCase(caseData: Case)
  func deleteCaseFromPreviewPlayer(dataCase: Case)
  
}

class CaseCardInfoView: UIView, PreviewVimeoYoutubeViewDelegate {

  private var caseData: Case! = nil
  private var casePreviewVideoPlayerVimeoYoutube: PreviewVimeoYoutubeView! = nil
  private var caseNameLabel: UILabel! = nil
  private var twoPointsButton: UIButton! = nil
  
  var delegate: CaseCardInfoViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, dataFromCase: Case) {
    caseData = dataFromCase
    super.init(frame: frame)
    self.initInterface()
  }
  
  private func initInterface() {
    self.backgroundColor = UIColor.whiteColor()
    
    self.createCaseVideoPlayer()
    self.createCaseNameLabel()
    self.createTwoPointsButton()
  
  }
  
  private func createCaseVideoPlayer() {
    
    let frameForPreviewVideoPlayer = CGRect.init(x: 0.0,
                                          y: 0.0,
                                      width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 110.0 * UtilityManager.sharedInstance.conversionHeight)
    
    casePreviewVideoPlayerVimeoYoutube = PreviewVimeoYoutubeView.init(frame: frameForPreviewVideoPlayer, caseInfo: caseData, showButtonsOfEdition: true)
    casePreviewVideoPlayerVimeoYoutube.delegate = self
    
    self.addSubview(casePreviewVideoPlayerVimeoYoutube)
 
  }
  
  private func createCaseNameLabel() {
    
    caseNameLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: caseData.name,
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    caseNameLabel.attributedText = stringWithFormat
    caseNameLabel.sizeToFit()
    let newFrame = CGRect.init(x: 2.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 140.0 * UtilityManager.sharedInstance.conversionHeight - (caseNameLabel.frame.size.height),
                               width: caseNameLabel.frame.size.width,
                               height: caseNameLabel.frame.size.height)
    
    caseNameLabel.frame = newFrame
    self.addSubview(caseNameLabel)
  
  }
  
  private func createTwoPointsButton() {
    
    twoPointsButton = UIButton.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: ":",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    twoPointsButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    twoPointsButton.addTarget(self,
                              action: #selector(delegateFlipCardAndShowPreviewCase),
                              forControlEvents: .TouchUpInside)
    twoPointsButton.sizeToFit()
    
    let frameForButton = CGRect.init(x:(220.0 * UtilityManager.sharedInstance.conversionWidth) - (25.0 * UtilityManager.sharedInstance.conversionWidth),
                                     y: 140.0 * UtilityManager.sharedInstance.conversionHeight - (twoPointsButton.frame.size.height),
                                 width: twoPointsButton.frame.size.width,
                                height: twoPointsButton.frame.size.height)
    
    twoPointsButton.frame = frameForButton
    
    self.addSubview(twoPointsButton)
  }
  
  
  @objc private func delegateFlipCardAndShowPreviewCase() {
    
    print(self.caseData)
    
    self.delegate?.flipCardAndShowPreviewCase(self.caseData)
    
  }
  
  //MARK: - PreviewVimeoYoutubeDelegate
  
  func deleteSelectedCase(caseData: Case) {
    self.delegate?.deleteCaseFromPreviewPlayer(caseData)
  }
  
  func editSelectedCase(caseData: Case) {
    ///EDIT CASE
  }
  
  
}
