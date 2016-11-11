//
//  EditPitchEvaluationView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 11/3/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol EditPitchEvaluationViewDelegate {
  
  func updatePitchEvaluation(params: [String: AnyObject])
  
}


class EditPitchEvaluationView: UIView, CustomSegmentedControlWithTitleViewDelegate, CustomTextFieldWithTitleAndPickerViewDelegate {
  
  private var pitchEvaluationInfoFromServer: [String: AnyObject]! = nil
  
  private var mainScrollView: UIScrollView! = nil
  private var evaluatePitchButton: UIButton! = nil
  
  private var clearObjectivesView: CustomSegmentedControlWithTitleView! = nil
  private var isClearObjectivesViewEdited: Bool = false
  
  private var youKnowTheProjectBudget: CustomSegmentedControlWithTitleView! = nil
  private var isYouKnowTheProjectBudgetEdited: Bool = false
  
  private var youKnowTheSelectionCriteria: CustomSegmentedControlWithTitleView! = nil
  private var isYouKnowTheSelectionCriteriaEdited: Bool = false
  
  private var involvementOfMarketing: CustomSegmentedControlWithTitleView! = nil
  private var isInvolvementOfMarketingEdited: Bool = false
  
  private var howManyAgenciesParticipate: CustomSegmentedControlWithTitleView! = nil
  private var isHowManyAgenciesParticipateEdited: Bool = false
  
  private var howManyDaysToShow: CustomTextFieldWithTitleAndPickerView! = nil //6
  private var isHowManyDaysToShowEdited: Bool = false
  
  private var youKnowHowManyPresentationRounds: CustomSegmentedControlWithTitleView! = nil
  private var isYouKnowHowManyPresentationRounds: Bool = false
  
  private var howMany: CustomTextFieldWithTitleAndPickerView! = nil //8
  private var isHowManyEdited: Bool = false
  
  private var containerOfLastQuestions: UIView! = nil
  private var alreadyMoveDownTheContainer: Bool = false
  
  private var howManyDaysTheyGiveTheRuling: CustomTextFieldWithTitleAndPickerView! = nil //9
  private var isHowManyDaysTheyGiveTheRulingEdited: Bool = false
  
  private var deliverIntelectualPropertyJustToPitch: CustomSegmentedControlWithTitleView! = nil
  private var isDeliverIntelectualPropertyJustToPitchEdited: Bool = false
  
  private var clearDeliverable: CustomSegmentedControlWithTitleView! = nil
  private var isClearDeliverableEdited: Bool = false
  
  var delegate: EditPitchEvaluationViewDelegate?
  
