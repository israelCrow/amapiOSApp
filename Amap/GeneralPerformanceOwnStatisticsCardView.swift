//
//  GeneralPerformanceOwnStatisticsCardView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 12/16/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit
import CorePlot

protocol GeneralPerformanceOwnStatisticsCardViewDelegate {
  
  func requestToGetValuesByBrand(params: [String: AnyObject])
  func requestToGetValuesFromCompany()
  
}

class GeneralPerformanceOwnStatisticsCardView: UIView, CustomTextFieldWithTitleAndPickerForDashboardViewDelegate, CPTPieChartDataSource {
  
  private var mainScrollView: UIScrollView! = nil
  private var selectorOfInformationView: CustomTextFieldWithTitleAndPickerForDashboardView! = nil
  private var optionsForSelector = [String]()
  private var facesView: FacesEvaluationsView! = nil
  private var circleGraph: CircleGraphView! = nil
  private var recommendations: RecommendationsDashboardsView! = nil
  private var recommendationsData = [RecommendationModelData]()
  private var recommendationsView: RecommendationsDashboardsView! = nil
  private var borderAfterRecommendations: CALayer! = nil
  
  private var chartHostView: CPTGraphHostingView! = nil
  private var dataForChart: [Double]! = nil
  
  //Company
  
  private var titleText: String! = nil
  private var titleLabel: UILabel! = nil
  private var arrayOfBrandsWithCompanyModelData = [BrandModelData]()
  private var numberOfPitchesByCompany = [String: Int]()
  
