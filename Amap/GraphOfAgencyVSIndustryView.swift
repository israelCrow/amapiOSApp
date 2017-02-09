//
//  GraphOfAgencyVSIndustryView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 11/14/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

protocol GraphOfAgencyVSIndustryViewDelegate {
  
  func filterFromGraphOfAgencyVSIndustryPressed(sender: GraphOfAgencyVSIndustryView)
  
}

class GraphOfAgencyVSIndustryView: UIView {
  
  private var filterButton: UIButton! = nil
  private var agencyPerformanceLabel: UILabel! = nil
  private var noEnoughInfoLabel: UILabel! = nil
  private var genericGraph: GenericDashboardGraphic! = nil
  private var optionsForSelector: [String]! = nil
  
  private var arrayOfPitchesAverageByAgency = [Double]()
  
  private var arrayOfPitchesAvergaeByIndustry = [Double]()
  
  var delegate: GraphOfAgencyVSIndustryViewDelegate?
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(frame: CGRect, newArrayByAgency: [Double], newArrayByIndustry: [Double]) {
    
    arrayOfPitchesAverageByAgency = newArrayByAgency
    arrayOfPitchesAvergaeByIndustry = newArrayByIndustry
    
    super.init(frame: frame)
    
    self.initValues()
    self.initInterface()
    
  }
  
  private func initValues() {
    
    optionsForSelector = ["Performance General", "Usuario 1", "Usuario 2"]
    
  }
  
  private func initInterface() {
    
    self.backgroundColor = UIColor.whiteColor()
    self.createFilterButton()
    self.createGraphOfAgencyVSIndustryLabel()
    
    if arrayOfPitchesAverageByAgency.count > 0 && arrayOfPitchesAvergaeByIndustry.count > 0 {
      
      self.createGraphic()
      
    } else {
      
      self.createLabelNoEnoughInfo()
      
    }
    
  }
  
  private func createFilterButton() {
    
    let frameForButton = CGRect.init(x: 262.0 * UtilityManager.sharedInstance.conversionWidth,
                                     y: 9.0 * UtilityManager.sharedInstance.conversionHeight,
                                     width: 25.0 * UtilityManager.sharedInstance.conversionWidth,
                                     height: 21.0 * UtilityManager.sharedInstance.conversionHeight)
    
    filterButton = UIButton.init(frame: frameForButton)
    let image = UIImage(named: "iconNavBarFilters") as UIImage?
    filterButton.setImage(image, forState: .Normal)
    filterButton.tag = 1
    filterButton.addTarget(self, action: #selector(filterButtonPressed), forControlEvents:.TouchUpInside)
    
    self.addSubview(filterButton)
    
  }
  
  private func createGraphOfAgencyVSIndustryLabel() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 220.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    agencyPerformanceLabel = UILabel.init(frame: frameForLabel)
    agencyPerformanceLabel.numberOfLines = 2
    agencyPerformanceLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIDisplay-Ultralight",
                      size: 30.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    var stringWithFormat = NSMutableAttributedString(
      string: VisualizeDashboardConstants.GraphOfAgencyVSIndustry.agencyPerformanceLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSKernAttributeName: CGFloat(2.0),
        NSForegroundColorAttributeName: color
      ]
    )
    
    if UserSession.session.role == "4" || UserSession.session.role == "5" {
      
      stringWithFormat = NSMutableAttributedString(
        string: VisualizeDashboardConstants.GraphOfAgencyVSIndustry.companyPerformanceLabelText,
        attributes:[NSFontAttributeName: font!,
          NSParagraphStyleAttributeName: style,
          NSKernAttributeName: CGFloat(2.0),
          NSForegroundColorAttributeName: color
        ]
      )
      
    }
    
