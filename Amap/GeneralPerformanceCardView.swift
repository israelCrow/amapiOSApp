//
//  GeneralPerformanceCardView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 10/28/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class GeneralPerformanceCardView: UIView {
  
  private var mainScrollView: UIScrollView! = nil
  private var selectorOfInformationView: CustomTextFieldWithTitleAndPickerView! = nil
  private var optionsForSelector = [String]()
  private var circleGraph: CircleGraphView! = nil
  private var recommendationsView: RecommendationsDashboardsView! = nil
  
  private var arrayOfAgencyUsersModelData = [AgencyUserModelData]()
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newArrayOfUsers: [AgencyUserModelData]) {
    
    arrayOfAgencyUsersModelData = newArrayOfUsers
    
    super.init(frame: frame)
    
    self.initValues()
    self.initInterface()
    
  }
  
  private func initValues() {
    
    for user in arrayOfAgencyUsersModelData {
      
      if user.firstName != nil && user.firstName != "" {
        
        optionsForSelector.append(user.firstName)
        
      } else {
        
        optionsForSelector.append("unknown user")
        
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
    self.createRecommendationsView()
    
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
    
    selectorOfInformationView = CustomTextFieldWithTitleAndPickerView.init(frame: frameForView,
      textLabel: VisualizeDashboardConstants.GeneralPerformanceCardView.selectorLabelText,
      nameOfImage: "dropdown",
      newOptionsOfPicker: optionsForSelector)
    
    selectorOfInformationView.tag = 1
//    selectorOfInformationView.mainTextField.addTarget(self,
//                                              action: #selector(howManyDaysToShowEdited),
//                                              forControlEvents: .AllEditingEvents)
    mainScrollView.addSubview(selectorOfInformationView)

  }
  
  private func createFaces() {
    
    let facesToShow = [
      VisualizeDashboardConstants.Faces.kGold:   7,
      VisualizeDashboardConstants.Faces.kSilver: 5,
      VisualizeDashboardConstants.Faces.kMedium: 3,
      VisualizeDashboardConstants.Faces.kBad:    1
    ]
    
    let frameForFacesView = CGRect.init(x: 0.0,
                                        y: selectorOfInformationView.frame.origin.y + selectorOfInformationView.frame.size.height + (22.0 * UtilityManager.sharedInstance.conversionHeight),
                                    width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 60.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let facesView = FacesEvaluationsView.init(frame: frameForFacesView,
                                        facesToShow: facesToShow)
    
    mainScrollView.addSubview(facesView)
    
  }
  
  private func createCircleGraph() {
    
    let frameForCircleGraph = CGRect.init(x: 0.0,
                                          y: 211.0 * UtilityManager.sharedInstance.conversionHeight,
                                      width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 256.0 * UtilityManager.sharedInstance.conversionHeight)
    
    circleGraph = CircleGraphView.init(frame: frameForCircleGraph, toPercentage: 0.68)
    mainScrollView.addSubview(circleGraph)
    circleGraph.animateCircle(0.5)
    
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
  
}
