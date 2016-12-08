//
//  PitchEvaluationByUserModelDataForCompany.swift
//  Amap
//
//  Created by Alejandro Aristi C on 12/8/16.
//  Copyright © 2016 Alejandro Aristi C. All rights reserved.
//

import Foundation

class PitchEvaluationByUserModelDataForCompany {
  
  var brandName: String! = nil
  var breakDown: [String: AnyObject]! = nil
  var briefDate: String! = nil
  var briefEmailContact: String! = nil
  var companyName: String! = nil
  var pitchId: String! = nil
  var pitchName: String! = nil
  var pitchTypesPercentage: [String: AnyObject]! = nil
  var winner: String! = nil
  
  init(newBrandName: String,
       newBreakDown: [String: AnyObject],
       newBriefDate: String,
       newBriefEmailContact: String,
       newCompanyName: String,
       newPitchId: String,
       newPitchName: String,
       newPitchTypesPercentage: [String: AnyObject],
       newWinner: String) {
    
    brandName = newBrandName
    breakDown = newBreakDown
    briefDate = newBriefDate
    briefEmailContact = newBriefEmailContact
    companyName = newCompanyName
    pitchId = newPitchId
    pitchName = newPitchName
    pitchTypesPercentage = newPitchTypesPercentage
    winner = newWinner

  }
  
  
}