  let kSpaceInSegments = 36.0 * UtilityManager.sharedInstance.conversionWidth
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newPitchEvaluationData: [String: AnyObject]) {
    
    pitchEvaluationInfoFromServer = newPitchEvaluationData
    
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
    self.createYouKnowHowManyPresentationRounds()
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
    evaluatePitchButton.backgroundColor = UIColor.blackColor()
    evaluatePitchButton.addTarget(self,
                                  action: #selector(evaluatePitchButtonPressed),
                                  forControlEvents: .TouchUpInside)
    evaluatePitchButton.sizeToFit()
    
    let frameForButton = CGRect.init(x: 0.0,
                                     y: self.frame.size.height - (70.0 * UtilityManager.sharedInstance.conversionHeight),
                                     width: self.frame.size.width,
                                     height: 70.0 * UtilityManager.sharedInstance.conversionHeight)
    
    evaluatePitchButton.alpha = 1.0
    evaluatePitchButton.frame = frameForButton
    evaluatePitchButton.enabled = true
    self.activateEvaluatePitchButton()
    
    self.addSubview(evaluatePitchButton)
    
  }
  
  
  private func createClearObjectivesView() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: 0.0,
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let segmentsArray = ["Sí", "", "No"]
    
    clearObjectivesView = CustomSegmentedControlWithTitleView.init(frame: frameForView,
                                                                   title: "¿Tienes los objetivos claros?",
                                                                   image: nil,
                                                                   segmentsText: segmentsArray)
    let originalSegmentControlFrame = clearObjectivesView.mainSegmentedControl.frame
    let newFrame = CGRect.init(x: originalSegmentControlFrame.origin.x + (20.0 * UtilityManager.sharedInstance.conversionWidth),
                               y: originalSegmentControlFrame.origin.y,
                               width: originalSegmentControlFrame.size.width,
                               height: originalSegmentControlFrame.size.height)
    clearObjectivesView.mainSegmentedControl.frame = newFrame
    clearObjectivesView.tag = 1
    clearObjectivesView.delegate = self
    clearObjectivesView.mainSegmentedControl.setWidth(kSpaceInSegments, forSegmentAtIndex: 1)
    clearObjectivesView.mainSegmentedControl.setEnabled(false, forSegmentAtIndex: 1)
    
    if pitchEvaluationInfoFromServer["are_objectives_clear"] as? Bool != nil {
      
      let are_objectives_clear = pitchEvaluationInfoFromServer["are_objectives_clear"] as! Bool
      
      if are_objectives_clear == true {
        
        clearObjectivesView.mainSegmentedControl.selectedSegmentIndex = 0
        
      } else {
        
        clearObjectivesView.mainSegmentedControl.selectedSegmentIndex = 2
        
      }
      
    }
    
    mainScrollView.addSubview(clearObjectivesView)
    
    
  }
  
  private func createYouKnowTheProjectBudget() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: 89.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let segmentsArray = ["Sí", "", "No"]
    
    youKnowTheProjectBudget = CustomSegmentedControlWithTitleView.init(frame: frameForView,
                                                                       title: "¿Saben el budget del proyecto?",
                                                                       image: nil,
                                                                       segmentsText: segmentsArray)
    let originalSegmentControlFrame = youKnowTheProjectBudget.mainSegmentedControl.frame
    let newFrame = CGRect.init(x: originalSegmentControlFrame.origin.x + (20.0 * UtilityManager.sharedInstance.conversionWidth),
                               y: originalSegmentControlFrame.origin.y,
                               width: originalSegmentControlFrame.size.width,
                               height: originalSegmentControlFrame.size.height)
    youKnowTheProjectBudget.mainSegmentedControl.frame = newFrame
    youKnowTheProjectBudget.tag = 2
    youKnowTheProjectBudget.delegate = self
    youKnowTheProjectBudget.mainSegmentedControl.setWidth(kSpaceInSegments, forSegmentAtIndex: 1)
    youKnowTheProjectBudget.mainSegmentedControl.setEnabled(false, forSegmentAtIndex: 1)
    
    if pitchEvaluationInfoFromServer["is_budget_known"] as? Bool != nil {
      
      let is_budget_known = pitchEvaluationInfoFromServer["is_budget_known"] as! Bool
      
      if is_budget_known == true {
        
        youKnowTheProjectBudget.mainSegmentedControl.selectedSegmentIndex = 0
        
      } else {
        
        youKnowTheProjectBudget.mainSegmentedControl.selectedSegmentIndex = 2
        
      }
      
    }
    
    mainScrollView.addSubview(youKnowTheProjectBudget)
    
  }
  
  private func createYouKnowTheSelectionCriteria() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: 181.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    
    let segmentsArray = ["Sí", "", "No"]
    
    youKnowTheSelectionCriteria = CustomSegmentedControlWithTitleView.init(frame: frameForView,
                                                                           title: "¿Saben el criterio de selección?",
                                                                           image: nil,
                                                                           segmentsText: segmentsArray)
    
    let originalSegmentControlFrame = youKnowTheSelectionCriteria.mainSegmentedControl.frame
    let newFrame = CGRect.init(x: originalSegmentControlFrame.origin.x + (20.0 * UtilityManager.sharedInstance.conversionWidth),
                               y: originalSegmentControlFrame.origin.y,
                               width: originalSegmentControlFrame.size.width,
                               height: originalSegmentControlFrame.size.height)
    youKnowTheSelectionCriteria.mainSegmentedControl.frame = newFrame
    youKnowTheSelectionCriteria.tag = 3
    youKnowTheSelectionCriteria.delegate = self
    youKnowTheSelectionCriteria.mainSegmentedControl.setWidth(kSpaceInSegments, forSegmentAtIndex: 1)
    youKnowTheSelectionCriteria.mainSegmentedControl.setEnabled(false, forSegmentAtIndex: 1)
    
    if pitchEvaluationInfoFromServer["has_selection_criteria"] as? Bool != nil {
      
      let has_selection_criteria = pitchEvaluationInfoFromServer["has_selection_criteria"] as! Bool
      
      if has_selection_criteria == true {
        
        youKnowTheSelectionCriteria.mainSegmentedControl.selectedSegmentIndex = 0
        
      } else {
        
        youKnowTheSelectionCriteria.mainSegmentedControl.selectedSegmentIndex = 2
        
      }
      
    }
    
    mainScrollView.addSubview(youKnowTheSelectionCriteria)
    
  }
  
  private func createInvolvementOfMarketing() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: 269.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 78.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let segmentsArray = ["Sí", "No sé", "No"]
    
    involvementOfMarketing = CustomSegmentedControlWithTitleView.init(frame: frameForView,
                                                                      title: "¿Hay involucramiento de alguien de marketing?",
                                                                      image: nil,
                                                                      segmentsText: segmentsArray)
    involvementOfMarketing.tag = 4
    involvementOfMarketing.delegate = self
    
    if pitchEvaluationInfoFromServer["is_marketing_involved"] as? String != nil {
      
      let is_marketing_involved = pitchEvaluationInfoFromServer["is_marketing_involved"] as! String
      
      if is_marketing_involved.lowercaseString == "si" {
        
        involvementOfMarketing.mainSegmentedControl.selectedSegmentIndex = 0
        
      } else
        if is_marketing_involved.lowercaseString == "no" {
        
          involvementOfMarketing.mainSegmentedControl.selectedSegmentIndex = 2
        
      } else
      
        if is_marketing_involved.lowercaseString == "no se" {
            
          involvementOfMarketing.mainSegmentedControl.selectedSegmentIndex = 1
            
        }
      
    }
    
    mainScrollView.addSubview(involvementOfMarketing)
    
  }
  
  private func createHowManyAgenciesParticipate() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: 364.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let widthOfSegments = CGFloat((210.0 * UtilityManager.sharedInstance.conversionWidth) / 4.0)
    
    let segmentsArray = ["2 - 4", "5 - 7", "+ de 7", "No sé"]
    
    howManyAgenciesParticipate = CustomSegmentedControlWithTitleView.init(frame: frameForView,
                                                                          title: "¿Cuántas agencias participan en el pitch?",
                                                                          image: nil,
                                                                          segmentsText: segmentsArray)
    howManyAgenciesParticipate.delegate = self
    howManyAgenciesParticipate.tag = 5
    howManyAgenciesParticipate.mainSegmentedControl.setWidth(widthOfSegments, forSegmentAtIndex: 0)
    howManyAgenciesParticipate.mainSegmentedControl.setWidth(widthOfSegments, forSegmentAtIndex: 1)
    howManyAgenciesParticipate.mainSegmentedControl.setWidth(widthOfSegments, forSegmentAtIndex: 2)
    howManyAgenciesParticipate.mainSegmentedControl.setWidth(widthOfSegments, forSegmentAtIndex: 3)
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 12.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let attributes = [NSFontAttributeName:font!,
                      NSParagraphStyleAttributeName:style,
                      NSForegroundColorAttributeName:color]
    
    howManyAgenciesParticipate.mainSegmentedControl.setTitleTextAttributes(attributes, forState: .Normal)
  
    
    if pitchEvaluationInfoFromServer["number_of_agencies"] as? String != nil {
      
      let number_of_agencies = pitchEvaluationInfoFromServer["number_of_agencies"] as! String
      
      if number_of_agencies == "2 - 4" {
        
        howManyAgenciesParticipate.mainSegmentedControl.selectedSegmentIndex = 0
        
      } else
        if number_of_agencies == "5 - 7" {
          
          howManyAgenciesParticipate.mainSegmentedControl.selectedSegmentIndex = 1
          
        } else
          
        if number_of_agencies == "+7" {
            
          howManyAgenciesParticipate.mainSegmentedControl.selectedSegmentIndex = 2
            
        } else
          
        if number_of_agencies.lowercaseString == "no se" {
              
          howManyAgenciesParticipate.mainSegmentedControl.selectedSegmentIndex = 3
              
        }
      
    }
    
    mainScrollView.addSubview(howManyAgenciesParticipate)
    
  }
  
  private func createHowManyDaysToShow() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: 452.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    var segmentsArray = [String]()
    
    for i in 1...30 {
      
      segmentsArray.append(String(i))
      
    }
    
    //    CustomTextFieldWithTitleView.init(frame: frameForView,
    //                                      title: "¿Cuántas semanas les dieron para presentar?",
    //                                      image: nil)
    
    howManyDaysToShow = CustomTextFieldWithTitleAndPickerView.init(frame: frameForView,
                                                                   textLabel: "¿Cuántos días les dieron para presentar?",
                                                                   nameOfImage: "dropdown",
                                                                   newOptionsOfPicker: segmentsArray)
    
    howManyDaysToShow.tag = 6
    howManyDaysToShow.mainTextField.keyboardType = .NumberPad
    howManyDaysToShow.mainTextField.addTarget(self,
                                              action: #selector(howManyDaysToShowEdited),
                                              forControlEvents: .AllEditingEvents)
    
    if pitchEvaluationInfoFromServer["time_to_present"] as? String != nil {
      
      let time_to_present = pitchEvaluationInfoFromServer["time_to_present"] as! String
      
      howManyDaysToShow.mainTextField.text = time_to_present
      
    }
    
    mainScrollView.addSubview(howManyDaysToShow)
    
  }
  
  private func createYouKnowHowManyPresentationRounds() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: 539.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 78.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let segmentsArray = ["Sí", "", "No"]
    
    youKnowHowManyPresentationRounds = CustomSegmentedControlWithTitleView.init(frame: frameForView,
                                                                                title: "¿Sabes cuántas rondas de presentación hay?",
                                                                                image: nil,
                                                                                segmentsText: segmentsArray)
    youKnowHowManyPresentationRounds.tag = 7
    youKnowHowManyPresentationRounds.delegate = self
    youKnowHowManyPresentationRounds.mainSegmentedControl.addTarget(self, action: #selector(youKnoHowManyPresentationRoundsChangeValue), forControlEvents: .ValueChanged)
    youKnowHowManyPresentationRounds.mainSegmentedControl.setWidth(kSpaceInSegments, forSegmentAtIndex: 1)
    youKnowHowManyPresentationRounds.mainSegmentedControl.setEnabled(false, forSegmentAtIndex: 1)
    
    if pitchEvaluationInfoFromServer["number_of_rounds"] as? String != nil {
      
      youKnowHowManyPresentationRounds.mainSegmentedControl.selectedSegmentIndex = 0
      
    }
    
    mainScrollView.addSubview(youKnowHowManyPresentationRounds)
    
  }
  
  private func createHowMany() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: 629.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 300.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let segmentsArray = ["1 round", "2 rounds", "3 rounds", "4 rounds"]
    
    howMany = CustomTextFieldWithTitleAndPickerView.init(frame: frameForView,
                                                         textLabel: "¿Cuántas?",
                                                         nameOfImage: "dropdown",
                                                         newOptionsOfPicker: segmentsArray)
    howMany.alpha = 0.0
    howMany.tag = 8
    howMany.delegate = self
    
    if pitchEvaluationInfoFromServer["number_of_rounds"] as? String != nil {
      
      let number_of_rounds = pitchEvaluationInfoFromServer["number_of_rounds"] as! String
      
      if number_of_rounds == "1r" {
        
        howMany.mainTextField.text = segmentsArray[0]
        
      } else
        if number_of_rounds == "2r" {
        
        howMany.mainTextField.text = segmentsArray[1]
          
      } else
        if number_of_rounds == "3r" {
        
          howMany.mainTextField.text = segmentsArray[2]
          
      } else
        if number_of_rounds == "4r" {
        
          howMany.mainTextField.text = segmentsArray[3]
          
      }
      
    }
    
    mainScrollView.addSubview(howMany)
    
  }
  
  private func createContainerOfLastQuestions() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: 629.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 300.0 * UtilityManager.sharedInstance.conversionHeight)
    
    containerOfLastQuestions = UIView.init(frame: frameForView)
    containerOfLastQuestions.backgroundColor = UIColor.clearColor()
    mainScrollView.addSubview(containerOfLastQuestions)
    
  }
  
  
  private func createHowManyDaysTheyGiveTheRuling() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: 2.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let segmentsArray = ["2 semanas", "3 semanas", "4 semanas", "5 semanas", ">5", "NA"]
    
    howManyDaysTheyGiveTheRuling = CustomTextFieldWithTitleAndPickerView.init(frame: frameForView,
                                                                              textLabel: "¿En cuántas semanas les dan el fallo?",
                                                                              nameOfImage: "dropdown",
                                                                              newOptionsOfPicker: segmentsArray)
    howManyDaysTheyGiveTheRuling.tag = 9
    
    if pitchEvaluationInfoFromServer["time_to_know_decision"] as? String != nil {
      
      let time_to_know_decision = pitchEvaluationInfoFromServer["time_to_know_decision"] as! String
      
      if time_to_know_decision == "2s" {
        
        howManyDaysTheyGiveTheRuling.mainTextField.text! = segmentsArray[0]
        
      } else
        if time_to_know_decision == "3s" {
          
          howManyDaysTheyGiveTheRuling.mainTextField.text! = segmentsArray[1]
          
      } else
          
        if time_to_know_decision == "4s" {
            
          howManyDaysTheyGiveTheRuling.mainTextField.text! = segmentsArray[2]
            
      } else
          
        if time_to_know_decision == "5s" {
            
          howManyDaysTheyGiveTheRuling.mainTextField.text! = segmentsArray[3]
            
      } else
            
        if time_to_know_decision == ">5" {
              
          howManyDaysTheyGiveTheRuling.mainTextField.text! = segmentsArray[4]
              
      } else
          
        if time_to_know_decision == "NA" {
            
          howManyDaysTheyGiveTheRuling.mainTextField.text! = segmentsArray[5]
            
      }
      
    }
    
    howManyDaysTheyGiveTheRuling.delegate = self
    
    containerOfLastQuestions.addSubview(howManyDaysTheyGiveTheRuling)
    
  }
  
  private func createDeliverIntelectualPropertyJustToPitch() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: 89.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 78.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let segmentsArray = ["Sí", "No sé", "No"]
    
    deliverIntelectualPropertyJustToPitch = CustomSegmentedControlWithTitleView.init(frame: frameForView,
                                                                                     title: "¿Entregarás la propiedad intelectual de tu trabajo solo por pitchear?",
                                                                                     image: nil,
                                                                                     segmentsText: segmentsArray)
    deliverIntelectualPropertyJustToPitch.delegate = self
    deliverIntelectualPropertyJustToPitch.tag = 10
    
    if pitchEvaluationInfoFromServer["deliver_copyright_for_pitching"] as? String != nil {
      
      let deliver_copyright_for_pitching = pitchEvaluationInfoFromServer["deliver_copyright_for_pitching"] as! String
      
      if deliver_copyright_for_pitching.lowercaseString == "si" {
        
        deliverIntelectualPropertyJustToPitch.mainSegmentedControl.selectedSegmentIndex = 0
        
      } else
        if deliver_copyright_for_pitching.lowercaseString == "no" {
          
          deliverIntelectualPropertyJustToPitch.mainSegmentedControl.selectedSegmentIndex = 2
          
      } else
          
        if deliver_copyright_for_pitching.lowercaseString == "no se" {
            
          deliverIntelectualPropertyJustToPitch.mainSegmentedControl.selectedSegmentIndex = 1
            
        }
      
    }
    
    
    containerOfLastQuestions.addSubview(deliverIntelectualPropertyJustToPitch)
    
  }
  
  private func createClearDeliverable() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: 192.0 * UtilityManager.sharedInstance.conversionHeight,
                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let segmentsArray = ["Sí", "", "No"]
    
    clearDeliverable = CustomSegmentedControlWithTitleView.init(frame: frameForView,
                                                                title: "¿Tienes los entregables claros?",
                                                                image: nil,
                                                                segmentsText: segmentsArray)
    
    let originalSegmentControlFrame = clearDeliverable.mainSegmentedControl.frame
    let newFrame = CGRect.init(x: originalSegmentControlFrame.origin.x + (20.0 * UtilityManager.sharedInstance.conversionWidth),
                               y: originalSegmentControlFrame.origin.y,
                               width: originalSegmentControlFrame.size.width,
                               height: originalSegmentControlFrame.size.height)
    clearDeliverable.mainSegmentedControl.frame = newFrame
    clearDeliverable.tag = 11
    clearDeliverable.delegate = self
    clearDeliverable.mainSegmentedControl.setWidth(kSpaceInSegments, forSegmentAtIndex: 1)
    clearDeliverable.mainSegmentedControl.setEnabled(false, forSegmentAtIndex: 1)
    
    if pitchEvaluationInfoFromServer["are_deliverables_clear"] as? Bool != nil {
      
      let are_deliverables_clear = pitchEvaluationInfoFromServer["are_deliverables_clear"] as! Bool
      
      if are_deliverables_clear == true {
        
        clearDeliverable.mainSegmentedControl.selectedSegmentIndex = 0
        
      } else {
        
        clearDeliverable.mainSegmentedControl.selectedSegmentIndex = 2
        
      }
      
    }
    
    containerOfLastQuestions.addSubview(clearDeliverable)
    
    self.moveDownContainer()
    self.showHowMany()
    
  }
  
  
  @objc private func youKnoHowManyPresentationRoundsChangeValue(sender: UISegmentedControl) {
    
    if youKnowHowManyPresentationRounds.returnValueSelectedFromSegmentControl() == "Sí" {
      
      if alreadyMoveDownTheContainer == false {
        
        youKnowHowManyPresentationRounds.mainSegmentedControl.userInteractionEnabled = false
        self.moveDownContainer()
        self.showHowMany()
        
      }
      
    }else{
      
      if alreadyMoveDownTheContainer == true {
        
        howMany.mainTextField.text! = ""
        youKnowHowManyPresentationRounds.mainSegmentedControl.userInteractionEnabled = false
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
        
        self.youKnowHowManyPresentationRounds.mainSegmentedControl.userInteractionEnabled = true
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
        
        self.youKnowHowManyPresentationRounds.mainSegmentedControl.userInteractionEnabled = true
        self.alreadyMoveDownTheContainer = true
        
      }
    }
    
  }
  
  @objc private func evaluatePitchButtonPressed() {
    
    let clearObjectiveResult = (clearObjectivesView.returnValueSelectedFromSegmentControl() == "Sí" ? 1 : 0)
    
    let knowTheProjectBudgetResult = (youKnowTheProjectBudget.returnValueSelectedFromSegmentControl() == "Sí" ? 1 : 0)
    
    let knowTheSelectionCriteriaResult = (youKnowTheSelectionCriteria.returnValueSelectedFromSegmentControl() == "Sí" ? 1 : 0)
    
    var involvementMKResultString = ""
    if involvementOfMarketing.returnValueSelectedFromSegmentControl() == "Sí" {
      
      involvementMKResultString = "si"
      
    }else
      if involvementOfMarketing.returnValueSelectedFromSegmentControl() == "No" {
        
        involvementMKResultString = "no"
        
      }else
        if involvementOfMarketing.returnValueSelectedFromSegmentControl() == "No sé" {
          
          involvementMKResultString = "no se"
          
    }
    
    var howManyAgenciesResult:String = howManyAgenciesParticipate.returnValueSelectedFromSegmentControl()
    if howManyAgenciesResult == "No sé" {
      howManyAgenciesResult = "no se"
    }else
    if howManyAgenciesResult == "+ de 7" {
      howManyAgenciesResult = "+7"
    }
    //    if howManyAgenciesParticipate.returnValueSelectedFromSegmentControl() == "- de 4" {
    //
    //      howManyAgenciesResult = "- de 4"
    //
    //    }else
    //      if howManyAgenciesParticipate.returnValueSelectedFromSegmentControl() == "4 - 7" {
    //
    //        howManyAgenciesResult = "4 - 7"
    //
    //    }else
    //      if howManyAgenciesParticipate.returnValueSelectedFromSegmentControl() == "+ de 7" {
    //
    //        howManyAgenciesResult = "+ de 7"
    //
    //    }
    
    let howManyDaysToPresent = howManyDaysToShow.mainTextField.text!
    
    //    let howManyWeeks = (UtilityManager.sharedInstance.isValidText(howManyDaysToShow.mainTextField.text!) == true ? howManyDaysToShow.mainTextField.text! : "1s")
    //    let howManyWeeksWithoutSpaces = howManyWeeks.stringByReplacingOccurrencesOfString(" ", withString: "")
    //    let howManyWeeksResult = howManyWeeksWithoutSpaces.substringWithRange(howManyWeeksWithoutSpaces.startIndex..<howManyWeeksWithoutSpaces.startIndex.advancedBy(2))
    
    //    var howManyPresentationRoundsResult = ""
    //    if youKnowHowManyPresentationRounds.returnValueSelectedFromSegmentControl() == "Sí" {
    //
    //      howManyPresentationRoundsResult = "true"
    //
    //    }else
    //    if youKnowHowManyPresentationRounds.returnValueSelectedFromSegmentControl() == "No" {
    //
    //      howManyPresentationRoundsResult = "false"
    //
    //    }else
    //    if youKnowHowManyPresentationRounds.returnValueSelectedFromSegmentControl() == "No sé" {
    //
    //      howManyPresentationRoundsResult = "true"
    //
    //    }
    
    //    let howManyRoundsResult = (UtilityManager.sharedInstance.isValidText(howMany.mainTextField.text!) == true ? howMany.mainTextField.text! : "")
    
    let howManyRounds = (UtilityManager.sharedInstance.isValidText(howMany.mainTextField.text!) == true ? howMany.mainTextField.text! : "1r")
    let howManyRoundsWithoutSpaces = howManyRounds.stringByReplacingOccurrencesOfString(" ", withString: "")
    let howManyRoundsResult = howManyRoundsWithoutSpaces.substringWithRange(howManyRoundsWithoutSpaces.startIndex..<howManyRoundsWithoutSpaces.startIndex.advancedBy(2))
    
    let howManyWeeksRuling = (UtilityManager.sharedInstance.isValidText(howManyDaysTheyGiveTheRuling.mainTextField.text!) == true ? howManyDaysTheyGiveTheRuling.mainTextField.text! : "2s")
    let howManyRulingWeeksWithoutSpaces = howManyWeeksRuling.stringByReplacingOccurrencesOfString(" ", withString: "")
    let howManyWeeksTheRulingResult = howManyRulingWeeksWithoutSpaces.substringWithRange(howManyRulingWeeksWithoutSpaces.startIndex..<howManyRulingWeeksWithoutSpaces.startIndex.advancedBy(2))
    
    //    let howManyDaysTheyRulingResult = (UtilityManager.sharedInstance.isValidText(howManyDaysTheyGiveTheRuling.mainTextField.text!) == true ? howManyDaysTheyGiveTheRuling.mainTextField.text! : "1")
    
    var deliverIntelectualPropertyResultString = ""
    if deliverIntelectualPropertyJustToPitch.returnValueSelectedFromSegmentControl() == "Sí" {
      
      deliverIntelectualPropertyResultString = "si"
      
    }else
      if deliverIntelectualPropertyJustToPitch.returnValueSelectedFromSegmentControl() == "No" {
        
        deliverIntelectualPropertyResultString = "no"
        
      }else
        if deliverIntelectualPropertyJustToPitch.returnValueSelectedFromSegmentControl() == "No sé" {
          
          deliverIntelectualPropertyResultString = "no se"
          
    }
    
    let clearDeliverableResult = (clearDeliverable.returnValueSelectedFromSegmentControl() == "Sí" ? 1 : 0)
    
    
    let params:  [String: AnyObject] = [
      "has_selection_criteria": knowTheSelectionCriteriaResult,
      "are_objectives_clear": clearObjectiveResult,
      "time_to_present": howManyDaysToPresent,
      "is_budget_known": knowTheProjectBudgetResult,
      "number_of_agencies": howManyAgenciesResult,
      "are_deliverables_clear": clearDeliverableResult,
      "is_marketing_involved": involvementMKResultString,
      "time_to_know_decision": howManyWeeksTheRulingResult,
      "deliver_copyright_for_pitching": deliverIntelectualPropertyResultString,
      "number_of_rounds": howManyRoundsResult
    ]
    
    
    self.delegate?.updatePitchEvaluation(params)
    
  }
  
  @objc private func howManyDaysToShowEdited() {
    
    isHowManyDaysToShowEdited = true
    
  }
  
  private func activateEvaluatePitchButton() {
    
    if evaluatePitchButton.enabled == false {
      
      UIView.animateWithDuration(0.25,
                                 animations: {
                                  
                                  self.evaluatePitchButton.backgroundColor = UIColor.blackColor()
                                  
      }) { (finished) in
        if finished == true {
          
          self.evaluatePitchButton.enabled = true
          
        }
      }
    }
    
  }
  
  private func checkIfAllElementsSelected() {
    
    let notDesirableCharacters = NSCharacterSet.decimalDigitCharacterSet().invertedSet
    let lettersInHowManyDaysToShow = howManyDaysToShow.mainTextField.text!.rangeOfCharacterFromSet(notDesirableCharacters)
    
    if isClearObjectivesViewEdited == true && isYouKnowTheProjectBudgetEdited == true && isYouKnowTheSelectionCriteriaEdited == true  && isInvolvementOfMarketingEdited == true && isHowManyAgenciesParticipateEdited == true && isHowManyDaysToShowEdited == true && UtilityManager.sharedInstance.isValidText(howManyDaysToShow.mainTextField.text!) && lettersInHowManyDaysToShow == nil && isYouKnowHowManyPresentationRounds == true && isHowManyDaysTheyGiveTheRulingEdited == true && isDeliverIntelectualPropertyJustToPitchEdited == true && isClearDeliverableEdited == true {
      
      if youKnowHowManyPresentationRounds.returnValueSelectedFromSegmentControl() == "Sí" {
        
        if isHowManyEdited == true && UtilityManager.sharedInstance.isValidText(howMany.mainTextField.text!) {
          
          self.activateEvaluatePitchButton()
          
        }
        
      }else{
        
        self.activateEvaluatePitchButton()
        
      }
      
    }
    
  }
  
  //MARK: - CustomSegmentedControlWithTitleViewDelegate
  
  func customSegmentedControlWithTitleViewDidBeginEditing(sender: AnyObject) {
    
    if let customView = sender as? CustomSegmentedControlWithTitleView {
      
      if customView.tag == 1 {
        
        isClearObjectivesViewEdited = true
        
      } else
        if customView.tag == 2 {
          
          isYouKnowTheProjectBudgetEdited = true
          
        } else
          if customView.tag == 3 {
            
            isYouKnowTheSelectionCriteriaEdited = true
            
          } else
            if customView.tag == 4 {
              
              isInvolvementOfMarketingEdited = true
              
            } else
              if customView.tag == 5 {
                
                isHowManyAgenciesParticipateEdited = true
                
              } else
                if customView.tag == 7 {
                  
                  isYouKnowHowManyPresentationRounds = true
                  
                } else
                  if customView.tag == 10 {
                    
                    isDeliverIntelectualPropertyJustToPitchEdited = true
                    
                  } else
                    if customView.tag == 11 {
                      
                      isClearDeliverableEdited = true
                      
      }
      
    }
    
    self.checkIfAllElementsSelected()
    
  }
  
  //MARK: - CustomTextFieldWithTitleAndPickerViewDelegate
  func customTextFieldWithTitleAndPickerViewDidBeginEditing(sender: AnyObject) {
    
    if let customView = sender as? CustomTextFieldWithTitleAndPickerView {
      
      //      if customView.tag == 6 {
      //        
      //        isHowManyDaysToShowEdited = true
      //        
      //      } else
      if customView.tag == 8 {
        
        isHowManyEdited = true
        
      }else
        if customView.tag == 9 {
          
          isHowManyDaysTheyGiveTheRulingEdited = true
          
      }
      
    }
    
    self.checkIfAllElementsSelected()
    
  }
  
  
}


