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
  private var recommendations: RecommendationsDashboardsView! = nil
  private var recommendationsData = [RecommendationModelData]()
  private var borderAfterRecommendations: CALayer! = nil
//  private var recommendationsView: RecommendationsDashboardsView! = nil
  
  private var arrayOfAgencyUsersModelData = [AgencyUserModelData]()
  private var numberOfPitchesByAgency = [String: Int]()
  
  //Company
  
  private var titleText: String! = nil
  private var titleLabel: UILabel! = nil
  private var arrayOfBrandsWithCompanyModelData = [BrandModelData]()
  private var numberOfPitchesByCompany = [String: Int]()
  
  var delegate: GeneralPerformanceCardViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newArrayOfUsers: [AgencyUserModelData], newNumberOfPitchesByAgency: [String: Int], newRecommendationsData: [RecommendationModelData]) {
    
    recommendationsData = newRecommendationsData
    arrayOfAgencyUsersModelData = newArrayOfUsers
    numberOfPitchesByAgency = newNumberOfPitchesByAgency
    
    super.init(frame: frame)
    
    self.addGestures()
    self.initValues()
    self.initInterface()
    
  }
  
  init(frame: CGRect, newArrayOfBrands: [BrandModelData], newNumberOfPitchesByCompany: [String: Int], newTitleText: String) {
    
    titleText = newTitleText
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
    
    if UserSession.session.role == "2" || UserSession.session.role == "3" {
      
      for user in arrayOfAgencyUsersModelData {
        
        if user.firstName != nil && user.firstName != "" {
          
          optionsForSelector.append(user.firstName)
          
        } else {
          
          optionsForSelector.append("unknown user")
          
        }
        
      }
      
    } else
      if UserSession.session.role == "4" || UserSession.session.role == "5" {
        
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
    self.createRecommendations()
    
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
    
    var frameForView = CGRect.init(x: 0.0,
                                   y: 40.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                              height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
    
    var textForselector = VisualizeDashboardConstants.GeneralPerformanceCardView.selectorLabelText
    
    if (UserSession.session.role == "4" || UserSession.session.role == "5") && titleText != nil {
      
      self.createTitleLabel()
      
      frameForView = CGRect.init(x: 0.0,
                                 y: 111.0 * UtilityManager.sharedInstance.conversionHeight,
                                 width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                 height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
      
      textForselector = "Elige al anunciante que quieres visualizar"
      
    }
    
    selectorOfInformationView = CustomTextFieldWithTitleAndPickerForDashboardView.init(frame: frameForView,
      textLabel: textForselector,
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
    
    if UserSession.session.role == "2" {
      
      selectorOfInformationView.mainTextField.text = (AgencyModel.Data.name != nil && AgencyModel.Data.name != "" ? AgencyModel.Data.name! : "Agencia Actual")
      
    }else
    
      if UserSession.session.role == "3" || UserSession.session.role == "5" {
      
        selectorOfInformationView.mainTextField.text = (UserSession.session.first_name != nil && UserSession.session.first_name != "" ? UserSession.session.first_name! : "Usuario actual")
        selectorOfInformationView.alpha = 1.0
        selectorOfInformationView.userInteractionEnabled = false
      
      }
    
    
    mainScrollView.addSubview(selectorOfInformationView)

  }
  
  private func createTitleLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0 * UtilityManager.sharedInstance.conversionHeight,
                                    width: 222.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    titleLabel = UILabel.init(frame: frameForLabel)
    titleLabel.numberOfLines = 0
    titleLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: titleText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    titleLabel.attributedText = stringWithFormat
    titleLabel.sizeToFit()
    let newFrame = CGRect.init(x: (mainScrollView.frame.size.width / 2.0) - ((titleLabel.frame.size.width / 2.0) + (5.0 * UtilityManager.sharedInstance.conversionWidth)),
                               y: 30.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: titleLabel.frame.size.width,
                               height: titleLabel.frame.size.height)
    
    titleLabel.frame = newFrame
    
    self.mainScrollView.addSubview(titleLabel)
    
  }
  
  private func createFaces() {
    
    if facesView != nil {
      
      facesView.removeFromSuperview()
      facesView = nil
      
    }
    
    var facesToShow = [String: Int]()
    
    if UserSession.session.role == "2" || UserSession.session.role == "3" {
      
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
      if UserSession.session.role == "4" || UserSession.session.role == "5" {
        
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
    
    if UserSession.session.role == "2" || UserSession.session.role == "3" {
    
      numberOfLostPitchesByAgency = (numberOfPitchesByAgency["lost"] != nil ? numberOfPitchesByAgency["lost"]! : 0)
      numberOfWonPitchesByAgency = (numberOfPitchesByAgency["won"] != nil ? numberOfPitchesByAgency["won"]! : 0)
      
    } else
      if UserSession.session.role == "4" || UserSession.session.role == "5"  {
        
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
                                          y: facesView.frame.origin.y + facesView.frame.size.height + (30.0 * UtilityManager.sharedInstance.conversionHeight),
//                                          y: 211.0 * UtilityManager.sharedInstance.conversionHeight,
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
  
//  private func createRecommendationsView() {
//    
//    let frameForRecommendations = CGRect.init(x: 0.0,
//                        y: circleGraph.frame.origin.y + circleGraph.frame.size.height + (15.0 * UtilityManager.sharedInstance.conversionHeight),
//                    width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
//                   height: 230.0 * UtilityManager.sharedInstance.conversionHeight)
//    
//    recommendationsView = RecommendationsDashboardsView.init(frame: frameForRecommendations,
//      newArrayOfRecommendations: [RecommendationModelData]())
//    
//    mainScrollView.addSubview(recommendationsView)
//  
//  }
  
  private func createRecommendations() {
    
    if recommendations != nil {
      
      let newContentSize = CGSize.init(width: mainScrollView.contentSize.width,
                                       height: mainScrollView.contentSize.height - recommendations.frame.size.height)
      
      mainScrollView.contentSize = newContentSize
      
      recommendations.removeFromSuperview()
      recommendations = nil
      
    }
    
    let frameForRecommendations = CGRect.init(x: 0.0,
                                              y: circleGraph.frame.origin.y + circleGraph.frame.size.height + (15.0 * UtilityManager.sharedInstance.conversionHeight),
                                              width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                              height: 230.0 * UtilityManager.sharedInstance.conversionHeight)
    
    recommendations = RecommendationsDashboardsView.init(frame: frameForRecommendations,
                                                         newArrayOfRecommendations: self.recommendationsData)
    
    mainScrollView.addSubview(recommendations)
    
    if borderAfterRecommendations != nil {
      
      borderAfterRecommendations.removeFromSuperlayer()
      borderAfterRecommendations = nil
      
    }
    
    borderAfterRecommendations = CALayer()
    let width = CGFloat(1)
    borderAfterRecommendations.borderColor = UIColor.grayColor().CGColor
    borderAfterRecommendations.borderWidth = width
    borderAfterRecommendations.frame = CGRect.init(x: 0.0 * UtilityManager.sharedInstance.conversionWidth,
                                                   y: recommendations.frame.origin.y + recommendations.getFinalHeight() + (22.0 * UtilityManager.sharedInstance.conversionHeight),
                                                   width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                                   height: 1.0 * UtilityManager.sharedInstance.conversionHeight)
    mainScrollView.layer.addSublayer(borderAfterRecommendations)
    //    mainScrollView.layer.masksToBounds = false
    
    let newContentSize = CGSize.init(width: mainScrollView.contentSize.width,
                                     height: mainScrollView.contentSize.height + recommendations.frame.size.height + (40.0 * UtilityManager.sharedInstance.conversionHeight))
    
    mainScrollView.contentSize = newContentSize
    
  }
  
  func actionToMakeWhenUserRoleThree() {
    
    if UserSession.session.role == "3" {
      
      let params: [String: AnyObject] = ["auth_token": UserSession.session.auth_token,
                                         "id": UserSession.session.id]
      
      self.delegate?.requestToGetValuesByUser(params)
      
    }
    
  }

  
  //MARK: - CustomTextFieldWithTitleAndPickerForDashboardViewDelegate
  
  func userSelected(numberOfElementInArrayOfUsers: Int) {
    
    if UserSession.session.role == "2" || UserSession.session.role == "3" {
      
      
      
    }else
      if UserSession.session.role == "4" || UserSession.session.role == "5"  {
        
        
        
      }
    
    
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
