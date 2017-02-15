//
//  GenericDashboardGraphic.swift
//  Amap
//
//  Created by Alejandro Aristi C on 11/14/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit
import Charts

class GenericDashboardGraphic: UIView {
  
  private var chartView: CombinedChartView! = nil
  private var dataForLineChart: [Double]! = nil
  private var dataForBarChart: [Double]! = nil
  private var valuesOfXAxis = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
  private var descriptionBarGraph: String! = nil
  private var descriptionLineGraph: String! = nil
  
  //
  private var border1: CALayer! = nil
  private var border2: CALayer! = nil
  private var border3: CALayer! = nil
  private var border4: CALayer! = nil
  
  private var labelHappitch: UILabel! = nil
  private var labelHappy: UILabel! = nil
  private var labelOK: UILabel! = nil
  private var labelUnHappy: UILabel! = nil
  
  
  
  
  init(frame: CGRect, newDataForLineChart: [Double], newDataForBarChart: [Double], newValuesOfXAxis: [String]?, newDescriptionBarGraph: String?, newDescriptionLineGraph: String?) {
    
    dataForBarChart = newDataForBarChart
    dataForLineChart = newDataForLineChart
    
    if newValuesOfXAxis != nil {
      
      valuesOfXAxis = newValuesOfXAxis!
      
    }
    
    if newDescriptionBarGraph != nil {
      
      descriptionBarGraph = newDescriptionBarGraph
      
    }else{
      
      descriptionBarGraph = "Agencia"
      
    }
    
    if newDescriptionLineGraph != nil {
      
      descriptionLineGraph = newDescriptionLineGraph
      
    }else{
      
      descriptionLineGraph = "Usuario"
      
    }
    
    super.init(frame: frame)
    
    self.initInterface()
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func initInterface() {
    
    self.checkForChart()
    self.createXAxis()
    
  }
  
  private func checkForChart() {
    
    if chartView != nil {
      
      UIView.animateWithDuration(0.35,
        animations: { 
          self.chartView.alpha = 0.0
        }, completion: { (finished) in
          if finished == true {
            
            self.chartView.removeFromSuperview()
            self.chartView = nil
            self.createChart()
            self.getAllLabelsAndBordersToTheFront()
          }
      })
    
    } else {
      
      self.createChart()
      
    }
  
  }
  
  private func createChart() {
    
    let frameForChartView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
                                        y: 0.0,
                                        width: 245.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 237.0 * UtilityManager.sharedInstance.conversionHeight)
    
    chartView = CombinedChartView.init(frame: frameForChartView)
    chartView.drawGridBackgroundEnabled = false
    chartView.drawBarShadowEnabled = false
    chartView.descriptionText = ""
    chartView.drawOrder = [CombinedChartDrawOrder.Line.rawValue, CombinedChartDrawOrder.Bar.rawValue]
    
    let leftAxis = chartView.leftAxis
    leftAxis.drawGridLinesEnabled = false
    leftAxis.labelCount = 0
    leftAxis.drawLabelsEnabled = false
    
    let rightAxis = chartView.rightAxis
    rightAxis.drawGridLinesEnabled = false
    rightAxis.labelCount = 0
    rightAxis.drawLabelsEnabled = false
    
    let combinedData = CombinedChartData.init(xVals: valuesOfXAxis)
    
    combinedData.lineData = self.generateLineData(dataForLineChart)
    combinedData.barData = self.generateBarData(dataForBarChart)
    
    chartView.data = combinedData
    chartView.userInteractionEnabled = false
    chartView.drawBordersEnabled = false
    chartView.legend.yOffset = 10.0 * UtilityManager.sharedInstance.conversionHeight
    chartView.legend.form = .Circle
    chartView.legend.formSize = 14.0 * UtilityManager.sharedInstance.conversionWidth
    chartView.legend.xEntrySpace = 53.0 * UtilityManager.sharedInstance.conversionWidth
    chartView.legend.yEntrySpace =  15.0 * UtilityManager.sharedInstance.conversionHeight
    chartView.legend.position = .BelowChartLeft
    chartView.legend.font = UIFont(name: "SFUIText-Light",
                                   size: 13.0 * UtilityManager.sharedInstance.conversionWidth)!
    
    chartView.xAxis.labelPosition = .Top
    chartView.xAxis.axisLineWidth = 0.0
    
    chartView.rightAxis.enabled = false
    chartView.leftAxis.enabled = false
    chartView.dragEnabled = false
    chartView.pinchZoomEnabled = false
    chartView.doubleTapToZoomEnabled = false
    chartView.animate(xAxisDuration: 1.0)
    chartView.animate(yAxisDuration: 1.0)
    chartView.backgroundColor = UIColor.whiteColor()
    
    chartView.noDataText = "Aún no tenemos información para mostrarte, entre más pitches agregues mejor información verás aquí."
    
    self.addSubview(chartView)
    
  }
  
