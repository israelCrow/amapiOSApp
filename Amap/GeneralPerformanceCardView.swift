//
//  GeneralPerformanceCardView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/28/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol GeneralPerformanceCardViewDelegate {
  
  func requestToGetValuesByUser(params: [String: AnyObject])
  func requestToGetValuesFromAgency()
  
}

class GeneralPerformanceCardView: UIView, CustomTextFieldWithTitleAndPickerForDashboardViewDelegate {
  
  private var mainScrollView: UIScrollView! = nil
  private var selectorOfInformationView: CustomTextFieldWithTitleAndPickerForDashboardView! = nil
  private var optionsForSelector = [String]()
  private var facesView: FacesEvaluationsView! = nil
  private var circleGraph: CircleGraphView! = nil
  private var recommendationsView: RecommendationsDashboardsView! = nil
  
  private var arrayOfAgencyUsersModelData = [AgencyUserModelData]()
  private var numberOfPitchesByAgency = [String: Int]()
  
  //Company
  private var arrayOfBrandsWithCompanyModelData = [BrandModelData]()
  private var numberOfPitchesByCompany = [String: Int]()
  
  var delegate: GeneralPerformanceCardViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newArrayOfUsers: [AgencyUserModelData], newNumberOfPitchesByAgency: [String: Int]) {
    
    arrayOfAgencyUsersModelData = newArrayOfUsers
    numberOfPitchesByAgency = newNumberOfPitchesByAgency
    
    super.init(frame: frame)
    
    self.addGestures()
    self.initValues()
    self.initInterface()
    
  }
  
  init(frame: CGRect, newArrayOfBrands: [BrandModelData], newNumberOfPitchesByCompany: [String: Int]) {
    
    arrayOfBrandsWithCompanyModelData = newArrayOfBrands
    numberOfPitchesByCompany = newNumberOfPitchesByCompany
    
    super.init(frame: frame)
    
    self.addGestures()
    self.initValues()
    self.initInterface()
    
  }
  
  private func addGestures() {
    
    let tapToDismissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                              action: #selector(dismissKeyboard))
    tapToDismissKeyboard.numberOfTapsRequired = 1
    tapToDismissKeyboard.cancelsTouchesInView = false
    self.addGestureRecognizer(tapToDismissKeyboard)
    
  }
  
  private func initValues() {
    
    if UserSession.session.role == "2" {
      
      for user in arrayOfAgencyUsersModelData {
        
        if user.firstName != nil && user.firstName != "" {
          
          optionsForSelector.append(user.firstName)
          
        } else {
          
          optionsForSelector.append("unknown user")
          
        }
        
      }
      
    } else
      if UserSession.session.role == "4" {
        
        for brand in arrayOfBrandsWithCompanyModelData {
          
          if brand.name != nil {
            
            optionsForSelector.append(brand.name)
            
          } else {
            
            optionsForSelector.append("unknown user")
            
          }
          
        }
        
      }
    
//    optionsForSelector = ["Performance General", "Usuario 1", "Usuario 2"]
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    self.createMainScrollView()
    self.createSelectorOfInformationView()
    self.createFaces()
    self.createCircleGraph()
//    self.createRecommendationsView()
    
  }
  
  private func createMainScrollView() {
    
    let frameForMainScrollView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                             y: 0.0,
                                         width: 235.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: self.frame.size.height)
    
    let sizeForContentScrollView = CGSize.init(width: frameForMainScrollView.size.width,
                                              height: frameForMainScrollView.size.height + (200.0 * UtilityManager.sharedInstance.conversionHeight))//Value that i considered
    
    mainScrollView = UIScrollView.init(frame: frameForMainScrollView)
    mainScrollView.backgroundColor = UIColor.clearColor()
    mainScrollView.contentSize = sizeForContentScrollView
    mainScrollView.showsVerticalScrollIndicator = true
    self.addSubview(mainScrollView)
    
  }
  
  private func createSelectorOfInformationView() {
    
    let frameForView = CGRect.init(x: 0.0,
                                   y: 40.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                              height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    selectorOfInformationView = CustomTextFieldWithTitleAndPickerForDashboardView.init(frame: frameForView,
      textLabel: VisualizeDashboardConstants.GeneralPerformanceCardView.selectorLabelText,
      nameOfImage: "dropdown",
      newOptionsOfPicker: optionsForSelector)
    
    let newFrameForSelector = CGRect.init(x: selectorOfInformationView.mainTextField.frame.origin.x,
                                          y: selectorOfInformationView.mainTextField.frame.origin.y,
      width: selectorOfInformationView.mainTextField.frame.size.width,
      height: selectorOfInformationView.mainTextField.frame.size.height + (6.0 * UtilityManager.sharedInstance.conversionHeight))
    
    selectorOfInformationView.delegate = self
    selectorOfInformationView.mainTextField.frame = newFrameForSelector
    
    selectorOfInformationView.tag = 1
//    selectorOfInformationView.mainTextField.addTarget(self,
//                                              action: #selector(howManyDaysToShowEdited),
//                                              forControlEvents: .AllEditingEvents)
    mainScrollView.addSubview(selectorOfInformationView)

  }
  
  private func createFaces() {
    
    if facesView != nil {
      
      facesView.removeFromSuperview()
      facesView = nil
      
    }
    
    var facesToShow = [String: Int]()
    
    if UserSession.session.role == "2" {
      
      let numberOfHappitchesByAgency = (numberOfPitchesByAgency["happitch"] != nil ? numberOfPitchesByAgency["happitch"] : 0)
      let numberOfHappiesByAgency = (numberOfPitchesByAgency["happy"] != nil ? numberOfPitchesByAgency["happy"] : 0)
      let numberOfOksByAgency = (numberOfPitchesByAgency["ok"] != nil ? numberOfPitchesByAgency["ok"] : 0)
      let numberOfUnhappiesByAgency = (numberOfPitchesByAgency["unhappy"] != nil ? numberOfPitchesByAgency["unhappy"] : 0)
      
      
      facesToShow = [
      VisualizeDashboardConstants.Faces.kGold:   numberOfHappitchesByAgency!,
      VisualizeDashboardConstants.Faces.kSilver: numberOfHappiesByAgency!,
      VisualizeDashboardConstants.Faces.kMedium: numberOfOksByAgency!,
      VisualizeDashboardConstants.Faces.kBad:    numberOfUnhappiesByAgency!
      ]
      
    } else
      if UserSession.session.role == "4" {
        
        let numberOfHappitchesByCompany = (numberOfPitchesByCompany["happitch"] != nil ? numberOfPitchesByCompany["happitch"] : 0)
        let numberOfHappiesByCompany = (numberOfPitchesByCompany["happy"] != nil ? numberOfPitchesByCompany["happy"] : 0)
        let numberOfOksByCompany = (numberOfPitchesByCompany["ok"] != nil ? numberOfPitchesByCompany["ok"] : 0)
        let numberOfUnhappiesByCompany = (numberOfPitchesByCompany["unhappy"] != nil ? numberOfPitchesByCompany["unhappy"] : 0)
        
        
        facesToShow = [
          VisualizeDashboardConstants.Faces.kGold:   numberOfHappitchesByCompany!,
          VisualizeDashboardConstants.Faces.kSilver: numberOfHappiesByCompany!,
          VisualizeDashboardConstants.Faces.kMedium: numberOfOksByCompany!,
          VisualizeDashboardConstants.Faces.kBad:    numberOfUnhappiesByCompany!
        ]
        
      }
    

    
    let frameForFacesView = CGRect.init(x: 0.0,
                                        y: selectorOfInformationView.frame.origin.y + selectorOfInformationView.frame.size.height + (22.0 * UtilityManager.sharedInstance.conversionHeight),
                                    width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 60.0 * UtilityManager.sharedInstance.conversionHeight)
    
    facesView = FacesEvaluationsView.init(frame: frameForFacesView,
                                        facesToShow: facesToShow)
    
    mainScrollView.addSubview(facesView)
    
  }
  
  private func createCircleGraph() {
    
    if circleGraph != nil {
      
      circleGraph.removeFromSuperview()
      circleGraph = nil
      
    }
    
    var numberOfLostPitchesByAgency = 0
    var numberOfWonPitchesByAgency = 0
    
    if UserSession.session.role == "2" {
    
      numberOfLostPitchesByAgency = (numberOfPitchesByAgency["lost"] != nil ? numberOfPitchesByAgency["lost"]! : 0)
      numberOfWonPitchesByAgency = (numberOfPitchesByAgency["won"] != nil ? numberOfPitchesByAgency["won"]! : 0)
      
    } else
      if UserSession.session.role == "4" {
        
        numberOfLostPitchesByAgency = (numberOfPitchesByCompany["lost"] != nil ? numberOfPitchesByCompany["lost"]! : 0)
        numberOfWonPitchesByAgency = (numberOfPitchesByCompany["won"] != nil ? numberOfPitchesByCompany["won"]! : 0)
        
      }
    
    var finalPercentage: CGFloat = 0.0
    
    if numberOfWonPitchesByAgency != 0 && numberOfLostPitchesByAgency != 0 {
      
      finalPercentage = CGFloat(CGFloat(numberOfWonPitchesByAgency)) / CGFloat(numberOfLostPitchesByAgency + numberOfWonPitchesByAgency)
      
    }
    
//    let stringNumber: String = String(format: "%.1f", Double(finalPercentage))
//    finalPercentage = CGFloat((stringNumber as NSString).floatValue)
    
    let frameForCircleGraph = CGRect.init(x: 0.0,
                                          y: 211.0 * UtilityManager.sharedInstance.conversionHeight,
                                      width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 256.0 * UtilityManager.sharedInstance.conversionHeight)
    
    circleGraph = CircleGraphView.init(frame: frameForCircleGraph, toPercentage: finalPercentage)
    mainScrollView.addSubview(circleGraph)
    circleGraph.animateCircle(0.5)
    
  }
  
  func updateData(newNumberOfPitchesByAgency: [String: Int]) {
    
    numberOfPitchesByAgency = newNumberOfPitchesByAgency
    
    self.createFaces()
    self.createCircleGraph()
    
  }
  
  private func createRecommendationsView() {
    
    let frameForRecommendations = CGRect.init(x: 0.0,
                        y: circleGraph.frame.origin.y + circleGraph.frame.size.height + (15.0 * UtilityManager.sharedInstance.conversionHeight),
                    width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                   height: 230.0 * UtilityManager.sharedInstance.conversionHeight)
  
    let arrayOfRecommendations = ["No aceptes pitches con más de 5 agencias involucradas",
                                  "No aceptes pitches con más de 5 agencias involucradas",
                                  "No aceptes pitches con más de 5 agencias involucradas"
                                 ]
    
    recommendationsView = RecommendationsDashboardsView.init(frame: frameForRecommendations,
      newArrayOfRecommendations: arrayOfRecommendations)
    
    mainScrollView.addSubview(recommendationsView)
  
  }
  
  //MARK: - CustomTextFieldWithTitleAndPickerForDashboardViewDelegate
  
  func userSelected(numberOfElementInArrayOfUsers: Int) {
    
    if numberOfElementInArrayOfUsers == 0 {
      
      self.delegate?.requestToGetValuesFromAgency()
      
    } else {
      
      let params: [String: AnyObject] = ["auth_token": UserSession.session.auth_token,
                                         "id": arrayOfAgencyUsersModelData[numberOfElementInArrayOfUsers - 1].id]
      
      self.delegate?.requestToGetValuesByUser(params)
      
    }
    
  }
  
  @objc private func dismissKeyboard(sender:AnyObject) {
    
    self.endEditing(true)
    
  }
  
}
