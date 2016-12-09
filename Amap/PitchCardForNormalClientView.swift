//
//  PitchCardForNormalClientView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 12/7/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit
import Charts

class PitchCardForNormalClientView: UIView {
  
  private var descriptionView: PitchCardForNormalClientDescriptionView! = nil
  
  private var circularView: PieChartView! = nil
  
  private var facesView: FacesEvaluationsView! = nil
  private var pitchData: PitchEvaluationByUserModelDataForCompany! = nil
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newPitchData: PitchEvaluationByUserModelDataForCompany) {
    
    pitchData = newPitchData
    
    super.init(frame: frame)
    
    self.initInterface()
    
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
    
    let frameForChartView = CGRect.init(x: (self.frame.size.width / 2.0) - (90.5 * UtilityManager.sharedInstance.conversionWidth),
                                        y: 135.0 * UtilityManager.sharedInstance.conversionHeight,
                                        width: 181.0 * UtilityManager.sharedInstance.conversionWidth,
                                        height: 181.0 * UtilityManager.sharedInstance.conversionHeight)
    
    let happitchPercentage = Double(CGFloat(pitchData.pitchTypesPercentage["happitch"] as! Int) / 100.0)
    let happyPercentage = Double(CGFloat(pitchData.pitchTypesPercentage["happy"] as! Int) / 100.0)
    let okPercentage = Double(CGFloat(pitchData.pitchTypesPercentage["ok"] as! Int) / 100.0)
    let sadPercentage = Double(CGFloat(pitchData.pitchTypesPercentage["sad"] as! Int) / 100.0)
    
    circularView = PieChartView.init(frame: frameForChartView)
    
    let nameValues = ["","","",""]
    let firstPercentage = BarChartDataEntry.init(value: happitchPercentage, xIndex: 0)
    let secondPercentage = BarChartDataEntry.init(value: happyPercentage, xIndex: 1)
    let thirdPercentage = BarChartDataEntry.init(value: okPercentage, xIndex: 2)
    let fourthPercentage = BarChartDataEntry.init(value: sadPercentage, xIndex:3)
    let percentageValues = [firstPercentage, secondPercentage, thirdPercentage, fourthPercentage]
    
    
    let dataSetForPie = PieChartDataSet.init(yVals: percentageValues, label: nil)
    dataSetForPie.sliceSpace = 0.0
    
    let colors = [UIColor.init(red: 238.0/255.0, green: 220.0/255.0, blue: 55.0/255.0, alpha: 1.0),
                  UIColor.init(red: 219.0/255.0, green: 59.0/255.0, blue: 39.0/255.0, alpha: 1.0),
                  UIColor.init(red: 111.0/255.0, green: 139.0/255.0, blue: 226.0/255.0, alpha: 1.0),
                  UIColor.init(red: 49.0/255.0, green: 190.0/255.0, blue: 175.0/255.0, alpha: 1.0)]
    dataSetForPie.colors = colors
    
    let dataPie: PieChartData = PieChartData.init(xVals: nameValues, dataSet: dataSetForPie)
    let pieFormatter = NSNumberFormatter.init()
    pieFormatter.numberStyle = .PercentStyle
    pieFormatter.maximumFractionDigits = 2
    pieFormatter.multiplier = 1.0
    pieFormatter.percentSymbol = " %"
    
    dataPie.setValueFormatter(pieFormatter)
    //    dataPie.setValueFont(UIFont.)
    dataPie.setValueTextColor(UIColor.whiteColor())
    
    circularView.data = dataPie
    circularView.userInteractionEnabled = false
    circularView.transparentCircleRadiusPercent = 0.0
    circularView.drawHoleEnabled = false
    
    circularView.animate(xAxisDuration: 0.7)
    circularView.animate(yAxisDuration: 0.7)
    circularView.legend.enabled = false
    circularView.descriptionText = ""
    
    self.addSubview(circularView)
    
  }
  
  private func createFaces() {
    
    if facesView != nil {
      
      facesView.removeFromSuperview()
      facesView = nil
      
    }
    
    let facesToShow: [String: Int] = [
      VisualizeDashboardConstants.Faces.kGold:   0,
      VisualizeDashboardConstants.Faces.kSilver: 0,
      VisualizeDashboardConstants.Faces.kMedium: 0,
      VisualizeDashboardConstants.Faces.kBad:    0
    ]
    
    let frameForFacesView = CGRect.init(x: (self.frame.size.width / 2.0) - (110.0 * UtilityManager.sharedInstance.conversionWidth),
                                        y: 340.0 * UtilityManager.sharedInstance.conversionHeight,
                                    width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                   height: 43.0 * UtilityManager.sharedInstance.conversionHeight)
    
    facesView = FacesEvaluationsView.init(frame: frameForFacesView,
                                          facesToShow: facesToShow)
    facesView.clipsToBounds = true
    
    self.addSubview(facesView)
    
  }
  
  func getData() -> PitchEvaluationByUserModelDataForCompany {
    
    return pitchData
    
  }

  
}
