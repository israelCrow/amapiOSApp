//
//  VisualizeCaseDetailViewController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/7/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class VisualizeCaseDetailViewController: UIViewController {
  
  private var caseData: Case! = nil
  private var backgroundView: UIView! = nil
  private var mainScrollView: UIScrollView! = nil
  private var caseNameLabel: UILabel! = nil
  private var caseDescriptionLabel: UILabel! = nil
  private var playerVimeoYoutube: VideoPlayerVimeoYoutubeView! = nil
  private var shareThisInfo: UIView! = nil
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(dataOfCase: Case) {
    
    caseData = dataOfCase
    
    super.init(nibName: nil, bundle: nil)
    
  }
  
  override func loadView() {
    self.view = UIView.init(frame: UIScreen.mainScreen().bounds)
    self.view.backgroundColor = UIColor.blackColor()
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.navigationController?.navigationBarHidden = false
    
    self.changeBackButtonItem()
    self.changeNavigationBarTitle()
    self.changeRigthButtonItem()
    self.createBackgroundView()
    self.createMainScrollView()
    self.createCaseNameLabel()
    self.createCaseDescriptionLabel()
    self.createPlayerVimeoYoutube()
    
    self.createShareThisInfo()
    
  }
  
  private func changeBackButtonItem() {
    
    let leftButton = UIBarButtonItem(title: "",
                                     style: UIBarButtonItemStyle.Plain,
                                     target: self,
                                     action: nil)
    
    self.navigationItem.leftBarButtonItem = leftButton
    
  }
  
  private func changeNavigationBarTitle() {
    
    let titleLabel = UILabel.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 17.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: AgencyProfileVisualizeConstants.VisualizeCaseViewController.navigationBarText,
      attributes:[NSFontAttributeName:font!,
        NSParagraphStyleAttributeName:style,
        NSForegroundColorAttributeName:color
      ]
    )
    titleLabel.attributedText = stringWithFormat
    titleLabel.sizeToFit()
    self.navigationItem.titleView = titleLabel
    
  }
  
  private func changeRigthButtonItem() {
    
    let rightButton = UIBarButtonItem(title: AgencyProfileVisualizeConstants.VisualizeCaseViewController.rightButtonText,
                                      style: UIBarButtonItemStyle.Plain,
                                      target: self,
                                      action: #selector(popThis))
    
    let fontForButtonItem =  UIFont(name: "SFUIText-Regular",
                                    size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    
    let attributesDict: [String:AnyObject] = [NSFontAttributeName: fontForButtonItem!,
                                              NSForegroundColorAttributeName: UIColor.whiteColor()
    ]
    
    rightButton.setTitleTextAttributes(attributesDict, forState: .Normal)
    
    self.navigationItem.rightBarButtonItem = rightButton
    
  }
  
  private func createBackgroundView() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: 60.0,
                                   width: UIScreen.mainScreen().bounds.size.width,
                                   height: UIScreen.mainScreen().bounds.size.height - 60.0)
    
    backgroundView = UIView.init(frame: frameForView)
    backgroundView.backgroundColor = UIColor.whiteColor()
    self.view.addSubview(backgroundView)
    
  }
  
  private func createMainScrollView() {
    
    let frameForMainScrollView = CGRect.init(x: 40.0 * UtilityManager.sharedInstance.conversionWidth,
                                             y: 100.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: 310.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 510.0 * UtilityManager.sharedInstance.conversionHeight)
    
    mainScrollView = UIScrollView.init(frame: frameForMainScrollView)
    mainScrollView.contentSize = CGSize.init(width: mainScrollView.frame.size.width,
                                             height: mainScrollView.frame.size.height + 50.0)
    mainScrollView.backgroundColor = UIColor.clearColor()
    
    self.view.addSubview(mainScrollView)
    
  }
  
  private func createCaseNameLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    caseNameLabel = UILabel.init(frame: frameForLabel)
    caseNameLabel.numberOfLines = 0
    caseNameLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: caseData.name,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    caseNameLabel.attributedText = stringWithFormat
    caseNameLabel.sizeToFit()
    let newFrame = CGRect.init(x: 0.0,
                               y: 0.0,
                               width: caseNameLabel.frame.size.width,
                               height: caseNameLabel.frame.size.height)
    
    caseNameLabel.frame = newFrame
    
    mainScrollView.addSubview(caseNameLabel)
    
  }
  
  private func createCaseDescriptionLabel() {
    
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: caseNameLabel.frame.origin.y + caseNameLabel.frame.size.height + (30.0 * UtilityManager.sharedInstance.conversionHeight),
                                    width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    caseDescriptionLabel = UILabel.init(frame: frameForLabel)
    caseDescriptionLabel.numberOfLines = 0
    caseDescriptionLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: caseData.description,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    caseDescriptionLabel.attributedText = stringWithFormat
    caseDescriptionLabel.sizeToFit()
    let newFrame = CGRect.init(x: 0.0,
                               y: caseNameLabel.frame.origin.y + caseNameLabel.frame.size.height + (30.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: caseDescriptionLabel.frame.size.width,
                               height: caseDescriptionLabel.frame.size.height)
    
    caseDescriptionLabel.frame = newFrame
    
    mainScrollView.addSubview(caseDescriptionLabel)
    
  }
  
  private func createPlayerVimeoYoutube() {
    
    let frameForPlayer = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: caseDescriptionLabel.frame.origin.y + caseDescriptionLabel.frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 148.0 * UtilityManager.sharedInstance.conversionHeight)
    
    playerVimeoYoutube = VideoPlayerVimeoYoutubeView.init(frame: frameForPlayer,
                                                            url: caseData.url,
                                                       urlImage: nil)
    if playerVimeoYoutube.changeCaseImageButton != nil && playerVimeoYoutube.deleteCaseImageButton != nil {
    
      playerVimeoYoutube.changeCaseImageButton.removeFromSuperview()
      playerVimeoYoutube.deleteCaseImageButton.removeFromSuperview()
    
    }
    
    
    if caseData.case_image_url != nil && UIApplication.sharedApplication().canOpenURL(NSURL.init(string: caseData.case_image_url!)!) == true{
      let frameForImageView = CGRect.init(x: 0.0,
                                          y: 0.0,
                                      width: playerVimeoYoutube.frame.size.width,
                                     height: playerVimeoYoutube.frame.size.height)
      playerVimeoYoutube.imageForCaseImageView = nil
      playerVimeoYoutube.imageForCaseImageView = UIImageView.init(frame: frameForImageView)
      playerVimeoYoutube.imageForCaseImageView.backgroundColor = UIColor.lightGrayColor()
      playerVimeoYoutube.imageForCaseImageView.userInteractionEnabled = true
      playerVimeoYoutube.imageForCaseImageView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
      playerVimeoYoutube.imageForCaseImageView.contentMode = .ScaleAspectFit
      playerVimeoYoutube.imageForCaseImageView.center = playerVimeoYoutube.center
    
      playerVimeoYoutube.imageForCaseImageView.imageFromUrlAndAdaptToSize(caseData.case_image_url!)
      playerVimeoYoutube.addSubview(playerVimeoYoutube.imageForCaseImageView)
    }
    
    
    playerVimeoYoutube.changeCaseImageButton = nil
    playerVimeoYoutube.deleteCaseImageButton = nil
    
    mainScrollView.addSubview(playerVimeoYoutube)
    
    if playerVimeoYoutube.frame.origin.y + playerVimeoYoutube.frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight) >= mainScrollView.frame.size.height {
      
      mainScrollView.contentSize = CGSize.init(width: mainScrollView.frame.size.width,
                                              height: mainScrollView.frame.size.height + (mainScrollView.frame.size.height - (playerVimeoYoutube.frame.origin.y + playerVimeoYoutube.frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight))))
      
    }
    
  }
  
  private func createShareThisInfo() {
    
    let frameForShareView = CGRect.init(x: 0.0,
                                        y: 360.0 * UtilityManager.sharedInstance.conversionHeight,
                                    width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 78.0 * UtilityManager.sharedInstance.conversionHeight)
    
    shareThisInfo = UIView.init(frame: frameForShareView)
    shareThisInfo.backgroundColor = UIColor.clearColor()
    mainScrollView.addSubview(shareThisInfo)
    
    self.createLabel()
    self.createMailButton()
    self.createWhatsappButton()
    
  }
  
  private func createLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    let shareLabel = UILabel.init(frame: frameForLabel)
    shareLabel.numberOfLines = 0
    shareLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Medium",
                      size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.init(white: 0.0, alpha: 0.25)
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Comparte este contenido",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    shareLabel.attributedText = stringWithFormat
    shareLabel.sizeToFit()
    let newFrame = CGRect.init(x: 0.0,
                               y: 0.0,
                               width: shareLabel.frame.size.width,
                               height: shareLabel.frame.size.height)
    
    shareLabel.frame = newFrame
    
    shareThisInfo.addSubview(shareLabel)
    
  }
  
  private func createMailButton() {
    
    let frameForButton = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 38.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 24.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 16.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let mailIconButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "iconMailBlack") as UIImage?
    mailIconButton.setImage(image, forState: .Normal)
    
    mailIconButton.backgroundColor = UIColor.clearColor()
    mailIconButton.tag = 1
    mailIconButton.addTarget(self, action: #selector(mailIconPressed), forControlEvents:.TouchUpInside)
    shareThisInfo.addSubview(mailIconButton)
    
  }
  
  private func createWhatsappButton() {
    
    let frameForButton = CGRect.init(x: 56.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 38.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 19.6 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 19.6 * UtilityManager.sharedInstance.conversionHeight)
    
    let whatsAppButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "page1") as UIImage?
    whatsAppButton.setImage(image, forState: .Normal)
    
    whatsAppButton.backgroundColor = UIColor.clearColor()
    whatsAppButton.tag = 2
    whatsAppButton.addTarget(self, action: #selector(whatsAppButtonPressed), forControlEvents:.TouchUpInside)
    shareThisInfo.addSubview(whatsAppButton)
    
    
  }
  
  @objc private func popThis() {
    
    self.navigationController?.popViewControllerAnimated(true)
    
  }
  
  @objc private func mailIconPressed() {
    
    
    
  }
  
  @objc private func whatsAppButtonPressed() {
    
    
    
  }
  
  override func viewWillAppear(animated: Bool) {
    UIView.setAnimationsEnabled(true)
  }
  
}
