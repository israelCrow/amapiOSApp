//
//  PitchEvaluationAveragePerMonthModelData.swift
//  Amap
//
//  Created by Alejandro Aristi C on 11/17/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import Foundation

class PitchEvaluationAveragePerMonthModelData {
  
  var id: String?
  var monthYear: String! = nil
  var monthYearWithFormat: String! = nil
  var score: String! = nil
  
  init(newId: String?, newMonthYear: String, newScore: String) {
    
    id = newId
    monthYear = newMonthYear
    score = newScore

  }
  
}