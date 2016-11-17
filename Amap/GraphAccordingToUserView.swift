//
//  GraphAccordingToUserView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 11/14/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit

class GraphAccordingToUserView: UIView {

  private var filterButton: UIButton! = nil
  private var selectorOfInformationView: CustomTextFieldWithTitleAndPickerView! = nil
  private var genericGraph: GenericDashboardGraphic! = nil
  private var optionsForSelector: [String]! = nil
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(frame: CGRect) {
    
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
    self.createSelectorOfInformationView()
    
    self.createGraphic()

    
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
  
  private func createSelectorOfInformationView() {
    
    let frameForView = CGRect.init(x: 38.0 * UtilityManager.sharedInstance.conversionWidth,
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
    self.addSubview(selectorOfInformationView)
    
  }
  
  private func createGraphic() {
    
    let frameForGraph = CGRect.init(x: 12.0 * UtilityManager.sharedInstance.conversionWidth,
                                    y: 145.0 * UtilityManager.sharedInstance.conversionHeight,
                                width: 285.0 * UtilityManager.sharedInstance.conversionWidth,
                               height: 260.0 * UtilityManager.sharedInstance.conversionHeight)
    
    genericGraph = GenericDashboardGraphic.init(frame: frameForGraph,
                                  newDataForLineChart: [5.0, 10.0, 20.0, 18.0, 13.0],
                                   newDataForBarChart: [13.0, 18.0, 20.0, 10.0, 5.0],
                                     newValuesOfXAxis: nil,
                               newDescriptionBarGraph: nil,
                              newDescriptionLineGraph: nil)
    
    self.addSubview(genericGraph)
    
    NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(3), target: self, selector: #selector(changeData), userInfo: nil, repeats: false)
    
  }
  
  @objc private func changeData() {
    
    genericGraph.changeValuesOfGraph("usuario 666",
                                     newXValues: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"],
                               newLineGraphData: [1,2,3,4,5,6,7,8,9,10,11,12],
                                newBarGraphData: [12,11,10,9,8,7,6,5,4,3,2,1])
    
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
    
    
    
  }
  
  
}
