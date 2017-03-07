//
//  VisualizeCaseDetailViewController.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/7/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit
import MessageUI

protocol VisualizeCaseDetailViewControllerDelegate {
  
  func showCasesFromCaseDetailViewController()
  
}

class VisualizeCaseDetailViewController: UIViewController, MFMailComposeViewControllerDelegate {
  
  let kNotificationCenterKey = "ReceiveImageSuccessfully"
  
  private var caseData: Case! = nil
  private var backgroundView: UIView! = nil
  private var mainScrollView: UIScrollView! = nil
  private var caseNameLabel: UILabel! = nil
  private var caseDescriptionLabel: UILabel! = nil
  private var playerVimeoYoutube: VideoPlayerVimeoYoutubeView! = nil
  private var linkLabel: UILabel! = nil
  private var shareThisInfo: UIView! = nil
  private var imageCase: UIImageView! = nil
  
  private var mailIconButton: UIButton! = nil
  private var whatsAppIconButton: UIButton! = nil
  
  var delegate: VisualizeCaseDetailViewControllerDelegate?
  
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
    
    self.addLikeObserver()
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
    self.createLinkLabel()
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
                                             y: 70.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: 310.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 540.0 * UtilityManager.sharedInstance.conversionHeight)
    
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
                               y: 5.0 * UtilityManager.sharedInstance.conversionHeight,
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
                                                            url: caseData.case_video_url,
                                                       urlImage: nil)
    if playerVimeoYoutube.changeCaseImageButton != nil && playerVimeoYoutube.deleteCaseImageButton != nil {
    
      playerVimeoYoutube.changeCaseImageButton.removeFromSuperview()
      playerVimeoYoutube.deleteCaseImageButton.removeFromSuperview()
    
    }
    
    
    if caseData.case_image_url != nil && UIApplication.sharedApplication().canOpenURL(NSURL.init(string: caseData.case_image_url!)!) == true {
//      let frameForImageView = CGRect.init(x: 0.0,
//                                          y: 0.0,
//                                      width: playerVimeoYoutube.frame.size.width,
//                                     height: playerVimeoYoutube.frame.size.height)
      
      imageCase = UIImageView.init(frame: frameForPlayer)
      imageCase.backgroundColor = UIColor.clearColor()
      imageCase.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
      imageCase.contentMode = .ScaleAspectFit
      imageCase.imageFromUrlAndAdaptToSize(caseData.case_image_url!)
      mainScrollView.addSubview(imageCase)

      
//      playerVimeoYoutube.imageForCaseImageView = nil
//      playerVimeoYoutube.imageForCaseImageView = UIImageView.init(frame: frameForImageView)
//      playerVimeoYoutube.imageForCaseImageView.backgroundColor = UIColor.whiteColor()
//      playerVimeoYoutube.imageForCaseImageView.userInteractionEnabled = true
//      playerVimeoYoutube.imageForCaseImageView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
//      playerVimeoYoutube.imageForCaseImageView.contentMode = .ScaleAspectFit
//      playerVimeoYoutube.imageForCaseImageView.center = playerVimeoYoutube.center
//    
//      playerVimeoYoutube.imageForCaseImageView.imageFromUrlAndAdaptToSize(caseData.case_image_url!)
//      playerVimeoYoutube.addSubview(playerVimeoYoutube.imageForCaseImageView)
    }
    
    
    playerVimeoYoutube.changeCaseImageButton = nil
    playerVimeoYoutube.deleteCaseImageButton = nil
    
    playerVimeoYoutube.backgroundColor = UIColor.clearColor()
    
    mainScrollView.addSubview(playerVimeoYoutube)
    
    if playerVimeoYoutube.frame.origin.y + playerVimeoYoutube.frame.size.height + (30.0 * UtilityManager.sharedInstance.conversionHeight) >= mainScrollView.frame.size.height {
      
      mainScrollView.contentSize = CGSize.init(width: mainScrollView.frame.size.width,
                                              height: mainScrollView.frame.size.height + (playerVimeoYoutube.frame.origin.y + playerVimeoYoutube.frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight)))
      
    }
    
  }
  
  private func createLinkLabel() {
    
    var finalURL = ""
    
    if caseData.url != nil && caseData.url != "" {
      
      finalURL = caseData.url
      
    }
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    linkLabel = UILabel.init(frame: frameForLabel)
    linkLabel.numberOfLines = 0
    linkLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: finalURL,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    linkLabel.attributedText = stringWithFormat
    linkLabel.sizeToFit()
    let newFrame = CGRect.init(x: 0.0,
                               y: playerVimeoYoutube.frame.origin.y + playerVimeoYoutube.frame.size.height + (30.0 * UtilityManager.sharedInstance.conversionHeight),    //295.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: linkLabel.frame.size.width,
                               height: linkLabel.frame.size.height)
    
    linkLabel.frame = newFrame
    
    mainScrollView.addSubview(linkLabel)
    
  }
  
  private func createShareThisInfo() {
    
    var frameForShareView: CGRect
    
    if linkLabel != nil {
      
      frameForShareView = CGRect.init(x: 0.0,
                                      y: linkLabel.frame.origin.y + linkLabel.frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight),
                                  width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                                 height: 78.0 * UtilityManager.sharedInstance.conversionHeight)
      
    } else {
      
      frameForShareView = CGRect.init(x: 0.0,
                                      y: 295.0 * UtilityManager.sharedInstance.conversionHeight,
                                  width: 295.0 * UtilityManager.sharedInstance.conversionWidth,
                                 height: 78.0 * UtilityManager.sharedInstance.conversionHeight)
      
    }
    

    
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
    
    mailIconButton = UIButton.init(frame: frameForButton)
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
    
    whatsAppIconButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "page1") as UIImage?
    whatsAppIconButton.setImage(image, forState: .Normal)
    
    whatsAppIconButton.backgroundColor = UIColor.clearColor()
    whatsAppIconButton.tag = 2
    whatsAppIconButton.addTarget(self, action: #selector(whatsAppButtonPressed), forControlEvents:.TouchUpInside)
    shareThisInfo.addSubview(whatsAppIconButton)
 
  }
  
  override func viewDidLoad() {
    
//    self.addLikeObserver()
    
  }
  
  private func addLikeObserver() {
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(changePositionOfButtons) , name: kNotificationCenterKey, object: nil)
    
  }
  
  @objc private func changePositionOfButtons(notification: NSNotification) {
    
    if notification.userInfo?["image"] as? UIImage != nil {
      
      let image = notification.userInfo?["image"] as! UIImage
      let sizeInPixels = CGSize.init(width: image.size.width * image.scale,
                                    height: image.size.height * image.scale)
      
      if sizeInPixels.width < (295.0 * UtilityManager.sharedInstance.conversionWidth) {
        
        imageCase.frame = CGRect.init(x: (imageCase.frame.size.width / 2.0) - (image.size.width / 2.0),
                                      y: imageCase.frame.origin.y,
                                  width: sizeInPixels.width,
                                 height: sizeInPixels.height)
        
      }
      
      UIView.animateWithDuration(0.35) {
        
        if self.linkLabel != nil && (UtilityManager.sharedInstance.validateIfLinkIsYoutube(self.caseData.case_video_url) == true || UtilityManager.sharedInstance.validateIfLinkIsVimeo(self.caseData.case_video_url) == true) {
        
          self.playerVimeoYoutube.frame = CGRect.init(
            x: self.playerVimeoYoutube.frame.origin.x,
            y: self.playerVimeoYoutube.frame.origin.y + sizeInPixels.height + (30.0 * UtilityManager.sharedInstance.conversionHeight),
        width: self.playerVimeoYoutube.frame.size.width,
       height: self.playerVimeoYoutube.frame.size.height)
          
          self.linkLabel.frame = CGRect.init(
            x: self.linkLabel.frame.origin.x,
            y: self.playerVimeoYoutube.frame.origin.y + self.playerVimeoYoutube.frame.size.height + (30.0 * UtilityManager.sharedInstance.conversionHeight),
        width: self.linkLabel.frame.size.width,
       height: self.linkLabel.frame.size.height)
          
          self.shareThisInfo.frame = CGRect.init(x: self.shareThisInfo.frame.origin.x,
                                                 y: self.linkLabel.frame.origin.y + self.linkLabel.frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight),
                                             width: self.shareThisInfo.frame.size.width,
                                            height: self.shareThisInfo.frame.size.height)
          
        } else
          
          //when linllabek != nil  && (UtilityManager.sharedInstance.validateIfLinkIsYoutube(self.caseData.case_video_url) == false || UtilityManager.sharedInstance.validateIfLinkIsVimeo(self.caseData.case_video_url) == false)
        
          if self.linkLabel == nil && (UtilityManager.sharedInstance.validateIfLinkIsYoutube(self.caseData.case_video_url) == true || UtilityManager.sharedInstance.validateIfLinkIsVimeo(self.caseData.case_video_url) == true) {
            
            self.playerVimeoYoutube.frame = CGRect.init(
              x: self.playerVimeoYoutube.frame.origin.x,
              y: self.playerVimeoYoutube.frame.origin.y + sizeInPixels.height + (30.0 * UtilityManager.sharedInstance.conversionHeight),
              width: self.playerVimeoYoutube.frame.size.width,
              height: self.playerVimeoYoutube.frame.size.height)
            
            self.shareThisInfo.frame = CGRect.init(x: self.shareThisInfo.frame.origin.x,
                                                   y: self.playerVimeoYoutube.frame.origin.y + self.playerVimeoYoutube.frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight),
                                                   width: self.shareThisInfo.frame.size.width,
                                                   height: self.shareThisInfo.frame.size.height)
            
            
        } else
            
          if self.linkLabel != nil {
            
            self.linkLabel.frame = CGRect.init(
              x: self.linkLabel.frame.origin.x,
              y: self.imageCase.frame.origin.y + self.imageCase.frame.size.height + (30.0 * UtilityManager.sharedInstance.conversionHeight),
          width: self.linkLabel.frame.size.width,
         height: self.linkLabel.frame.size.height)
            
            self.shareThisInfo.frame = CGRect.init(x: self.shareThisInfo.frame.origin.x,
                                                   y: self.linkLabel.frame.origin.y + self.linkLabel.frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight),
                                               width: self.shareThisInfo.frame.size.width,
                                              height: self.shareThisInfo.frame.size.height)
              
          } else {
          
          self.shareThisInfo.frame = CGRect.init(x: self.shareThisInfo.frame.origin.x,
                                                 y: self.imageCase.frame.origin.y + self.imageCase.frame.size.height + (20.0 * UtilityManager.sharedInstance.conversionHeight),
                                             width: self.shareThisInfo.frame.size.width,
                                            height: self.shareThisInfo.frame.size.height)
        
        }
        
      }
      
      if ( UtilityManager.sharedInstance.validateIfLinkIsYoutube(caseData.case_video_url) == true || UtilityManager.sharedInstance.validateIfLinkIsVimeo(caseData.case_video_url) == true ) == false{
        
        if caseNameLabel.frame.size.height + caseDescriptionLabel.frame.size.height + sizeInPixels.height + (95.0 * UtilityManager.sharedInstance.conversionHeight) >= mainScrollView.frame.size.height {
          
          mainScrollView.contentSize = CGSize.init(width: mainScrollView.contentSize.width,
                                                   height: caseNameLabel.frame.size.height + linkLabel.frame.size.height + caseDescriptionLabel.frame.size.height + sizeInPixels.height + ( (78.0 + 190.0) * UtilityManager.sharedInstance.conversionHeight))
          
        }

      } else {
        
        if caseNameLabel.frame.size.height + caseDescriptionLabel.frame.size.height + sizeInPixels.height + playerVimeoYoutube.frame.size.height + (150.0 * UtilityManager.sharedInstance.conversionHeight) >= mainScrollView.frame.size.height {
          
          mainScrollView.contentSize = CGSize.init(width: mainScrollView.contentSize.width,
                                                   height: caseNameLabel.frame.size.height + caseDescriptionLabel.frame.size.height + sizeInPixels.height + playerVimeoYoutube.frame.size.height  + ( (78.0 + 220.0) * UtilityManager.sharedInstance.conversionHeight))
          
        }
        
      }
      

      
    } else
      if notification.userInfo?["image"] as? String != nil {
    
        let message = notification.userInfo?["image"] as! String
        if message == "No hay imagen" {
          
          self.showErrorFromDownloadImage()
          
        }
        
    }
    
  }
  
  private func showErrorFromDownloadImage() {
    
    print()
    
  }
  
  @objc private func popThis() {
    
    self.navigationController?.popViewControllerAnimated(true)
    
  }
  
  override func viewWillDisappear(animated: Bool) {
    
    super.viewWillDisappear(animated)
    
    NSNotificationCenter.defaultCenter().removeObserver(self)
    
    self.delegate?.showCasesFromCaseDetailViewController()
    
  }
  
  @objc private func mailIconPressed() {
    
    if UtilityManager.sharedInstance.validateIfLinkIsYoutube(caseData.case_video_url) || UtilityManager.sharedInstance.validateIfLinkIsVimeo(caseData.case_video_url)  || (caseData.url != nil && caseData.url != "") {
      
      self.shareURLViaMail()
      
      
    } else
      
    if imageCase.image != nil {
        
        self.shareImageViaMail()
        
    }
    
  }
  
  private func shareURLViaMail() {
      
    let mailComposeVC = MFMailComposeViewController()
    mailComposeVC.mailComposeDelegate = self
      
    mailComposeVC.setSubject("Caso \(caseData.name)")
    
    var finalText = ""
    
    if caseData.url != nil && caseData.url != "" {
      
      finalText = caseData.url
      
    } else
    
      if caseData.case_video_url != nil && caseData.case_video_url != "" {
        
        finalText = finalText + "\n" + caseData.case_video_url!
        
      }
      
    mailComposeVC.setMessageBody("Conoce el caso \(caseData.name) de \(AgencyModel.Data.name). \n\(finalText)\n\nDescarga Android\nDescarga iOS", isHTML: false)
      
    self.presentViewController(mailComposeVC, animated: true, completion: nil)
    
  }
  
  private func shareImageViaMail() {
      
    let mailComposeVC = MFMailComposeViewController()
    mailComposeVC.mailComposeDelegate = self
    
    var finalText = ""
    
    if caseData.url != nil && caseData.url != "" {
      
      finalText = caseData.url
      
    } else
      
      if caseData.case_video_url != nil && caseData.case_video_url != "" {
        
        finalText = finalText + "\n" + caseData.case_video_url!
        
    }
    
    mailComposeVC.addAttachmentData(UIImageJPEGRepresentation(imageCase.image!, CGFloat(1.0))!, mimeType: "image/jpeg", fileName:"caso_\(caseData.name).jpeg")
      
    mailComposeVC.setSubject("Caso \(caseData.name)")
      
    mailComposeVC.setMessageBody("Descarga Happitch y conoce el caso \(caseData.name) de \(AgencyModel.Data.name). \n\(finalText)\n\nDescarga Android\nDescarga iOS", isHTML: false)
      
    self.presentViewController(mailComposeVC, animated: true, completion: nil)
    
  }
  
  @objc private func whatsAppButtonPressed() {
    
    if UtilityManager.sharedInstance.validateIfLinkIsYoutube(caseData.case_video_url) || UtilityManager.sharedInstance.validateIfLinkIsVimeo(caseData.case_video_url)  || (caseData.url != nil && caseData.url != "") {
      
      self.shareURLViaWhatsapp()
      
      
    } else
      
      if imageCase.image != nil {
        
        self.shareImageViaWhatsapp()
        
      }
    
  }
  
  private func shareURLViaWhatsapp() {
    
    var finalText = ""
    
    if caseData.url != nil && caseData.url != "" {
      
      finalText = caseData.url
      
    } else
      
      if caseData.case_video_url != nil && caseData.case_video_url != "" {
        
        finalText = caseData.case_video_url!
        
    }
    
    let textToShare = "Conoce el caso \(caseData.name) de \(AgencyModel.Data.name):\n\(finalText)\n\nDescarga Android\nDescarga iOS"
    
    let activityItems: [AnyObject] = [textToShare]
    
    let activityController = UIActivityViewController.init(activityItems: activityItems,
                                                           applicationActivities: nil)
    
    activityController.excludedActivityTypes = [ UIActivityTypePrint,
                                                 UIActivityTypeCopyToPasteboard,
                                                 UIActivityTypeAssignToContact,
                                                 UIActivityTypeSaveToCameraRoll,
                                                 UIActivityTypeAddToReadingList,
                                                 UIActivityTypeAirDrop,
                                                 UIActivityTypeMail,
                                                 UIActivityTypeMessage]
    
    self.presentViewController(activityController, animated: true, completion: nil)

  }
  
  private func shareImageViaWhatsapp() {
    
    if imageCase.image != nil {
      
      
      let textToShare = "Descarga Happitch y conoce el caso \(caseData.name) de \(AgencyModel.Data.name)\n\nDescarga Android\nDescarga iOS"
      
      let activityItems: [AnyObject] = [textToShare, imageCase.image!]
      
      let activityController = UIActivityViewController.init(activityItems: activityItems,
                                                     applicationActivities: nil)
      
      activityController.excludedActivityTypes = [ UIActivityTypePrint,
                                                   UIActivityTypeCopyToPasteboard,
                                                   UIActivityTypeAssignToContact,
                                                   UIActivityTypeSaveToCameraRoll,
                                                   UIActivityTypeAddToReadingList,
                                                   UIActivityTypeAirDrop,
                                                   UIActivityTypeMail,
                                                   UIActivityTypeMessage]
    
      self.presentViewController(activityController, animated: true, completion: nil)
      
    }
    
  }
  
  func showSendMailErrorAlert() {
    
    let alertController = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: UIAlertControllerStyle.Alert)
    
    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel) { (result : UIAlertAction) -> Void in
      
    }
    
    alertController.addAction(okAction)
    self.presentViewController(alertController, animated: true, completion: nil)
    
  }
  
  func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
    controller.dismissViewControllerAnimated(true, completion: nil)
  }
  
  override func viewWillAppear(animated: Bool) {
    UIView.setAnimationsEnabled(true)
  }
  
}
