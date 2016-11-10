//
//  DashboardGraphView.swift
//  Amap
//
//  Created by Alejandro Aristi C on 11/9/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import UIKit
import Charts

class DashboardGraphView: UIView {
  
  private var yAxisElements: [String]! = nil
  private var xAxisElements: [Double]! = nil
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  init(frame: CGRect, newYAxisElements: [String], newXAxisElements: [Double]) {
    
    yAxisElements = newYAxisElements
    xAxisElements = newXAxisElements
    
    super.init(frame: frame)
    
    self.backgroundColor = UIColor.whiteColor()
    self.createInterface()
    
  }

  
  private func createInterface() {
    
    self.createGraph()
    
  }
  
  private func createGraph() {
    
    
    
  }
  
}
