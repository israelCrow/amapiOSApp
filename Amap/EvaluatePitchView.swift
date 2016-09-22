//
//  EvaluatePitchView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 9/14/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol EvaluatePitchViewDelegate {
  
  func createEvaluatePitch()
  
}


class EvaluatePitchView: UIView {
  
  private var mainScrollView: UIScrollView! = nil
  private var evaluatePitchButton: UIButton! = nil
  private var clearObjectivesView: CustomSegmentedControlWithTitleView! = nil
  private var youKnowTheProjectBudget: CustomSegmentedControlWithTitleView! = nil
  private var youKnowTheSelectionCriteria: CustomSegmentedControlWithTitleView! = nil
  private var involvementOfMarketing: CustomSegmentedControlWithTitleView! = nil
  private var howManyAgenciesParticipate: CustomSegmentedControlWithTitleView! = nil
  private var howManyDaysToShow: CustomTextFieldWithTitleAndPickerView! = nil
  private var youKnoHowManyPresentationRounds: CustomSegmentedControlWithTitleView! = nil
  private var howMany: CustomTextFieldWithTitleAndPickerView! = nil
  
  private var containerOfLastQuestions: UIView! = nil
  
  private var howManyDaysTheyGiveTheRuling: CustomTextFieldWithTitleAndPickerView! = nil
  private var deliverIntelectualPropertyJustToPitch: CustomSegmentedControlWithTitleView! = nil
  private var clearDeliverable: CustomSegmentedControlWithTitleView! = nil

  private var alreadyMoveDownTheContainer: Bool = false
  
  var delegate: EvaluatePitchViewDelegate?

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
    self.createEvaluatePitchButton()
    self.createClearObjectivesView()
    self.createYouKnowTheProjectBudget()
    self.createYouKnowTheSelectionCriteria()
    self.createInvolvementOfMarketing()
    self.createHowManyAgenciesParticipate()
    self.createHowManyDaysToShow()
    self.createYouKnoHowManyPresentationRounds()
    self.createHowMany()
    
    self.createContainerOfLastQuestions()
    
