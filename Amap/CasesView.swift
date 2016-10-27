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
  func flipCardAndShowPreviewOfCase(caseData: Case)
  func deleteCaseSelectedFromPreviewVimeoYoutubePlayer(caseData: Case)
}

class CasesView: UIView, CaseCardInfoViewDelegate {
  
  let kLimitOfCases = 4
  
  private var casesLabel: UILabel! = nil
  private var mainScrollView: UIScrollView! = nil
  private var creatorOfCasesView: UIView! = nil
  private var arrayOfCases: [Case]! = nil
  private var arrayOfCasesCards: [CaseCardInfoView]! = nil
  
  
  var delegate: CasesViewDelegate?
  var justVisualizeDelegate: VisualizeCasesDelegate?
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    self.initSomeValues()
    self.initInterface()
    
  }
  
  private func initSomeValues() {
    
    arrayOfCases = []
    arrayOfCasesCards = []
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    
    self.createCasesLabel()
    self.createMainScrollView()
    
    //
    self.createCaseCardsInfo()
    //
//    
//    self.createCreatorOfCasesView()
    
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
                                             width: 235.0 * UtilityManager.sharedInstance.conversionWidth,
                                             height: 374.0 * UtilityManager.sharedInstance.conversionHeight)//Value that I considered
    let sizeForContentScrollView = CGSize.init(width: frameForMainScrollView.size.width,
                                               height: frameForMainScrollView.size.height + (150.0 * UtilityManager.sharedInstance.conversionHeight))//Value that i considered
    
    mainScrollView = UIScrollView.init(frame: frameForMainScrollView)
    mainScrollView.backgroundColor = UIColor.clearColor()
    mainScrollView.contentSize = sizeForContentScrollView
    mainScrollView.showsVerticalScrollIndicator = true
    self.addSubview(mainScrollView)
    
  }
  
  private func createCaseCardsInfo() {
    
    if arrayOfCasesCards != nil && arrayOfCasesCards.count > 0 {
      
      for caseCard in arrayOfCasesCards {
        
        caseCard.removeFromSuperview()
        
      }
      
      arrayOfCasesCards.removeAll()
      
    }
    
    self.loadCases()
  
  }
  
  private func loadCases() {
    
    RequestToServerManager.sharedInstance.requestForAgencyData {
      if AgencyModel.Data.success_cases != nil {
    
        self.arrayOfCases = AgencyModel.Data.success_cases
        
        self.createCaseCardsInfoAfterRequestToServer()

        UtilityManager.sharedInstance.hideLoader()
        
      }
    }

  }
  
  private func createCaseCardsInfoAfterRequestToServer() {
    
    var frameForCaseCard = CGRect.init(x: 0.0,
                                       y: 0.0,
                                       width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                       height: 140.0 * UtilityManager.sharedInstance.conversionHeight)
    
    if arrayOfCases != nil && arrayOfCases.count > 0 {
      
      for caseInArray in arrayOfCases {
        
        let caseCardInfo = CaseCardInfoView.init(frame: frameForCaseCard, dataFromCase: caseInArray)
        caseCardInfo.delegate = self
        
        frameForCaseCard = CGRect.init(x: 0.0,
                                       y: frameForCaseCard.origin.y + (160.0 * UtilityManager.sharedInstance.conversionHeight),
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                  height: 140.0 * UtilityManager.sharedInstance.conversionHeight)
        self.mainScrollView.addSubview(caseCardInfo)
        
        self.arrayOfCasesCards.append(caseCardInfo)
        
      }
      
    }
    
  let frameForCreatorOfCases = frameForCaseCard
    
    let newContentSize = CGSize.init(width: mainScrollView.contentSize.width,
                                    height: frameForCreatorOfCases.origin.y + frameForCreatorOfCases.size.height + (35.0 * UtilityManager.sharedInstance.conversionHeight))
    
    mainScrollView.contentSize = newContentSize
    self.createCreatorOfCasesView(frameForCreatorOfCases)
    
  }
  
  private func createCreatorOfCasesView(frameForCreatorOfCases: CGRect) {
    
    if creatorOfCasesView == nil {
      
      let finalFrame = CGRect.init(x: frameForCreatorOfCases.origin.x,
                                   y: frameForCreatorOfCases.origin.y,
                               width: frameForCreatorOfCases.size.width,
                              height: 50.0 * UtilityManager.sharedInstance.conversionHeight)
      
      
      creatorOfCasesView = UIView.init(frame: finalFrame)
      creatorOfCasesView.backgroundColor = UIColor.clearColor()
      self.mainScrollView.addSubview(creatorOfCasesView)
      
      self.cretaeAndAddButtonForCreateNewCase()
      
    }else{
      
      UIView.animateWithDuration(0.35){
        
        self.creatorOfCasesView.frame = frameForCreatorOfCases
        
      }
      
    }
    
  }
  
  private func cretaeAndAddButtonForCreateNewCase() {
    
    let frameForButton = CGRect.init(x: (creatorOfCasesView.frame.size.width / 2.0) - ((110.0 / 2.0) * UtilityManager.sharedInstance.conversionWidth),
                                     y: ((creatorOfCasesView.frame.size.height / 2.0) - (70.0 / 2.0) * UtilityManager.sharedInstance.conversionHeight),
                                     width: 110.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 50.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 11.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: AgencyProfileEditConstants.CasesView.createNewCaseButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    stringWithFormat.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: NSMakeRange(0, AgencyProfileEditConstants.CasesView.createNewCaseButtonText.characters.count))
    
    let createAnotherCaseButton = UIButton.init(frame: frameForButton)
    createAnotherCaseButton.addTarget(self,
                                      action: #selector(createAndAddAnotherCase),
                                      forControlEvents: .TouchUpInside)
    
    createAnotherCaseButton.backgroundColor = UIColor.clearColor()
    createAnotherCaseButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    self.creatorOfCasesView.addSubview(createAnotherCaseButton)
    
  }
  
  @objc private func createAndAddAnotherCase() {
    
    self.delegate?.flipCardAndShowCreateNewCase()
    
  }
  
  func addCaseToViewsOfCase(newCase: Case){
    
//    if arrayOfCases.count == kLimitOfCases {
//      
//      arrayOfCases.popLast()
//      arrayOfCases.insert(newCase, atIndex: 0)
//      
//    }else{
//      
//      arrayOfCases.insert(newCase, atIndex: 0)
//      
//    }
    
    self.createCaseCardsInfo()
    
  }
  
  //MARK: - CaseCardInfoDelegate
  
  func flipCardAndShowPreviewCase(caseData: Case) {
    
    self.delegate?.flipCardAndShowPreviewOfCase(caseData)
    
  }
  
  func deleteCaseFromPreviewPlayer(caseData: Case) {
    self.delegate?.deleteCaseSelectedFromPreviewVimeoYoutubePlayer(caseData)
  }
  
  func createAgainAllCasesCardInfo() {
    
    self.createCaseCardsInfo()
    
  }
  
}
