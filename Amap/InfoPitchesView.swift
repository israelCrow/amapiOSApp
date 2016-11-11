//
//  InfoPitchesView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 11/7/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol InfoPitchesViewDelegate {
  
  func mailIconPressedFromInfoPitchesView()
  func phoneIconPressedFromInfoPtichesView()
  func webPageIconPressedFronInfoPitchesView()

}

class InfoPitchesView: UIView {
  
  private var mainScrollView: UIScrollView! = nil
  
  //
  
  private var evaluationLabel: UILabel! = nil
  
  private var faceOneIcon: UIImageView! = nil
  private var faceOneLabel: UILabel! = nil
  
  private var faceTwoIcon: UIImageView! = nil
  private var faceTwoLabel: UILabel! = nil
  
  private var faceThreeIcon: UIImageView! = nil
  private var faceThreeLabel: UILabel! = nil
  
  private var faceFourIcon: UIImageView! = nil
  private var faceFourLabel: UILabel! = nil
  
  //
  
  private var statisticsLabel: UILabel! = nil
  private var statisticsDescriptionLabel: UILabel! = nil
  
  //
  
  private var contactLabel: UILabel! = nil
  
  private var mailIcon: UIButton! = nil
  private var mailLabel: UILabel! = nil
  
  private var phoneIcon: UIButton! = nil
  private var phoneLabel: UILabel! = nil
  
  private var webPageIcon: UIButton! = nil
  private var webPageLabel: UILabel! = nil
  