    self.createHowManyDaysTheyGiveTheRuling()
    self.createDeliverIntelectualPropertyJustToPitch()
    self.createClearDeliverable()
    
  }
  
  private func createMainScrollView() {
    
    let frameForMainScrollView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                             y: 30.0 * UtilityManager.sharedInstance.conversionHeight,
                                             width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                             height: 291.0 * UtilityManager.sharedInstance.conversionHeight)//Value that I considered
    let sizeForContentScrollView = CGSize.init(width: frameForMainScrollView.size.width,
                                               height: frameForMainScrollView.size.height + (800.0 * UtilityManager.sharedInstance.conversionHeight))//Value that i considered
    
    mainScrollView = UIScrollView.init(frame: frameForMainScrollView)
    mainScrollView.backgroundColor = UIColor.clearColor()
    mainScrollView.contentSize = sizeForContentScrollView
    mainScrollView.showsVerticalScrollIndicator = true
    self.addSubview(mainScrollView)
    
  }
  
  private func createEvaluatePitchButton() {
    
    evaluatePitchButton = UIButton.init(frame: CGRectZero)
    
    let font = UIFont(name: "SFUIDisplay-Light",
                      size: 22.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.whiteColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "evaluar pitch",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    let colorWhenDisabled = UIColor.whiteColor()
    let styleWhenDisabled = NSMutableParagraphStyle()
    styleWhenDisabled.alignment = NSTextAlignment.Center
    
    let stringWithFormatWhenDisabled = NSMutableAttributedString(
      string: "evaluar pitch",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: styleWhenDisabled,
        NSForegroundColorAttributeName: colorWhenDisabled
      ]
    )
    
    evaluatePitchButton.setAttributedTitle(stringWithFormat, forState: .Normal)
    evaluatePitchButton.setAttributedTitle(stringWithFormatWhenDisabled, forState: .Disabled)
    evaluatePitchButton.backgroundColor = UIColor.grayColor()
    evaluatePitchButton.addTarget(self,
                        action: #selector(evaluatePitchButtonPressed),
                        forControlEvents: .TouchUpInside)
    evaluatePitchButton.sizeToFit()
    
    let frameForButton = CGRect.init(x: 0.0,
                                     y: self.frame.size.height - (70.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: self.frame.size.width,
                                     height: 70.0 * UtilityManager.sharedInstance.conversionHeight)
    
    evaluatePitchButton.frame = frameForButton
    evaluatePitchButton.enabled = true
    
    self.addSubview(evaluatePitchButton)
    
  }

  
  private func createClearObjectivesView() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: 0.0,
                               width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                              height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let segmentsArray = ["Sí", "No"]
    
    clearObjectivesView = CustomSegmentedControlWithTitleView.init(frame: frameForView,
                                                                   title: "¿Tienes los objetivos claros?",
                                                                   image: nil,
                                                                   segmentsText: segmentsArray)
    
    mainScrollView.addSubview(clearObjectivesView)
    
    
  }
  
  private func createYouKnowTheProjectBudget() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: 87.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let segmentsArray = ["Sí", "No"]
    
    youKnowTheProjectBudget = CustomSegmentedControlWithTitleView.init(frame: frameForView,
                                                                   title: "¿Saben el budget del proyecto?",
                                                                   image: nil,
                                                                   segmentsText: segmentsArray)
    
    mainScrollView.addSubview(youKnowTheProjectBudget)
    
  }
  
  private func createYouKnowTheSelectionCriteria() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: 177.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let segmentsArray = ["Sí", "No"]
    
    youKnowTheSelectionCriteria = CustomSegmentedControlWithTitleView.init(frame: frameForView,
                                                                   title: "¿Saben el criterio de selección?",
                                                                   image: nil,
                                                                   segmentsText: segmentsArray)
    
    mainScrollView.addSubview(youKnowTheSelectionCriteria)
    
  }
  
  private func createInvolvementOfMarketing() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: 267.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 78.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let segmentsArray = ["Sí", "No sé", "No"]
    
    involvementOfMarketing = CustomSegmentedControlWithTitleView.init(frame: frameForView,
                                                                           title: "¿Hay involucramiento de alguien de marketing?",
                                                                           image: nil,
                                                                           segmentsText: segmentsArray)
    
    mainScrollView.addSubview(involvementOfMarketing)
    
  }
  
  private func createHowManyAgenciesParticipate() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: 362.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let segmentsArray = ["- de 4", "4 - 7", "+ de 7"]
    
    howManyAgenciesParticipate = CustomSegmentedControlWithTitleView.init(frame: frameForView,
                                                                      title: "¿Cuántas agencias participan en el pitch?",
                                                                      image: nil,
                                                                      segmentsText: segmentsArray)
    
    mainScrollView.addSubview(howManyAgenciesParticipate)
    
  }
  
  private func createHowManyDaysToShow() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: 450.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    var segmentsArray = [String]()
    
    for i in 1...15 {
      
      segmentsArray.append(String(i))
      
    }
    
    howManyDaysToShow = CustomTextFieldWithTitleAndPickerView.init(frame: frameForView,
      textLabel: "¿Cuántos días les dieron para presentar?",
      nameOfImage: "dropdown",
      newOptionsOfPicker: segmentsArray)
    
    mainScrollView.addSubview(howManyDaysToShow)
    
  }
  
  private func createYouKnoHowManyPresentationRounds() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: 537.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let segmentsArray = ["Sí", "No sé", "No"]
    
    youKnoHowManyPresentationRounds = CustomSegmentedControlWithTitleView.init(frame: frameForView,
                                                                          title: "¿Sabes cuántas rondas de presentación hay?",
                                                                          image: nil,
                                                                          segmentsText: segmentsArray)
    
    youKnoHowManyPresentationRounds.mainSegmentedControl.addTarget(self, action: #selector(youKnoHowManyPresentationRoundsChangeValue), forControlEvents: .ValueChanged)
    mainScrollView.addSubview(youKnoHowManyPresentationRounds)
    
  }
  
  private func createHowMany() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: 627.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 300.0 * UtilityManager.sharedInstance.conversionHeight)
    
    var segmentsArray = [String]()
    
    for i in 1...15 {
      
      segmentsArray.append(String(i))
      
    }
    
    howMany = CustomTextFieldWithTitleAndPickerView.init(frame: frameForView,
                                                                   textLabel: "¿Cuántas?",
                                                                   nameOfImage: "dropdown",
                                                                   newOptionsOfPicker: segmentsArray)
    howMany.alpha = 0.0
    
    mainScrollView.addSubview(howMany)
    
  }
  
  private func createContainerOfLastQuestions() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: 627.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 300.0 * UtilityManager.sharedInstance.conversionHeight)
    
    containerOfLastQuestions = UIView.init(frame: frameForView)
    containerOfLastQuestions.backgroundColor = UIColor.clearColor()
    mainScrollView.addSubview(containerOfLastQuestions)
    
  }
  
  
  private func createHowManyDaysTheyGiveTheRuling() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: 0.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    var segmentsArray = [String]()
    segmentsArray.append("No sé")
    
    for i in 1...15 {
      
      segmentsArray.append(String(i))
      
    }
    
    howManyDaysTheyGiveTheRuling = CustomTextFieldWithTitleAndPickerView.init(frame: frameForView,
                                                                   textLabel: "¿En cuántos días les dan el fallo?",
                                                                   nameOfImage: "dropdown",
                                                                   newOptionsOfPicker: segmentsArray)
    
    containerOfLastQuestions.addSubview(howManyDaysTheyGiveTheRuling)
    
  }
  
  private func createDeliverIntelectualPropertyJustToPitch() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: 87.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let segmentsArray = ["Sí", "No sé", "No"]
    
    deliverIntelectualPropertyJustToPitch = CustomSegmentedControlWithTitleView.init(frame: frameForView,
                                                                               title: "¿Entregarás la propiedad intelectual de tu trabajo solo por pitchear?",
                                                                               image: nil,
                                                                               segmentsText: segmentsArray)
    
    containerOfLastQuestions.addSubview(deliverIntelectualPropertyJustToPitch)
    
  }
  
  private func createClearDeliverable() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: 190.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let segmentsArray = ["Sí", "No"]
    
    clearDeliverable = CustomSegmentedControlWithTitleView.init(frame: frameForView,
                                                                           title: "¿Tienes los entregables claros?",
                                                                           image: nil,
                                                                           segmentsText: segmentsArray)
    
    containerOfLastQuestions.addSubview(clearDeliverable)
    
  }
  
  
  @objc private func youKnoHowManyPresentationRoundsChangeValue(sender: UISegmentedControl) {
    
    if youKnoHowManyPresentationRounds.returnValueSelectedFromSegmentControl() == "Sí" {
      
      if alreadyMoveDownTheContainer == false {
      
        youKnoHowManyPresentationRounds.mainSegmentedControl.userInteractionEnabled = false
        self.moveDownContainer()
        self.showHowMany()
        
      }
      
    }else{
      
      if alreadyMoveDownTheContainer == true {
      
      youKnoHowManyPresentationRounds.mainSegmentedControl.userInteractionEnabled = false
      self.moveUpContainer()
      self.hideHowMany()
      
      }
      
    }
    
  }
  
  private func showHowMany() {
    
    UIView.animateWithDuration(0.25){
      
      self.howMany.alpha = 1.0
      
    }
    
  }
  
  private func hideHowMany() {
    
    UIView.animateWithDuration(0.25){
      
      self.howMany.alpha = 0.0
      
    }
    
  }

  private func moveUpContainer() {
    
    let newFrameForContainer = CGRect.init(x: containerOfLastQuestions.frame.origin.x,
                                           y: containerOfLastQuestions.frame.origin.y - (90.0 * UtilityManager.sharedInstance.conversionHeight),
                                           width: containerOfLastQuestions.frame.size.width,
                                           height: containerOfLastQuestions.frame.size.height)
    
    UIView.animateWithDuration(0.25,
                               animations: {
                                
                                self.containerOfLastQuestions.frame = newFrameForContainer
                                
    }) { (finished) in
      if finished == true {
        
        self.youKnoHowManyPresentationRounds.mainSegmentedControl.userInteractionEnabled = true
        self.alreadyMoveDownTheContainer = false
        
      }
    }
    
  }
  
  private func moveDownContainer() {
    
    let newFrameForContainer = CGRect.init(x: containerOfLastQuestions.frame.origin.x,
                                           y: containerOfLastQuestions.frame.origin.y + (90.0 * UtilityManager.sharedInstance.conversionHeight),
                                           width: containerOfLastQuestions.frame.size.width,
                                           height: containerOfLastQuestions.frame.size.height)
    
    UIView.animateWithDuration(0.25,
      animations: {
      
        self.containerOfLastQuestions.frame = newFrameForContainer
        
      }) { (finished) in
        if finished == true {
          
          self.youKnoHowManyPresentationRounds.mainSegmentedControl.userInteractionEnabled = true
          self.alreadyMoveDownTheContainer = true
          
        }
    }
    
  }
  
  @objc private func evaluatePitchButtonPressed() {
    
    self.delegate?.createEvaluatePitch()
    
  }

}


