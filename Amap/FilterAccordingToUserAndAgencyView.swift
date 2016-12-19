//
//  FilterAccordingToUserAndAgencyView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 11/17/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol FilterAccordingToUserAndAgencyViewDelegate {
  
  func applyFilterButtonPressedFromFilterAccordingToUserAndAgencyView()
  func cancelFilterButtonPressed(sender: FilterAccordingToUserAndAgencyView)
  
}

class FilterAccordingToUserAndAgencyView: UIView, UITextFieldDelegate {
  
  private var cancelFilterButton: UIButton! = nil
  private var filterLabel: UILabel! = nil
  private var fromDateView: CustomTextFieldWithTitleView! = nil
  private var toDateView: CustomTextFieldWithTitleView! = nil
  private var containerViewForPicker: UIView! = nil
  private var mainDatePicker: UIDatePicker! = nil
  private var rankTimeLabel: UILabel! = nil
  private var monthsSegmentedControl: UISegmentedControl! = nil
  private var applyFilterButton: UIButton! = nil
  
  private var textFieldToWriteDown: Int = -1
  
  var delegate: FilterAccordingToUserAndAgencyViewDelegate?
  
  

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    
    self.addGestures()
    self.createCancelFilterButton()
    self.createContainerViewForPicker()
    self.createMainDatePicker()
    self.createFilterLabel()
    self.createFromDateView()
    self.createToDateView()
//    self.createRankTimeLabel()
//    self.createMonthsSegmentedControl()
    self.createApplyFilterButton()
    
  }
  
  private func addGestures() {
    
    let tapToDismissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                              action: #selector(dismissKeyboard))
    tapToDismissKeyboard.numberOfTapsRequired = 1
    tapToDismissKeyboard.cancelsTouchesInView = false
    self.addGestureRecognizer(tapToDismissKeyboard)
    
  }
  
  private func createContainerViewForPicker() {
    
    let frameForContainerView = CGRect.init(x: 0.0,
                                            y: 0.0,
                                            width: UIScreen.mainScreen().bounds.width,
                                            height: 181.0 * UtilityManager.sharedInstance.conversionHeight)
    
    containerViewForPicker = UIView.init(frame: frameForContainerView)
    containerViewForPicker.backgroundColor = UIColor.clearColor()
    
  }
  
  private func createCancelFilterButton() {
    
    let frameForButton = CGRect.init(x:270.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 10.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 15.0 * UtilityManager.sharedInstance.conversionWidth ,
                                     height: 15.0 * UtilityManager.sharedInstance.conversionHeight)
    
    cancelFilterButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "iconCloseBlack") as UIImage?
    cancelFilterButton.setImage(image, forState: .Normal)
    cancelFilterButton.alpha = 1.0
    cancelFilterButton.addTarget(self, action: #selector(cancelFilterButtonPressed), forControlEvents:.TouchUpInside)
    
    self.addSubview(cancelFilterButton)
    
  }
  
  private func createMainDatePicker() {
    
    let button = self.createGenericButton()
    containerViewForPicker.addSubview(button)
    
    let frameForPicker = CGRect.init(x: 0.0,
                                     y: button.frame.size.height + (5.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: UIScreen.mainScreen().bounds.width,
                                     height: 150.0 * UtilityManager.sharedInstance.conversionHeight)
    
    mainDatePicker = UIDatePicker.init(frame: frameForPicker)
    mainDatePicker.datePickerMode = .Date
    mainDatePicker.addTarget(self, action: #selector(datePickerViewChanged), forControlEvents: UIControlEvents.ValueChanged)
    containerViewForPicker.addSubview(mainDatePicker)
    
  }
  
  @objc private func datePickerViewChanged(sender: UIDatePicker) {
    
    let dateFromPicker = mainDatePicker.date
    let calendar = NSCalendar.currentCalendar()
    let components = calendar.components([.Day, .Month, .Year], fromDate: dateFromPicker)
    
    let stringDate = "\(components.year)-\(components.month)-\(components.day)"
    
    if textFieldToWriteDown == 1 {
      
      fromDateView.mainTextField.text = stringDate
      
    } else
      if textFieldToWriteDown == 2 {
        
        toDateView.mainTextField.text = stringDate
        
    }
    
  }
  
  private func createGenericButton() -> UIButton {
    
    let okButton = UIButton.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 15.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Ok",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    okButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    okButton.backgroundColor = UIColor.grayColor()
    okButton.addTarget(self,
                       action: #selector(okButtonPressed),
                       forControlEvents: .TouchUpInside)
    okButton.sizeToFit()
    
    let frameForButton = CGRect.init(x: (UIScreen.mainScreen().bounds.width / 2.0) - (okButton.frame.size.width / 2.0),
                                     y: 8.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: okButton.frame.size.width,
                                     height: okButton.frame.size.height)
    
    okButton.frame = frameForButton
    okButton.layer.cornerRadius = 3.0
    
    return okButton
    
  }
  
  @objc private func okButtonPressed(sender: UIButton) {
    
    let dateFromPicker = mainDatePicker.date
    let calendar = NSCalendar.currentCalendar()
    let components = calendar.components([.Day, .Month, .Year], fromDate: dateFromPicker)
    
    let stringDate = "\(components.year)-\(components.month)-\(components.day)"
    
    if textFieldToWriteDown == 1 {
      
      fromDateView.mainTextField.text = stringDate
      
    } else
      if textFieldToWriteDown == 2 {
        
        toDateView.mainTextField.text = stringDate
        
    }
    
    self.dismissKeyboard()
    
  }
  
  private func createFilterLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 90.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    filterLabel = UILabel.init(frame: frameForLabel)
    filterLabel.numberOfLines = 0
    filterLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Filtros",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    filterLabel.attributedText = stringWithFormat
    filterLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (filterLabel.frame.size.width / 2.0),
                               y: 40.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: filterLabel.frame.size.width,
                               height: filterLabel.frame.size.height)
    
    filterLabel.frame = newFrame
    
    self.addSubview(filterLabel)
    
  }
  
  private func createFromDateView() {
      
    let frameForView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 106.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
      
    fromDateView = CustomTextFieldWithTitleView.init(frame: frameForView,
                                                                     title: "A partir de",
                                                                     image: "iconImputCalendar")
    
    fromDateView.mainTextField.tag = 1
    fromDateView.mainTextField.placeholder = "dd/mm/aa"
    fromDateView.mainTextField.inputView = containerViewForPicker
    fromDateView.mainTextField.delegate = self
      
    self.addSubview(fromDateView)
    
  }
  
  private func createToDateView() {
    
    let frameForView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                   y: 195.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                              height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    toDateView = CustomTextFieldWithTitleView.init(frame: frameForView,
                                                     title: "Hasta",
                                                     image: "iconImputCalendar")
    
    toDateView.mainTextField.tag = 2
    toDateView.mainTextField.placeholder = "dd/mm/aa"
    toDateView.mainTextField.inputView = containerViewForPicker
    toDateView.mainTextField.delegate = self
    
    self.addSubview(toDateView)
    
  }
  
  private func createRankTimeLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 255.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    rankTimeLabel = UILabel.init(frame: frameForLabel)
    rankTimeLabel.numberOfLines = 0
    rankTimeLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Medium",
                      size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Left
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Elige un plazo de tiempo",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    rankTimeLabel.attributedText = stringWithFormat
    rankTimeLabel.sizeToFit()
    let newFrame = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                               y: 294.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: rankTimeLabel.frame.size.width,
                               height: rankTimeLabel.frame.size.height)
    
    rankTimeLabel.frame = newFrame
    
    self.addSubview(rankTimeLabel)
    
  }
  
  private func createMonthsSegmentedControl() {
    
    let frameForSegmentedControl = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                               y: 326.0 * UtilityManager.sharedInstance.conversionHeight,
                                          width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                         height: 34.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let arrayOfOptions = ["12 Meses"," ", "6 Meses", " ", "3 Meses"]
    
    monthsSegmentedControl = UISegmentedControl.init(items: arrayOfOptions)
    monthsSegmentedControl.addTarget(self,
                                   action: #selector(mainSegmentedControlEditingDidBegin),
                                   forControlEvents: UIControlEvents.ValueChanged)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 10.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let attributes = [NSFontAttributeName:font!,
                      NSParagraphStyleAttributeName:style,
                      NSForegroundColorAttributeName:color]
    
    monthsSegmentedControl.setTitleTextAttributes(attributes, forState: .Normal)
    
    monthsSegmentedControl.frame = frameForSegmentedControl
    monthsSegmentedControl.layer.borderColor = UIColor.clearColor().CGColor
    monthsSegmentedControl.layer.borderWidth = 1.0
    
    monthsSegmentedControl.setDividerImage(self.imageWithColor(UIColor.clearColor()), forLeftSegmentState: UIControlState.Normal, rightSegmentState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
    
    monthsSegmentedControl.setBackgroundImage(self.imageWithColor(UIColor.clearColor()), forState:UIControlState.Normal, barMetrics:UIBarMetrics.Default)
    
    monthsSegmentedControl.setBackgroundImage(self.imageWithColor(UIColor.blackColor()), forState:UIControlState.Selected, barMetrics:UIBarMetrics.Default);
    
    for  borderview in monthsSegmentedControl.subviews {
      
      let upperBorder: CALayer = CALayer()
      upperBorder.backgroundColor = UIColor.clearColor().CGColor
      upperBorder.frame = CGRectMake(0, borderview.frame.size.height-1, borderview.frame.size.width, 1.0);
      borderview.layer.addSublayer(upperBorder);
      
    }
    
    for index in 0..<arrayOfOptions.count {
      
      monthsSegmentedControl.setWidth(70.0 * UtilityManager.sharedInstance.conversionWidth,
                                    forSegmentAtIndex: index)
      
    }
    
    for segment in monthsSegmentedControl.subviews {
      
      segment.tintColor = UIColor.blackColor()
      segment.layer.borderColor = UIColor.clearColor().CGColor
      segment.layer.borderWidth = 0.0
      
    }
    
    let border = CALayer()
    let width = CGFloat(0.5)
    border.borderColor = UIColor.darkGrayColor().CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 0.0,
                               y: self.frame.size.height - (0.5 * UtilityManager.sharedInstance.conversionHeight),
                               width: self.frame.size.width,
                               height: 0.5 * UtilityManager.sharedInstance.conversionHeight)
    self.layer.masksToBounds = false
    self.layer.addSublayer(border)
    monthsSegmentedControl.backgroundColor = UIColor.whiteColor()

    
    monthsSegmentedControl.setWidth(5.0 * UtilityManager.sharedInstance.conversionWidth,
                                    forSegmentAtIndex: 1)
    
    monthsSegmentedControl.setWidth(5.0 * UtilityManager.sharedInstance.conversionWidth,
                                    forSegmentAtIndex: 3)
    
    self.addSubview(monthsSegmentedControl)
    
  }
  
  private func imageWithColor(color: UIColor) -> UIImage {
    
    let rect = CGRectMake(0.0, 0.0, 1.0, monthsSegmentedControl.frame.size.height)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    let image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image
    
  }
  
  @objc private func mainSegmentedControlEditingDidBegin() {
    
    
    
  }
  
  @objc private func dismissKeyboard() {
    
    self.endEditing(true)
    
  }
  
  func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
    
    if textField.tag == 1 {
      
      textFieldToWriteDown = 1
      
    }else
      if textField.tag == 2 {
        
        textFieldToWriteDown = 2
        
    }
    
    return true
    
  }
  
  private func createApplyFilterButton() {
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let colorWhenPressed = UIColor.greenColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: EditPitchesConstants.ArchivedPitchEvaluationView.nextButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(1.5),
        NSForegroundColorAttributeName: color
      ]
    )
    
    let stringWithFormatWhenpressed = NSMutableAttributedString(
      string: EditPitchesConstants.ArchivedPitchEvaluationView.nextButtonText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(1.5),
        NSForegroundColorAttributeName: colorWhenPressed
      ]
    )
    
    let frameForButton = CGRect.init(x: 0.0,
                                     y: self.frame.size.height - (70.0 * UtilityManager.sharedInstance.conversionHeight),
                                 width: self.frame.size.width,
                                height: (70.0 * UtilityManager.sharedInstance.conversionHeight))
    applyFilterButton = UIButton.init(frame: frameForButton)
    applyFilterButton.addTarget(self,
                         action: #selector(applyFilterButtonPressed),
                         forControlEvents: .TouchUpInside)
    applyFilterButton.backgroundColor = UIColor.blackColor()
    applyFilterButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    applyFilterButton.setAttributedTitle(stringWithFormatWhenpressed, forState: .Highlighted)
    
    self.addSubview(applyFilterButton)
    
  }
  
  @objc private func applyFilterButtonPressed() {
    
    self.delegate?.applyFilterButtonPressedFromFilterAccordingToUserAndAgencyView()
    
  }
  
  @objc private func cancelFilterButtonPressed() {
  
    self.delegate?.cancelFilterButtonPressed(self)
  
  }
  
}
