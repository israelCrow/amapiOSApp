//
//  PitchCardForNormalClientView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 12/7/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit
import Charts
import CorePlot

class PitchCardForNormalClientView: UIView, CPTPieChartDataSource {
  
  private var descriptionView: PitchCardForNormalClientDescriptionView! = nil
  
  
  private var chartHostView: CPTGraphHostingView! = nil
  private var circularView: PieChartView! = nil
  
  private var facesView: FacesEvaluationsView! = nil
  private var pitchData: PitchEvaluationByUserModelDataForCompany! = nil
  private var dataForChart: [Double]! = nil
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newPitchData: PitchEvaluationByUserModelDataForCompany) {
    
    pitchData = newPitchData
    
    super.init(frame: frame)
    
    self.setData()
    self.initInterface()
    
  }
  
  private func setData() {
    
    let happitchPercentage = Double(CGFloat(pitchData.pitchTypesPercentage["happitch"] as! Int) / 100.0)
    let happyPercentage = Double(CGFloat(pitchData.pitchTypesPercentage["happy"] as! Int) / 100.0)
    let okPercentage = Double(CGFloat(pitchData.pitchTypesPercentage["ok"] as! Int) / 100.0)
    let sadPercentage = Double(CGFloat(pitchData.pitchTypesPercentage["unhappy"] as! Int) / 100.0)
    
    dataForChart = [happitchPercentage, happyPercentage, okPercentage, sadPercentage]
//    dataForChart = [0.25, 0.25, 0.25, 0.25]
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    self.createDescriptionView()
    self.createCircularChart()
    self.createFaces()
    
  }
  
  private func createDescriptionView() {
    
    let frameForView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                   y: 30.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: 255.0 * UtilityManager.sharedInstance.conversionWidth,
                              height: 80.0 * UtilityManager.sharedInstance.conversionHeight)
    
    var winner: String = ""
    
    if pitchData.winner == "0" {
      
      winner = "Ganador: Por definir"
      
    } else {
      
      winner = String.init(format: "Ganador: " + pitchData.winner)
      
    }
    
    descriptionView = PitchCardForNormalClientDescriptionView.init(frame: frameForView,
                                                            newMailBrief: pitchData.briefEmailContact,
                                                          newProjectName: pitchData.pitchName,
                                                           newWinnerName: winner,
                                                          newCompanyName: pitchData.companyName)
    
    self.addSubview(descriptionView)
    
  }
  
  private func createCircularChart() {
    
    let frameForChartView = CGRect.init(x: (self.frame.size.width / 2.0) - (105.5 * UtilityManager.sharedInstance.conversionWidth),
                                        y: 105.0 * UtilityManager.sharedInstance.conversionHeight,
                                        width: 211.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 211.0 * UtilityManager.sharedInstance.conversionHeight)

    
    chartHostView = CPTGraphHostingView.init(frame: frameForChartView)

    self.configureHostView()
    self.configureGraph()
    self.configureChart()
//    self.configureLegend()

    self.addSubview(chartHostView)
    
  }
  
  private func configureHostView() {
    
    chartHostView.allowPinchScaling = false
    
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
    
    CPTAnimation.animate(pieChart,
                         property: "endAngle",
                         from: CGFloat(M_PI_2),
                         to: CGFloat(-3.0*M_PI_2),
                         duration: 0.5)
    
  }
  
//  private func configureLegend() {
//
//    // 1 - Get graph instance
//    guard let graph = chartHostView.hostedGraph else { return }
//    
//    // 2 - Create legend
//    let theLegend = CPTLegend(graph: graph)
//    
//    // 3 - Configure legend
//    theLegend.numberOfColumns = 1
//    theLegend.fill = CPTFill(color: CPTColor.whiteColor())
//    let textStyle = CPTMutableTextStyle()
//    textStyle.fontSize = 18
//    theLegend.textStyle = textStyle
//    
//    // 4 - Add legend to graph
//    graph.legend = theLegend
//    if view.bounds.width > view.bounds.height {
//      graph.legendAnchor = .right
//      graph.legendDisplacement = CGPoint(x: -20, y: 0.0)
//      
//    } else {
//      graph.legendAnchor = .bottomRight
//      graph.legendDisplacement = CGPoint(x: -8.0, y: 8.0)
//    }
//    
//  }
  
  private func createFaces() {
    
    if facesView != nil {
      
      facesView.removeFromSuperview()
      facesView = nil
      
    }
    
    let facesToShow: [String: Int] = [
      VisualizeDashboardConstants.Faces.kGold:   pitchData.pitchTypesPercentage["happitch"] as! Int,
      VisualizeDashboardConstants.Faces.kSilver: pitchData.pitchTypesPercentage["happy"] as! Int,
      VisualizeDashboardConstants.Faces.kMedium: pitchData.pitchTypesPercentage["ok"] as! Int,
      VisualizeDashboardConstants.Faces.kBad:    pitchData.pitchTypesPercentage["unhappy"] as! Int
    ]
    
    let frameForFacesView = CGRect.init(x: (self.frame.size.width / 2.0) - (110.0 * UtilityManager.sharedInstance.conversionWidth),
                                        y: 340.0 * UtilityManager.sharedInstance.conversionHeight,
                                    width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 60.0 * UtilityManager.sharedInstance.conversionHeight)
    
    facesView = FacesEvaluationsView.init(frame: frameForFacesView,
                                          facesToShow: facesToShow)
    facesView.clipsToBounds = true
    
    self.addSubview(facesView)
    
  }
  
  func getData() -> PitchEvaluationByUserModelDataForCompany {
    
    return pitchData
    
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
    
    
    let firstColorHappitch = CPTColor.init(componentRed: 237.0/255.0 , green: 237.0/255.0, blue: 24.0/255.0, alpha: 1.0)
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