  private func generateLineData(newValues: [Double]) -> LineChartData {
    
    let lineData = LineChartData.init()
    
    var entries = [BarChartDataEntry]()
    
    for i in 0..<newValues.count {
      
      entries.append(BarChartDataEntry.init(value: newValues[i], xIndex: i))
      
    }
    
    let lineChartSet = LineChartDataSet.init(yVals: entries, label: descriptionLineGraph)
    lineChartSet.setColor(UIColor.init(red: 51.0/255.0, green: 166.0/255.0, blue: 233.0/255.0, alpha: 1.0))
    lineChartSet.lineWidth = 4.0  * UtilityManager.sharedInstance.conversionWidth
    lineChartSet.fillColor = UIColor.init(red: 51.0/255.0, green: 166.0/255.0, blue: 233.0/255.0, alpha: 1.0)
    lineChartSet.drawCubicEnabled = false
    lineChartSet.drawValuesEnabled = false
    lineChartSet.drawCirclesEnabled = true
    lineChartSet.circleRadius = 4.0 * UtilityManager.sharedInstance.conversionWidth
    
    lineChartSet.axisDependency = .Left
    
    lineData.addDataSet(lineChartSet)
    
    return lineData
    
  }
  
  private func generateBarData(newValues: [Double]) -> BarChartData {
    
    let barData = BarChartData.init()
    
    var entries = [BarChartDataEntry]()
    
    for i in 0..<newValues.count {
      
      entries.append(BarChartDataEntry.init(value: newValues[i], xIndex: i))
      
    }
    
    let barSet = BarChartDataSet.init(yVals: entries, label: descriptionBarGraph)
    barSet.setColor(UIColor.init(red: 0.0/255.0, green: 246.0/255.0, blue: 143.0/255.0, alpha: 0.75))
    barSet.axisDependency = .Left
    barSet.barSpace = 0.6  * UtilityManager.sharedInstance.conversionWidth
    barSet.drawValuesEnabled = false
    
    barData.addDataSet(barSet)
    
    return barData
    
  }
  