    agencyPerformanceLabel.attributedText = stringWithFormat
    agencyPerformanceLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (agencyPerformanceLabel.frame.size.width / 2.0),
                               y: 20.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: agencyPerformanceLabel.frame.size.width,
                               height: agencyPerformanceLabel.frame.size.height)
    
    agencyPerformanceLabel.frame = newFrame
    
    self.addSubview(agencyPerformanceLabel)
    
  }
  
  private func createLabelNoEnoughInfo() {
    
    let frameForLabel = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: 218.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: CGFloat.max)
    
    noEnoughInfoLabel = UILabel.init(frame: frameForLabel)
    noEnoughInfoLabel.numberOfLines = 0
    noEnoughInfoLabel.lineBreakMode = .ByWordWrapping
    
    let font = UIFont(name: "SFUIText-Light",
                      size: 16.0 * UtilityManager.sharedInstance.conversionWidth)
    let color = UIColor.blackColor()
    let style = NSMutableParagraphStyle()
    style.alignment = NSTextAlignment.Center
    
    let stringWithFormat = NSMutableAttributedString(
      string: VisualizeDashboardConstants.GraphOfAgencyVSIndustry.noEnoughInfoLabelText,
      attributes:[NSFontAttributeName: font!,
        NSParagraphStyleAttributeName: style,
        NSForegroundColorAttributeName: color
      ]
    )
    
    noEnoughInfoLabel.attributedText = stringWithFormat
    noEnoughInfoLabel.sizeToFit()
    let newFrame = CGRect.init(x: (self.frame.size.width / 2.0) - (noEnoughInfoLabel.frame.size.width / 2.0),
                               y: 182.0 * UtilityManager.sharedInstance.conversionHeight,
                               width: noEnoughInfoLabel.frame.size.width,
                               height: noEnoughInfoLabel.frame.size.height)
    
    noEnoughInfoLabel.frame = newFrame
    
    self.addSubview(noEnoughInfoLabel)
    
  }
  
  private func createGraphic() {
    
    let frameForGraph = CGRect.init(x: 12.0 * UtilityManager.sharedInstance.conversionWidth,
                                    y: 106.0 * UtilityManager.sharedInstance.conversionHeight,
                                    width: 285.0 * UtilityManager.sharedInstance.conversionWidth,
                                    height: 260.0 * UtilityManager.sharedInstance.conversionHeight)
    
    
    
    var stringName = ""
    
    if UserSession.session.role == "2" || UserSession.session.role == "3" {
      
      stringName = AgencyModel.Data.name
      
    } else
      if UserSession.session.role == "4" || UserSession.session.role == "5" {
      
        stringName = MyCompanyModelData.Data.name
        
      }
    
    
    
    
    
    if stringName.characters.count > 13 {
    
      let index = stringName.startIndex.advancedBy(11)
      stringName = stringName.substringToIndex(index)
      stringName = stringName + "..."
    
    }
    
    genericGraph = GenericDashboardGraphic.init(frame: frameForGraph,
                                                newDataForLineChart: arrayOfPitchesAverageByAgency,
                                                newDataForBarChart: arrayOfPitchesAvergaeByIndustry,
                                                newValuesOfXAxis: nil,
                                                newDescriptionBarGraph: "Industria",
                                                newDescriptionLineGraph: stringName)
    
    
    
    self.addSubview(genericGraph)
    
//    NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(3), target: self, selector: #selector(changeData), userInfo: nil, repeats: false)
    
  }
  
  func changeData(newNameUser: String, newXValues: [String]?, newLineGraphData: [Double], newBarGraphData: [Double]) {

    var xValues = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    
    if newXValues != nil {
      
      xValues = newXValues!
      
    }
    
    genericGraph.changeValuesOfGraph(newNameUser,
                                     newXValues: xValues,
                                     newLineGraphData: newLineGraphData,
                                     newBarGraphData: newBarGraphData)
    
//    genericGraph.changeValuesOfGraph("usuario 666",
//                                     newXValues: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"],
//                                     newLineGraphData: [1,2,3,4,5,6,7,8,9,10,11,12],
//                                     newBarGraphData: [12,11,10,9,8,7,6,5,4,3,2,1])
    
  }
  
  
  //  private func createYAxis(quantityOfLines: Int) {
  //
  //    let distanceBetweenLines: CGFloat = (207.0 / CGFloat(quantityOfLines)) * UtilityManager.sharedInstance.conversionWidth
  //
  //    var frameForLines = CGRect.init(x: 53.0 * UtilityManager.sharedInstance.conversionWidth,
  //                                    y: 13.0 * UtilityManager.sharedInstance.conversionHeight,
  //                                    width: 1.0 * UtilityManager.sharedInstance.conversionWidth,
  //                                    height: 198.0 * UtilityManager.sharedInstance.conversionHeight)
  //
  //    var border: CALayer
  //    let width = CGFloat(1)
  //
  //    for i in 1...quantityOfLines {
  //
  //      border = CALayer()
  //      border.borderColor = UIColor.darkGrayColor().CGColor
  //      border.borderWidth = width
  //      border.frame = frameForLines
  //      self.layer.addSublayer(border)
  //
  //      self.createLabelForYAxis(String(i), baseFrame: frameForLines)
  //      frameForLines = CGRect.init(x: frameForLines.origin.x + distanceBetweenLines,
  //                                  y: frameForLines.origin.y,
  //                                  width: frameForLines.size.width,
  //                                  height: frameForLines.size.height)
  //
  //
  //    }
  //
  //  }
  
  @objc private func filterButtonPressed() {
    
    self.delegate?.filterFromGraphOfAgencyVSIndustryPressed(self)
    
  }
  
  
}