  var delegate: InfoPitchesViewDelegate?

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    self.createMainScrollView()
    self.createEvaluation()
    self.createStatistics()
    self.createContact()
    
  }
  
  private func createMainScrollView() {
    
    let frameForMainScrollView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                             y: 30.0 * UtilityManager.sharedInstance.conversionHeight,
                                         width: 230.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: self.frame.size.height - (30.0 * UtilityManager.sharedInstance.conversionHeight))
    
    let sizeForContentScrollView = CGSize.init(width: frameForMainScrollView.size.width,
                                              height: frameForMainScrollView.size.height + (200.0 * UtilityManager.sharedInstance.conversionHeight))//Value that i considered
    
    mainScrollView = UIScrollView.init(frame: frameForMainScrollView)
    mainScrollView.backgroundColor = UIColor.clearColor()
    mainScrollView.contentSize = sizeForContentScrollView
    mainScrollView.showsVerticalScrollIndicator = true
    self.addSubview(mainScrollView)
    
  }
  
  private func createEvaluation() {
    
    self.createEvaluationLabel()
    self.createEvaluationFaces()
    self.createSeparatorLineForEvaluation()
    
  }
  
  private func createEvaluationLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 160.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    evaluationLabel = UILabel.init(frame: frameForLabel)
    evaluationLabel.numberOfLines = 0
    evaluationLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.InfoPitchesViewAndViewController.evaluationLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    evaluationLabel.attributedText = stringWithFormat
    evaluationLabel.sizeToFit()
    let newFrame = CGRect.init(x: 35.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 0.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: evaluationLabel.frame.size.width,
                               height: evaluationLabel.frame.size.height)
    
    evaluationLabel.frame = newFrame
    
    mainScrollView.addSubview(evaluationLabel)
    
  }
  
  private func createEvaluationFaces() {
    
    self.createFaceOneIcon()
    self.createFaceOneLabel()
    
    self.createFaceTwoIcon()
    self.createFaceTwoLabel()
    
    self.createFaceThreeIcon()
    self.createFaceThreeLabel()
    
    self.createFaceFourIcon()
    self.createFaceFourLabel()
    
  }
  
  private func createFaceOneIcon() {
    
    faceOneIcon = UIImageView.init(image: UIImage.init(named: "color_bigger_fill1"))
    let iconFrame = CGRect.init(x: 0.0,
                                y: 57.0 * UtilityManager.sharedInstance.conversionHeight,
                            width: 35.0 * UtilityManager.sharedInstance.conversionWidth,
                           height: 34.0 * UtilityManager.sharedInstance.conversionWidth)
    
    faceOneIcon.frame = iconFrame
    
    mainScrollView.addSubview(faceOneIcon)
    
  }
  
  private func createFaceOneLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 150.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    faceOneLabel = UILabel.init(frame: frameForLabel)
    faceOneLabel.numberOfLines = 0
    faceOneLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.InfoPitchesViewAndViewController.faceOneLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    faceOneLabel.attributedText = stringWithFormat
    faceOneLabel.sizeToFit()
    let newFrame = CGRect.init(x: 42.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 58.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: faceOneLabel.frame.size.width,
                               height: faceOneLabel.frame.size.height)
    
    faceOneLabel.frame = newFrame
    
    mainScrollView.addSubview(faceOneLabel)
    
  }
  
  private func createFaceTwoIcon() {
    
    faceTwoIcon = UIImageView.init(image: UIImage.init(named: "color_bigger_fill3"))
    let iconFrame = CGRect.init(x: 0.0,
                                y: (112.0 * UtilityManager.sharedInstance.conversionHeight),
                                width: 35.0 * UtilityManager.sharedInstance.conversionWidth,
                                height: 34.0 * UtilityManager.sharedInstance.conversionWidth)
    
    faceTwoIcon.frame = iconFrame
    
    mainScrollView.addSubview(faceTwoIcon)
    
  }
  
  private func createFaceTwoLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 150.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    faceTwoLabel = UILabel.init(frame: frameForLabel)
    faceTwoLabel.numberOfLines = 0
    faceTwoLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.InfoPitchesViewAndViewController.faceTwoLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    faceTwoLabel.attributedText = stringWithFormat
    faceTwoLabel.sizeToFit()
    let newFrame = CGRect.init(x: 42.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 113.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: faceTwoLabel.frame.size.width,
                               height: faceTwoLabel.frame.size.height)
    
    faceTwoLabel.frame = newFrame
    
    mainScrollView.addSubview(faceTwoLabel)
    
  }
  
  private func createFaceThreeIcon() {
    
    faceThreeIcon = UIImageView.init(image: UIImage.init(named: "color_bigger_fill5"))
    let iconFrame = CGRect.init(x: 124.0 * UtilityManager.sharedInstance.conversionWidth,
                                y: (57.0 * UtilityManager.sharedInstance.conversionHeight),
                                width: 35.0 * UtilityManager.sharedInstance.conversionWidth,
                                height: 34.0 * UtilityManager.sharedInstance.conversionWidth)
    
    faceThreeIcon.frame = iconFrame
    
    mainScrollView.addSubview(faceThreeIcon)
    
  }
  
  private func createFaceThreeLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 150.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    faceThreeLabel = UILabel.init(frame: frameForLabel)
    faceThreeLabel.numberOfLines = 0
    faceThreeLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.InfoPitchesViewAndViewController.faceThreeLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    faceThreeLabel.attributedText = stringWithFormat
    faceThreeLabel.sizeToFit()
    let newFrame = CGRect.init(x: 169.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 58.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: faceThreeLabel.frame.size.width,
                               height: faceThreeLabel.frame.size.height)
    
    faceThreeLabel.frame = newFrame
    
    mainScrollView.addSubview(faceThreeLabel)
    
  }
  
  private func createFaceFourIcon() {
    
    faceFourIcon = UIImageView.init(image: UIImage.init(named: "color_bigger_fill7"))
    let iconFrame = CGRect.init(x: 124.0 * UtilityManager.sharedInstance.conversionWidth,
                                y: (112.0 * UtilityManager.sharedInstance.conversionHeight),
                                width: 35.0 * UtilityManager.sharedInstance.conversionWidth,
                                height: 34.0 * UtilityManager.sharedInstance.conversionWidth)
    
    faceFourIcon.frame = iconFrame
    
    mainScrollView.addSubview(faceFourIcon)
    
  }
  
  private func createFaceFourLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 150.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    faceFourLabel = UILabel.init(frame: frameForLabel)
    faceFourLabel.numberOfLines = 0
    faceFourLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.InfoPitchesViewAndViewController.faceFourLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    faceFourLabel.attributedText = stringWithFormat
    faceFourLabel.sizeToFit()
    let newFrame = CGRect.init(x: 169.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 113.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: faceFourLabel.frame.size.width,
                               height: faceFourLabel.frame.size.height)
    
    faceFourLabel.frame = newFrame
    
    mainScrollView.addSubview(faceFourLabel)
    
  }
  
  private func createSeparatorLineForEvaluation() {
    
    let border = CALayer()
    let width = CGFloat(1)
    border.borderColor = UIColor.darkGrayColor().CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 0.0,
                               y: (176.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: (220.0 * UtilityManager.sharedInstance.conversionWidth),
                               height: 1.0)
    mainScrollView.layer.addSublayer(border)
    mainScrollView.layer.masksToBounds = true
    
  }
  
  //
  
  private func createStatistics() {
    
    self.createStatisticsLabel()
    self.createStatisticsDescriptionLabel()
    self.createSeparatorLineForStatistics()
    
  }
  
  private func createStatisticsLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 170.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    statisticsLabel = UILabel.init(frame: frameForLabel)
    statisticsLabel.numberOfLines = 0
    statisticsLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.InfoPitchesViewAndViewController.statisticsLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    statisticsLabel.attributedText = stringWithFormat
    statisticsLabel.sizeToFit()
    let newFrame = CGRect.init(x: 28.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 207.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: statisticsLabel.frame.size.width,
                               height: statisticsLabel.frame.size.height)
    
    statisticsLabel.frame = newFrame
    
    mainScrollView.addSubview(statisticsLabel)
    
  }
  
  private func createStatisticsDescriptionLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 215.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    statisticsDescriptionLabel = UILabel.init(frame: frameForLabel)
    statisticsDescriptionLabel.numberOfLines = 0
    statisticsDescriptionLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.InfoPitchesViewAndViewController.descriptionStatisticsLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    statisticsDescriptionLabel.attributedText = stringWithFormat
    statisticsDescriptionLabel.sizeToFit()
    let newFrame = CGRect.init(x: (mainScrollView.frame.size.width / 2.0) - (statisticsDescriptionLabel.frame.size.width / 2.0),
                               y: 265.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: statisticsDescriptionLabel.frame.size.width,
                               height: statisticsDescriptionLabel.frame.size.height)
    
    statisticsDescriptionLabel.frame = newFrame
    
    mainScrollView.addSubview(statisticsDescriptionLabel)
    
  }
  
  private func createSeparatorLineForStatistics() {
    
    let border = CALayer()
    let width = CGFloat(1)
    border.borderColor = UIColor.darkGrayColor().CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 0.0,
                               y: (423.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: (220.0 * UtilityManager.sharedInstance.conversionWidth),
                               height: 1.0)
    mainScrollView.layer.addSublayer(border)
    mainScrollView.layer.masksToBounds = true
    
  }
  
  //
  
  private func createContact() {
    
    self.createContactLabel()
    
    self.createMailIcon()
    self.createMailLabel()
    
    self.createPhoneIcon()
    self.createPhoneLabel()
    
    self.createWebPageIcon()
    self.createWebPageLabel()
    
  }
  
  private func createContactLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 150.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    contactLabel = UILabel.init(frame: frameForLabel)
    contactLabel.numberOfLines = 0
    contactLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.InfoPitchesViewAndViewController.contactLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    contactLabel.attributedText = stringWithFormat
    contactLabel.sizeToFit()
    let newFrame = CGRect.init(x: 46.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 454.0 * UtilityManager.sharedInstance.conversionHeight,
                           width: contactLabel.frame.size.width,
                          height: contactLabel.frame.size.height)
    
    contactLabel.frame = newFrame
    
    mainScrollView.addSubview(contactLabel)
    
  }
  
  private func createMailIcon() {
    
    let frameForButton = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 510.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 24.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 16.0 * UtilityManager.sharedInstance.conversionHeight)
    
    mailIcon = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "iconMailBlack") as UIImage?
    mailIcon.setImage(image, forState: .Normal)
    mailIcon.tag = 1
    mailIcon.addTarget(self, action: #selector(mailIconPressed), forControlEvents:.TouchUpInside)
    
    mainScrollView.addSubview(mailIcon)
    
    
  }
  
  private func createMailLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 150.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    mailLabel = UILabel.init(frame: frameForLabel)
    mailLabel.numberOfLines = 0
    mailLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.InfoPitchesViewAndViewController.mailLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    mailLabel.attributedText = stringWithFormat
    mailLabel.sizeToFit()
    let newFrame = CGRect.init(x: 45.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 510.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: mailLabel.frame.size.width,
                               height: mailLabel.frame.size.height)
    
    mailLabel.frame = newFrame
    
    let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(mailIconPressed))
    tapGesture.numberOfTapsRequired = 1
    
    mailLabel.addGestureRecognizer(tapGesture)
    mailLabel.userInteractionEnabled = true
    
    mainScrollView.addSubview(mailLabel)
    
  }
  
  private func createPhoneIcon() {
    
    let frameForButton = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 546.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 24.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 24.0 * UtilityManager.sharedInstance.conversionHeight)
    
    phoneIcon = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "iconPhoneBlack") as UIImage?
    phoneIcon.setImage(image, forState: .Normal)
    phoneIcon.tag = 2
    phoneIcon.addTarget(self, action: #selector(phoneIconPressed), forControlEvents:.TouchUpInside)
    
    mainScrollView.addSubview(phoneIcon)
    
  }
  
  private func createPhoneLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 150.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    phoneLabel = UILabel.init(frame: frameForLabel)
    phoneLabel.numberOfLines = 0
    phoneLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.InfoPitchesViewAndViewController.phoneLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    phoneLabel.attributedText = stringWithFormat
    phoneLabel.sizeToFit()
    let newFrame = CGRect.init(x: 45.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 550.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: phoneLabel.frame.size.width,
                               height: phoneLabel.frame.size.height)
    
    phoneLabel.frame = newFrame
    
    let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(phoneIconPressed))
    tapGesture.numberOfTapsRequired = 1
    
    phoneLabel.addGestureRecognizer(tapGesture)
    phoneLabel.userInteractionEnabled = true
    
    mainScrollView.addSubview(phoneLabel)
    
  }
  
  private func createWebPageIcon() {
    
    let frameForButton = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 590.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 24.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 24.0 * UtilityManager.sharedInstance.conversionHeight)
    
    webPageIcon = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "iconWebsiteBlack") as UIImage?
    webPageIcon.setImage(image, forState: .Normal)
    webPageIcon.tag = 3
    webPageIcon.addTarget(self, action: #selector(webPageIconPressed), forControlEvents:.TouchUpInside)
    
    mainScrollView.addSubview(webPageIcon)
    
  }
  
  private func createWebPageLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 150.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    webPageLabel = UILabel.init(frame: frameForLabel)
    webPageLabel.numberOfLines = 0
    webPageLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 14.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizePitchesConstants.InfoPitchesViewAndViewController.webSiteLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    webPageLabel.attributedText = stringWithFormat
    webPageLabel.sizeToFit()
    let newFrame = CGRect.init(x: 45.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 592.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: webPageLabel.frame.size.width,
                               height: webPageLabel.frame.size.height)
    
    webPageLabel.frame = newFrame
    
    let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(webPageIconPressed))
    tapGesture.numberOfTapsRequired = 1
    
    webPageLabel.addGestureRecognizer(tapGesture)
    webPageLabel.userInteractionEnabled = true
    
    mainScrollView.addSubview(webPageLabel)
    
  }
  
  
  
  
  @objc private func mailIconPressed() {
    
    self.delegate?.mailIconPressedFromInfoPitchesView()
    
  }
  
  @objc private func phoneIconPressed() {
    
    self.delegate?.phoneIconPressedFromInfoPtichesView()
    
  }
  
  @objc private func webPageIconPressed() {
    
    self.delegate?.webPageIconPressedFronInfoPitchesView()  
    
  }
  
}