  private func createXAxis() {
    
    //bottom line
    border1 = CALayer()
    let width = CGFloat(0.5 * UtilityManager.sharedInstance.conversionHeight)
    border1.borderColor = UIColor.darkGrayColor().CGColor
    border1.borderWidth = width
    border1.frame = CGRect.init(x: 0.0,
                               y: 47.0 * UtilityManager.sharedInstance.conversionHeight,
                           width: 283.0 * UtilityManager.sharedInstance.conversionWidth,
                          height: 0.5 * UtilityManager.sharedInstance.conversionHeight)
    self.layer.addSublayer(border1)
    labelHappitch = self.createLabel(CGPoint.init(x: 6.0 * UtilityManager.sharedInstance.conversionWidth, y: 35.0 * UtilityManager.sharedInstance.conversionHeight), text: "Happitch")
    self.addSubview(labelHappitch)
    
    //
    border2 = CALayer()
    border2.borderColor = UIColor.darkGrayColor().CGColor
    border2.borderWidth = width
    border2.frame = CGRect.init(x: 0.0,
                                y: 95.0 * UtilityManager.sharedInstance.conversionHeight,
                            width: 283.0 * UtilityManager.sharedInstance.conversionWidth,
                           height: 0.5 * UtilityManager.sharedInstance.conversionHeight)
    self.layer.addSublayer(border2)
    labelHappy = self.createLabel(CGPoint.init(x: 17.0 * UtilityManager.sharedInstance.conversionWidth, y: 80.0 * UtilityManager.sharedInstance.conversionHeight), text: "Happy")
    self.addSubview(labelHappy)
    
    //
    border3 = CALayer()
    border3.borderColor = UIColor.darkGrayColor().CGColor
    border3.borderWidth = width
    border3.frame = CGRect.init(x: 0.0,
                                y: 133.0 * UtilityManager.sharedInstance.conversionHeight,
                                width: 283.0 * UtilityManager.sharedInstance.conversionWidth,
                                height: 0.5 * UtilityManager.sharedInstance.conversionHeight)
    self.layer.addSublayer(border3)
    labelOK = self.createLabel(CGPoint.init(x: 5.0 * UtilityManager.sharedInstance.conversionWidth, y: 118.0 * UtilityManager.sharedInstance.conversionHeight), text: "Unhappy") //Ok
    self.addSubview(labelOK)
    
    //
    border4 = CALayer()
    border4.borderColor = UIColor.darkGrayColor().CGColor
    border4.borderWidth = width
    border4.frame = CGRect.init(x: 0.0,
                                y: 210.5 * UtilityManager.sharedInstance.conversionHeight,
                            width: 283.0 * UtilityManager.sharedInstance.conversionWidth,
                           height: 0.5 * UtilityManager.sharedInstance.conversionHeight)
    self.layer.addSublayer(border4)
    labelUnHappy = self.createLabel(CGPoint.init(x: 6.0 * UtilityManager.sharedInstance.conversionWidth, y: 198.0 * UtilityManager.sharedInstance.conversionHeight), text: "Badpitch") //Unhappy
    self.addSubview(labelUnHappy)
    
  }
  
  private func createLabel(position: CGPoint, text: String) -> UILabel {
    
    let frameForLabel = CGRect.init(x: position.x,
                                    y: position.y,
                                    width: 40.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    let valueLabel = UILabel.init(frame: frameForLabel)
    valueLabel.numberOfLines = 0
    valueLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Regular",
                      size: 9.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Right
    
    let stringWithFormat = NSMutableAttributedString(
      string: text,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    valueLabel.attributedText = stringWithFormat
    valueLabel.sizeToFit()
    let newFrame = CGRect.init(x: position.x,
                               y: position.y,
                               width: valueLabel.frame.size.width,
                               height: valueLabel.frame.size.height)
    
    valueLabel.frame = newFrame
    
    return valueLabel
    
  }
  
  private func getAllLabelsAndBordersToTheFront() {
    
    self.bringSubviewToFront(labelHappitch)
    self.bringSubviewToFront(labelHappy)
    self.bringSubviewToFront(labelOK)
    self.bringSubviewToFront(labelUnHappy)
    
    self.layer.addSublayer(border1)
    self.layer.addSublayer(border2)
    self.layer.addSublayer(border3)
    self.layer.addSublayer(border4)
    
  }
  
  func changeValuesOfGraph(newDescriptionForLineGraph: String, newXValues: [String], newLineGraphData: [Double], newBarGraphData: [Double]) {
    
    descriptionLineGraph = newDescriptionForLineGraph
    valuesOfXAxis = newXValues
    dataForLineChart = newLineGraphData
    dataForBarChart = newBarGraphData
    
    self.checkForChart()
    
  }
  
}