//
//  GraphPartPitchCardView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/12/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class GraphPartPitchCardView: UIView {
  
  var containerAndGradientView: GradientView! = nil
  private var arrayOfQualifications = [Int]()
  private var arrayOfFinalQualifications = [Int]()
  private var arrayOfAgencyNames = [String]()
  private var arrayOfBarGraphic = [GraphView]()
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newArrayOfQualifications: [Int], newArrayOfAgencyNames: [String]) {
    
    arrayOfQualifications = newArrayOfQualifications
    arrayOfAgencyNames = newArrayOfAgencyNames
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.changeValuesOfQualifications()
    
    self.createContainerAndGradientView()
    self.createFaces()
    self.createLinesOfGraph()
    self.createGraphs()
    
    if UserSession.session.is_member_amap == false {
      
      self.createBlurEffect()
      
    }
    
  }
  
  private func changeValuesOfQualifications() {
    
    for element in arrayOfQualifications {
      
//      let finalValue = Int(CGFloat(100.0/92.0) * CGFloat(element + 5))
//      arrayOfFinalQualifications.append(finalValue)
      
      arrayOfFinalQualifications.append(element)
      
    }
    
  }
  
  private func createContainerAndGradientView() {
    
    let frameForGradient = CGRect.init(x: 0.0,
                                       y: 0.0,
                                   width: self.frame.size.width,
                                  height: self.frame.size.height)
    
    var firstColor = UIColor.whiteColor()
    var secondColor = UIColor.whiteColor()
    
    var titleLabel =  UILabel.init()
    
    if arrayOfQualifications.count > 0 {
    
      let myQualification = arrayOfQualifications[0]
      
//      myQualification = Int(CGFloat(100.0/92.0) * CGFloat(myQualification + 5))
      
      if myQualification >= 70 {
        
        titleLabel = self.createTitleLabel("HAPPITCH")
        
        firstColor = UIColor.init(red: 237.0/255.0, green: 237.0/255.0, blue: 24.0/255.0, alpha: 1.0)
        secondColor = UIColor.init(red: 255.0/255.0, green: 85.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        
      }else
        if myQualification >= 59 && myQualification <= 69 {
          
          firstColor = UIColor.init(red: 45.0/255.0, green: 252.0/255.0, blue: 197.0/255.0, alpha: 1.0)
          secondColor = UIColor.init(red: 21.0/255.0, green: 91.0/255.0, blue: 138.0/255.0, alpha: 1.0)
          
          titleLabel = self.createTitleLabel("HAPPY")
          
        }else
        if myQualification >= 45 && myQualification <= 58 {
            
            firstColor = UIColor.init(red: 48.0/255.0, green: 196.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            secondColor = UIColor.init(red: 242.0/255.0, green: 10.0/255.0, blue: 172.0/255.0, alpha: 1.0)
            titleLabel = self.createTitleLabel("OK")
          
        }else
        if myQualification <= 44 {
            
            firstColor = UIColor.init(red: 190.0/255.0, green: 81.0/255.0, blue: 237.0/255.0, alpha: 1.0)
            secondColor = UIColor.init(red: 255.0/255.0, green: 25.0/255.0, blue: 33.0/255.0, alpha: 1.0)
            titleLabel = self.createTitleLabel("UNHAPPY")
          
        }
  
    }
    
    let colorsForBackground = [firstColor, secondColor]

    containerAndGradientView = GradientView.init(frame: frameForGradient, arrayOfcolors: colorsForBackground, typeOfInclination: GradientView.TypeOfInclination.leftToRightInclination)
    self.addSubview(containerAndGradientView)
    self.containerAndGradientView.addSubview(titleLabel)
    
  }
  
  private func createTitleLabel(text: String) -> UILabel{
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 75.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    let label = UILabel.init(frame: frameForLabel)
    label.numberOfLines = 0
    label.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 17.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.init(white: 0, alpha: 0.45)
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: text,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    label.attributedText = stringWithFormat
    label.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (label.frame.size.width / 2.0),
                               y: 13.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: label.frame.size.width,
                               height: label.frame.size.height)
    
    label.frame = newFrame
    
    return label
    
  }
  
  private func createFaces() {
    
    self.createFirstFace()
    self.createSecondFace()
    self.createThirdFace()
    self.createFourthFace()

  }
  
  private func createFirstFace() {
    
    let firstFace = UIImageView.init(image: UIImage.init(named: "fill1"))
    let faceFrame = CGRect.init(x: 14.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 59.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 26.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 26.0 * UtilityManager.sharedInstance.conversionHeight)
    firstFace.frame = faceFrame
    
    self.addSubview(firstFace)
    
  }
  
  private func createSecondFace() {
    
    let secondFace = UIImageView.init(image: UIImage.init(named: "fill3"))
    let faceFrame = CGRect.init(x: 14.0 * UtilityManager.sharedInstance.conversionWidth,
                                y: 108.0 * UtilityManager.sharedInstance.conversionHeight,
                                width: 26.0 * UtilityManager.sharedInstance.conversionWidth,
                                height: 26.0 * UtilityManager.sharedInstance.conversionHeight)
    secondFace.frame = faceFrame
    
    self.addSubview(secondFace)
    
  }
  
  private func createThirdFace() {
    
    let thirdFace = UIImageView.init(image: UIImage.init(named: "fill5"))
    let faceFrame = CGRect.init(x: 14.0 * UtilityManager.sharedInstance.conversionWidth,
                                y: 149.0 * UtilityManager.sharedInstance.conversionHeight,
                                width: 26.0 * UtilityManager.sharedInstance.conversionWidth,
                                height: 26.0 * UtilityManager.sharedInstance.conversionHeight)
    thirdFace.frame = faceFrame
    
    self.addSubview(thirdFace)
    
  }
  
  private func createFourthFace() {
    
    let fourthFace = UIImageView.init(image: UIImage.init(named: "fill7"))
    let faceFrame = CGRect.init(x: 14.0 * UtilityManager.sharedInstance.conversionWidth,
                                y: 224.0 * UtilityManager.sharedInstance.conversionHeight,
                                width: 26.0 * UtilityManager.sharedInstance.conversionWidth,
                                height: 26.0 * UtilityManager.sharedInstance.conversionHeight)
    fourthFace.frame = faceFrame
    
    self.addSubview(fourthFace)
    
  }
  
  private func createLinesOfGraph() {
    
    var border = CALayer()
    let width = CGFloat(0.5)
    border.borderColor = UIColor.init(red: 0/255.0,
                                    green: 63.0/255.0,
                                     blue: 89.0/255.0,
                                    alpha: 0.25).CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 12.0,
                               y: 45.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: 271 * UtilityManager.sharedInstance.conversionWidth,
                               height: 1.0 * UtilityManager.sharedInstance.conversionHeight)
    self.layer.addSublayer(border)

    border = CALayer()
    border.borderColor = UIColor.init(red: 0/255.0,
                                      green: 63.0/255.0,
                                      blue: 89.0/255.0,
                                      alpha: 0.25).CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 12.0,
                               y: 93.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: 271 * UtilityManager.sharedInstance.conversionWidth,
                               height: 1.0 * UtilityManager.sharedInstance.conversionHeight)
    self.layer.addSublayer(border)

    border = CALayer()
    border.borderColor = UIColor.init(red: 0/255.0,
                                      green: 63.0/255.0,
                                      blue: 89.0/255.0,
                                      alpha: 0.25).CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 12.0,
                               y: 141.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: 271 * UtilityManager.sharedInstance.conversionWidth,
                               height: 1.0 * UtilityManager.sharedInstance.conversionHeight)
    self.layer.addSublayer(border)

    border = CALayer()
    border.borderColor = UIColor.init(red: 0/255.0,
                                      green: 63.0/255.0,
                                      blue: 89.0/255.0,
                                      alpha: 0.25).CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 12.0,
                               y: 179.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: 271 * UtilityManager.sharedInstance.conversionWidth,
                               height: 1.0 * UtilityManager.sharedInstance.conversionHeight)
    self.layer.addSublayer(border)

    border = CALayer()
    border.borderColor = UIColor.init(red: 0/255.0,
                                      green: 63.0/255.0,
                                      blue: 89.0/255.0,
                                      alpha: 0.45).CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 12.0,
                               y: 292.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: 271 * UtilityManager.sharedInstance.conversionWidth,
                               height: 1.0 * UtilityManager.sharedInstance.conversionHeight)
    self.layer.addSublayer(border)

    containerAndGradientView.layer.masksToBounds = true
    
  }
  
  private func createGraphs() {
    
    if arrayOfFinalQualifications.count >= 1 && arrayOfFinalQualifications.count < 6 {
      
      for index in 0..<(arrayOfFinalQualifications.count - 1) {
        
        arrayOfAgencyNames.append("Agencia \(index + 1)")
        
      }
      
      let spaceBetweenGraphs = (250.0 * UtilityManager.sharedInstance.conversionWidth) / CGFloat(arrayOfFinalQualifications.count)
      
      for index in 0..<arrayOfFinalQualifications.count {
        
        let qualification = arrayOfFinalQualifications[index]
        let agencyName = arrayOfAgencyNames[index]
        
        let frameForGraph = CGRect.init(x: (32.0 * UtilityManager.sharedInstance.conversionWidth) + (spaceBetweenGraphs * CGFloat(index)),
                                        y: 45.0 * UtilityManager.sharedInstance.conversionHeight,
                                        width: 50.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 287.5 * UtilityManager.sharedInstance.conversionHeight)
        
        let newGraph = GraphView.init(frame: frameForGraph, newAgencyName: agencyName, newAgencyQualification: qualification)
        newGraph.alpha = 0.0
        self.addSubview(newGraph)
        
        arrayOfBarGraphic.append(newGraph)
        
      }

    } else
      if arrayOfFinalQualifications.count >= 6 {
        
        let qualification = arrayOfFinalQualifications.first
        let agencyName = arrayOfAgencyNames.first
        
        let frameForGraph = CGRect.init(x: 32.0 * UtilityManager.sharedInstance.conversionWidth,
                                        y: 45.0 * UtilityManager.sharedInstance.conversionHeight,
                                        width: 50.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 287.5 * UtilityManager.sharedInstance.conversionHeight)
        
        let newGraph = GraphView.init(frame: frameForGraph, newAgencyName: agencyName!, newAgencyQualification: qualification!)
        newGraph.alpha = 0.0
        self.addSubview(newGraph)
        
        arrayOfBarGraphic.append(newGraph)
        
        let limit = min(arrayOfFinalQualifications.count, 7)
        
        let spaceBetweenGraphs = (240.0 * UtilityManager.sharedInstance.conversionWidth) / CGFloat(limit)

        for index in 1..<limit {
          
          let qualification = arrayOfFinalQualifications[index]
          
          let frameForGraph = CGRect.init(x: (32.0 * UtilityManager.sharedInstance.conversionWidth) + (spaceBetweenGraphs * CGFloat(index)),
                                          y: 45.0 * UtilityManager.sharedInstance.conversionHeight,
                                          width: 50.0 * UtilityManager.sharedInstance.conversionWidth,
                                          height: 287.5 * UtilityManager.sharedInstance.conversionHeight)
          
          let newGraph = GraphView.init(frame: frameForGraph, newAgencyName: "", newAgencyQualification: qualification)
          newGraph.alpha = 0.0
          self.addSubview(newGraph)
          
          arrayOfBarGraphic.append(newGraph)
          
        }
        
        self.createOtherAgenciesLabel()
        
      }

  }
  
  private func createOtherAgenciesLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 70.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    let otherAgenciesLabel = UILabel.init(frame: frameForLabel)
    otherAgenciesLabel.numberOfLines = 0
    otherAgenciesLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Regular",
                      size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Otras agencias",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    otherAgenciesLabel.attributedText = stringWithFormat
    otherAgenciesLabel.sizeToFit()
    let newFrame = CGRect.init(x: 129.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 317.5 * UtilityManager.sharedInstance.conversionHeight,
                               width: otherAgenciesLabel.frame.size.width,
                               height: otherAgenciesLabel.frame.size.height)
    
    otherAgenciesLabel.frame = newFrame
    
    self.addSubview(otherAgenciesLabel)
  
  }
  
  func animateGraph() {
    
    for i in 0..<arrayOfBarGraphic.count {
      
      let element = arrayOfBarGraphic[i]
      if i != 0 && UserSession.session.is_member_amap == false {
        
        element.alpha = 0.0
        
      } else {
        
        element.alpha = 1.0
        
      }
      
      element.animateBar()
      
    }
    
    //    for graphView in arrayOfBarGraphic {
    //
    //      UIView.animateWithDuration(0.15) {
    //
    //        graphView.alpha = 1.0
    //
    //      }
    //
    //      graphView.animateBar()
    //      
    //    }
    
  }
  
  func animateChangeOfFrameOfGradientView() {
    
    let newFrame = CGRect.init(x: containerAndGradientView.frame.origin.x,
                               y: containerAndGradientView.frame.origin.y - (50.0 * UtilityManager.sharedInstance.conversionHeight),
                           width: containerAndGradientView.frame.size.width,
                          height: containerAndGradientView.frame.size.height + (100.0 * UtilityManager.sharedInstance.conversionHeight))
    
    UIView.animateWithDuration(0.35,
      animations: {
        self.containerAndGradientView.frame = newFrame
      }) { (finished) in
        if finished == true {
          
          
        }
    }
    
  }
  
  private func createBlurEffect() {
    
    //    let frameForBlur = CGRect.init(x: 31.0 * UtilityManager.sharedInstance.conversionWidth,
    //                                   y: 74.0 * UtilityManager.sharedInstance.conversionHeight,
    //                               width: 224.0 * UtilityManager.sharedInstance.conversionWidth,
    //                              height: 272.0 * UtilityManager.sharedInstance.conversionHeight)
    //
    //    let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
    //    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    //    blurEffectView.layer.cornerRadius = 10.0
    //    blurEffectView.clipsToBounds = true
    //    blurEffectView.alpha = 0.95
    //    blurEffectView.frame = frameForBlur
    //    self.addSubview(blurEffectView)
    
    self.createMessageForNonAmapUser()
    self.createGetContactButton()
    
  }
  
  private func createMessageForNonAmapUser() {
    
    let frameForLabel = CGRect.init(x: 31.0 * UtilityManager.sharedInstance.conversionWidth,
                                    y: 74.0 * UtilityManager.sharedInstance.conversionHeight,
                                    width: 209.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: 110.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let messageLabel = UILabel.init(frame: frameForLabel)
    messageLabel.numberOfLines = 0
    messageLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "¿Quieres saber con cuántas agencias participas y cuál es su pitch-score? Afíliate a la AMAP",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    messageLabel.attributedText = stringWithFormat
    messageLabel.sizeToFit()
    let newFrame = CGRect.init(x: 70.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 120.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: messageLabel.frame.size.width,
                               height: messageLabel.frame.size.height)
    
    messageLabel.frame = newFrame
    
    self.addSubview(messageLabel)
    
  }
  
  private func createGetContactButton() {
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    //let colorWhenPressed = UIColor.greenColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Contacta a la AMAP",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    let stringWithFormatWhenpressed = NSMutableAttributedString(
      string: "Contacta a la AMAP",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color //colorWhenPressed
      ]
    )
    
    let frameForButton = CGRect.init(x: 96.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 228.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 157.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 30.0 * UtilityManager.sharedInstance.conversionHeight)
    let contactButton = UIButton.init(frame: frameForButton)
    contactButton.addTarget(self,
                            action: nil,
                            forControlEvents: .TouchUpInside)
    contactButton.backgroundColor = UIColor.blackColor()
    contactButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    contactButton.setAttributedTitle(stringWithFormatWhenpressed, forState: .Highlighted)
    
    self.addSubview(contactButton)
    
  }
  
}