  var delegate: GeneralPerformanceOwnStatisticsCardViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newArrayOfBrands: [BrandModelData], newNumberOfPitchesByCompany: [String: Int], newTitleText: String, newRecommendationsData: [RecommendationModelData]) {
    
    titleText = newTitleText
    arrayOfBrandsWithCompanyModelData = newArrayOfBrands
    numberOfPitchesByCompany = newNumberOfPitchesByCompany
    recommendationsData = newRecommendationsData
    
    super.init(frame: frame)
    
    self.addGestures()
    self.initValues()
    self.initInterface()
    
  }
  
  private func initValues() {
    
    self.setData()
    
    for brand in arrayOfBrandsWithCompanyModelData {
      
      if brand.name != nil {
        
        optionsForSelector.append(brand.name)
        
      } else {
        
        optionsForSelector.append("unknown user")
        
      }
      
    }
    //    optionsForSelector = ["Performance General", "Usuario 1", "Usuario 2"]
    
  }
  
  private func setData() {
    
    let happitchPercentage = Double(CGFloat(numberOfPitchesByCompany["happitch"] != nil ? CGFloat(numberOfPitchesByCompany["happitch"]!) / 100.0 : 0.0))
    let happyPercentage = Double(CGFloat(numberOfPitchesByCompany["happy"] != nil ? CGFloat(numberOfPitchesByCompany["happy"]!) / 100.0 : 0.0))
    let okPercentage = Double(CGFloat(numberOfPitchesByCompany["ok"] != nil ? CGFloat(numberOfPitchesByCompany["ok"]!) / 100.0 : 0.0))
    let sadPercentage = Double(CGFloat(numberOfPitchesByCompany["unhappy"] != nil ? CGFloat(numberOfPitchesByCompany["unhappy"]!) / 100.0 : 0.0))
    
    dataForChart = [happitchPercentage, happyPercentage, okPercentage, sadPercentage]
    //    dataForChart = [0.25, 0.25, 0.25, 0.25]
  }
  
  private func addGestures() {
    
    let tapToDismissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                              action: #selector(dismissKeyboard))
    tapToDismissKeyboard.numberOfTapsRequired = 1
    tapToDismissKeyboard.cancelsTouchesInView = false
    self.addGestureRecognizer(tapToDismissKeyboard)
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    self.createMainScrollView()
    self.createTitleLabel()
//    self.createSelectorOfInformationView()
    self.createFaces()
    self.createPieChart()
//    self.createCircleGraph()
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
    
    let frameForView = CGRect.init(x: 0.0,
                                 y: 111.0 * UtilityManager.sharedInstance.conversionHeight,
                                 width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                 height: 68.0 * UtilityManager.sharedInstance.conversionHeight)
      
      self.createTitleLabel()
    
    selectorOfInformationView = CustomTextFieldWithTitleAndPickerForDashboardView.init(frame: frameForView,
      textLabel: "Elige a la marca que quieres visualizar",
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
    
    selectorOfInformationView.mainTextField.text = (MyCompanyModelData.Data.name != nil ? MyCompanyModelData.Data.name! : "Anunciante")
    
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
    
    let frameForFacesView = CGRect.init(x: 0.0,
                                        y: 100.0 * UtilityManager.sharedInstance.conversionHeight, //selectorOfInformationView.frame.origin.y + selectorOfInformationView.frame.size.height + (22.0 * UtilityManager.sharedInstance.conversionHeight),
                                        width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 60.0 * UtilityManager.sharedInstance.conversionHeight)
    
    facesView = FacesEvaluationsView.init(frame: frameForFacesView,
                                          facesToShow: facesToShow)
    
    mainScrollView.addSubview(facesView)
    
  }
  
  private func createPieChart() {
    
    var noValues = true
    
    for anyData in dataForChart {
      
      if anyData != 0.0 {
        
        noValues = false
        
      }
      
    }
    
    if noValues == false {
      
      let frameForChartView = CGRect.init(x: (self.mainScrollView.frame.size.width / 2.0) - (110.5 * UtilityManager.sharedInstance.conversionWidth),
                                          y: 165.0 * UtilityManager.sharedInstance.conversionHeight,
                                          width: 211.0 * UtilityManager.sharedInstance.conversionWidth,
                                          height: 211.0 * UtilityManager.sharedInstance.conversionHeight)
      
      
      chartHostView = CPTGraphHostingView.init(frame: frameForChartView)
      
      self.configureHostView()
      self.configureGraph()
      self.configureChart()
      self.createLine()
      //    self.configureLegend()
      
      self.mainScrollView.addSubview(chartHostView)
      
    } else {
      
      self.createNoValuesLabel()
      
    }
    
  }
  
  private func createNoValuesLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 255.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    let genericLabel = UILabel.init(frame: frameForLabel)
    genericLabel.numberOfLines = 0
    genericLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 26.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: "Ninguna agencia\nha evaluado este pitch",
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    genericLabel.attributedText = stringWithFormat
    genericLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (genericLabel.frame.size.width / 2.0),
                               y: 65.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: genericLabel.frame.size.width,
                               height: genericLabel.frame.size.height)
    
    genericLabel.frame = newFrame
    
    self.mainScrollView.addSubview(genericLabel)
    
  }
  
  private func configureHostView() {
    
    chartHostView.allowPinchScaling = false
    chartHostView.userInteractionEnabled = false
    
  }
  
  private func configureGraph() {
    
    // 1 - Create and configure the graph
    let graph = CPTXYGraph(frame: chartHostView.bounds)
    chartHostView.hostedGraph = graph
    graph.paddingLeft = 0.0
    graph.paddingTop = 0.0
    graph.paddingRight = 0.0
    graph.paddingBottom = 0.0
    graph.axisSet = nil
    
    // 2 - Create text style
    let textStyle: CPTMutableTextStyle = CPTMutableTextStyle()
    textStyle.color = CPTColor.blackColor()
    textStyle.fontName = "HelveticaNeue-Bold"
    textStyle.fontSize = 16.0
    textStyle.textAlignment = .Center
    
    // 3 - Set graph title and text style
    //    graph.title = "\(base.name) exchange rates\n\(rate.date)"
    graph.titleTextStyle = textStyle
    graph.titlePlotAreaFrameAnchor = CPTRectAnchor.Top
    
  }
  
  private func configureChart() {
    
    //
    //    CPTGradient *overlayGradient = [[CPTGradient alloc] init];
    //    overlayGradient.gradientType = CPTGradientTypeRadial;
    //    overlayGradient              = [overlayGradient addColorStop:[[CPTColor blackColor] colorWithAlphaComponent:CPTFloat(0.0)] atPosition:CPTFloat(0.0)];
    //    overlayGradient              = [overlayGradient addColorStop:[[CPTColor blackColor] colorWithAlphaComponent:CPTFloat(0.3)] atPosition:CPTFloat(0.9)];
    //    overlayGradient              = [overlayGradient addColorStop:[[CPTColor blackColor] colorWithAlphaComponent:CPTFloat(0.7)] atPosition:CPTFloat(1.0)];
    //
    
    var overlayGradient = CPTGradient.init()
    overlayGradient.gradientType = .Radial
    
    overlayGradient = overlayGradient.addColorStop(CPTColor.whiteColor().colorWithAlphaComponent(2.0), atPosition: 0.0)
    
    
    //    overlayGradient = overlayGradient.addColorStop(CPTColor.whiteColor().colorWithAlphaComponent(0.0), atPosition: 0.2)
    overlayGradient = overlayGradient.addColorStop(CPTColor.grayColor().colorWithAlphaComponent(0.05), atPosition: 1.1)
    overlayGradient = overlayGradient.gradientWithAlphaComponent(0.5)
    
    // 1 - Get a reference to the graph
    let graph = chartHostView.hostedGraph!
    
    // 2 - Create the chart
    let pieChart = CPTPieChart()
    pieChart.delegate = self
    pieChart.dataSource = self
    pieChart.pieRadius = (min(chartHostView.bounds.size.width, chartHostView.bounds.size.height) * 0.7) / 2
    //    pieChart.identifier = NSString(string: graph.title!)
    pieChart.startAngle = CGFloat(M_PI_2)
    pieChart.sliceDirection = .CounterClockwise
    pieChart.labelOffset = -0.6 * pieChart.pieRadius
//    pieChart.overlayFill = CPTFill.init(gradient: overlayGradient)
    
    
    // 3 - Configure border style
    let borderStyle = CPTMutableLineStyle()
    borderStyle.lineColor = CPTColor.whiteColor()
    borderStyle.lineWidth = 2.0
    pieChart.borderLineStyle = borderStyle
    
    // 4 - Configure text style
    let textStyle = CPTMutableTextStyle()
    textStyle.color = CPTColor.whiteColor()
    textStyle.textAlignment = .Center
    
    pieChart.showLabels = false
    pieChart.labelTextStyle = textStyle
    
    // 5 - Add chart to graph
    graph.addPlot(pieChart)
    
    //    CPTAnimation.animate(pieChart,
    //                         property: "endAngle",
    //                         from: CGFloat(M_PI_2),
    //                         to: CGFloat(-3.0*M_PI_2),
    //                         duration: 0.5)
    
  }

  private func createLine() {
    
    let border = CALayer()
    let width = CGFloat(1)
    border.borderColor = UIColor.lightGrayColor().CGColor
    border.borderWidth = width
    border.frame = CGRect.init(x: 0.0,
                               y: self.chartHostView.frame.origin.y + self.chartHostView.frame.size.height - (2.0 * UtilityManager.sharedInstance.conversionHeight),
                               width: (220.0 * UtilityManager.sharedInstance.conversionWidth),
                               height: 1.0)
    self.mainScrollView.layer.addSublayer(border)
    
  }
  
  private func createCircleGraph() {
    
    if circleGraph != nil {
      
      circleGraph.removeFromSuperview()
      circleGraph = nil
      
    }
    
    var numberOfLostPitchesByAgency = 0
    var numberOfWonPitchesByAgency = 0
    
    numberOfLostPitchesByAgency = (numberOfPitchesByCompany["lost"] != nil ? numberOfPitchesByCompany["lost"]! : 0)
    numberOfWonPitchesByAgency = (numberOfPitchesByCompany["won"] != nil ? numberOfPitchesByCompany["won"]! : 0)
    
    var finalPercentage: CGFloat = 0.0
    
    if numberOfWonPitchesByAgency != 0 {
      
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
  
  func updateData(newNumberOfPitchesByCompany: [String: Int], newRecommendations: [RecommendationModelData]) {
    
    numberOfPitchesByCompany = newNumberOfPitchesByCompany
    recommendationsData = newRecommendations
    
    self.createFaces()
    self.createCircleGraph()
    self.createRecommendations()
    
  }
  
  private func createRecommendations() {
    
    if recommendations != nil {
      
      let newContentSize = CGSize.init(width: mainScrollView.contentSize.width,
                                       height: mainScrollView.contentSize.height - recommendations.frame.size.height)
      
      mainScrollView.contentSize = newContentSize
      
      recommendations.removeFromSuperview()
      recommendations = nil
      
    }
    
    let frameForRecommendations = CGRect.init(x: 0.0,
                                              y: chartHostView.frame.origin.y + chartHostView.frame.size.height + (15.0 * UtilityManager.sharedInstance.conversionHeight),//circleGraph.frame.origin.y + circleGraph.frame.size.height + (15.0 * UtilityManager.sharedInstance.conversionHeight),
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
                                    height: titleLabel.frame.size.height + facesView.frame.size.height + chartHostView.frame.size.height + recommendations.getFinalHeight() + (150.0 * UtilityManager.sharedInstance.conversionHeight))
    
    mainScrollView.contentSize = newContentSize
    
  }
  
  //MARK: - CustomTextFieldWithTitleAndPickerForDashboardViewDelegate
  
  func userSelected(numberOfElementInArrayOfUsers: Int) {
    
    if numberOfElementInArrayOfUsers == 0 {
      
      self.delegate?.requestToGetValuesFromCompany()
      
    } else {
      
      let params: [String: AnyObject] = ["auth_token": UserSession.session.auth_token,
                                         "id": arrayOfBrandsWithCompanyModelData[numberOfElementInArrayOfUsers].id]
      
      self.delegate?.requestToGetValuesByBrand(params)
      
    }
    
  }
  
  func actionToMakeWhenUserRoleIsFive() {
    
    if UserSession.session.role == "5" {
  
      let params: [String: AnyObject] = ["auth_token": UserSession.session.auth_token,
                                         "id": UserSession.session.id]
      
      self.delegate?.requestToGetValuesByBrand(params)
  
    }

  }
  
  @objc private func dismissKeyboard(sender:AnyObject) {
    
    self.endEditing(true)
    
  }
  
  // MARK: - Plot Data Source Methods
  
  func numberOfRecordsForPlot(plot: CPTPlot) -> UInt
  {
    return UInt(self.dataForChart.count)
  }
  
  func numberForPlot(plot: CPTPlot, field: UInt, recordIndex: UInt) -> AnyObject? {
    
    if Int(recordIndex) > self.dataForChart.count {
      
      return nil
      
    }
      
    else {
      
      switch CPTPieChartField(rawValue: Int(field))! {
        
      case .SliceWidth:
        return (self.dataForChart)[Int(recordIndex)] as NSNumber
        
      default:
        
        return recordIndex as NSNumber
        
      }
      
    }
    
  }
  
  func dataLabelForPlot(plot: CPTPlot, recordIndex: UInt) -> CPTLayer? {
    
    let label = CPTTextLayer(text:"\(recordIndex)")
    
    if let textStyle = label.textStyle?.mutableCopy() as? CPTMutableTextStyle {
      
      textStyle.color = CPTColor.lightGrayColor()
      label.textStyle = textStyle
      
    }
    
    return label
    
  }
  
  func sliceFillForPieChart(pieChart: CPTPieChart, recordIndex idx: UInt) -> CPTFill? {
    
    
    let firstColorHappitch = CPTColor.init(componentRed: 242.0/255.0 , green: 165.0/255.0, blue: 18.0/255.0, alpha: 1.0)
    let secondColorHappitch = CPTColor.init(componentRed: 255.0/255.0 , green: 85.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    let gradientHappitch = CPTGradient.init(beginningColor: firstColorHappitch, endingColor: secondColorHappitch)
    
    let happitchFill = CPTFill.init(gradient: gradientHappitch)
    
    let firstColorHappy = CPTColor.init(componentRed: 45.0/255.0 , green: 252.0/255.0, blue: 197.0/255.0, alpha: 1.0)
    let secondColorHappy = CPTColor.init(componentRed: 21.0/255.0 , green: 91.0/255.0, blue: 138.0/255.0, alpha: 1.0)
    let gradientHappy = CPTGradient.init(beginningColor: firstColorHappy, endingColor: secondColorHappy)
    let happyFill = CPTFill.init(gradient: gradientHappy)
    
    let firstColorOK = CPTColor.init(componentRed: 48.0/255.0 , green: 197.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    let secondColorOK = CPTColor.init(componentRed: 243.0/255.0 , green: 9.0/255.0, blue: 173.0/255.0, alpha: 1.0)
    let gradientOK = CPTGradient.init(beginningColor: firstColorOK, endingColor: secondColorOK)
    let oKFill = CPTFill.init(gradient: gradientOK)
    
    let firstColorUnhappy = CPTColor.init(componentRed: 190.0/255.0 , green: 80.0/255.0, blue: 238.0/255.0, alpha: 1.0)
    let secondColorUnhappy = CPTColor.init(componentRed: 255.0/255.0 , green: 25.0/255.0, blue: 33.0/255.0, alpha: 1.0)
    let gradientUnhappy = CPTGradient.init(beginningColor: firstColorUnhappy, endingColor: secondColorUnhappy)
    let unhappyFill = CPTFill.init(gradient: gradientUnhappy)
    
    
    switch idx {
      
    case 0:   return happitchFill
    case 1:   return happyFill
    case 2:   return oKFill
    case 3:   return unhappyFill
      
    default:  return nil
      
    }
    
  }
  
}
